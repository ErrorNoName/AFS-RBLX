--[[
-- SriBlox Modern Runtime
-- Système d'instances virtuelles avec compatibilité Roblox complète
--]]

local VERBOSE = false
local VERSION = "2.0.0"

---@type table<string, table>
local instances = {}

---@type table<string, table>
local modules = {}

-- Environnement global
local globalEnv = getfenv(0)

-- Fonction pour obtenir tous les enfants d'une instance
local function getChildren(instance)
	local children = {}
	local path = rawget(instance, "__path")
	
	-- Chercher toutes les instances dont le parent est ce path
	for instancePath, inst in pairs(instances) do
		if rawget(inst, "__parent") == path then
			table.insert(children, inst)
		end
	end
	
	return children
end

-- Créer une instance virtuelle
local function createVirtualInstance(name, className, path, parentPath)
	local instance = {}
	
	-- Propriétés internes (rawset pour éviter __index)
	rawset(instance, "Name", name)
	rawset(instance, "ClassName", className)
	rawset(instance, "__path", path)
	rawset(instance, "__parent", parentPath)
	rawset(instance, "Parent", parentPath and instances[parentPath] or nil)
	
	-- GetFullName
	rawset(instance, "GetFullName", function(self)
		return path
	end)
	
	-- FindFirstChild (récursif dans tous les descendants)
	rawset(instance, "FindFirstChild", function(self, childName, recursive)
		if VERBOSE then
			print("[FindFirstChild] Looking for '" .. childName .. "' in " .. rawget(self, "Name"))
		end
		
		-- D'abord chercher dans les enfants directs
		local children = getChildren(self)
		if VERBOSE then
			print("[FindFirstChild] Found " .. #children .. " direct children")
		end
		
		for _, child in ipairs(children) do
			if rawget(child, "Name") == childName then
				if VERBOSE then
					print("[FindFirstChild] Found '" .. childName .. "' as direct child!")
				end
				return child
			end
		end
		
		-- Si récursif ou si aucun enfant direct trouvé, chercher dans tous les descendants
		if recursive ~= false then
			if VERBOSE then
				print("[FindFirstChild] Searching recursively...")
			end
			for instancePath, inst in pairs(instances) do
				-- Vérifier si c'est un descendant
				if instancePath:find("^" .. path:gsub("%.", "%%.") .. "%.") and rawget(inst, "Name") == childName then
					if VERBOSE then
						print("[FindFirstChild] Found '" .. childName .. "' recursively at " .. instancePath)
					end
					return inst
				end
			end
		end
		
		if VERBOSE then
			print("[FindFirstChild] '" .. childName .. "' not found")
		end
		return nil
	end)
	
	-- FindFirstAncestor
	rawset(instance, "FindFirstAncestor", function(self, ancestorName)
		local current = rawget(self, "Parent")
		while current do
			if rawget(current, "Name") == ancestorName then
				return current
			end
			current = rawget(current, "Parent")
		end
		return nil
	end)
	
	-- FindFirstAncestorWhichIsA
	rawset(instance, "FindFirstAncestorWhichIsA", function(self, className)
		local current = rawget(self, "Parent")
		while current do
			if rawget(current, "ClassName") == className then
				return current
			end
			current = rawget(current, "Parent")
		end
		return nil
	end)
	
	-- IsDescendantOf
	rawset(instance, "IsDescendantOf", function(self, ancestor)
		if type(ancestor) == "table" and rawget(ancestor, "__path") then
			local current = rawget(self, "Parent")
			while current do
				if current == ancestor or rawget(current, "__path") == rawget(ancestor, "__path") then
					return true
				end
				current = rawget(current, "Parent")
			end
		elseif typeof(ancestor) == "Instance" then
			return false
		end
		return false
	end)
	
	-- IsA
	rawset(instance, "IsA", function(self, className)
		return rawget(self, "ClassName") == className
	end)
	
	-- WaitForChild
	rawset(instance, "WaitForChild", function(self, childName, timeOut)
		local child = self:FindFirstChild(childName)
		if child then
			return child
		end
		-- Sinon attendre un peu et réessayer (simulation simple)
		task.wait(0.1)
		return self:FindFirstChild(childName) or error("WaitForChild timeout: " .. childName)
	end)
	
	-- GetChildren
	rawset(instance, "GetChildren", function(self)
		return getChildren(self)
	end)
	
	-- Metatable pour accès par point (script.Parent.include)
	-- IMPORTANT: N'intercepte que les clés qui n'existent PAS déjà
	setmetatable(instance, {
		__index = function(self, key)
			-- D'abord vérifier si c'est une propriété/méthode existante
			local existing = rawget(self, key)
			if existing ~= nil then
				return existing
			end
			
			-- Sinon chercher un enfant avec ce nom
			-- Utiliser rawget pour accéder à FindFirstChild sans déclencher __index
			local findFirstChild = rawget(self, "FindFirstChild")
			if findFirstChild then
				return findFirstChild(self, key, false)
			end
			
			return nil
		end
	})
	
	return instance
end

-- Module resolution

local currentlyLoading = {}

local function validateRequire(module, caller)
	currentlyLoading[caller] = module

	local currentModule = module
	local depth = 0

	if not modules[module.__path or module] then
		while currentModule do
			depth = depth + 1
			currentModule = currentlyLoading[currentModule]

			if currentModule == module then
				local str = (currentModule.Name or "unknown")
				
				for _ = 1, depth do
					currentModule = currentlyLoading[currentModule]
					str = str .. "  ⇒ " .. (currentModule.Name or "unknown")
				end

				error("Failed to load '" .. (module.Name or "unknown") .. "'; Detected a circular dependency chain: " .. str, 2)
			end
		end
	end

	return function()
		if currentlyLoading[caller] == module then
			currentlyLoading[caller] = nil
		end
	end
end

local function loadModule(obj, this)
	local cleanup = this and validateRequire(obj, this)
	local modulePath = obj.__path or obj
	local moduleData = modules[modulePath]
	
	if not moduleData then
		error("Module not found: " .. tostring(modulePath), 2)
	end

	if moduleData.isLoaded then
		if cleanup then
			cleanup()
		end
		return moduleData.value
	else
		local data = moduleData.fn()
		moduleData.value = data
		moduleData.isLoaded = true
		if cleanup then
			cleanup()
		end
		return data
	end
end

local function requireModuleInternal(target, this)
	local targetPath = type(target) == "table" and target.__path or target
	
	if modules[targetPath] and (type(target) == "table" and target:IsA("ModuleScript") or type(target) == "string") then
		return loadModule(target, this)
	else
		return require(target)
	end
end

-- Environment creation

local function newEnv(id)
	return setmetatable({
		VERSION = VERSION,
		script = instances[id],
		require = function(module)
			return requireModuleInternal(module, instances[id])
		end,
	}, {
		__index = globalEnv,
		__metatable = "This metatable is locked",
	})
end

-- Instance creation

local function newModule(name, className, path, parent, fn)
	local instance = createVirtualInstance(name, className, path, parent)
	
	instances[path] = instance
	
	modules[path] = {
		fn = fn,
		isLoaded = false,
		value = nil,
	}
	
	if VERBOSE then
		print("[SriBlox] Module created: " .. path)
	end
end

local function newInstance(name, className, path, parent)
	local instance = createVirtualInstance(name, className, path, parent)
	
	instances[path] = instance
	
	if VERBOSE then
		print("[SriBlox] Instance created: " .. path)
	end
end

-- Runtime

local function init()
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	
	local mainModule = instances["SriBlox-Modern.main"]
	if not mainModule then
		error("[SriBlox] Main module not found!")
	end
	
	if VERBOSE then
		print("[SriBlox] Starting main module...")
	end
	
	task.spawn(loadModule, mainModule)
end
