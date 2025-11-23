-- ============================================
-- SriBlox Modern Runtime Environment
-- Version: "2.0.0"
-- Système de chargement des modules style Orca
-- ============================================

local VERSION = "2.0.0"
local VERBOSE = false

-- Protection GUI
local function protectGui(gui)
	if syn and syn.protect_gui then
		syn.protect_gui(gui)
	elseif gethui then
		gui.Parent = gethui()
		return
	end
	gui.Parent = game:GetService("CoreGui")
end

-- Services Roblox
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Environment global pour les modules
local globalEnv = {
	-- Roblox globals
	game = game,
	workspace = workspace,
	script = script,
	shared = shared,
	
	-- Services
	Players = Players,
	CoreGui = CoreGui,
	RunService = RunService,
	HttpService = HttpService,
	TweenService = TweenService,
	UserInputService = UserInputService,
	
	-- Exploit functions
	loadstring = loadstring,
	readfile = readfile,
	writefile = writefile,
	setclipboard = setclipboard,
	
	-- Standard Lua
	print = print,
	warn = warn,
	error = error,
	assert = assert,
	type = type,
	typeof = typeof,
	tonumber = tonumber,
	tostring = tostring,
	pairs = pairs,
	ipairs = ipairs,
	next = next,
	select = select,
	unpack = unpack,
	pcall = pcall,
	xpcall = xpcall,
	setmetatable = setmetatable,
	getmetatable = getmetatable,
	rawset = rawset,
	rawget = rawget,
	rawequal = rawequal,
	
	-- Roblox constructors
	Vector2 = Vector2,
	Vector3 = Vector3,
	CFrame = CFrame,
	UDim = UDim,
	UDim2 = UDim2,
	Color3 = Color3,
	ColorSequence = ColorSequence,
	NumberSequence = NumberSequence,
	NumberRange = NumberRange,
	Rect = Rect,
	Region3 = Region3,
	Ray = Ray,
	
	-- Enums
	Enum = Enum,
	
	-- Libraries
	math = math,
	table = table,
	string = string,
	coroutine = coroutine,
	debug = debug,
	os = os,
	
	-- Version info
	VERSION = VERSION,
}

-- Module storage
local modules = {}
local instances = {}

-- Créer un environnement pour un module
local function newEnv(path)
	local env = setmetatable({}, {
		__index = function(self, key)
			if key == "script" then
				return instances[path]
			end
			return globalEnv[key]
		end,
	})
	
	-- Fonction require custom
	env.require = function(module)
		local modulePath
		
		if typeof(module) == "Instance" then
			modulePath = module:GetFullName()
		else
			modulePath = tostring(module)
		end
		
		local moduleData = modules[modulePath]
		if not moduleData then
			error("Module not found: " .. modulePath, 2)
		end
		
		-- Si déjà chargé, retourner le cache
		if moduleData.loaded then
			return moduleData.result
		end
		
		-- Charger le module
		moduleData.loaded = true
		local success, result = pcall(moduleData.loader)
		
		if not success then
			error("Error loading module " .. modulePath .. ": " .. tostring(result), 2)
		end
		
		moduleData.result = result
		return result
	end
	
	return env
end

-- Créer un nouveau module
local function newModule(name, className, path, parent, loader)
	-- Créer l'instance virtuelle
	local instance = {
		Name = name,
		ClassName = className,
		Parent = parent and instances[parent],
		GetFullName = function()
			return path
		end,
	}
	
	instances[path] = instance
	
	-- Enregistrer le module
	modules[path] = {
		name = name,
		path = path,
		loader = loader,
		loaded = false,
		result = nil,
	}
	
	if VERBOSE then
		print("[SriBlox] Module loaded: " .. path)
	end
end

-- Créer une instance simple
local function newInstance(name, className, path, parent)
	local instance = {
		Name = name,
		ClassName = className,
		Parent = parent and instances[parent],
		GetFullName = function()
			return path
		end,
	}
	
	instances[path] = instance
	
	if VERBOSE then
		print("[SriBlox] Instance created: " .. path)
	end
end

-- Initialiser l'application
local function init()
	-- Attendre que le jeu soit chargé
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	
	-- Charger le module principal
	local mainModule = instances["SriBlox-Modern.main.client"]
	if not mainModule then
		error("[SriBlox] Main module not found!")
		return
	end
	
	-- Require du module principal
	local env = newEnv("SriBlox-Modern")
	env.require(mainModule)
	
	print("✅ SriBlox Modern v" .. VERSION .. " loaded successfully!")
end

-- Pas de return ici, les fonctions sont déjà globales pour bundle.lua



newInstance("SriBlox-Modern", "Folder", "SriBlox-Modern", nil)

newModule("App", "ModuleScript", "SriBlox-Modern.App", "SriBlox-Modern", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.include.RuntimeLib)
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _roact_hooked = TS.import(script, TS.getModule(script, "@rbxts", "roact-hooked").out)
local hooked = _roact_hooked.hooked
local useState = _roact_hooked.useState
local useEffect = _roact_hooked.useEffect
local store = TS.import(script, script.Parent, "store", "store").default
local _actions = TS.import(script, script.Parent, "store", "actions")
local setSearchQuery = _actions.setSearchQuery
local setSearchResults = _actions.setSearchResults
local setLoading = _actions.setLoading
local setError = _actions.setError
local toggleVisibility = _actions.toggleVisibility
local ScriptBloxService = TS.import(script, script.Parent, "services", "scriptblox.service").ScriptBloxService
local SearchBar = TS.import(script, script.Parent, "components", "SearchBar").SearchBar
local ScriptCard = TS.import(script, script.Parent, "components", "ScriptCard").ScriptCard
local Acrylic = TS.import(script, script.Parent, "components", "Acrylic").Acrylic
local themes = TS.import(script, script.Parent, "themes", "themes").themes
local UserInputService = game:GetService("UserInputService")
local AppContent = hooked(function()
	local _binding = useState(themes.dark)
	local currentTheme = _binding[1]
	local _binding_1 = useState("")
	local searchQuery = _binding_1[1]
	local setSearchQueryState = _binding_1[2]
	local _binding_2 = useState(false)
	local isVisible = _binding_2[1]
	local setIsVisible = _binding_2[2]
	local _binding_3 = useState(false)
	local isLoading = _binding_3[1]
	local setIsLoadingState = _binding_3[2]
	local _binding_4 = useState({})
	local scripts = _binding_4[1]
	local setScripts = _binding_4[2]
	useEffect(function()
		local connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and input.KeyCode == Enum.KeyCode.F6 then
				setIsVisible(not isVisible)
				store:dispatch(toggleVisibility())
			end
		end)
		return function()
			return connection:Disconnect()
		end
	end, { isVisible })
	local handleSearch = function(query)
		if query == "" then
			return nil
		end
		setSearchQueryState(query)
		setIsLoadingState(true)
		store:dispatch(setLoading(true))
		store:dispatch(setSearchQuery(query))
		local _exp = ScriptBloxService:searchScripts(query, 1, 20)
		local _arg0 = function(response)
			setScripts(response.result.scripts)
			setIsLoadingState(false)
			store:dispatch(setSearchResults(response.result.scripts, response.result.totalPages))
		end
		_exp:andThen(_arg0):catch(function(err)
			setIsLoadingState(false)
			store:dispatch(setError(tostring(err)))
		end)
	end
	local handleSettingsClick = function()
		print("Theme selector opened")
	end
	if not isVisible then
		return Roact.createElement("Frame", {
			Size = UDim2.fromScale(0, 0),
			BackgroundTransparency = 1,
		})
	end
	local _attributes = {
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
	}
	local _children = {}
	local _length = #_children
	local _attributes_1 = {
		transparency = 0.6,
		blurSize = 24,
		tintColor = currentTheme.colors.background,
		tintTransparency = 0.3,
	}
	local _children_1 = {}
	local _length_1 = #_children_1
	local _attributes_2 = {
		Size = UDim2.new(0, 900, 0, 680),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = currentTheme.colors.surface,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
	}
	local _children_2 = {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 16),
		}),
		Roact.createElement("UIStroke", {
			Color = currentTheme.colors.border,
			Thickness = 2,
			Transparency = 0.5,
		}, {
			Roact.createElement("UIGradient", {
				Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, currentTheme.colors.primary), ColorSequenceKeypoint.new(0.5, currentTheme.colors.accent), ColorSequenceKeypoint.new(1, currentTheme.colors.primary) }),
				Rotation = 45,
			}),
		}),
		Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 100),
			BackgroundTransparency = 1,
		}, {
			Roact.createElement("TextLabel", {
				Size = UDim2.new(0, 300, 0, 50),
				Position = UDim2.new(0, 24, 0, 20),
				BackgroundTransparency = 1,
				Text = "SriBlox Modern",
				TextColor3 = currentTheme.colors.text,
				Font = Enum.Font.GothamBold,
				TextSize = 36,
				TextXAlignment = Enum.TextXAlignment.Left,
			}, {
				Roact.createElement("UIGradient", {
					Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, currentTheme.colors.primary), ColorSequenceKeypoint.new(1, currentTheme.colors.accent) }),
				}),
			}),
			Roact.createElement("TextLabel", {
				Size = UDim2.new(0, 150, 0, 20),
				Position = UDim2.new(0, 330, 0, 35),
				BackgroundTransparency = 1,
				Text = "v2.0 TypeScript",
				TextColor3 = currentTheme.colors.textSecondary,
				Font = Enum.Font.Gotham,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
			}),
			Roact.createElement("TextButton", {
				Size = UDim2.new(0, 40, 0, 40),
				Position = UDim2.new(1, -52, 0, 20),
				BackgroundColor3 = currentTheme.colors.error,
				Text = "X",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Font = Enum.Font.GothamBold,
				TextSize = 24,
				[Roact.Event.MouseButton1Click] = function()
					setIsVisible(false)
					store:dispatch(toggleVisibility())
				end,
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 10),
				}),
			}),
		}),
		Roact.createElement("Frame", {
			Size = UDim2.new(1, -48, 0, 50),
			Position = UDim2.new(0, 24, 0, 100),
			BackgroundTransparency = 1,
		}, {
			Roact.createElement(SearchBar, {
				theme = currentTheme,
				placeholder = "Search scripts...",
				onSearch = handleSearch,
				onSettingsClick = handleSettingsClick,
			}),
		}),
	}
	local _length_2 = #_children_2
	local _attributes_3 = {
		Size = UDim2.new(1, -48, 1, -170),
		Position = UDim2.new(0, 24, 0, 160),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = currentTheme.colors.primary,
		CanvasSize = UDim2.new(0, 0, 0, math.ceil(#scripts / 3) * 180),
	}
	local _children_3 = {}
	local _length_3 = #_children_3
	local _attributes_4 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}
	local _children_4 = {
		Roact.createElement("UIGridLayout", {
			CellSize = UDim2.new(0, 270, 0, 160),
			CellPadding = UDim2.new(0, 16, 0, 16),
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	}
	local _length_4 = #_children_4
	local _child = isLoading and (Roact.createElement("TextLabel", {
		Size = UDim2.fromScale(1, 0),
		BackgroundTransparency = 1,
		Text = "Loading...",
		TextColor3 = currentTheme.colors.text,
		Font = Enum.Font.GothamBold,
		TextSize = 24,
		LayoutOrder = 0,
	}))
	if _child then
		_children_4[_length_4 + 1] = _child
	end
	_length_4 = #_children_4
	local _child_1 = not isLoading and (#scripts == 0 and (searchQuery ~= "" and (Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 0, 200),
		BackgroundTransparency = 1,
		LayoutOrder = 0,
	}, {
		Roact.createElement("TextLabel", {
			Size = UDim2.fromScale(1, 0.4),
			Position = UDim2.fromScale(0.5, 0.3),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Text = "No Results",
			TextSize = 80,
		}),
		Roact.createElement("TextLabel", {
			Size = UDim2.fromScale(1, 0.3),
			Position = UDim2.fromScale(0.5, 0.6),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Text = "No scripts found",
			TextColor3 = currentTheme.colors.textSecondary,
			Font = Enum.Font.GothamBold,
			TextSize = 20,
		}),
	}))))
	if _child_1 then
		_children_4[_length_4 + 1] = _child_1
	end
	_length_4 = #_children_4
	local _condition = not isLoading
	if _condition then
		local _arg0 = function(scr, idx)
			return Roact.createFragment({
				[scr._id] = Roact.createElement(ScriptCard, {
					scriptData = scr,
					theme = currentTheme,
					index = idx + 1,
				}),
			})
		end
		--▼ ReadonlyArray.map ▼
		local _newValue = table.create(#scripts)
		for _k, _v in ipairs(scripts) do
			_newValue[_k] = _arg0(_v, _k - 1, scripts)
		end
		--▲ ReadonlyArray.map ▲
		_condition = _newValue
	end
	if _condition then
		for _k, _v in ipairs(_condition) do
			_children_4[_length_4 + _k] = _v
		end
	end
	_children_3[_length_3 + 1] = Roact.createElement("Frame", _attributes_4, _children_4)
	_children_2[_length_2 + 1] = Roact.createElement("ScrollingFrame", _attributes_3, _children_3)
	_children_2[_length_2 + 2] = Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		Position = UDim2.new(0, 0, 1, -30),
		BackgroundColor3 = currentTheme.colors.surfaceVariant,
		BackgroundTransparency = 0.5,
	}, {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 16),
		}),
		Roact.createElement("TextLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = tostring(#scripts) .. (" scripts | F6 toggle | " .. currentTheme.name),
			TextColor3 = currentTheme.colors.textSecondary,
			Font = Enum.Font.Gotham,
			TextSize = 13,
		}),
	})
	_children_1[_length_1 + 1] = Roact.createElement("Frame", _attributes_2, _children_2)
	_children[_length + 1] = Roact.createElement(Acrylic, _attributes_1, _children_1)
	return Roact.createElement("ScreenGui", _attributes, _children)
end)
local App = AppContent
return {
	App = App,
}
 end, newEnv("SriBlox-Modern.App"))() end)

newInstance("components", "Folder", "SriBlox-Modern.components", "SriBlox-Modern")

newModule("Acrylic", "ModuleScript", "SriBlox-Modern.components.Acrylic", "SriBlox-Modern.components", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.Parent.include.RuntimeLib)
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local hooked = TS.import(script, TS.getModule(script, "@rbxts", "roact-hooked").out).hooked
--[[
	*
	 * Composant Acrylic - Effet de flou backdrop moderne (style Windows 11 / macOS)
	 * CrÃ©e un fond semi-transparent avec effet de flou pour un look premium
	 
]]
local Acrylic = hooked(function(props)
	local _binding = props
	local transparency = _binding.transparency
	if transparency == nil then
		transparency = 0.3
	end
	local blurSize = _binding.blurSize
	if blurSize == nil then
		blurSize = 24
	end
	local tintColor = _binding.tintColor
	if tintColor == nil then
		tintColor = Color3.fromRGB(20, 23, 35)
	end
	local tintTransparency = _binding.tintTransparency
	if tintTransparency == nil then
		tintTransparency = 0.4
	end
	local children = _binding.children
	local _attributes = {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = tintColor,
		BackgroundTransparency = tintTransparency,
		BorderSizePixel = 0,
	}
	local _children = {
		Roact.createElement("ImageLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
			ImageColor3 = tintColor,
			ImageTransparency = transparency,
			ScaleType = Enum.ScaleType.Tile,
		}),
		Roact.createElement("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.98,
			BorderSizePixel = 0,
			ZIndex = 2,
		}, {
			Roact.createElement("UIGradient", {
				Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 210, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
				Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.98), NumberSequenceKeypoint.new(0.5, 0.95), NumberSequenceKeypoint.new(1, 0.98) }),
			}),
		}),
	}
	local _length = #_children
	local _attributes_1 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 3,
	}
	local _children_1 = {}
	local _length_1 = #_children_1
	if children then
		if children.elements ~= nil or children.props ~= nil and children.component ~= nil then
			_children_1[_length_1 + 1] = children
		else
			for _k, _v in ipairs(children) do
				_children_1[_length_1 + _k] = _v
			end
		end
	end
	_children[_length + 1] = Roact.createElement("Frame", _attributes_1, _children_1)
	return Roact.createElement("Frame", _attributes, _children)
end)
return {
	Acrylic = Acrylic,
}
 end, newEnv("SriBlox-Modern.components.Acrylic"))() end)

newModule("ScriptCard", "ModuleScript", "SriBlox-Modern.components.ScriptCard", "SriBlox-Modern.components", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.Parent.include.RuntimeLib)
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _roact_hooked = TS.import(script, TS.getModule(script, "@rbxts", "roact-hooked").out)
local hooked = _roact_hooked.hooked
local useState = _roact_hooked.useState
local useEffect = _roact_hooked.useEffect
local useMemo = _roact_hooked.useMemo
local _flipper = TS.import(script, TS.getModule(script, "@rbxts", "flipper").src)
local SingleMotor = _flipper.SingleMotor
local Spring = _flipper.Spring
local ScriptBloxService = TS.import(script, script.Parent.Parent, "services", "scriptblox.service").ScriptBloxService
--[[
	*
	 * ScriptCard - Carte de script animée avec effets Material Design
	 * 
	 * Features:
	 * - Effet hover avec scale et glow
	 * - Tags colorés et animés
	 * - Gradient background
	 * - Statistiques avec icônes
	 * - Boutons Run et Link avec animations
	 
]]
local ScriptCard = hooked(function(props)
	local _binding = props
	local scriptData = _binding.scriptData
	local theme = _binding.theme
	local index = _binding.index
	local _binding_1 = useState(false)
	local hovered = _binding_1[1]
	local setHovered = _binding_1[2]
	local _binding_2 = useState("idle")
	local runState = _binding_2[1]
	local setRunState = _binding_2[2]
	-- Motors pour animations
	local hoverMotor = useMemo(function()
		return SingleMotor.new(0)
	end, {})
	local _binding_3 = useState(0)
	local hoverProgress = _binding_3[1]
	local setHoverProgress = _binding_3[2]
	-- Animation hover
	useEffect(function()
		hoverMotor:onStep(setHoverProgress)
		return function()
			return hoverMotor:destroy()
		end
	end, {})
	useEffect(function()
		if hovered then
			hoverMotor:setGoal(Spring.new(1, {
				frequency = 4,
				dampingRatio = 0.8,
			}))
		else
			hoverMotor:setGoal(Spring.new(0, {
				frequency = 4,
				dampingRatio = 0.8,
			}))
		end
	end, { hovered })
	-- Interpolations
	local scale = 1 + (hoverProgress * 0.03)
	local glowSize = hoverProgress * 12
	local cardColor = theme.colors.surface:Lerp(theme.colors.surfaceVariant, hoverProgress)
	-- Couleurs des tags
	local tagColors = { theme.colors.primary, theme.colors.secondary, theme.colors.success, theme.colors.warning }
	local handleRun = function()
		setRunState("loading")
		local _exp = ScriptBloxService:executeScript(scriptData.slug)
		local _arg0 = function()
			setRunState("success")
			wait(2)
			setRunState("idle")
		end
		_exp:andThen(_arg0):catch(function()
			setRunState("error")
			wait(2)
			setRunState("idle")
		end)
	end
	local handleCopyLink = function()
		ScriptBloxService:copyScriptUrl(scriptData.slug)
	end
	local _attributes = {
		Size = UDim2.new(1, -8, 0, 180),
		Position = UDim2.new(0, 0, 0, (index - 1) * 184),
		BackgroundColor3 = cardColor,
		BorderSizePixel = 0,
		[Roact.Event.MouseEnter] = function()
			return setHovered(true)
		end,
		[Roact.Event.MouseLeave] = function()
			return setHovered(false)
		end,
	}
	local _children = {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 12),
		}),
		Roact.createElement("UIStroke", {
			Color = theme.colors.outline,
			Transparency = 0.5,
			Thickness = 1,
		}),
		Roact.createElement("ImageLabel", {
			Size = UDim2.new(1, glowSize * 2, 1, glowSize * 2),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
			ImageColor3 = theme.colors.primary,
			ImageTransparency = 1 - hoverProgress * 0.3,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(10, 10, 10, 10),
			ZIndex = 0,
		}),
		Roact.createElement("ImageLabel", {
			Size = UDim2.fromScale(1, 0.4),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = 1,
			Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
			ImageColor3 = theme.colors.primary,
			ImageTransparency = 0.9,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 12),
			}),
		}),
		Roact.createElement("UIScale", {
			Scale = scale,
		}),
	}
	local _length = #_children
	local _attributes_1 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}
	local _children_1 = {
		Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 40),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
		}, {
			Roact.createElement("TextLabel", {
				Size = UDim2.new(1, -60, 0, 24),
				Position = UDim2.new(0, 12, 0, 10),
				BackgroundTransparency = 1,
				Text = scriptData.title,
				Font = Enum.Font.GothamBold,
				TextSize = 16,
				TextColor3 = theme.colors.onSurface,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
			}),
			Roact.createElement("Frame", {
				Size = UDim2.new(0, 32, 0, 24),
				Position = UDim2.new(1, -44, 0, 8),
				BackgroundColor3 = theme.colors.primary,
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				Roact.createElement("TextLabel", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "#" .. tostring(index),
					Font = Enum.Font.GothamBold,
					TextSize = 12,
					TextColor3 = theme.colors.onPrimary,
				}),
			}),
		}),
	}
	local _length_1 = #_children_1
	local _result = scriptData.tags
	if _result ~= nil then
		local _arg0 = function(tag, idx)
			return Roact.createFragment({
				[tag] = Roact.createElement("Frame", {
					Size = UDim2.new(0, 70, 1, 0),
					BackgroundColor3 = tagColors[idx % #tagColors + 1],
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					}),
					Roact.createElement("TextLabel", {
						Size = UDim2.fromScale(1, 1),
						BackgroundTransparency = 1,
						Text = tag,
						Font = Enum.Font.Gotham,
						TextSize = 10,
						TextColor3 = Color3.new(1, 1, 1),
						TextTruncate = Enum.TextTruncate.AtEnd,
					}),
				}),
			})
		end
		--▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_result)
		for _k, _v in ipairs(_result) do
			_newValue[_k] = _arg0(_v, _k - 1, _result)
		end
		--▲ ReadonlyArray.map ▲
		_result = _newValue
	end
	local _attributes_2 = {
		Size = UDim2.new(1, -16, 0, 20),
		Position = UDim2.new(0, 12, 0, 42),
		BackgroundTransparency = 1,
	}
	local _children_2 = {
		Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 4),
		}),
	}
	local _length_2 = #_children_2
	if _result then
		for _k, _v in ipairs(_result) do
			_children_2[_length_2 + _k] = _v
		end
	end
	_children_1[_length_1 + 1] = Roact.createElement("Frame", _attributes_2, _children_2)
	_children_1[_length_1 + 2] = Roact.createElement("TextLabel", {
		Size = UDim2.new(1, -16, 0, 16),
		Position = UDim2.new(0, 12, 0, 68),
		BackgroundTransparency = 1,
		Text = if scriptData.owner then "by " .. scriptData.owner.username else "by Unknown",
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextColor3 = theme.colors.onSurfaceVariant,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	local _attributes_3 = {
		Size = UDim2.new(1, -16, 0, 32),
		Position = UDim2.new(0, 12, 0, 88),
		BackgroundTransparency = 1,
	}
	local _condition = scriptData.features
	if not (_condition ~= "" and _condition) then
		local _result_1 = scriptData.game
		if _result_1 ~= nil then
			_result_1 = _result_1.name
		end
		_condition = _result_1
		if not (_condition ~= "" and _condition) then
			_condition = "No description"
		end
	end
	_attributes_3.Text = _condition
	_attributes_3.Font = Enum.Font.Gotham
	_attributes_3.TextSize = 11
	_attributes_3.TextColor3 = theme.colors.onSurfaceVariant
	_attributes_3.TextXAlignment = Enum.TextXAlignment.Left
	_attributes_3.TextYAlignment = Enum.TextYAlignment.Top
	_attributes_3.TextWrapped = true
	_children_1[_length_1 + 3] = Roact.createElement("TextLabel", _attributes_3)
	local _attributes_4 = {
		Size = UDim2.new(1, -16, 0, 24),
		Position = UDim2.new(0, 12, 0, 128),
		BackgroundTransparency = 1,
	}
	local _children_3 = {
		Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 6),
		}),
	}
	local _length_3 = #_children_3
	local _attributes_5 = {
		Size = UDim2.new(0, 55, 1, 0),
		BackgroundColor3 = theme.colors.surfaceVariant,
	}
	local _children_4 = {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 6),
		}),
	}
	local _length_4 = #_children_4
	local _attributes_6 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}
	local _fn = ScriptBloxService
	local _condition_1 = scriptData.views
	if not (_condition_1 ~= 0 and (_condition_1 == _condition_1 and _condition_1)) then
		_condition_1 = 0
	end
	_attributes_6.Text = _fn:formatNumber(_condition_1)
	_attributes_6.Font = Enum.Font.GothamMedium
	_attributes_6.TextSize = 11
	_attributes_6.TextColor3 = theme.colors.onSurfaceVariant
	_children_4[_length_4 + 1] = Roact.createElement("TextLabel", _attributes_6)
	_children_3[_length_3 + 1] = Roact.createElement("Frame", _attributes_5, _children_4)
	local _attributes_7 = {
		Size = UDim2.new(0, 55, 1, 0),
		BackgroundColor3 = theme.colors.success,
	}
	local _children_5 = {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 6),
		}),
	}
	local _length_5 = #_children_5
	local _attributes_8 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}
	local _fn_1 = ScriptBloxService
	local _condition_2 = scriptData.likes
	if not (_condition_2 ~= 0 and (_condition_2 == _condition_2 and _condition_2)) then
		_condition_2 = 0
	end
	_attributes_8.Text = _fn_1:formatNumber(_condition_2)
	_attributes_8.Font = Enum.Font.GothamBold
	_attributes_8.TextSize = 11
	_attributes_8.TextColor3 = Color3.new(1, 1, 1)
	_children_5[_length_5 + 1] = Roact.createElement("TextLabel", _attributes_8)
	_children_3[_length_3 + 2] = Roact.createElement("Frame", _attributes_7, _children_5)
	local _attributes_9 = {
		Size = UDim2.new(0, 55, 1, 0),
		BackgroundColor3 = theme.colors.primary,
	}
	local _children_6 = {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 6),
		}),
	}
	local _length_6 = #_children_6
	local _attributes_10 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}
	local _result_1 = scriptData.type
	if _result_1 ~= nil then
		_result_1 = string.upper(_result_1)
	end
	local _condition_3 = _result_1
	if not (_condition_3 ~= "" and _condition_3) then
		_condition_3 = "?"
	end
	_attributes_10.Text = _condition_3
	_attributes_10.Font = Enum.Font.GothamBold
	_attributes_10.TextSize = 10
	_attributes_10.TextColor3 = theme.colors.onPrimary
	_children_6[_length_6 + 1] = Roact.createElement("TextLabel", _attributes_10)
	_children_3[_length_3 + 3] = Roact.createElement("Frame", _attributes_9, _children_6)
	_children_1[_length_1 + 4] = Roact.createElement("Frame", _attributes_4, _children_3)
	_children_1[_length_1 + 5] = Roact.createElement("Frame", {
		Size = UDim2.new(1, -16, 0, 28),
		Position = UDim2.new(0, 12, 1, -36),
		BackgroundTransparency = 1,
	}, {
		Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 8),
		}),
		Roact.createElement("TextButton", {
			Size = UDim2.new(0.65, -4, 1, 0),
			BackgroundColor3 = if runState == "loading" then theme.colors.secondary elseif runState == "success" then theme.colors.success elseif runState == "error" then theme.colors.error else theme.colors.primary,
			Text = if runState == "loading" then "LOADING..." elseif runState == "success" then "SUCCESS" elseif runState == "error" then "ERROR" else "RUN SCRIPT",
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = theme.colors.onPrimary,
			[Roact.Event.Activated] = handleRun,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		}),
		Roact.createElement("TextButton", {
			Size = UDim2.new(0.35, -4, 1, 0),
			BackgroundColor3 = theme.colors.secondary,
			Text = "COPY",
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = theme.colors.onSecondary,
			[Roact.Event.Activated] = handleCopyLink,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		}),
	})
	_children[_length + 1] = Roact.createElement("Frame", _attributes_1, _children_1)
	return Roact.createElement("Frame", _attributes, _children)
end)
return {
	ScriptCard = ScriptCard,
}
 end, newEnv("SriBlox-Modern.components.ScriptCard"))() end)

newModule("SearchBar", "ModuleScript", "SriBlox-Modern.components.SearchBar", "SriBlox-Modern.components", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.Parent.include.RuntimeLib)
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _roact_hooked = TS.import(script, TS.getModule(script, "@rbxts", "roact-hooked").out)
local hooked = _roact_hooked.hooked
local useState = _roact_hooked.useState
local useEffect = _roact_hooked.useEffect
local useMemo = _roact_hooked.useMemo
local _flipper = TS.import(script, TS.getModule(script, "@rbxts", "flipper").src)
local SingleMotor = _flipper.SingleMotor
local Spring = _flipper.Spring
--[[
	*
	 * Barre de recherche moderne avec animations Flipper
	 * - Focus effects avec transitions fluides
	 * - Icon animÃ©e
	 * - Bouton paramÃ¨tres intÃ©grÃ©
	 
]]
local SearchBar = hooked(function(props)
	local _binding = props
	local theme = _binding.theme
	local onSearch = _binding.onSearch
	local onSettingsClick = _binding.onSettingsClick
	local placeholder = _binding.placeholder
	local _binding_1 = useState("")
	local query = _binding_1[1]
	local setQuery = _binding_1[2]
	local _binding_2 = useState(false)
	local focused = _binding_2[1]
	local setFocused = _binding_2[2]
	-- Motors pour animations fluides
	local borderColorMotor = useMemo(function()
		return SingleMotor.new(0)
	end, {})
	local scaleMotor = useMemo(function()
		return SingleMotor.new(1)
	end, {})
	local glowMotor = useMemo(function()
		return SingleMotor.new(0)
	end, {})
	local _binding_3 = useState(0)
	local borderProgress = _binding_3[1]
	local setBorderProgress = _binding_3[2]
	local _binding_4 = useState(1)
	local scale = _binding_4[1]
	local setScale = _binding_4[2]
	local _binding_5 = useState(0)
	local glowIntensity = _binding_5[1]
	local setGlowIntensity = _binding_5[2]
	-- Animation au focus
	useEffect(function()
		borderColorMotor:onStep(setBorderProgress)
		scaleMotor:onStep(setScale)
		glowMotor:onStep(setGlowIntensity)
		if focused then
			borderColorMotor:setGoal(Spring.new(1, {
				frequency = 3,
				dampingRatio = 0.8,
			}))
			scaleMotor:setGoal(Spring.new(1.02, {
				frequency = 4,
			}))
			glowMotor:setGoal(Spring.new(1, {
				frequency = 3,
			}))
		else
			borderColorMotor:setGoal(Spring.new(0, {
				frequency = 3,
			}))
			scaleMotor:setGoal(Spring.new(1, {
				frequency = 4,
			}))
			glowMotor:setGoal(Spring.new(0, {
				frequency = 3,
			}))
		end
		return function()
			borderColorMotor:destroy()
			scaleMotor:destroy()
			glowMotor:destroy()
		end
	end, { focused })
	-- Interpoler les couleurs
	local borderColor = theme.colors.border:Lerp(theme.colors.primary, borderProgress)
	local iconColor = theme.colors.textSecondary:Lerp(theme.colors.primary, borderProgress)
	return Roact.createElement("Frame", {
		Size = UDim2.new(0, 560, 0, 48),
		Position = UDim2.fromScale(0.5, 0.12),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = theme.colors.surface,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
	}, {
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 14),
		}),
		Roact.createElement("UIStroke", {
			Color = borderColor,
			Thickness = 2,
			Transparency = 0.2,
		}),
		Roact.createElement("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
			Thickness = 1,
			Transparency = 0.9,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}),
		Roact.createElement("ImageLabel", {
			Size = UDim2.new(0, 24, 0, 24),
			Position = UDim2.new(0, 16, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Image = "rbxassetid://7733960981",
			ImageColor3 = iconColor,
			ImageTransparency = 0,
		}),
		Roact.createElement("TextBox", {
			Size = UDim2.new(1, -100, 1, -12),
			Position = UDim2.new(0, 50, 0, 6),
			BackgroundTransparency = 1,
			Text = query,
			PlaceholderText = "Search ScriptBlox scripts...",
			PlaceholderColor3 = theme.colors.textSecondary,
			TextColor3 = theme.colors.text,
			Font = Enum.Font.GothamSemibold,
			TextSize = 18,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = false,
			[Roact.Event.Focused] = function()
				return setFocused(true)
			end,
			[Roact.Event.FocusLost] = function(rbx, enterPressed)
				setFocused(false)
				if enterPressed and #query > 0 then
					onSearch(query)
				end
			end,
			[Roact.Change.Text] = function(rbx)
				return setQuery(rbx.Text)
			end,
		}),
		Roact.createElement("TextButton", {
			Size = UDim2.new(0, 36, 0, 36),
			Position = UDim2.new(1, -44, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = theme.colors.surfaceVariant,
			BackgroundTransparency = 0,
			Text = "âš™",
			TextColor3 = theme.colors.primary,
			TextSize = 20,
			Font = Enum.Font.GothamBold,
			AutoButtonColor = false,
			[Roact.Event.MouseButton1Click] = onSettingsClick,
			[Roact.Event.MouseEnter] = function(rbx)
				-- Hover effect
				local tween = game:GetService("TweenService"):Create(rbx, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
					BackgroundColor3 = theme.colors.primary,
				})
				tween:Play()
			end,
			[Roact.Event.MouseLeave] = function(rbx)
				local tween = game:GetService("TweenService"):Create(rbx, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
					BackgroundColor3 = theme.colors.surfaceVariant,
				})
				tween:Play()
			end,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 10),
			}),
		}),
	})
end)
return {
	SearchBar = SearchBar,
}
 end, newEnv("SriBlox-Modern.components.SearchBar"))() end)

newInstance("hooks", "Folder", "SriBlox-Modern.hooks", "SriBlox-Modern")

newModule("main", "LocalScript", "SriBlox-Modern.main", "SriBlox-Modern", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.include.RuntimeLib)
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local App = TS.import(script, script.Parent, "App").App
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
--[[
	*
	 * Point d'entrée de SriBlox Modern
	 * Monte l'application dans PlayerGui
	 
]]
local tree = Roact.mount(Roact.createElement(App), PlayerGui, "SriBloxModern")
print("SriBlox Modern v2.0 loaded! Press F6 to toggle.")
-- Cleanup au démontage
game:GetService("RunService").Heartbeat:Connect(function() end)
 end, newEnv("SriBlox-Modern.main"))() end)

newInstance("services", "Folder", "SriBlox-Modern.services", "SriBlox-Modern")

newModule("scriptblox.service", "ModuleScript", "SriBlox-Modern.services.scriptblox.service", "SriBlox-Modern.services", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.Parent.include.RuntimeLib)
local HttpService = TS.import(script, TS.getModule(script, "@rbxts", "services")).HttpService
local BASE_URL = "https://scriptblox.com/api/script"
local ScriptBloxService
do
	ScriptBloxService = setmetatable({}, {
		__tostring = function()
			return "ScriptBloxService"
		end,
	})
	ScriptBloxService.__index = ScriptBloxService
	function ScriptBloxService.new(...)
		local self = setmetatable({}, ScriptBloxService)
		return self:constructor(...) or self
	end
	function ScriptBloxService:constructor()
	end
	function ScriptBloxService:searchScripts(query, page, maxResults)
		if page == nil then
			page = 1
		end
		if maxResults == nil then
			maxResults = 12
		end
		return TS.Promise.new(function(resolve, reject)
			local encodedQuery = HttpService:UrlEncode(query)
			local url = BASE_URL .. ("/search?q=" .. (encodedQuery .. ("&mode=free&max=" .. (tostring(maxResults) .. ("&page=" .. tostring(page))))))
			TS.try(function()
				local response = HttpService:GetAsync(url)
				local data = HttpService:JSONDecode(response)
				resolve(data)
			end, function(error)
				reject("Search failed: " .. tostring(error))
			end)
		end)
	end
	function ScriptBloxService:getScriptCode(slug)
		return TS.Promise.new(function(resolve, reject)
			local url = BASE_URL .. ("/" .. slug)
			TS.try(function()
				local response = HttpService:GetAsync(url)
				local data = HttpService:JSONDecode(response)
				local _value = data.script and data.script.script
				if _value ~= "" and _value then
					resolve(data.script.script)
				else
					reject("Script code not found")
				end
			end, function(error)
				reject("Failed to fetch script: " .. tostring(error))
			end)
		end)
	end
	function ScriptBloxService:executeScript(slug)
		return TS.Promise.new(function(resolve, reject)
			local _exp = self:getScriptCode(slug)
			local _arg0 = function(code)
				TS.try(function()
					if loadstring then
						local loadedFunc = loadstring(code)
						if loadedFunc then
							loadedFunc()
							resolve()
						else
							reject("Failed to load script")
						end
					else
						reject("loadstring not available")
					end
				end, function(error)
					reject("Execution failed: " .. tostring(error))
				end)
			end
			_exp:andThen(_arg0):catch(reject)
		end)
	end
	function ScriptBloxService:copyScriptUrl(slug)
		local url = "https://scriptblox.com/script/" .. slug
		-- setclipboard (fonctionne uniquement dans les executors)
		local setClipFunc = setclipboard
		if setClipFunc then
			setClipFunc(url)
		else
			warn("setclipboard not available - URL: " .. url)
		end
	end
	function ScriptBloxService:formatNumber(num)
		if not (num ~= 0 and (num == num and num)) then
			return "0"
		end
		if num >= 1000000 then
			return tostring(math.floor(num / 100000) / 10) .. "M"
		end
		if num >= 1000 then
			return tostring(math.floor(num / 100) / 10) .. "K"
		end
		return tostring(num)
	end
	function ScriptBloxService:formatDate(dateString)
		if not (dateString ~= "" and dateString) then
			return ""
		end
		local year, month, day = string.match(dateString, "(%d+)%-(%d+)%-(%d+)")
		local _condition = year
		if _condition ~= "" and _condition then
			_condition = month
			if _condition ~= "" and _condition then
				_condition = day
			end
		end
		if _condition ~= "" and _condition then
			return day .. ("/" .. (month .. ("/" .. year)))
		end
		return dateString
	end
end
return {
	ScriptBloxService = ScriptBloxService,
}
 end, newEnv("SriBlox-Modern.services.scriptblox.service"))() end)

newInstance("store", "Folder", "SriBlox-Modern.store", "SriBlox-Modern")

newModule("actions", "ModuleScript", "SriBlox-Modern.store.actions", "SriBlox-Modern.store", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
-- Action types
-- Action creators
-- Union type pour toutes les actions
-- Action creators functions
local setSearchQuery = function(query)
	return {
		type = "SET_SEARCH_QUERY",
		query = query,
	}
end
local setSearchResults = function(results, totalPages)
	return {
		type = "SET_SEARCH_RESULTS",
		results = results,
		totalPages = totalPages,
	}
end
local setLoading = function(loading)
	return {
		type = "SET_LOADING",
		loading = loading,
	}
end
local setError = function(errorMessage)
	return {
		type = "SET_ERROR",
		errorMessage = errorMessage,
	}
end
local setCurrentPage = function(page)
	return {
		type = "SET_CURRENT_PAGE",
		page = page,
	}
end
local toggleVisibility = function()
	return {
		type = "TOGGLE_VISIBILITY",
	}
end
local setTheme = function(theme)
	return {
		type = "SET_THEME",
		theme = theme,
	}
end
local setThemeSelectorOpen = function(open)
	return {
		type = "SET_THEME_SELECTOR_OPEN",
		open = open,
	}
end
return {
	setSearchQuery = setSearchQuery,
	setSearchResults = setSearchResults,
	setLoading = setLoading,
	setError = setError,
	setCurrentPage = setCurrentPage,
	toggleVisibility = toggleVisibility,
	setTheme = setTheme,
	setThemeSelectorOpen = setThemeSelectorOpen,
}
 end, newEnv("SriBlox-Modern.store.actions"))() end)

newModule("reducer", "ModuleScript", "SriBlox-Modern.store.reducer", "SriBlox-Modern.store", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
-- État initial
local initialState = {
	search = {
		query = "",
		results = {},
		loading = false,
		error = nil,
		page = 1,
		totalPages = 1,
	},
	ui = {
		visible = false,
		currentTheme = "dark",
		searchBarFocused = false,
	},
}
-- Reducer principal
local rootReducer = function(state, action)
	if state == nil then
		state = initialState
	end
	local _exp = action.type
	repeat
		if _exp == "SET_SEARCH_QUERY" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "search"
			local _object_1 = {}
			for _k, _v in pairs(state.search) do
				_object_1[_k] = _v
			end
			_object_1.query = action.query
			_object[_left] = _object_1
			return _object
		end
		if _exp == "SET_SEARCH_RESULTS" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "search"
			local _object_1 = {}
			for _k, _v in pairs(state.search) do
				_object_1[_k] = _v
			end
			_object_1.results = action.results
			_object_1.totalPages = action.totalPages
			_object_1.loading = false
			_object_1.error = nil
			_object[_left] = _object_1
			return _object
		end
		if _exp == "SET_LOADING" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "search"
			local _object_1 = {}
			for _k, _v in pairs(state.search) do
				_object_1[_k] = _v
			end
			_object_1.loading = action.loading
			_object[_left] = _object_1
			return _object
		end
		if _exp == "SET_ERROR" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "search"
			local _object_1 = {}
			for _k, _v in pairs(state.search) do
				_object_1[_k] = _v
			end
			_object_1.error = action.errorMessage
			_object_1.loading = false
			_object[_left] = _object_1
			return _object
		end
		if _exp == "SET_CURRENT_PAGE" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "search"
			local _object_1 = {}
			for _k, _v in pairs(state.search) do
				_object_1[_k] = _v
			end
			_object_1.page = action.page
			_object[_left] = _object_1
			return _object
		end
		if _exp == "TOGGLE_VISIBILITY" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "ui"
			local _object_1 = {}
			for _k, _v in pairs(state.ui) do
				_object_1[_k] = _v
			end
			_object_1.visible = not state.ui.visible
			_object[_left] = _object_1
			return _object
		end
		if _exp == "SET_THEME" then
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "ui"
			local _object_1 = {}
			for _k, _v in pairs(state.ui) do
				_object_1[_k] = _v
			end
			_object_1.currentTheme = action.theme.name
			_object[_left] = _object_1
			return _object
		end
		if _exp == "SET_THEME_SELECTOR_OPEN" then
			-- Nous utilisons searchBarFocused pour simuler themeSelectorOpen
			local _object = {}
			for _k, _v in pairs(state) do
				_object[_k] = _v
			end
			local _left = "ui"
			local _object_1 = {}
			for _k, _v in pairs(state.ui) do
				_object_1[_k] = _v
			end
			_object_1.searchBarFocused = action.open
			_object[_left] = _object_1
			return _object
		end
		return state
	until true
end
return {
	rootReducer = rootReducer,
}
 end, newEnv("SriBlox-Modern.store.reducer"))() end)

newModule("store", "ModuleScript", "SriBlox-Modern.store.store", "SriBlox-Modern.store", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
local TS = require(script.Parent.Parent.include.RuntimeLib)
local Rodux = TS.import(script, TS.getModule(script, "@rbxts", "rodux").src)
local rootReducer = TS.import(script, script.Parent, "reducer").rootReducer
-- Création du store Rodux
local store = Rodux.Store.new(rootReducer)
-- Type pour le dispatch
-- Export du store configuré
local default = store
return {
	store = store,
	default = default,
}
 end, newEnv("SriBlox-Modern.store.store"))() end)

newInstance("themes", "Folder", "SriBlox-Modern.themes", "SriBlox-Modern")

newModule("themes", "ModuleScript", "SriBlox-Modern.themes.themes", "SriBlox-Modern.themes", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
-- Thème Sombre Moderne (Style Orca avec gradients)
local darkTheme = {
	name = "Dark",
	colors = {
		background = Color3.fromRGB(12, 14, 22),
		surface = Color3.fromRGB(20, 23, 35),
		surfaceVariant = Color3.fromRGB(28, 32, 45),
		primary = Color3.fromRGB(88, 134, 255),
		primaryVariant = Color3.fromRGB(65, 105, 225),
		secondary = Color3.fromRGB(120, 140, 255),
		accent = Color3.fromRGB(138, 180, 255),
		text = Color3.fromRGB(235, 238, 250),
		textSecondary = Color3.fromRGB(160, 170, 200),
		success = Color3.fromRGB(72, 220, 140),
		warning = Color3.fromRGB(255, 184, 72),
		error = Color3.fromRGB(255, 92, 110),
		border = Color3.fromRGB(60, 70, 100),
		borderLight = Color3.fromRGB(40, 48, 70),
		outline = Color3.fromRGB(60, 70, 100),
		onSurface = Color3.fromRGB(235, 238, 250),
		onSurfaceVariant = Color3.fromRGB(160, 170, 200),
		onPrimary = Color3.fromRGB(255, 255, 255),
		onSecondary = Color3.fromRGB(255, 255, 255),
	},
	gradients = {
		primary = { Color3.fromRGB(88, 134, 255), Color3.fromRGB(138, 92, 246) },
		card = { Color3.fromRGB(20, 23, 35), Color3.fromRGB(28, 32, 45) },
		accent = { Color3.fromRGB(72, 220, 140), Color3.fromRGB(88, 134, 255) },
	},
	blur = {
		enabled = true,
		intensity = 32,
	},
}
-- Thème Clair Moderne (Style macOS Big Sur)
local lightTheme = {
	name = "Light",
	colors = {
		background = Color3.fromRGB(245, 247, 252),
		surface = Color3.fromRGB(255, 255, 255),
		surfaceVariant = Color3.fromRGB(248, 250, 255),
		primary = Color3.fromRGB(0, 122, 255),
		primaryVariant = Color3.fromRGB(10, 132, 255),
		secondary = Color3.fromRGB(88, 86, 214),
		accent = Color3.fromRGB(52, 199, 89),
		text = Color3.fromRGB(28, 32, 45),
		textSecondary = Color3.fromRGB(100, 110, 140),
		success = Color3.fromRGB(52, 199, 89),
		warning = Color3.fromRGB(255, 159, 10),
		error = Color3.fromRGB(255, 69, 58),
		border = Color3.fromRGB(200, 210, 230),
		borderLight = Color3.fromRGB(220, 225, 240),
		outline = Color3.fromRGB(200, 210, 230),
		onSurface = Color3.fromRGB(28, 32, 45),
		onSurfaceVariant = Color3.fromRGB(100, 110, 140),
		onPrimary = Color3.fromRGB(255, 255, 255),
		onSecondary = Color3.fromRGB(255, 255, 255),
	},
	gradients = {
		primary = { Color3.fromRGB(0, 122, 255), Color3.fromRGB(88, 86, 214) },
		card = { Color3.fromRGB(255, 255, 255), Color3.fromRGB(248, 250, 255) },
		accent = { Color3.fromRGB(52, 199, 89), Color3.fromRGB(0, 122, 255) },
	},
	blur = {
		enabled = true,
		intensity = 24,
	},
}
-- Thème Coloré (Style Discord/Gaming avec néons)
local colorfulTheme = {
	name = "Colorful",
	colors = {
		background = Color3.fromRGB(44, 27, 66),
		surface = Color3.fromRGB(58, 38, 84),
		surfaceVariant = Color3.fromRGB(70, 48, 100),
		primary = Color3.fromRGB(162, 89, 255),
		primaryVariant = Color3.fromRGB(138, 68, 234),
		secondary = Color3.fromRGB(255, 107, 237),
		accent = Color3.fromRGB(89, 242, 255),
		text = Color3.fromRGB(250, 245, 255),
		textSecondary = Color3.fromRGB(200, 190, 220),
		success = Color3.fromRGB(87, 242, 135),
		warning = Color3.fromRGB(255, 202, 40),
		error = Color3.fromRGB(255, 85, 127),
		border = Color3.fromRGB(120, 80, 160),
		borderLight = Color3.fromRGB(90, 60, 130),
		outline = Color3.fromRGB(120, 80, 160),
		onSurface = Color3.fromRGB(250, 245, 255),
		onSurfaceVariant = Color3.fromRGB(200, 190, 220),
		onPrimary = Color3.fromRGB(255, 255, 255),
		onSecondary = Color3.fromRGB(255, 255, 255),
	},
	gradients = {
		primary = { Color3.fromRGB(162, 89, 255), Color3.fromRGB(255, 107, 237) },
		card = { Color3.fromRGB(58, 38, 84), Color3.fromRGB(70, 48, 100) },
		accent = { Color3.fromRGB(89, 242, 255), Color3.fromRGB(162, 89, 255) },
	},
	blur = {
		enabled = true,
		intensity = 40,
	},
}
-- Thème Cyberpunk (Nouveauté - style futuriste)
local cyberpunkTheme = {
	name = "Cyberpunk",
	colors = {
		background = Color3.fromRGB(10, 10, 15),
		surface = Color3.fromRGB(18, 18, 25),
		surfaceVariant = Color3.fromRGB(25, 25, 35),
		primary = Color3.fromRGB(0, 255, 255),
		primaryVariant = Color3.fromRGB(0, 200, 255),
		secondary = Color3.fromRGB(255, 0, 255),
		accent = Color3.fromRGB(255, 255, 0),
		text = Color3.fromRGB(240, 255, 255),
		textSecondary = Color3.fromRGB(180, 200, 220),
		success = Color3.fromRGB(0, 255, 128),
		warning = Color3.fromRGB(255, 200, 0),
		error = Color3.fromRGB(255, 0, 100),
		border = Color3.fromRGB(0, 200, 200),
		borderLight = Color3.fromRGB(0, 150, 150),
		outline = Color3.fromRGB(0, 200, 200),
		onSurface = Color3.fromRGB(240, 255, 255),
		onSurfaceVariant = Color3.fromRGB(180, 200, 220),
		onPrimary = Color3.fromRGB(0, 0, 0),
		onSecondary = Color3.fromRGB(0, 0, 0),
	},
	gradients = {
		primary = { Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255) },
		card = { Color3.fromRGB(18, 18, 25), Color3.fromRGB(25, 25, 35) },
		accent = { Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 255, 0) },
	},
	blur = {
		enabled = true,
		intensity = 48,
	},
}
local themes = {
	dark = darkTheme,
	light = lightTheme,
	colorful = colorfulTheme,
	cyberpunk = cyberpunkTheme,
}
local defaultTheme = darkTheme
return {
	darkTheme = darkTheme,
	lightTheme = lightTheme,
	colorfulTheme = colorfulTheme,
	cyberpunkTheme = cyberpunkTheme,
	themes = themes,
	defaultTheme = defaultTheme,
}
 end, newEnv("SriBlox-Modern.themes.themes"))() end)

newInstance("types", "Folder", "SriBlox-Modern.types", "SriBlox-Modern")

newModule("types", "ModuleScript", "SriBlox-Modern.types", "SriBlox-Modern", function () return setfenv(function() --Compiled with roblox-ts v1.3.3
-- Types pour SriBlox Modern
return nil
 end, newEnv("SriBlox-Modern.types"))() end)

newInstance("include", "Folder", "SriBlox-Modern.include", "SriBlox-Modern")

newModule("Promise", "ModuleScript", "SriBlox-Modern.include.Promise", "SriBlox-Modern.include", function () return setfenv(function() --[[
	An implementation of Promises similar to Promise/A+.
]]

local ERROR_NON_PROMISE_IN_LIST = "Non-promise value passed into %s at index %s"
local ERROR_NON_LIST = "Please pass a list of promises to %s"
local ERROR_NON_FUNCTION = "Please pass a handler function to %s!"
local MODE_KEY_METATABLE = { __mode = "k" }

local function isCallable(value)
	if type(value) == "function" then
		return true
	end

	if type(value) == "table" then
		local metatable = getmetatable(value)
		if metatable and type(rawget(metatable, "__call")) == "function" then
			return true
		end
	end

	return false
end

--[[
	Creates an enum dictionary with some metamethods to prevent common mistakes.
]]
local function makeEnum(enumName, members)
	local enum = {}

	for _, memberName in ipairs(members) do
		enum[memberName] = memberName
	end

	return setmetatable(enum, {
		__index = function(_, k)
			error(string.format("%s is not in %s!", k, enumName), 2)
		end,
		__newindex = function()
			error(string.format("Creating new members in %s is not allowed!", enumName), 2)
		end,
	})
end

--[=[
	An object to represent runtime errors that occur during execution.
	Promises that experience an error like this will be rejected with
	an instance of this object.

	@class Error
]=]
local Error
do
	Error = {
		Kind = makeEnum("Promise.Error.Kind", {
			"ExecutionError",
			"AlreadyCancelled",
			"NotResolvedInTime",
			"TimedOut",
		}),
	}
	Error.__index = Error

	function Error.new(options, parent)
		options = options or {}
		return setmetatable({
			error = tostring(options.error) or "[This error has no error text.]",
			trace = options.trace,
			context = options.context,
			kind = options.kind,
			parent = parent,
			createdTick = os.clock(),
			createdTrace = debug.traceback(),
		}, Error)
	end

	function Error.is(anything)
		if type(anything) == "table" then
			local metatable = getmetatable(anything)

			if type(metatable) == "table" then
				return rawget(anything, "error") ~= nil and type(rawget(metatable, "extend")) == "function"
			end
		end

		return false
	end

	function Error.isKind(anything, kind)
		assert(kind ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")

		return Error.is(anything) and anything.kind == kind
	end

	function Error:extend(options)
		options = options or {}

		options.kind = options.kind or self.kind

		return Error.new(options, self)
	end

	function Error:getErrorChain()
		local runtimeErrors = { self }

		while runtimeErrors[#runtimeErrors].parent do
			table.insert(runtimeErrors, runtimeErrors[#runtimeErrors].parent)
		end

		return runtimeErrors
	end

	function Error:__tostring()
		local errorStrings = {
			string.format("-- Promise.Error(%s) --", self.kind or "?"),
		}

		for _, runtimeError in ipairs(self:getErrorChain()) do
			table.insert(
				errorStrings,
				table.concat({
					runtimeError.trace or runtimeError.error,
					runtimeError.context,
				}, "\n")
			)
		end

		return table.concat(errorStrings, "\n")
	end
end

--[[
	Packs a number of arguments into a table and returns its length.

	Used to cajole varargs without dropping sparse values.
]]
local function pack(...)
	return select("#", ...), { ... }
end

--[[
	Returns first value (success), and packs all following values.
]]
local function packResult(success, ...)
	return success, select("#", ...), { ... }
end

local function makeErrorHandler(traceback)
	assert(traceback ~= nil, "traceback is nil")

	return function(err)
		-- If the error object is already a table, forward it directly.
		-- Should we extend the error here and add our own trace?

		if type(err) == "table" then
			return err
		end

		return Error.new({
			error = err,
			kind = Error.Kind.ExecutionError,
			trace = debug.traceback(tostring(err), 2),
			context = "Promise created at:\n\n" .. traceback,
		})
	end
end

--[[
	Calls a Promise executor with error handling.
]]
local function runExecutor(traceback, callback, ...)
	return packResult(xpcall(callback, makeErrorHandler(traceback), ...))
end

--[[
	Creates a function that invokes a callback with correct error handling and
	resolution mechanisms.
]]
local function createAdvancer(traceback, callback, resolve, reject)
	return function(...)
		local ok, resultLength, result = runExecutor(traceback, callback, ...)

		if ok then
			resolve(unpack(result, 1, resultLength))
		else
			reject(result[1])
		end
	end
end

local function isEmpty(t)
	return next(t) == nil
end

--[=[
	An enum value used to represent the Promise's status.
	@interface Status
	@tag enum
	@within Promise
	.Started "Started" -- The Promise is executing, and not settled yet.
	.Resolved "Resolved" -- The Promise finished successfully.
	.Rejected "Rejected" -- The Promise was rejected.
	.Cancelled "Cancelled" -- The Promise was cancelled before it finished.
]=]
--[=[
	@prop Status Status
	@within Promise
	@readonly
	@tag enums
	A table containing all members of the `Status` enum, e.g., `Promise.Status.Resolved`.
]=]
--[=[
	A Promise is an object that represents a value that will exist in the future, but doesn't right now.
	Promises allow you to then attach callbacks that can run once the value becomes available (known as *resolving*),
	or if an error has occurred (known as *rejecting*).

	@class Promise
	@__index prototype
]=]
local Promise = {
	Error = Error,
	Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
	_getTime = os.clock,
	_timeEvent = game:GetService("RunService").Heartbeat,
	_unhandledRejectionCallbacks = {},
}
Promise.prototype = {}
Promise.__index = Promise.prototype

function Promise._new(traceback, callback, parent)
	if parent ~= nil and not Promise.is(parent) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end

	local self = {
		-- Used to locate where a promise was created
		_source = traceback,

		_status = Promise.Status.Started,

		-- A table containing a list of all results, whether success or failure.
		-- Only valid if _status is set to something besides Started
		_values = nil,

		-- Lua doesn't like sparse arrays very much, so we explicitly store the
		-- length of _values to handle middle nils.
		_valuesLength = -1,

		-- Tracks if this Promise has no error observers..
		_unhandledRejection = true,

		-- Queues representing functions we should invoke when we update!
		_queuedResolve = {},
		_queuedReject = {},
		_queuedFinally = {},

		-- The function to run when/if this promise is cancelled.
		_cancellationHook = nil,

		-- The "parent" of this promise in a promise chain. Required for
		-- cancellation propagation upstream.
		_parent = parent,

		-- Consumers are Promises that have chained onto this one.
		-- We track them for cancellation propagation downstream.
		_consumers = setmetatable({}, MODE_KEY_METATABLE),
	}

	if parent and parent._status == Promise.Status.Started then
		parent._consumers[self] = true
	end

	setmetatable(self, Promise)

	local function resolve(...)
		self:_resolve(...)
	end

	local function reject(...)
		self:_reject(...)
	end

	local function onCancel(cancellationHook)
		if cancellationHook then
			if self._status == Promise.Status.Cancelled then
				cancellationHook()
			else
				self._cancellationHook = cancellationHook
			end
		end

		return self._status == Promise.Status.Cancelled
	end

	coroutine.wrap(function()
		local ok, _, result = runExecutor(self._source, callback, resolve, reject, onCancel)

		if not ok then
			reject(result[1])
		end
	end)()

	return self
end

--[=[
	Construct a new Promise that will be resolved or rejected with the given callbacks.

	If you `resolve` with a Promise, it will be chained onto.

	You can safely yield within the executor function and it will not block the creating thread.

	```lua
	local myFunction()
		return Promise.new(function(resolve, reject, onCancel)
			wait(1)
			resolve("Hello world!")
		end)
	end

	myFunction():andThen(print)
	```

	You do not need to use `pcall` within a Promise. Errors that occur during execution will be caught and turned into a rejection automatically. If `error()` is called with a table, that table will be the rejection value. Otherwise, string errors will be converted into `Promise.Error(Promise.Error.Kind.ExecutionError)` objects for tracking debug information.

	You may register an optional cancellation hook by using the `onCancel` argument:

	* This should be used to abort any ongoing operations leading up to the promise being settled.
	* Call the `onCancel` function with a function callback as its only argument to set a hook which will in turn be called when/if the promise is cancelled.
	* `onCancel` returns `true` if the Promise was already cancelled when you called `onCancel`.
	* Calling `onCancel` with no argument will not override a previously set cancellation hook, but it will still return `true` if the Promise is currently cancelled.
	* You can set the cancellation hook at any time before resolving.
	* When a promise is cancelled, calls to `resolve` or `reject` will be ignored, regardless of if you set a cancellation hook or not.

	@param executor (resolve: (...: any) -> (), reject: (...: any) -> (), onCancel: (abortHandler?: () -> ()) -> boolean) -> ()
	@return Promise
]=]
function Promise.new(executor)
	return Promise._new(debug.traceback(nil, 2), executor)
end

function Promise:__tostring()
	return string.format("Promise(%s)", self._status)
end

--[=[
	The same as [Promise.new](/api/Promise#new), except execution begins after the next `Heartbeat` event.

	This is a spiritual replacement for `spawn`, but it does not suffer from the same [issues](https://eryn.io/gist/3db84579866c099cdd5bb2ff37947cec) as `spawn`.

	```lua
	local function waitForChild(instance, childName, timeout)
	  return Promise.defer(function(resolve, reject)
		local child = instance:WaitForChild(childName, timeout)

		;(child and resolve or reject)(child)
	  end)
	end
	```

	@param executor (resolve: (...: any) -> (), reject: (...: any) -> (), onCancel: (abortHandler?: () -> ()) -> boolean) -> ()
	@return Promise
]=]
function Promise.defer(executor)
	local traceback = debug.traceback(nil, 2)
	local promise
	promise = Promise._new(traceback, function(resolve, reject, onCancel)
		local connection
		connection = Promise._timeEvent:Connect(function()
			connection:Disconnect()
			local ok, _, result = runExecutor(traceback, executor, resolve, reject, onCancel)

			if not ok then
				reject(result[1])
			end
		end)
	end)

	return promise
end

-- Backwards compatibility
Promise.async = Promise.defer

--[=[
	Creates an immediately resolved Promise with the given value.

	```lua
	-- Example using Promise.resolve to deliver cached values:
	function getSomething(name)
		if cache[name] then
			return Promise.resolve(cache[name])
		else
			return Promise.new(function(resolve, reject)
				local thing = getTheThing()
				cache[name] = thing

				resolve(thing)
			end)
		end
	end
	```

	@param ... any
	@return Promise<...any>
]=]
function Promise.resolve(...)
	local length, values = pack(...)
	return Promise._new(debug.traceback(nil, 2), function(resolve)
		resolve(unpack(values, 1, length))
	end)
end

--[=[
	Creates an immediately rejected Promise with the given value.

	:::caution
	Something needs to consume this rejection (i.e. `:catch()` it), otherwise it will emit an unhandled Promise rejection warning on the next frame. Thus, you should not create and store rejected Promises for later use. Only create them on-demand as needed.
	:::

	@param ... any
	@return Promise<...any>
]=]
function Promise.reject(...)
	local length, values = pack(...)
	return Promise._new(debug.traceback(nil, 2), function(_, reject)
		reject(unpack(values, 1, length))
	end)
end

--[[
	Runs a non-promise-returning function as a Promise with the
  given arguments.
]]
function Promise._try(traceback, callback, ...)
	local valuesLength, values = pack(...)

	return Promise._new(traceback, function(resolve)
		resolve(callback(unpack(values, 1, valuesLength)))
	end)
end

--[=[
	Begins a Promise chain, calling a function and returning a Promise resolving with its return value. If the function errors, the returned Promise will be rejected with the error. You can safely yield within the Promise.try callback.

	:::info
	`Promise.try` is similar to [Promise.promisify](#promisify), except the callback is invoked immediately instead of returning a new function.
	:::

	```lua
	Promise.try(function()
		return math.random(1, 2) == 1 and "ok" or error("Oh an error!")
	end)
		:andThen(function(text)
			print(text)
		end)
		:catch(function(err)
			warn("Something went wrong")
		end)
	```

	@param callback (...: T...) -> ...any
	@param ... T... -- Additional arguments passed to `callback`
	@return Promise
]=]
function Promise.try(callback, ...)
	return Promise._try(debug.traceback(nil, 2), callback, ...)
end

--[[
	Returns a new promise that:
		* is resolved when all input promises resolve
		* is rejected if ANY input promises reject
]]
function Promise._all(traceback, promises, amount)
	if type(promises) ~= "table" then
		error(string.format(ERROR_NON_LIST, "Promise.all"), 3)
	end

	-- We need to check that each value is a promise here so that we can produce
	-- a proper error rather than a rejected promise with our error.
	for i, promise in pairs(promises) do
		if not Promise.is(promise) then
			error(string.format(ERROR_NON_PROMISE_IN_LIST, "Promise.all", tostring(i)), 3)
		end
	end

	-- If there are no values then return an already resolved promise.
	if #promises == 0 or amount == 0 then
		return Promise.resolve({})
	end

	return Promise._new(traceback, function(resolve, reject, onCancel)
		-- An array to contain our resolved values from the given promises.
		local resolvedValues = {}
		local newPromises = {}

		-- Keep a count of resolved promises because just checking the resolved
		-- values length wouldn't account for promises that resolve with nil.
		local resolvedCount = 0
		local rejectedCount = 0
		local done = false

		local function cancel()
			for _, promise in ipairs(newPromises) do
				promise:cancel()
			end
		end

		-- Called when a single value is resolved and resolves if all are done.
		local function resolveOne(i, ...)
			if done then
				return
			end

			resolvedCount = resolvedCount + 1

			if amount == nil then
				resolvedValues[i] = ...
			else
				resolvedValues[resolvedCount] = ...
			end

			if resolvedCount >= (amount or #promises) then
				done = true
				resolve(resolvedValues)
				cancel()
			end
		end

		onCancel(cancel)

		-- We can assume the values inside `promises` are all promises since we
		-- checked above.
		for i, promise in ipairs(promises) do
			newPromises[i] = promise:andThen(function(...)
				resolveOne(i, ...)
			end, function(...)
				rejectedCount = rejectedCount + 1

				if amount == nil or #promises - rejectedCount < amount then
					cancel()
					done = true

					reject(...)
				end
			end)
		end

		if done then
			cancel()
		end
	end)
end

--[=[
	Accepts an array of Promises and returns a new promise that:
	* is resolved after all input promises resolve.
	* is rejected if *any* input promises reject.

	:::info
	Only the first return value from each promise will be present in the resulting array.
	:::

	After any input Promise rejects, all other input Promises that are still pending will be cancelled if they have no other consumers.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.all(promises)
	```

	@param promises {Promise<T>}
	@return Promise<{T}>
]=]
function Promise.all(promises)
	return Promise._all(debug.traceback(nil, 2), promises)
end

--[=[
	Folds an array of values or promises into a single value. The array is traversed sequentially.

	The reducer function can return a promise or value directly. Each iteration receives the resolved value from the previous, and the first receives your defined initial value.

	The folding will stop at the first rejection encountered.
	```lua
	local basket = {"blueberry", "melon", "pear", "melon"}
	Promise.fold(basket, function(cost, fruit)
		if fruit == "blueberry" then
			return cost -- blueberries are free!
		else
			-- call a function that returns a promise with the fruit price
			return fetchPrice(fruit):andThen(function(fruitCost)
				return cost + fruitCost
			end)
		end
	end, 0)
	```

	@since v3.1.0
	@param list {T | Promise<T>}
	@param reducer (accumulator: U, value: T, index: number) -> U | Promise<U>
	@param initialValue U
]=]
function Promise.fold(list, reducer, initialValue)
	assert(type(list) == "table", "Bad argument #1 to Promise.fold: must be a table")
	assert(isCallable(reducer), "Bad argument #2 to Promise.fold: must be a function")

	local accumulator = Promise.resolve(initialValue)
	return Promise.each(list, function(resolvedElement, i)
		accumulator = accumulator:andThen(function(previousValueResolved)
			return reducer(previousValueResolved, resolvedElement, i)
		end)
	end):andThen(function()
		return accumulator
	end)
end

--[=[
	Accepts an array of Promises and returns a Promise that is resolved as soon as `count` Promises are resolved from the input array. The resolved array values are in the order that the Promises resolved in. When this Promise resolves, all other pending Promises are cancelled if they have no other consumers.

	`count` 0 results in an empty array. The resultant array will never have more than `count` elements.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.some(promises, 2) -- Only resolves with first 2 promises to resolve
	```

	@param promises {Promise<T>}
	@param count number
	@return Promise<{T}>
]=]
function Promise.some(promises, count)
	assert(type(count) == "number", "Bad argument #2 to Promise.some: must be a number")

	return Promise._all(debug.traceback(nil, 2), promises, count)
end

--[=[
	Accepts an array of Promises and returns a Promise that is resolved as soon as *any* of the input Promises resolves. It will reject only if *all* input Promises reject. As soon as one Promises resolves, all other pending Promises are cancelled if they have no other consumers.

	Resolves directly with the value of the first resolved Promise. This is essentially [[Promise.some]] with `1` count, except the Promise resolves with the value directly instead of an array with one element.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.any(promises) -- Resolves with first value to resolve (only rejects if all 3 rejected)
	```

	@param promises {Promise<T>}
	@return Promise<T>
]=]
function Promise.any(promises)
	return Promise._all(debug.traceback(nil, 2), promises, 1):andThen(function(values)
		return values[1]
	end)
end

--[=[
	Accepts an array of Promises and returns a new Promise that resolves with an array of in-place Statuses when all input Promises have settled. This is equivalent to mapping `promise:finally` over the array of Promises.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.allSettled(promises)
	```

	@param promises {Promise<T>}
	@return Promise<{Status}>
]=]
function Promise.allSettled(promises)
	if type(promises) ~= "table" then
		error(string.format(ERROR_NON_LIST, "Promise.allSettled"), 2)
	end

	-- We need to check that each value is a promise here so that we can produce
	-- a proper error rather than a rejected promise with our error.
	for i, promise in pairs(promises) do
		if not Promise.is(promise) then
			error(string.format(ERROR_NON_PROMISE_IN_LIST, "Promise.allSettled", tostring(i)), 2)
		end
	end

	-- If there are no values then return an already resolved promise.
	if #promises == 0 then
		return Promise.resolve({})
	end

	return Promise._new(debug.traceback(nil, 2), function(resolve, _, onCancel)
		-- An array to contain our resolved values from the given promises.
		local fates = {}
		local newPromises = {}

		-- Keep a count of resolved promises because just checking the resolved
		-- values length wouldn't account for promises that resolve with nil.
		local finishedCount = 0

		-- Called when a single value is resolved and resolves if all are done.
		local function resolveOne(i, ...)
			finishedCount = finishedCount + 1

			fates[i] = ...

			if finishedCount >= #promises then
				resolve(fates)
			end
		end

		onCancel(function()
			for _, promise in ipairs(newPromises) do
				promise:cancel()
			end
		end)

		-- We can assume the values inside `promises` are all promises since we
		-- checked above.
		for i, promise in ipairs(promises) do
			newPromises[i] = promise:finally(function(...)
				resolveOne(i, ...)
			end)
		end
	end)
end

--[=[
	Accepts an array of Promises and returns a new promise that is resolved or rejected as soon as any Promise in the array resolves or rejects.

	:::warning
	If the first Promise to settle from the array settles with a rejection, the resulting Promise from `race` will reject.

	If you instead want to tolerate rejections, and only care about at least one Promise resolving, you should use [Promise.any](#any) or [Promise.some](#some) instead.
	:::

	All other Promises that don't win the race will be cancelled if they have no other consumers.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.race(promises) -- Only returns 1st value to resolve or reject
	```

	@param promises {Promise<T>}
	@return Promise<T>
]=]
function Promise.race(promises)
	assert(type(promises) == "table", string.format(ERROR_NON_LIST, "Promise.race"))

	for i, promise in pairs(promises) do
		assert(Promise.is(promise), string.format(ERROR_NON_PROMISE_IN_LIST, "Promise.race", tostring(i)))
	end

	return Promise._new(debug.traceback(nil, 2), function(resolve, reject, onCancel)
		local newPromises = {}
		local finished = false

		local function cancel()
			for _, promise in ipairs(newPromises) do
				promise:cancel()
			end
		end

		local function finalize(callback)
			return function(...)
				cancel()
				finished = true
				return callback(...)
			end
		end

		if onCancel(finalize(reject)) then
			return
		end

		for i, promise in ipairs(promises) do
			newPromises[i] = promise:andThen(finalize(resolve), finalize(reject))
		end

		if finished then
			cancel()
		end
	end)
end

--[=[
	Iterates serially over the given an array of values, calling the predicate callback on each value before continuing.

	If the predicate returns a Promise, we wait for that Promise to resolve before moving on to the next item
	in the array.

	:::info
	`Promise.each` is similar to `Promise.all`, except the Promises are ran in order instead of all at once.

	But because Promises are eager, by the time they are created, they're already running. Thus, we need a way to defer creation of each Promise until a later time.

	The predicate function exists as a way for us to operate on our data instead of creating a new closure for each Promise. If you would prefer, you can pass in an array of functions, and in the predicate, call the function and return its return value.
	:::

	```lua
	Promise.each({
		"foo",
		"bar",
		"baz",
		"qux"
	}, function(value, index)
		return Promise.delay(1):andThen(function()
		print(("%d) Got %s!"):format(index, value))
		end)
	end)

	--[[
		(1 second passes)
		> 1) Got foo!
		(1 second passes)
		> 2) Got bar!
		(1 second passes)
		> 3) Got baz!
		(1 second passes)
		> 4) Got qux!
	]]
	```

	If the Promise a predicate returns rejects, the Promise from `Promise.each` is also rejected with the same value.

	If the array of values contains a Promise, when we get to that point in the list, we wait for the Promise to resolve before calling the predicate with the value.

	If a Promise in the array of values is already Rejected when `Promise.each` is called, `Promise.each` rejects with that value immediately (the predicate callback will never be called even once). If a Promise in the list is already Cancelled when `Promise.each` is called, `Promise.each` rejects with `Promise.Error(Promise.Error.Kind.AlreadyCancelled`). If a Promise in the array of values is Started at first, but later rejects, `Promise.each` will reject with that value and iteration will not continue once iteration encounters that value.

	Returns a Promise containing an array of the returned/resolved values from the predicate for each item in the array of values.

	If this Promise returned from `Promise.each` rejects or is cancelled for any reason, the following are true:
	- Iteration will not continue.
	- Any Promises within the array of values will now be cancelled if they have no other consumers.
	- The Promise returned from the currently active predicate will be cancelled if it hasn't resolved yet.

	@since 3.0.0
	@param list {T | Promise<T>}
	@param predicate (value: T, index: number) -> U | Promise<U>
	@return Promise<{U}>
]=]
function Promise.each(list, predicate)
	assert(type(list) == "table", string.format(ERROR_NON_LIST, "Promise.each"))
	assert(isCallable(predicate), string.format(ERROR_NON_FUNCTION, "Promise.each"))

	return Promise._new(debug.traceback(nil, 2), function(resolve, reject, onCancel)
		local results = {}
		local promisesToCancel = {}

		local cancelled = false

		local function cancel()
			for _, promiseToCancel in ipairs(promisesToCancel) do
				promiseToCancel:cancel()
			end
		end

		onCancel(function()
			cancelled = true

			cancel()
		end)

		-- We need to preprocess the list of values and look for Promises.
		-- If we find some, we must register our andThen calls now, so that those Promises have a consumer
		-- from us registered. If we don't do this, those Promises might get cancelled by something else
		-- before we get to them in the series because it's not possible to tell that we plan to use it
		-- unless we indicate it here.

		local preprocessedList = {}

		for index, value in ipairs(list) do
			if Promise.is(value) then
				if value:getStatus() == Promise.Status.Cancelled then
					cancel()
					return reject(Error.new({
						error = "Promise is cancelled",
						kind = Error.Kind.AlreadyCancelled,
						context = string.format(
							"The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s",
							index,
							value._source
						),
					}))
				elseif value:getStatus() == Promise.Status.Rejected then
					cancel()
					return reject(select(2, value:await()))
				end

				-- Chain a new Promise from this one so we only cancel ours
				local ourPromise = value:andThen(function(...)
					return ...
				end)

				table.insert(promisesToCancel, ourPromise)
				preprocessedList[index] = ourPromise
			else
				preprocessedList[index] = value
			end
		end

		for index, value in ipairs(preprocessedList) do
			if Promise.is(value) then
				local success
				success, value = value:await()

				if not success then
					cancel()
					return reject(value)
				end
			end

			if cancelled then
				return
			end

			local predicatePromise = Promise.resolve(predicate(value, index))

			table.insert(promisesToCancel, predicatePromise)

			local success, result = predicatePromise:await()

			if not success then
				cancel()
				return reject(result)
			end

			results[index] = result
		end

		resolve(results)
	end)
end

--[=[
	Checks whether the given object is a Promise via duck typing. This only checks if the object is a table and has an `andThen` method.

	@param object any
	@return boolean -- `true` if the given `object` is a Promise.
]=]
function Promise.is(object)
	if type(object) ~= "table" then
		return false
	end

	local objectMetatable = getmetatable(object)

	if objectMetatable == Promise then
		-- The Promise came from this library.
		return true
	elseif objectMetatable == nil then
		-- No metatable, but we should still chain onto tables with andThen methods
		return isCallable(object.andThen)
	elseif
		type(objectMetatable) == "table"
		and type(rawget(objectMetatable, "__index")) == "table"
		and isCallable(rawget(rawget(objectMetatable, "__index"), "andThen"))
	then
		-- Maybe this came from a different or older Promise library.
		return true
	end

	return false
end

--[=[
	Wraps a function that yields into one that returns a Promise.

	Any errors that occur while executing the function will be turned into rejections.

	:::info
	`Promise.promisify` is similar to [Promise.try](#try), except the callback is returned as a callable function instead of being invoked immediately.
	:::

	```lua
	local sleep = Promise.promisify(wait)

	sleep(1):andThen(print)
	```

	```lua
	local isPlayerInGroup = Promise.promisify(function(player, groupId)
		return player:IsInGroup(groupId)
	end)
	```

	@param callback (...: any) -> ...any
	@return (...: any) -> Promise
]=]
function Promise.promisify(callback)
	return function(...)
		return Promise._try(debug.traceback(nil, 2), callback, ...)
	end
end

--[=[
	Returns a Promise that resolves after `seconds` seconds have passed. The Promise resolves with the actual amount of time that was waited.

	This function is **not** a wrapper around `wait`. `Promise.delay` uses a custom scheduler which provides more accurate timing. As an optimization, cancelling this Promise instantly removes the task from the scheduler.

	:::warning
	Passing `NaN`, infinity, or a number less than 1/60 is equivalent to passing 1/60.
	:::

	```lua
		Promise.delay(5):andThenCall(print, "This prints after 5 seconds")
	```

	@function delay
	@within Promise
	@param seconds number
	@return Promise<number>
]=]
do
	-- uses a sorted doubly linked list (queue) to achieve O(1) remove operations and O(n) for insert

	-- the initial node in the linked list
	local first
	local connection

	function Promise.delay(seconds)
		assert(type(seconds) == "number", "Bad argument #1 to Promise.delay, must be a number.")
		-- If seconds is -INF, INF, NaN, or less than 1 / 60, assume seconds is 1 / 60.
		-- This mirrors the behavior of wait()
		if not (seconds >= 1 / 60) or seconds == math.huge then
			seconds = 1 / 60
		end

		return Promise._new(debug.traceback(nil, 2), function(resolve, _, onCancel)
			local startTime = Promise._getTime()
			local endTime = startTime + seconds

			local node = {
				resolve = resolve,
				startTime = startTime,
				endTime = endTime,
			}

			if connection == nil then -- first is nil when connection is nil
				first = node
				connection = Promise._timeEvent:Connect(function()
					local threadStart = Promise._getTime()

					while first ~= nil and first.endTime < threadStart do
						local current = first
						first = current.next

						if first == nil then
							connection:Disconnect()
							connection = nil
						else
							first.previous = nil
						end

						current.resolve(Promise._getTime() - current.startTime)
					end
				end)
			else -- first is non-nil
				if first.endTime < endTime then -- if `node` should be placed after `first`
					-- we will insert `node` between `current` and `next`
					-- (i.e. after `current` if `next` is nil)
					local current = first
					local next = current.next

					while next ~= nil and next.endTime < endTime do
						current = next
						next = current.next
					end

					-- `current` must be non-nil, but `next` could be `nil` (i.e. last item in list)
					current.next = node
					node.previous = current

					if next ~= nil then
						node.next = next
						next.previous = node
					end
				else
					-- set `node` to `first`
					node.next = first
					first.previous = node
					first = node
				end
			end

			onCancel(function()
				-- remove node from queue
				local next = node.next

				if first == node then
					if next == nil then -- if `node` is the first and last
						connection:Disconnect()
						connection = nil
					else -- if `node` is `first` and not the last
						next.previous = nil
					end
					first = next
				else
					local previous = node.previous
					-- since `node` is not `first`, then we know `previous` is non-nil
					previous.next = next

					if next ~= nil then
						next.previous = previous
					end
				end
			end)
		end)
	end
end

--[=[
	Returns a new Promise that resolves if the chained Promise resolves within `seconds` seconds, or rejects if execution time exceeds `seconds`. The chained Promise will be cancelled if the timeout is reached.

	Rejects with `rejectionValue` if it is non-nil. If a `rejectionValue` is not given, it will reject with a `Promise.Error(Promise.Error.Kind.TimedOut)`. This can be checked with [[Error.isKind]].

	```lua
	getSomething():timeout(5):andThen(function(something)
		-- got something and it only took at max 5 seconds
	end):catch(function(e)
		-- Either getting something failed or the time was exceeded.

		if Promise.Error.isKind(e, Promise.Error.Kind.TimedOut) then
			warn("Operation timed out!")
		else
			warn("Operation encountered an error!")
		end
	end)
	```

	Sugar for:

	```lua
	Promise.race({
		Promise.delay(seconds):andThen(function()
			return Promise.reject(
				rejectionValue == nil
				and Promise.Error.new({ kind = Promise.Error.Kind.TimedOut })
				or rejectionValue
			)
		end),
		promise
	})
	```

	@param seconds number
	@param rejectionValue? any -- The value to reject with if the timeout is reached
	@return Promise
]=]
function Promise.prototype:timeout(seconds, rejectionValue)
	local traceback = debug.traceback(nil, 2)

	return Promise.race({
		Promise.delay(seconds):andThen(function()
			return Promise.reject(rejectionValue == nil and Error.new({
				kind = Error.Kind.TimedOut,
				error = "Timed out",
				context = string.format(
					"Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s",
					seconds,
					traceback
				),
			}) or rejectionValue)
		end),
		self,
	})
end

--[=[
	Returns the current Promise status.

	@return Status
]=]
function Promise.prototype:getStatus()
	return self._status
end

--[[
	Creates a new promise that receives the result of this promise.

	The given callbacks are invoked depending on that result.
]]
function Promise.prototype:_andThen(traceback, successHandler, failureHandler)
	self._unhandledRejection = false

	-- Create a new promise to follow this part of the chain
	return Promise._new(traceback, function(resolve, reject)
		-- Our default callbacks just pass values onto the next promise.
		-- This lets success and failure cascade correctly!

		local successCallback = resolve
		if successHandler then
			successCallback = createAdvancer(traceback, successHandler, resolve, reject)
		end

		local failureCallback = reject
		if failureHandler then
			failureCallback = createAdvancer(traceback, failureHandler, resolve, reject)
		end

		if self._status == Promise.Status.Started then
			-- If we haven't resolved yet, put ourselves into the queue
			table.insert(self._queuedResolve, successCallback)
			table.insert(self._queuedReject, failureCallback)
		elseif self._status == Promise.Status.Resolved then
			-- This promise has already resolved! Trigger success immediately.
			successCallback(unpack(self._values, 1, self._valuesLength))
		elseif self._status == Promise.Status.Rejected then
			-- This promise died a terrible death! Trigger failure immediately.
			failureCallback(unpack(self._values, 1, self._valuesLength))
		elseif self._status == Promise.Status.Cancelled then
			-- We don't want to call the success handler or the failure handler,
			-- we just reject this promise outright.
			reject(Error.new({
				error = "Promise is cancelled",
				kind = Error.Kind.AlreadyCancelled,
				context = "Promise created at\n\n" .. traceback,
			}))
		end
	end, self)
end

--[=[
	Chains onto an existing Promise and returns a new Promise.

	:::warning
	Within the failure handler, you should never assume that the rejection value is a string. Some rejections within the Promise library are represented by [[Error]] objects. If you want to treat it as a string for debugging, you should call `tostring` on it first.
	:::

	Return a Promise from the success or failure handler and it will be chained onto.

	@param successHandler (...: any) -> ...any
	@param failureHandler? (...: any) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:andThen(successHandler, failureHandler)
	assert(successHandler == nil or isCallable(successHandler), string.format(ERROR_NON_FUNCTION, "Promise:andThen"))
	assert(failureHandler == nil or isCallable(failureHandler), string.format(ERROR_NON_FUNCTION, "Promise:andThen"))

	return self:_andThen(debug.traceback(nil, 2), successHandler, failureHandler)
end

--[=[
	Shorthand for `Promise:andThen(nil, failureHandler)`.

	Returns a Promise that resolves if the `failureHandler` worked without encountering an additional error.

	:::warning
	Within the failure handler, you should never assume that the rejection value is a string. Some rejections within the Promise library are represented by [[Error]] objects. If you want to treat it as a string for debugging, you should call `tostring` on it first.
	:::


	@param failureHandler (...: any) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:catch(failureHandler)
	assert(failureHandler == nil or isCallable(failureHandler), string.format(ERROR_NON_FUNCTION, "Promise:catch"))
	return self:_andThen(debug.traceback(nil, 2), nil, failureHandler)
end

--[=[
	Similar to [Promise.andThen](#andThen), except the return value is the same as the value passed to the handler. In other words, you can insert a `:tap` into a Promise chain without affecting the value that downstream Promises receive.

	```lua
		getTheValue()
		:tap(print)
		:andThen(function(theValue)
			print("Got", theValue, "even though print returns nil!")
		end)
	```

	If you return a Promise from the tap handler callback, its value will be discarded but `tap` will still wait until it resolves before passing the original value through.

	@param tapHandler (...: any) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:tap(tapHandler)
	assert(isCallable(tapHandler), string.format(ERROR_NON_FUNCTION, "Promise:tap"))
	return self:_andThen(debug.traceback(nil, 2), function(...)
		local callbackReturn = tapHandler(...)

		if Promise.is(callbackReturn) then
			local length, values = pack(...)
			return callbackReturn:andThen(function()
				return unpack(values, 1, length)
			end)
		end

		return ...
	end)
end

--[=[
	Attaches an `andThen` handler to this Promise that calls the given callback with the predefined arguments. The resolved value is discarded.

	```lua
		promise:andThenCall(someFunction, "some", "arguments")
	```

	This is sugar for

	```lua
		promise:andThen(function()
		return someFunction("some", "arguments")
		end)
	```

	@param callback (...: any) -> any
	@param ...? any -- Additional arguments which will be passed to `callback`
	@return Promise
]=]
function Promise.prototype:andThenCall(callback, ...)
	assert(isCallable(callback), string.format(ERROR_NON_FUNCTION, "Promise:andThenCall"))
	local length, values = pack(...)
	return self:_andThen(debug.traceback(nil, 2), function()
		return callback(unpack(values, 1, length))
	end)
end

--[=[
	Attaches an `andThen` handler to this Promise that discards the resolved value and returns the given value from it.

	```lua
		promise:andThenReturn("some", "values")
	```

	This is sugar for

	```lua
		promise:andThen(function()
			return "some", "values"
		end)
	```

	:::caution
	Promises are eager, so if you pass a Promise to `andThenReturn`, it will begin executing before `andThenReturn` is reached in the chain. Likewise, if you pass a Promise created from [[Promise.reject]] into `andThenReturn`, it's possible that this will trigger the unhandled rejection warning. If you need to return a Promise, it's usually best practice to use [[Promise.andThen]].
	:::

	@param ... any -- Values to return from the function
	@return Promise
]=]
function Promise.prototype:andThenReturn(...)
	local length, values = pack(...)
	return self:_andThen(debug.traceback(nil, 2), function()
		return unpack(values, 1, length)
	end)
end

--[=[
	Cancels this promise, preventing the promise from resolving or rejecting. Does not do anything if the promise is already settled.

	Cancellations will propagate upwards and downwards through chained promises.

	Promises will only be cancelled if all of their consumers are also cancelled. This is to say that if you call `andThen` twice on the same promise, and you cancel only one of the child promises, it will not cancel the parent promise until the other child promise is also cancelled.

	```lua
		promise:cancel()
	```
]=]
function Promise.prototype:cancel()
	if self._status ~= Promise.Status.Started then
		return
	end

	self._status = Promise.Status.Cancelled

	if self._cancellationHook then
		self._cancellationHook()
	end

	if self._parent then
		self._parent:_consumerCancelled(self)
	end

	for child in pairs(self._consumers) do
		child:cancel()
	end

	self:_finalize()
end

--[[
	Used to decrease the number of consumers by 1, and if there are no more,
	cancel this promise.
]]
function Promise.prototype:_consumerCancelled(consumer)
	if self._status ~= Promise.Status.Started then
		return
	end

	self._consumers[consumer] = nil

	if next(self._consumers) == nil then
		self:cancel()
	end
end

--[[
	Used to set a handler for when the promise resolves, rejects, or is
	cancelled. Returns a new promise chained from this promise.
]]
function Promise.prototype:_finally(traceback, finallyHandler, onlyOk)
	if not onlyOk then
		self._unhandledRejection = false
	end

	-- Return a promise chained off of this promise
	return Promise._new(traceback, function(resolve, reject)
		local finallyCallback = resolve
		if finallyHandler then
			finallyCallback = createAdvancer(traceback, finallyHandler, resolve, reject)
		end

		if onlyOk then
			local callback = finallyCallback
			finallyCallback = function(...)
				if self._status == Promise.Status.Rejected then
					return resolve(self)
				end

				return callback(...)
			end
		end

		if self._status == Promise.Status.Started then
			-- The promise is not settled, so queue this.
			table.insert(self._queuedFinally, finallyCallback)
		else
			-- The promise already settled or was cancelled, run the callback now.
			finallyCallback(self._status)
		end
	end, self)
end

--[=[
	Set a handler that will be called regardless of the promise's fate. The handler is called when the promise is resolved, rejected, *or* cancelled.

	Returns a new promise chained from this promise.

	:::caution
	If the Promise is cancelled, any Promises chained off of it with `andThen` won't run. Only Promises chained with `finally` or `done` will run in the case of cancellation.
	:::

	```lua
	local thing = createSomething()

	doSomethingWith(thing)
		:andThen(function()
			print("It worked!")
			-- do something..
		end)
		:catch(function()
			warn("Oh no it failed!")
		end)
		:finally(function()
			-- either way, destroy thing

			thing:Destroy()
		end)

	```

	@param finallyHandler (status: Status) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:finally(finallyHandler)
	assert(finallyHandler == nil or isCallable(finallyHandler), string.format(ERROR_NON_FUNCTION, "Promise:finally"))
	return self:_finally(debug.traceback(nil, 2), finallyHandler)
end

--[=[
	Same as `andThenCall`, except for `finally`.

	Attaches a `finally` handler to this Promise that calls the given callback with the predefined arguments.

	@param callback (...: any) -> any
	@param ...? any -- Additional arguments which will be passed to `callback`
	@return Promise
]=]
function Promise.prototype:finallyCall(callback, ...)
	assert(isCallable(callback), string.format(ERROR_NON_FUNCTION, "Promise:finallyCall"))
	local length, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return callback(unpack(values, 1, length))
	end)
end

--[=[
	Attaches a `finally` handler to this Promise that discards the resolved value and returns the given value from it.

	```lua
		promise:finallyReturn("some", "values")
	```

	This is sugar for

	```lua
		promise:finally(function()
			return "some", "values"
		end)
	```

	@param ... any -- Values to return from the function
	@return Promise
]=]
function Promise.prototype:finallyReturn(...)
	local length, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return unpack(values, 1, length)
	end)
end

--[=[
	Set a handler that will be called only if the Promise resolves or is cancelled. This method is similar to `finally`, except it doesn't catch rejections.

	:::caution
	`done` should be reserved specifically when you want to perform some operation after the Promise is finished (like `finally`), but you don't want to consume rejections (like in <a href="/roblox-lua-promise/lib/Examples.html#cancellable-animation-sequence">this example</a>). You should use `andThen` instead if you only care about the Resolved case.
	:::

	:::warning
	Like `finally`, if the Promise is cancelled, any Promises chained off of it with `andThen` won't run. Only Promises chained with `done` and `finally` will run in the case of cancellation.
	:::

	Returns a new promise chained from this promise.

	@param doneHandler (status: Status) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:done(doneHandler)
	assert(doneHandler == nil or isCallable(doneHandler), string.format(ERROR_NON_FUNCTION, "Promise:done"))
	return self:_finally(debug.traceback(nil, 2), doneHandler, true)
end

--[=[
	Same as `andThenCall`, except for `done`.

	Attaches a `done` handler to this Promise that calls the given callback with the predefined arguments.

	@param callback (...: any) -> any
	@param ...? any -- Additional arguments which will be passed to `callback`
	@return Promise
]=]
function Promise.prototype:doneCall(callback, ...)
	assert(isCallable(callback), string.format(ERROR_NON_FUNCTION, "Promise:doneCall"))
	local length, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return callback(unpack(values, 1, length))
	end, true)
end

--[=[
	Attaches a `done` handler to this Promise that discards the resolved value and returns the given value from it.

	```lua
		promise:doneReturn("some", "values")
	```

	This is sugar for

	```lua
		promise:done(function()
			return "some", "values"
		end)
	```

	@param ... any -- Values to return from the function
	@return Promise
]=]
function Promise.prototype:doneReturn(...)
	local length, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return unpack(values, 1, length)
	end, true)
end

--[=[
	Yields the current thread until the given Promise completes. Returns the Promise's status, followed by the values that the promise resolved or rejected with.

	@yields
	@return Status -- The Status representing the fate of the Promise
	@return ...any -- The values the Promise resolved or rejected with.
]=]
function Promise.prototype:awaitStatus()
	self._unhandledRejection = false

	if self._status == Promise.Status.Started then
		local bindable = Instance.new("BindableEvent")

		self:finally(function()
			bindable:Fire()
		end)

		bindable.Event:Wait()
		bindable:Destroy()
	end

	if self._status == Promise.Status.Resolved then
		return self._status, unpack(self._values, 1, self._valuesLength)
	elseif self._status == Promise.Status.Rejected then
		return self._status, unpack(self._values, 1, self._valuesLength)
	end

	return self._status
end

local function awaitHelper(status, ...)
	return status == Promise.Status.Resolved, ...
end

--[=[
	Yields the current thread until the given Promise completes. Returns true if the Promise resolved, followed by the values that the promise resolved or rejected with.

	:::caution
	If the Promise gets cancelled, this function will return `false`, which is indistinguishable from a rejection. If you need to differentiate, you should use [[Promise.awaitStatus]] instead.
	:::

	```lua
		local worked, value = getTheValue():await()

	if worked then
		print("got", value)
	else
		warn("it failed")
	end
	```

	@yields
	@return boolean -- `true` if the Promise successfully resolved
	@return ...any -- The values the Promise resolved or rejected with.
]=]
function Promise.prototype:await()
	return awaitHelper(self:awaitStatus())
end

local function expectHelper(status, ...)
	if status ~= Promise.Status.Resolved then
		error((...) == nil and "Expected Promise rejected with no value." or (...), 3)
	end

	return ...
end

--[=[
	Yields the current thread until the given Promise completes. Returns the values that the promise resolved with.

	```lua
	local worked = pcall(function()
		print("got", getTheValue():expect())
	end)

	if not worked then
		warn("it failed")
	end
	```

	This is essentially sugar for:

	```lua
	select(2, assert(promise:await()))
	```

	**Errors** if the Promise rejects or gets cancelled.

	@error any -- Errors with the rejection value if this Promise rejects or gets cancelled.
	@yields
	@return ...any -- The values the Promise resolved with.
]=]
function Promise.prototype:expect()
	return expectHelper(self:awaitStatus())
end

-- Backwards compatibility
Promise.prototype.awaitValue = Promise.prototype.expect

--[[
	Intended for use in tests.

	Similar to await(), but instead of yielding if the promise is unresolved,
	_unwrap will throw. This indicates an assumption that a promise has
	resolved.
]]
function Promise.prototype:_unwrap()
	if self._status == Promise.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end

	local success = self._status == Promise.Status.Resolved

	return success, unpack(self._values, 1, self._valuesLength)
end

function Promise.prototype:_resolve(...)
	if self._status ~= Promise.Status.Started then
		if Promise.is((...)) then
			(...):_consumerCancelled(self)
		end
		return
	end

	-- If the resolved value was a Promise, we chain onto it!
	if Promise.is((...)) then
		-- Without this warning, arguments sometimes mysteriously disappear
		if select("#", ...) > 1 then
			local message = string.format(
				"When returning a Promise from andThen, extra arguments are " .. "discarded! See:\n\n%s",
				self._source
			)
			warn(message)
		end

		local chainedPromise = ...

		local promise = chainedPromise:andThen(function(...)
			self:_resolve(...)
		end, function(...)
			local maybeRuntimeError = chainedPromise._values[1]

			-- Backwards compatibility < v2
			if chainedPromise._error then
				maybeRuntimeError = Error.new({
					error = chainedPromise._error,
					kind = Error.Kind.ExecutionError,
					context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
				})
			end

			if Error.isKind(maybeRuntimeError, Error.Kind.ExecutionError) then
				return self:_reject(maybeRuntimeError:extend({
					error = "This Promise was chained to a Promise that errored.",
					trace = "",
					context = string.format(
						"The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n",
						self._source
					),
				}))
			end

			self:_reject(...)
		end)

		if promise._status == Promise.Status.Cancelled then
			self:cancel()
		elseif promise._status == Promise.Status.Started then
			-- Adopt ourselves into promise for cancellation propagation.
			self._parent = promise
			promise._consumers[self] = true
		end

		return
	end

	self._status = Promise.Status.Resolved
	self._valuesLength, self._values = pack(...)

	-- We assume that these callbacks will not throw errors.
	for _, callback in ipairs(self._queuedResolve) do
		coroutine.wrap(callback)(...)
	end

	self:_finalize()
end

function Promise.prototype:_reject(...)
	if self._status ~= Promise.Status.Started then
		return
	end

	self._status = Promise.Status.Rejected
	self._valuesLength, self._values = pack(...)

	-- If there are any rejection handlers, call those!
	if not isEmpty(self._queuedReject) then
		-- We assume that these callbacks will not throw errors.
		for _, callback in ipairs(self._queuedReject) do
			coroutine.wrap(callback)(...)
		end
	else
		-- At this point, no one was able to observe the error.
		-- An error handler might still be attached if the error occurred
		-- synchronously. We'll wait one tick, and if there are still no
		-- observers, then we should put a message in the console.

		local err = tostring((...))

		coroutine.wrap(function()
			Promise._timeEvent:Wait()

			-- Someone observed the error, hooray!
			if not self._unhandledRejection then
				return
			end

			-- Build a reasonable message
			local message = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", err, self._source)

			for _, callback in ipairs(Promise._unhandledRejectionCallbacks) do
				task.spawn(callback, self, unpack(self._values, 1, self._valuesLength))
			end

			if Promise.TEST then
				-- Don't spam output when we're running tests.
				return
			end

			warn(message)
		end)()
	end

	self:_finalize()
end

--[[
	Calls any :finally handlers. We need this to be a separate method and
	queue because we must call all of the finally callbacks upon a success,
	failure, *and* cancellation.
]]
function Promise.prototype:_finalize()
	for _, callback in ipairs(self._queuedFinally) do
		-- Purposefully not passing values to callbacks here, as it could be the
		-- resolved values, or rejected errors. If the developer needs the values,
		-- they should use :andThen or :catch explicitly.
		coroutine.wrap(callback)(self._status)
	end

	self._queuedFinally = nil
	self._queuedReject = nil
	self._queuedResolve = nil

	-- Clear references to other Promises to allow gc
	if not Promise.TEST then
		self._parent = nil
		self._consumers = nil
	end
end

--[=[
	Chains a Promise from this one that is resolved if this Promise is already resolved, and rejected if it is not resolved at the time of calling `:now()`. This can be used to ensure your `andThen` handler occurs on the same frame as the root Promise execution.

	```lua
	doSomething()
		:now()
		:andThen(function(value)
			print("Got", value, "synchronously.")
		end)
	```

	If this Promise is still running, Rejected, or Cancelled, the Promise returned from `:now()` will reject with the `rejectionValue` if passed, otherwise with a `Promise.Error(Promise.Error.Kind.NotResolvedInTime)`. This can be checked with [[Error.isKind]].

	@param rejectionValue? any -- The value to reject with if the Promise isn't resolved
	@return Promise
]=]
function Promise.prototype:now(rejectionValue)
	local traceback = debug.traceback(nil, 2)
	if self._status == Promise.Status.Resolved then
		return self:_andThen(traceback, function(...)
			return ...
		end)
	else
		return Promise.reject(rejectionValue == nil and Error.new({
			kind = Error.Kind.NotResolvedInTime,
			error = "This Promise was not resolved in time for :now()",
			context = ":now() was called at:\n\n" .. traceback,
		}) or rejectionValue)
	end
end

--[=[
	Repeatedly calls a Promise-returning function up to `times` number of times, until the returned Promise resolves.

	If the amount of retries is exceeded, the function will return the latest rejected Promise.

	```lua
	local function canFail(a, b, c)
		return Promise.new(function(resolve, reject)
			-- do something that can fail

			local failed, thing = doSomethingThatCanFail(a, b, c)

			if failed then
				reject("it failed")
			else
				resolve(thing)
			end
		end)
	end

	local MAX_RETRIES = 10
	local value = Promise.retry(canFail, MAX_RETRIES, "foo", "bar", "baz") -- args to send to canFail
	```

	@since 3.0.0
	@param callback (...: P) -> Promise<T>
	@param times number
	@param ...? P
]=]
function Promise.retry(callback, times, ...)
	assert(isCallable(callback), "Parameter #1 to Promise.retry must be a function")
	assert(type(times) == "number", "Parameter #2 to Promise.retry must be a number")

	local args, length = { ... }, select("#", ...)

	return Promise.resolve(callback(...)):catch(function(...)
		if times > 0 then
			return Promise.retry(callback, times - 1, unpack(args, 1, length))
		else
			return Promise.reject(...)
		end
	end)
end

--[=[
	Repeatedly calls a Promise-returning function up to `times` number of times, waiting `seconds` seconds between each
	retry, until the returned Promise resolves.

	If the amount of retries is exceeded, the function will return the latest rejected Promise.

	@since v3.2.0
	@param callback (...: P) -> Promise<T>
	@param times number
	@param seconds number
	@param ...? P
]=]
function Promise.retryWithDelay(callback, times, seconds, ...)
	assert(isCallable(callback), "Parameter #1 to Promise.retry must be a function")
	assert(type(times) == "number", "Parameter #2 (times) to Promise.retry must be a number")
	assert(type(seconds) == "number", "Parameter #3 (seconds) to Promise.retry must be a number")

	local args, length = { ... }, select("#", ...)

	return Promise.resolve(callback(...)):catch(function(...)
		if times > 0 then
			Promise.delay(seconds):await()

			return Promise.retryWithDelay(callback, times - 1, seconds, unpack(args, 1, length))
		else
			return Promise.reject(...)
		end
	end)
end

--[=[
	Converts an event into a Promise which resolves the next time the event fires.

	The optional `predicate` callback, if passed, will receive the event arguments and should return `true` or `false`, based on if this fired event should resolve the Promise or not. If `true`, the Promise resolves. If `false`, nothing happens and the predicate will be rerun the next time the event fires.

	The Promise will resolve with the event arguments.

	:::tip
	This function will work given any object with a `Connect` method. This includes all Roblox events.
	:::

	```lua
	-- Creates a Promise which only resolves when `somePart` is touched
	-- by a part named `"Something specific"`.
	return Promise.fromEvent(somePart.Touched, function(part)
		return part.Name == "Something specific"
	end)
	```

	@since 3.0.0
	@param event Event -- Any object with a `Connect` method. This includes all Roblox events.
	@param predicate? (...: P) -> boolean -- A function which determines if the Promise should resolve with the given value, or wait for the next event to check again.
	@return Promise<P>
]=]
function Promise.fromEvent(event, predicate)
	predicate = predicate or function()
		return true
	end

	return Promise._new(debug.traceback(nil, 2), function(resolve, _, onCancel)
		local connection
		local shouldDisconnect = false

		local function disconnect()
			connection:Disconnect()
			connection = nil
		end

		-- We use shouldDisconnect because if the callback given to Connect is called before
		-- Connect returns, connection will still be nil. This happens with events that queue up
		-- events when there's nothing connected, such as RemoteEvents

		connection = event:Connect(function(...)
			local callbackValue = predicate(...)

			if callbackValue == true then
				resolve(...)

				if connection then
					disconnect()
				else
					shouldDisconnect = true
				end
			elseif type(callbackValue) ~= "boolean" then
				error("Promise.fromEvent predicate should always return a boolean")
			end
		end)

		if shouldDisconnect and connection then
			return disconnect()
		end

		onCancel(disconnect)
	end)
end

--[=[
	Registers a callback that runs when an unhandled rejection happens. An unhandled rejection happens when a Promise
	is rejected, and the rejection is not observed with `:catch`.

	The callback is called with the actual promise that rejected, followed by the rejection values.

	@since v3.2.0
	@param callback (promise: Promise, ...: any) -- A callback that runs when an unhandled rejection happens.
	@return () -> () -- Function that unregisters the `callback` when called
]=]
function Promise.onUnhandledRejection(callback)
	table.insert(Promise._unhandledRejectionCallbacks, callback)

	return function()
		local index = table.find(Promise._unhandledRejectionCallbacks, callback)

		if index then
			table.remove(Promise._unhandledRejectionCallbacks, index)
		end
	end
end

return Promise
 end, newEnv("SriBlox-Modern.include.Promise"))() end)

newModule("RuntimeLib", "ModuleScript", "SriBlox-Modern.include.RuntimeLib", "SriBlox-Modern.include", function () return setfenv(function() local Promise = require(script.Parent.Promise)

local RunService = game:GetService("RunService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local TS = {}

TS.Promise = Promise

local function isPlugin(object)
	return RunService:IsStudio() and object:FindFirstAncestorWhichIsA("Plugin") ~= nil
end

function TS.getModule(object, scope, moduleName)
	if moduleName == nil then
		moduleName = scope
		scope = "@rbxts"
	end

	if RunService:IsRunning() and object:IsDescendantOf(ReplicatedFirst) then
		warn("roblox-ts packages should not be used from ReplicatedFirst!")
	end

	-- ensure modules have fully replicated
	if RunService:IsRunning() and RunService:IsClient() and not isPlugin(object) and not game:IsLoaded() then
		game.Loaded:Wait()
	end

	local globalModules = script.Parent:FindFirstChild("node_modules")
	if not globalModules then
		error("Could not find any modules!", 2)
	end

	repeat
		local modules = object:FindFirstChild("node_modules")
		if modules and modules ~= globalModules then
			modules = modules:FindFirstChild("@rbxts")
		end
		if modules then
			local module = modules:FindFirstChild(moduleName)
			if module then
				return module
			end
		end
		object = object.Parent
	until object == nil or object == globalModules

	local scopedModules = globalModules:FindFirstChild(scope or "@rbxts");
	return (scopedModules or globalModules):FindFirstChild(moduleName) or error("Could not find module: " .. moduleName, 2)
end

-- This is a hash which TS.import uses as a kind of linked-list-like history of [Script who Loaded] -> Library
local currentlyLoading = {}
local registeredLibraries = {}

function TS.import(caller, module, ...)
	for i = 1, select("#", ...) do
		module = module:WaitForChild((select(i, ...)))
	end

	if module.ClassName ~= "ModuleScript" then
		error("Failed to import! Expected ModuleScript, got " .. module.ClassName, 2)
	end

	currentlyLoading[caller] = module

	-- Check to see if a case like this occurs:
	-- module -> Module1 -> Module2 -> module

	-- WHERE currentlyLoading[module] is Module1
	-- and currentlyLoading[Module1] is Module2
	-- and currentlyLoading[Module2] is module

	local currentModule = module
	local depth = 0

	while currentModule do
		depth = depth + 1
		currentModule = currentlyLoading[currentModule]

		if currentModule == module then
			local str = currentModule.Name -- Get the string traceback

			for _ = 1, depth do
				currentModule = currentlyLoading[currentModule]
				str = str .. "  ⇒ " .. currentModule.Name
			end

			error("Failed to import! Detected a circular dependency chain: " .. str, 2)
		end
	end

	if not registeredLibraries[module] then
		if _G[module] then
			error(
				"Invalid module access! Do you have two TS runtimes trying to import this? " .. module:GetFullName(),
				2
			)
		end

		_G[module] = TS
		registeredLibraries[module] = true -- register as already loaded for subsequent calls
	end

	local data = require(module)

	if currentlyLoading[caller] == module then -- Thread-safe cleanup!
		currentlyLoading[caller] = nil
	end

	return data
end

function TS.instanceof(obj, class)
	-- custom Class.instanceof() check
	if type(class) == "table" and type(class.instanceof) == "function" then
		return class.instanceof(obj)
	end

	-- metatable check
	if type(obj) == "table" then
		obj = getmetatable(obj)
		while obj ~= nil do
			if obj == class then
				return true
			end
			local mt = getmetatable(obj)
			if mt then
				obj = mt.__index
			else
				obj = nil
			end
		end
	end

	return false
end

function TS.async(callback)
	return function(...)
		local n = select("#", ...)
		local args = { ... }
		return Promise.new(function(resolve, reject)
			coroutine.wrap(function()
				local ok, result = pcall(callback, unpack(args, 1, n))
				if ok then
					resolve(result)
				else
					reject(result)
				end
			end)()
		end)
	end
end

function TS.await(promise)
	if not Promise.is(promise) then
		return promise
	end

	local status, value = promise:awaitStatus()
	if status == Promise.Status.Resolved then
		return value
	elseif status == Promise.Status.Rejected then
		error(value, 2)
	else
		error("The awaited Promise was cancelled", 2)
	end
end

function TS.bit_lrsh(a, b)
	local absA = math.abs(a)
	local result = bit32.rshift(absA, b)
	if a == absA then
		return result
	else
		return -result - 1
	end
end

TS.TRY_RETURN = 1
TS.TRY_BREAK = 2
TS.TRY_CONTINUE = 3

function TS.try(func, catch, finally)
	local err, traceback
	local success, exitType, returns = xpcall(
		func,
		function(errInner)
			err = errInner
			traceback = debug.traceback()
		end
	)
	if not success and catch then
		local newExitType, newReturns = catch(err, traceback)
		if newExitType then
			exitType, returns = newExitType, newReturns
		end
	end
	if finally then
		local newExitType, newReturns = finally()
		if newExitType then
			exitType, returns = newExitType, newReturns
		end
	end
	return exitType, returns
end

function TS.generator(callback)
	local co = coroutine.create(callback)
	return {
		next = function(...)
			if coroutine.status(co) == "dead" then
				return { done = true }
			else
				local success, value = coroutine.resume(co, ...)
				if success == false then
					error(value, 2)
				end
				return {
					value = value,
					done = coroutine.status(co) == "dead",
				}
			end
		end,
	}
end

return TS
 end, newEnv("SriBlox-Modern.include.RuntimeLib"))() end)

newInstance("node_modules", "Folder", "SriBlox-Modern.include.node_modules", "SriBlox-Modern.include")

newInstance("@rbxts", "Folder", "SriBlox-Modern.include.node_modules.@rbxts", "SriBlox-Modern.include.node_modules")

newInstance("node_modules", "Folder", "SriBlox-Modern.include.node_modules", "SriBlox-Modern.include")

newInstance("compiler-types", "Folder", "SriBlox-Modern.include.node_modules.compiler-types", "SriBlox-Modern.include.node_modules")

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.compiler-types.package", "SriBlox-Modern.include.node_modules.compiler-types", function () return setfenv(function() return {
	author = "roblox-ts",
	description = "",
	devDependencies = {
		["@rbxts/types"] = "^1.0.459",
		["@typescript-eslint/eslint-plugin"] = "^5.10.0",
		["@typescript-eslint/parser"] = "^5.10.0",
		eslint = "^8.7.0",
		["eslint-config-prettier"] = "^8.1.0",
		["eslint-plugin-no-autofix"] = "^1.2.3",
		["eslint-plugin-prettier"] = "^4.0.0",
		["eslint-plugin-simple-import-sort"] = "^7.0.0",
		prettier = "^2.2.1",
		typescript = "^4.2.3",
	},
	files = {"types/*.d.ts"},
	license = "MIT",
	main = "types/core.d.ts",
	name = "@rbxts/compiler-types",
	scripts = {
		eslint = "npx eslint \"types/**/*.d.ts\" --max-warnings 0",
	},
	types = "types/core.d.ts",
	version = "1.3.2-types.0",
} end, newEnv("SriBlox-Modern.include.node_modules.compiler-types.package"))() end)

newInstance("types", "Folder", "SriBlox-Modern.include.node_modules.compiler-types.types", "SriBlox-Modern.include.node_modules.compiler-types")

newInstance("flipper", "Folder", "SriBlox-Modern.include.node_modules.flipper", "SriBlox-Modern.include.node_modules")

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.package", "SriBlox-Modern.include.node_modules.flipper", function () return setfenv(function() return {
	author = "Reselim",
	description = "An animation library for Roblox",
	devDependencies = {
		["@rbxts/types"] = "^1.0.390",
	},
	files = {"src", "typings", "!src/**/*.spec.lua"},
	homepage = "https://github.com/Reselim/Flipper",
	license = "MIT",
	main = "src/init.lua",
	name = "@rbxts/flipper",
	repository = {
		type = "git",
		url = "https://github.com/Reselim/Flipper",
	},
	types = "typings/index.d.ts",
	version = "2.0.1",
} end, newEnv("SriBlox-Modern.include.node_modules.flipper.package"))() end)

newModule("src", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src", "SriBlox-Modern.include.node_modules.flipper", function () return setfenv(function() local Flipper = {
	SingleMotor = require(script.SingleMotor),
	GroupMotor = require(script.GroupMotor),

	Instant = require(script.Instant),
	Linear = require(script.Linear),
	Spring = require(script.Spring),
	
	isMotor = require(script.isMotor),
}

return Flipper end, newEnv("SriBlox-Modern.include.node_modules.flipper.src"))() end)

newModule("BaseMotor", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.BaseMotor", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local RunService = game:GetService("RunService")

local Signal = require(script.Parent.Signal)

local noop = function() end

local BaseMotor = {}
BaseMotor.__index = BaseMotor

function BaseMotor.new()
	return setmetatable({
		_onStep = Signal.new(),
		_onStart = Signal.new(),
		_onComplete = Signal.new(),
	}, BaseMotor)
end

function BaseMotor:onStep(handler)
	return self._onStep:connect(handler)
end

function BaseMotor:onStart(handler)
	return self._onStart:connect(handler)
end

function BaseMotor:onComplete(handler)
	return self._onComplete:connect(handler)
end

function BaseMotor:start()
	if not self._connection then
		self._connection = RunService.RenderStepped:Connect(function(deltaTime)
			self:step(deltaTime)
		end)
	end
end

function BaseMotor:stop()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end

BaseMotor.destroy = BaseMotor.stop

BaseMotor.step = noop
BaseMotor.getValue = noop
BaseMotor.setGoal = noop

function BaseMotor:__tostring()
	return "Motor"
end

return BaseMotor
 end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.BaseMotor"))() end)

newModule("GroupMotor", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.GroupMotor", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local BaseMotor = require(script.Parent.BaseMotor)
local SingleMotor = require(script.Parent.SingleMotor)

local isMotor = require(script.Parent.isMotor)

local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

function GroupMotor.new(initialValues, useImplicitConnections)
	assert(initialValues, "Missing argument #1: initialValues")
	assert(typeof(initialValues) == "table", "initialValues must be a table!")
	assert(not initialValues.step, "initialValues contains disallowed property \"step\". Did you mean to put a table of values here?")

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

function GroupMotor:step(deltaTime)
	if self._complete then
		return true
	end

	local allMotorsComplete = true

	for _, motor in pairs(self._motors) do
		local complete = motor:step(deltaTime)
		if not complete then
			-- If any of the sub-motors are incomplete, the group motor will not be complete either
			allMotorsComplete = false
		end
	end

	self._onStep:fire(self:getValue())

	if allMotorsComplete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._complete = true
		self._onComplete:fire()
	end

	return allMotorsComplete
end

function GroupMotor:setGoal(goals)
	assert(not goals.step, "goals contains disallowed property \"step\". Did you mean to put a table of goals here?")

	self._complete = false
	self._onStart:fire()

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		motor:setGoal(goal)
	end

	if self._useImplicitConnections then
		self:start()
	end
end

function GroupMotor:getValue()
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue()
	end

	return values
end

function GroupMotor:__tostring()
	return "Motor(Group)"
end

return GroupMotor
 end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.GroupMotor"))() end)

newModule("Instant", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.Instant", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local Instant = {}
Instant.__index = Instant

function Instant.new(targetValue)
	return setmetatable({
		_targetValue = targetValue,
	}, Instant)
end

function Instant:step()
	return {
		complete = true,
		value = self._targetValue,
	}
end

return Instant end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.Instant"))() end)

newModule("Linear", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.Linear", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity -- Linear motion ignores the state's velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = dPos >= math.abs(goal - position)
	position = position + dPos * (goal > position and 1 or -1)
	if complete then
		position = self._targetValue
		velocity = 0
	end
	
	return {
		complete = complete,
		value = position,
		velocity = velocity,
	}
end

return Linear end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.Linear"))() end)

newModule("Signal", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.Signal", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local Connection = {}
Connection.__index = Connection

function Connection.new(signal, handler)
	return setmetatable({
		signal = signal,
		connected = true,
		_handler = handler,
	}, Connection)
end

function Connection:disconnect()
	if self.connected then
		self.connected = false

		for index, connection in pairs(self.signal._connections) do
			if connection == self then
				table.remove(self.signal._connections, index)
				return
			end
		end
	end
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
		_threads = {},
	}, Signal)
end

function Signal:fire(...)
	for _, connection in pairs(self._connections) do
		connection._handler(...)
	end

	for _, thread in pairs(self._threads) do
		coroutine.resume(thread, ...)
	end
	
	self._threads = {}
end

function Signal:connect(handler)
	local connection = Connection.new(self, handler)
	table.insert(self._connections, connection)
	return connection
end

function Signal:wait()
	table.insert(self._threads, coroutine.running())
	return coroutine.yield()
end

return Signal end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.Signal"))() end)

newModule("SingleMotor", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.SingleMotor", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local BaseMotor = require(script.Parent.BaseMotor)

local SingleMotor = setmetatable({}, BaseMotor)
SingleMotor.__index = SingleMotor

function SingleMotor.new(initialValue, useImplicitConnections)
	assert(initialValue, "Missing argument #1: initialValue")
	assert(typeof(initialValue) == "number", "initialValue must be a number!")

	local self = setmetatable(BaseMotor.new(), SingleMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._goal = nil
	self._state = {
		complete = true,
		value = initialValue,
	}

	return self
end

function SingleMotor:step(deltaTime)
	if self._state.complete then
		return true
	end

	local newState = self._goal:step(self._state, deltaTime)

	self._state = newState
	self._onStep:fire(newState.value)

	if newState.complete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._onComplete:fire()
	end

	return newState.complete
end

function SingleMotor:getValue()
	return self._state.value
end

function SingleMotor:setGoal(goal)
	self._state.complete = false
	self._goal = goal

	self._onStart:fire()

	if self._useImplicitConnections then
		self:start()
	end
end

function SingleMotor:__tostring()
	return "Motor(Single)"
end

return SingleMotor
 end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.SingleMotor"))() end)

newModule("Spring", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.Spring", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local VELOCITY_THRESHOLD = 0.001
local POSITION_THRESHOLD = 0.001

local EPS = 0.0001

local Spring = {}
Spring.__index = Spring

function Spring.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_frequency = options.frequency or 4,
		_dampingRatio = options.dampingRatio or 1,
	}, Spring)
end

function Spring:step(state, dt)
	-- Copyright 2018 Parker Stebbins (parker@fractality.io)
	-- github.com/Fraktality/Spring
	-- Distributed under the MIT license

	local d = self._dampingRatio
	local f = self._frequency*2*math.pi
	local g = self._targetValue
	local p0 = state.value
	local v0 = state.velocity or 0

	local offset = p0 - g
	local decay = math.exp(-d*f*dt)

	local p1, v1

	if d == 1 then -- Critically damped
		p1 = (offset*(1 + f*dt) + v0*dt)*decay + g
		v1 = (v0*(1 - f*dt) - offset*(f*f*dt))*decay
	elseif d < 1 then -- Underdamped
		local c = math.sqrt(1 - d*d)

		local i = math.cos(f*c*dt)
		local j = math.sin(f*c*dt)

		-- Damping ratios approaching 1 can cause division by small numbers.
		-- To fix that, group terms around z=j/c and find an approximation for z.
		-- Start with the definition of z:
		--    z = sin(dt*f*c)/c
		-- Substitute a=dt*f:
		--    z = sin(a*c)/c
		-- Take the Maclaurin expansion of z with respect to c:
		--    z = a - (a^3*c^2)/6 + (a^5*c^4)/120 + O(c^6)
		--    z ≈ a - (a^3*c^2)/6 + (a^5*c^4)/120
		-- Rewrite in Horner form:
		--    z ≈ a + ((a*a)*(c*c)*(c*c)/20 - c*c)*(a*a*a)/6

		local z
		if c > EPS then
			z = j/c
		else
			local a = dt*f
			z = a + ((a*a)*(c*c)*(c*c)/20 - c*c)*(a*a*a)/6
		end

		-- Frequencies approaching 0 present a similar problem.
		-- We want an approximation for y as f approaches 0, where:
		--    y = sin(dt*f*c)/(f*c)
		-- Substitute b=dt*c:
		--    y = sin(b*c)/b
		-- Now reapply the process from z.

		local y
		if f*c > EPS then
			y = j/(f*c)
		else
			local b = f*c
			y = dt + ((dt*dt)*(b*b)*(b*b)/20 - b*b)*(dt*dt*dt)/6
		end

		p1 = (offset*(i + d*z) + v0*y)*decay + g
		v1 = (v0*(i - z*d) - offset*(z*f))*decay

	else -- Overdamped
		local c = math.sqrt(d*d - 1)

		local r1 = -f*(d - c)
		local r2 = -f*(d + c)

		local co2 = (v0 - offset*r1)/(2*f*c)
		local co1 = offset - co2

		local e1 = co1*math.exp(r1*dt)
		local e2 = co2*math.exp(r2*dt)

		p1 = e1 + e2 + g
		v1 = e1*r1 + e2*r2
	end

	local complete = math.abs(v1) < VELOCITY_THRESHOLD and math.abs(p1 - g) < POSITION_THRESHOLD
	
	return {
		complete = complete,
		value = complete and g or p1,
		velocity = v1,
	}
end

return Spring end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.Spring"))() end)

newModule("isMotor", "ModuleScript", "SriBlox-Modern.include.node_modules.flipper.src.isMotor", "SriBlox-Modern.include.node_modules.flipper.src", function () return setfenv(function() local function isMotor(value)
	local motorType = tostring(value):match("^Motor%((.+)%)$")

	if motorType then
		return true, motorType
	else
		return false
	end
end

return isMotor end, newEnv("SriBlox-Modern.include.node_modules.flipper.src.isMotor"))() end)

newInstance("typings", "Folder", "SriBlox-Modern.include.node_modules.flipper.typings", "SriBlox-Modern.include.node_modules.flipper")

newInstance("roact", "Folder", "SriBlox-Modern.include.node_modules.roact", "SriBlox-Modern.include.node_modules")

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.package", "SriBlox-Modern.include.node_modules.roact", function () return setfenv(function() return {
	author = "",
	contributors = {{
		name = "Jonathan Holmes",
		url = "https://github.com/Vorlias",
	}},
	dependencies = {
	},
	description = "TypeScript support for Roact",
	devDependencies = {
		["@rbxts/compiler-types"] = "^1.0.0-types.0",
		["@rbxts/types"] = "^1.0.459",
	},
	files = {"src", "!src/test.tsx"},
	keywords = {"roblox", "typescript", "roact"},
	licenses = {{
		type = "Apache 2.0",
		url = "https://github.com/Roblox/roact/blob/master/LICENSE",
	}},
	main = "src/init.lua",
	name = "@rbxts/roact",
	scripts = {
	},
	typings = "src/index.d.ts",
	version = "1.4.0-ts.2",
} end, newEnv("SriBlox-Modern.include.node_modules.roact.package"))() end)

newModule("src", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src", "SriBlox-Modern.include.node_modules.roact", function () return setfenv(function() --[[
	Packages up the internals of Roact and exposes a public API for it.
]]

local GlobalConfig = require(script.GlobalConfig)
local createReconciler = require(script.createReconciler)
local createReconcilerCompat = require(script.createReconcilerCompat)
local RobloxRenderer = require(script.RobloxRenderer)
local strict = require(script.strict)
local Binding = require(script.Binding)

local robloxReconciler = createReconciler(RobloxRenderer)
local reconcilerCompat = createReconcilerCompat(robloxReconciler)

local Roact = strict {
	Component = require(script.Component),
	createElement = require(script.createElement),
	createFragment = require(script.createFragment),
	oneChild = require(script.oneChild),
	PureComponent = require(script.PureComponent),
	None = require(script.None),
	Portal = require(script.Portal),
	createRef = require(script.createRef),
	forwardRef = require(script.forwardRef),
	createBinding = Binding.create,
	joinBindings = Binding.join,
	createContext = require(script.createContext),

	Change = require(script.PropMarkers.Change),
	Children = require(script.PropMarkers.Children),
	Event = require(script.PropMarkers.Event),
	Ref = require(script.PropMarkers.Ref),

	mount = robloxReconciler.mountVirtualTree,
	unmount = robloxReconciler.unmountVirtualTree,
	update = robloxReconciler.updateVirtualTree,

	reify = reconcilerCompat.reify,
	teardown = reconcilerCompat.teardown,
	reconcile = reconcilerCompat.reconcile,

	setGlobalConfig = GlobalConfig.set,

	-- APIs that may change in the future without warning
	UNSTABLE = {
	},
}

return Roact end, newEnv("SriBlox-Modern.include.node_modules.roact.src"))() end)

newModule("Binding", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Binding", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local createSignal = require(script.Parent.createSignal)
local Symbol = require(script.Parent.Symbol)
local Type = require(script.Parent.Type)

local config = require(script.Parent.GlobalConfig).get()

local BindingImpl = Symbol.named("BindingImpl")

local BindingInternalApi = {}

local bindingPrototype = {}

function bindingPrototype:getValue()
	return BindingInternalApi.getValue(self)
end

function bindingPrototype:map(predicate)
	return BindingInternalApi.map(self, predicate)
end

local BindingPublicMeta = {
	__index = bindingPrototype,
	__tostring = function(self)
		return string.format("RoactBinding(%s)", tostring(self:getValue()))
	end,
}

function BindingInternalApi.update(binding, newValue)
	return binding[BindingImpl].update(newValue)
end

function BindingInternalApi.subscribe(binding, callback)
	return binding[BindingImpl].subscribe(callback)
end

function BindingInternalApi.getValue(binding)
	return binding[BindingImpl].getValue()
end

function BindingInternalApi.create(initialValue)
	local impl = {
		value = initialValue,
		changeSignal = createSignal(),
	}

	function impl.subscribe(callback)
		return impl.changeSignal:subscribe(callback)
	end

	function impl.update(newValue)
		impl.value = newValue
		impl.changeSignal:fire(newValue)
	end

	function impl.getValue()
		return impl.value
	end

	return setmetatable({
		[Type] = Type.Binding,
		[BindingImpl] = impl,
	}, BindingPublicMeta), impl.update
end

function BindingInternalApi.map(upstreamBinding, predicate)
	if config.typeChecks then
		assert(Type.of(upstreamBinding) == Type.Binding, "Expected arg #1 to be a binding")
		assert(typeof(predicate) == "function", "Expected arg #1 to be a function")
	end

	local impl = {}

	function impl.subscribe(callback)
		return BindingInternalApi.subscribe(upstreamBinding, function(newValue)
			callback(predicate(newValue))
		end)
	end

	function impl.update(newValue)
		error("Bindings created by Binding:map(fn) cannot be updated directly", 2)
	end

	function impl.getValue()
		return predicate(upstreamBinding:getValue())
	end

	return setmetatable({
		[Type] = Type.Binding,
		[BindingImpl] = impl,
	}, BindingPublicMeta)
end

function BindingInternalApi.join(upstreamBindings)
	if config.typeChecks then
		assert(typeof(upstreamBindings) == "table", "Expected arg #1 to be of type table")

		for key, value in pairs(upstreamBindings) do
			if Type.of(value) ~= Type.Binding then
				local message = (
					"Expected arg #1 to contain only bindings, but key %q had a non-binding value"
				):format(
					tostring(key)
				)
				error(message, 2)
			end
		end
	end

	local impl = {}

	local function getValue()
		local value = {}

		for key, upstream in pairs(upstreamBindings) do
			value[key] = upstream:getValue()
		end

		return value
	end

	function impl.subscribe(callback)
		local disconnects = {}

		for key, upstream in pairs(upstreamBindings) do
			disconnects[key] = BindingInternalApi.subscribe(upstream, function(newValue)
				callback(getValue())
			end)
		end

		return function()
			if disconnects == nil then
				return
			end

			for _, disconnect in pairs(disconnects) do
				disconnect()
			end

			disconnects = nil
		end
	end

	function impl.update(newValue)
		error("Bindings created by joinBindings(...) cannot be updated directly", 2)
	end

	function impl.getValue()
		return getValue()
	end

	return setmetatable({
		[Type] = Type.Binding,
		[BindingImpl] = impl,
	}, BindingPublicMeta)
end

return BindingInternalApi end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Binding"))() end)

newModule("Component", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Component", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local assign = require(script.Parent.assign)
local ComponentLifecyclePhase = require(script.Parent.ComponentLifecyclePhase)
local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)
local invalidSetStateMessages = require(script.Parent.invalidSetStateMessages)
local internalAssert = require(script.Parent.internalAssert)

local config = require(script.Parent.GlobalConfig).get()

--[[
	Calling setState during certain lifecycle allowed methods has the potential
	to create an infinitely updating component. Rather than time out, we exit
	with an error if an unreasonable number of self-triggering updates occur
]]
local MAX_PENDING_UPDATES = 100

local InternalData = Symbol.named("InternalData")

local componentMissingRenderMessage = [[
The component %q is missing the `render` method.
`render` must be defined when creating a Roact component!]]

local tooManyUpdatesMessage = [[
The component %q has reached the setState update recursion limit.
When using `setState` in `didUpdate`, make sure that it won't repeat infinitely!]]

local componentClassMetatable = {}

function componentClassMetatable:__tostring()
	return self.__componentName
end

local Component = {}
setmetatable(Component, componentClassMetatable)

Component[Type] = Type.StatefulComponentClass
Component.__index = Component
Component.__componentName = "Component"

--[[
	A method called by consumers of Roact to create a new component class.
	Components can not be extended beyond this point, with the exception of
	PureComponent.
]]
function Component:extend(name)
	if config.typeChecks then
		assert(Type.of(self) == Type.StatefulComponentClass, "Invalid `self` argument to `extend`.")
		assert(typeof(name) == "string", "Component class name must be a string")
	end

	local class = {}

	for key, value in pairs(self) do
		-- Roact opts to make consumers use composition over inheritance, which
		-- lines up with React.
		-- https://reactjs.org/docs/composition-vs-inheritance.html
		if key ~= "extend" then
			class[key] = value
		end
	end

	class[Type] = Type.StatefulComponentClass
	class.__index = class
	class.__componentName = name

	setmetatable(class, componentClassMetatable)

	return class
end

function Component:__getDerivedState(incomingProps, incomingState)
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentInstance, "Invalid use of `__getDerivedState`")
	end

	local internalData = self[InternalData]
	local componentClass = internalData.componentClass

	if componentClass.getDerivedStateFromProps ~= nil then
		local derivedState = componentClass.getDerivedStateFromProps(incomingProps, incomingState)

		if derivedState ~= nil then
			if config.typeChecks then
				assert(typeof(derivedState) == "table", "getDerivedStateFromProps must return a table!")
			end

			return derivedState
		end
	end

	return nil
end

function Component:setState(mapState)
	if config.typeChecks then
		assert(Type.of(self) == Type.StatefulComponentInstance, "Invalid `self` argument to `extend`.")
	end

	local internalData = self[InternalData]
	local lifecyclePhase = internalData.lifecyclePhase

	--[[
		When preparing to update, rendering, or unmounting, it is not safe
		to call `setState` as it will interfere with in-flight updates. It's
		also disallowed during unmounting
	]]
	if lifecyclePhase == ComponentLifecyclePhase.ShouldUpdate or
		lifecyclePhase == ComponentLifecyclePhase.WillUpdate or
		lifecyclePhase == ComponentLifecyclePhase.Render or
		lifecyclePhase == ComponentLifecyclePhase.WillUnmount
	then
		local messageTemplate = invalidSetStateMessages[internalData.lifecyclePhase]

		local message = messageTemplate:format(tostring(internalData.componentClass))

		error(message, 2)
	end

	local pendingState = internalData.pendingState

	local partialState
	if typeof(mapState) == "function" then
		partialState = mapState(pendingState or self.state, self.props)

		-- Abort the state update if the given state updater function returns nil
		if partialState == nil then
			return
		end
	elseif typeof(mapState) == "table" then
		partialState = mapState
	else
		error("Invalid argument to setState, expected function or table", 2)
	end

	local newState
	if pendingState ~= nil then
		newState = assign(pendingState, partialState)
	else
		newState = assign({}, self.state, partialState)
	end

	if lifecyclePhase == ComponentLifecyclePhase.Init then
		-- If `setState` is called in `init`, we can skip triggering an update!
		local derivedState = self:__getDerivedState(self.props, newState)
		self.state = assign(newState, derivedState)

	elseif lifecyclePhase == ComponentLifecyclePhase.DidMount or
		lifecyclePhase == ComponentLifecyclePhase.DidUpdate or
		lifecyclePhase == ComponentLifecyclePhase.ReconcileChildren
	then
		--[[
			During certain phases of the component lifecycle, it's acceptable to
			allow `setState` but defer the update until we're done with ones in flight.
			We do this by collapsing it into any pending updates we have.
		]]
		local derivedState = self:__getDerivedState(self.props, newState)
		internalData.pendingState = assign(newState, derivedState)

	elseif lifecyclePhase == ComponentLifecyclePhase.Idle then
		-- Pause parent events when we are updated outside of our lifecycle
		-- If these events are not paused, our setState can cause a component higher up the
		-- tree to rerender based on events caused by our component while this reconciliation is happening.
		-- This could cause the tree to become invalid.
		local virtualNode = internalData.virtualNode
		local reconciler = internalData.reconciler
		if config.tempFixUpdateChildrenReEntrancy then
			reconciler.suspendParentEvents(virtualNode)
		end

		-- Outside of our lifecycle, the state update is safe to make immediately
		self:__update(nil, newState)

		if config.tempFixUpdateChildrenReEntrancy then
			reconciler.resumeParentEvents(virtualNode)
		end
	else
		local messageTemplate = invalidSetStateMessages.default

		local message = messageTemplate:format(tostring(internalData.componentClass))

		error(message, 2)
	end
end

--[[
	Returns the stack trace of where the element was created that this component
	instance's properties are based on.

	Intended to be used primarily by diagnostic tools.
]]
function Component:getElementTraceback()
	return self[InternalData].virtualNode.currentElement.source
end

--[[
	Returns a snapshot of this component given the current props and state. Must
	be overridden by consumers of Roact and should be a pure function with
	regards to props and state.

	TODO (#199): Accept props and state as arguments.
]]
function Component:render()
	local internalData = self[InternalData]

	local message = componentMissingRenderMessage:format(
		tostring(internalData.componentClass)
	)

	error(message, 0)
end

--[[
	Retrieves the context value corresponding to the given key. Can return nil
	if a requested context key is not present
]]
function Component:__getContext(key)
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentInstance, "Invalid use of `__getContext`")
		internalAssert(key ~= nil, "Context key cannot be nil")
	end

	local virtualNode = self[InternalData].virtualNode
	local context = virtualNode.context

	return context[key]
end

--[[
	Adds a new context entry to this component's context table (which will be
	passed down to child components).
]]
function Component:__addContext(key, value)
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentInstance, "Invalid use of `__addContext`")
	end
	local virtualNode = self[InternalData].virtualNode

	-- Make sure we store a reference to the component's original, unmodified
	-- context the virtual node. In the reconciler, we'll restore the original
	-- context if we need to replace the node (this happens when a node gets
	-- re-rendered as a different component)
	if virtualNode.originalContext == nil then
		virtualNode.originalContext = virtualNode.context
	end

	-- Build a new context table on top of the existing one, then apply it to
	-- our virtualNode
	local existing = virtualNode.context
	virtualNode.context = assign({}, existing, { [key] = value })
end

--[[
	Performs property validation if the static method validateProps is declared.
	validateProps should follow assert's expected arguments:
	(false, message: string) | true. The function may return a message in the
	true case; it will be ignored. If this fails, the function will throw the
	error.
]]
function Component:__validateProps(props)
	if not config.propValidation then
		return
	end

	local validator = self[InternalData].componentClass.validateProps

	if validator == nil then
		return
	end

	if typeof(validator) ~= "function" then
		error(("validateProps must be a function, but it is a %s.\nCheck the definition of the component %q."):format(
			typeof(validator),
			self.__componentName
		))
	end

	local success, failureReason = validator(props)

	if not success then
		failureReason = failureReason or "<Validator function did not supply a message>"
		error(("Property validation failed in %s: %s\n\n%s"):format(
			self.__componentName,
			tostring(failureReason),
			self:getElementTraceback() or "<enable element tracebacks>"),
		0)
	end
end

--[[
	An internal method used by the reconciler to construct a new component
	instance and attach it to the given virtualNode.
]]
function Component:__mount(reconciler, virtualNode)
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentClass, "Invalid use of `__mount`")
		internalAssert(Type.of(virtualNode) == Type.VirtualNode, "Expected arg #2 to be of type VirtualNode")
	end

	local currentElement = virtualNode.currentElement
	local hostParent = virtualNode.hostParent

	-- Contains all the information that we want to keep from consumers of
	-- Roact, or even other parts of the codebase like the reconciler.
	local internalData = {
		reconciler = reconciler,
		virtualNode = virtualNode,
		componentClass = self,
		lifecyclePhase = ComponentLifecyclePhase.Init,
	}

	local instance = {
		[Type] = Type.StatefulComponentInstance,
		[InternalData] = internalData,
	}

	setmetatable(instance, self)

	virtualNode.instance = instance

	local props = currentElement.props

	if self.defaultProps ~= nil then
		props = assign({}, self.defaultProps, props)
	end

	instance:__validateProps(props)

	instance.props = props

	local newContext = assign({}, virtualNode.legacyContext)
	instance._context = newContext

	instance.state = assign({}, instance:__getDerivedState(instance.props, {}))

	if instance.init ~= nil then
		instance:init(instance.props)
		assign(instance.state, instance:__getDerivedState(instance.props, instance.state))
	end

	-- It's possible for init() to redefine _context!
	virtualNode.legacyContext = instance._context

	internalData.lifecyclePhase = ComponentLifecyclePhase.Render
	local renderResult = instance:render()

	internalData.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
	reconciler.updateVirtualNodeWithRenderResult(virtualNode, hostParent, renderResult)

	if instance.didMount ~= nil then
		internalData.lifecyclePhase = ComponentLifecyclePhase.DidMount
		instance:didMount()
	end

	if internalData.pendingState ~= nil then
		-- __update will handle pendingState, so we don't pass any new element or state
		instance:__update(nil, nil)
	end

	internalData.lifecyclePhase = ComponentLifecyclePhase.Idle
end

--[[
	Internal method used by the reconciler to clean up any resources held by
	this component instance.
]]
function Component:__unmount()
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentInstance, "Invalid use of `__unmount`")
	end

	local internalData = self[InternalData]
	local virtualNode = internalData.virtualNode
	local reconciler = internalData.reconciler

	if self.willUnmount ~= nil then
		internalData.lifecyclePhase = ComponentLifecyclePhase.WillUnmount
		self:willUnmount()
	end

	for _, childNode in pairs(virtualNode.children) do
		reconciler.unmountVirtualNode(childNode)
	end
end

--[[
	Internal method used by setState (to trigger updates based on state) and by
	the reconciler (to trigger updates based on props)

	Returns true if the update was completed, false if it was cancelled by shouldUpdate
]]
function Component:__update(updatedElement, updatedState)
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentInstance, "Invalid use of `__update`")
		internalAssert(
			Type.of(updatedElement) == Type.Element or updatedElement == nil,
			"Expected arg #1 to be of type Element or nil"
		)
		internalAssert(
			typeof(updatedState) == "table" or updatedState == nil,
			"Expected arg #2 to be of type table or nil"
		)
	end

	local internalData = self[InternalData]
	local componentClass = internalData.componentClass

	local newProps = self.props
	if updatedElement ~= nil then
		newProps = updatedElement.props

		if componentClass.defaultProps ~= nil then
			newProps = assign({}, componentClass.defaultProps, newProps)
		end

		self:__validateProps(newProps)
	end

	local updateCount = 0
	repeat
		local finalState
		local pendingState = nil

		-- Consume any pending state we might have
		if internalData.pendingState ~= nil then
			pendingState = internalData.pendingState
			internalData.pendingState = nil
		end

		-- Consume a standard update to state or props
		if updatedState ~= nil or newProps ~= self.props then
			if pendingState == nil then
				finalState = updatedState or self.state
			else
				finalState = assign(pendingState, updatedState)
			end

			local derivedState = self:__getDerivedState(newProps, finalState)

			if derivedState ~= nil then
				finalState = assign({}, finalState, derivedState)
			end

			updatedState = nil
		else
			finalState = pendingState
		end

		if not self:__resolveUpdate(newProps, finalState) then
			-- If the update was short-circuited, bubble the result up to the caller
			return false
		end

		updateCount = updateCount + 1

		if updateCount > MAX_PENDING_UPDATES then
			error(tooManyUpdatesMessage:format(tostring(internalData.componentClass)), 3)
		end
	until internalData.pendingState == nil

	return true
end

--[[
	Internal method used by __update to apply new props and state

	Returns true if the update was completed, false if it was cancelled by shouldUpdate
]]
function Component:__resolveUpdate(incomingProps, incomingState)
	if config.internalTypeChecks then
		internalAssert(Type.of(self) == Type.StatefulComponentInstance, "Invalid use of `__resolveUpdate`")
	end

	local internalData = self[InternalData]
	local virtualNode = internalData.virtualNode
	local reconciler = internalData.reconciler

	local oldProps = self.props
	local oldState = self.state

	if incomingProps == nil then
		incomingProps = oldProps
	end
	if incomingState == nil then
		incomingState = oldState
	end

	if self.shouldUpdate ~= nil then
		internalData.lifecyclePhase = ComponentLifecyclePhase.ShouldUpdate
		local continueWithUpdate = self:shouldUpdate(incomingProps, incomingState)

		if not continueWithUpdate then
			internalData.lifecyclePhase = ComponentLifecyclePhase.Idle
			return false
		end
	end

	if self.willUpdate ~= nil then
		internalData.lifecyclePhase = ComponentLifecyclePhase.WillUpdate
		self:willUpdate(incomingProps, incomingState)
	end

	internalData.lifecyclePhase = ComponentLifecyclePhase.Render

	self.props = incomingProps
	self.state = incomingState

	local renderResult = virtualNode.instance:render()

	internalData.lifecyclePhase = ComponentLifecyclePhase.ReconcileChildren
	reconciler.updateVirtualNodeWithRenderResult(virtualNode, virtualNode.hostParent, renderResult)

	if self.didUpdate ~= nil then
		internalData.lifecyclePhase = ComponentLifecyclePhase.DidUpdate
		self:didUpdate(oldProps, oldState)
	end

	internalData.lifecyclePhase = ComponentLifecyclePhase.Idle
	return true
end

return Component end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Component"))() end)

newModule("ComponentLifecyclePhase", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.ComponentLifecyclePhase", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)

local ComponentLifecyclePhase = strict({
	-- Component methods
	Init = Symbol.named("init"),
	Render = Symbol.named("render"),
	ShouldUpdate = Symbol.named("shouldUpdate"),
	WillUpdate = Symbol.named("willUpdate"),
	DidMount = Symbol.named("didMount"),
	DidUpdate = Symbol.named("didUpdate"),
	WillUnmount = Symbol.named("willUnmount"),

	-- Phases describing reconciliation status
	ReconcileChildren = Symbol.named("reconcileChildren"),
	Idle = Symbol.named("idle"),
}, "ComponentLifecyclePhase")

return ComponentLifecyclePhase end, newEnv("SriBlox-Modern.include.node_modules.roact.src.ComponentLifecyclePhase"))() end)

newModule("Config", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Config", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Exposes an interface to set global configuration values for Roact.

	Configuration can only occur once, and should only be done by an application
	using Roact, not a library.

	Any keys that aren't recognized will cause errors. Configuration is only
	intended for configuring Roact itself, not extensions or libraries.

	Configuration is expected to be set immediately after loading Roact. Setting
	configuration values after an application starts may produce unpredictable
	behavior.
]]

-- Every valid configuration value should be non-nil in this table.
local defaultConfig = {
	-- Enables asserts for internal Roact APIs. Useful for debugging Roact itself.
	["internalTypeChecks"] = false,
	-- Enables stricter type asserts for Roact's public API.
	["typeChecks"] = false,
	-- Enables storage of `debug.traceback()` values on elements for debugging.
	["elementTracing"] = false,
	-- Enables validation of component props in stateful components.
	["propValidation"] = false,

	-- Temporary config for enabling a bug fix for processing events based on updates to child instances
	-- outside of the standard lifecycle.
	["tempFixUpdateChildrenReEntrancy"] = false,
}

-- Build a list of valid configuration values up for debug messages.
local defaultConfigKeys = {}
for key in pairs(defaultConfig) do
	table.insert(defaultConfigKeys, key)
end

local Config = {}

function Config.new()
	local self = {}

	self._currentConfig = setmetatable({}, {
		__index = function(_, key)
			local message = (
				"Invalid global configuration key %q. Valid configuration keys are: %s"
			):format(
				tostring(key),
				table.concat(defaultConfigKeys, ", ")
			)

			error(message, 3)
		end
	})

	-- We manually bind these methods here so that the Config's methods can be
	-- used without passing in self, since they eventually get exposed on the
	-- root Roact object.
	self.set = function(...)
		return Config.set(self, ...)
	end

	self.get = function(...)
		return Config.get(self, ...)
	end

	self.scoped = function(...)
		return Config.scoped(self, ...)
	end

	self.set(defaultConfig)

	return self
end

function Config:set(configValues)
	-- Validate values without changing any configuration.
	-- We only want to apply this configuration if it's valid!
	for key, value in pairs(configValues) do
		if defaultConfig[key] == nil then
			local message = (
				"Invalid global configuration key %q (type %s). Valid configuration keys are: %s"
			):format(
				tostring(key),
				typeof(key),
				table.concat(defaultConfigKeys, ", ")
			)

			error(message, 3)
		end

		-- Right now, all configuration values must be boolean.
		if typeof(value) ~= "boolean" then
			local message = (
				"Invalid value %q (type %s) for global configuration key %q. Valid values are: true, false"
			):format(
				tostring(value),
				typeof(value),
				tostring(key)
			)

			error(message, 3)
		end

		self._currentConfig[key] = value
	end
end

function Config:get()
	return self._currentConfig
end

function Config:scoped(configValues, callback)
	local previousValues = {}
	for key, value in pairs(self._currentConfig) do
		previousValues[key] = value
	end

	self.set(configValues)

	local success, result = pcall(callback)

	self.set(previousValues)

	assert(success, result)
end

return Config end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Config"))() end)

newModule("ElementKind", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.ElementKind", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Contains markers for annotating the type of an element.

	Use `ElementKind` as a key, and values from it as the value.

		local element = {
			[ElementKind] = ElementKind.Host,
		}
]]

local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)
local Portal = require(script.Parent.Portal)

local ElementKind = newproxy(true)

local ElementKindInternal = {
	Portal = Symbol.named("Portal"),
	Host = Symbol.named("Host"),
	Function = Symbol.named("Function"),
	Stateful = Symbol.named("Stateful"),
	Fragment = Symbol.named("Fragment"),
}

function ElementKindInternal.of(value)
	if typeof(value) ~= "table" then
		return nil
	end

	return value[ElementKind]
end

local componentTypesToKinds = {
	["string"] = ElementKindInternal.Host,
	["function"] = ElementKindInternal.Function,
	["table"] = ElementKindInternal.Stateful,
}

function ElementKindInternal.fromComponent(component)
	if component == Portal then
		return ElementKind.Portal
	else
		return componentTypesToKinds[typeof(component)]
	end
end

getmetatable(ElementKind).__index = ElementKindInternal

strict(ElementKindInternal, "ElementKind")

return ElementKind end, newEnv("SriBlox-Modern.include.node_modules.roact.src.ElementKind"))() end)

newModule("ElementUtils", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.ElementUtils", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)

local function noop()
	return nil
end

local ElementUtils = {}

--[[
	A signal value indicating that a child should use its parent's key, because
	it has no key of its own.

	This occurs when you return only one element from a function component or
	stateful render function.
]]
ElementUtils.UseParentKey = Symbol.named("UseParentKey")

--[[
	Returns an iterator over the children of an element.
	`elementOrElements` may be one of:
	* a boolean
	* nil
	* a single element
	* a fragment
	* a table of elements

	If `elementOrElements` is a boolean or nil, this will return an iterator with
	zero elements.

	If `elementOrElements` is a single element, this will return an iterator with
	one element: a tuple where the first value is ElementUtils.UseParentKey, and
	the second is the value of `elementOrElements`.

	If `elementOrElements` is a fragment or a table, this will return an iterator
	over all the elements of the array.

	If `elementOrElements` is none of the above, this function will throw.
]]
function ElementUtils.iterateElements(elementOrElements)
	local richType = Type.of(elementOrElements)

	-- Single child
	if richType == Type.Element then
		local called = false

		return function()
			if called then
				return nil
			else
				called = true
				return ElementUtils.UseParentKey, elementOrElements
			end
		end
	end

	local regularType = typeof(elementOrElements)

	if elementOrElements == nil or regularType == "boolean" then
		return noop
	end

	if regularType == "table" then
		return pairs(elementOrElements)
	end

	error("Invalid elements")
end

--[[
	Gets the child corresponding to a given key, respecting Roact's rules for
	children. Specifically:
	* If `elements` is nil or a boolean, this will return `nil`, regardless of
		the key given.
	* If `elements` is a single element, this will return `nil`, unless the key
		is ElementUtils.UseParentKey.
	* If `elements` is a table of elements, this will return `elements[key]`.
]]
function ElementUtils.getElementByKey(elements, hostKey)
	if elements == nil or typeof(elements) == "boolean" then
		return nil
	end

	if Type.of(elements) == Type.Element then
		if hostKey == ElementUtils.UseParentKey then
			return elements
		end

		return nil
	end

	if typeof(elements) == "table" then
		return elements[hostKey]
	end

	error("Invalid elements")
end

return ElementUtils end, newEnv("SriBlox-Modern.include.node_modules.roact.src.ElementUtils"))() end)

newModule("GlobalConfig", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.GlobalConfig", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Exposes a single instance of a configuration as Roact's GlobalConfig.
]]

local Config = require(script.Parent.Config)

return Config.new() end, newEnv("SriBlox-Modern.include.node_modules.roact.src.GlobalConfig"))() end)

newModule("Logging", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Logging", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Centralized place to handle logging. Lets us:
	- Unit test log output via `Logging.capture`
	- Disable verbose log messages when not debugging Roact

	This should be broken out into a separate library with the addition of
	scoping and logging configuration.
]]

-- Determines whether log messages will go to stdout/stderr
local outputEnabled = true

-- A set of LogInfo objects that should have messages inserted into them.
-- This is a set so that nested calls to Logging.capture will behave.
local collectors = {}

-- A set of all stack traces that have called warnOnce.
local onceUsedLocations = {}

--[[
	Indent a potentially multi-line string with the given number of tabs, in
	addition to any indentation the string already has.
]]
local function indent(source, indentLevel)
	local indentString = ("\t"):rep(indentLevel)

	return indentString .. source:gsub("\n", "\n" .. indentString)
end

--[[
	Indents a list of strings and then concatenates them together with newlines
	into a single string.
]]
local function indentLines(lines, indentLevel)
	local outputBuffer = {}

	for _, line in ipairs(lines) do
		table.insert(outputBuffer, indent(line, indentLevel))
	end

	return table.concat(outputBuffer, "\n")
end

local logInfoMetatable = {}

--[[
	Automatic coercion to strings for LogInfo objects to enable debugging them
	more easily.
]]
function logInfoMetatable:__tostring()
	local outputBuffer = {"LogInfo {"}

	local errorCount = #self.errors
	local warningCount = #self.warnings
	local infosCount = #self.infos

	if errorCount + warningCount + infosCount == 0 then
		table.insert(outputBuffer, "\t(no messages)")
	end

	if errorCount > 0 then
		table.insert(outputBuffer, ("\tErrors (%d) {"):format(errorCount))
		table.insert(outputBuffer, indentLines(self.errors, 2))
		table.insert(outputBuffer, "\t}")
	end

	if warningCount > 0 then
		table.insert(outputBuffer, ("\tWarnings (%d) {"):format(warningCount))
		table.insert(outputBuffer, indentLines(self.warnings, 2))
		table.insert(outputBuffer, "\t}")
	end

	if infosCount > 0 then
		table.insert(outputBuffer, ("\tInfos (%d) {"):format(infosCount))
		table.insert(outputBuffer, indentLines(self.infos, 2))
		table.insert(outputBuffer, "\t}")
	end

	table.insert(outputBuffer, "}")

	return table.concat(outputBuffer, "\n")
end

local function createLogInfo()
	local logInfo = {
		errors = {},
		warnings = {},
		infos = {},
	}

	setmetatable(logInfo, logInfoMetatable)

	return logInfo
end

local Logging = {}

--[[
	Invokes `callback`, capturing all output that happens during its execution.

	Output will not go to stdout or stderr and will instead be put into a
	LogInfo object that is returned. If `callback` throws, the error will be
	bubbled up to the caller of `Logging.capture`.
]]
function Logging.capture(callback)
	local collector = createLogInfo()

	local wasOutputEnabled = outputEnabled
	outputEnabled = false
	collectors[collector] = true

	local success, result = pcall(callback)

	collectors[collector] = nil
	outputEnabled = wasOutputEnabled

	assert(success, result)

	return collector
end

--[[
	Issues a warning with an automatically attached stack trace.
]]
function Logging.warn(messageTemplate, ...)
	local message = messageTemplate:format(...)

	for collector in pairs(collectors) do
		table.insert(collector.warnings, message)
	end

	-- debug.traceback inserts a leading newline, so we trim it here
	local trace = debug.traceback("", 2):sub(2)
	local fullMessage = ("%s\n%s"):format(message, indent(trace, 1))

	if outputEnabled then
		warn(fullMessage)
	end
end

--[[
	Issues a warning like `Logging.warn`, but only outputs once per call site.

	This is useful for marking deprecated functions that might be called a lot;
	using `warnOnce` instead of `warn` will reduce output noise while still
	correctly marking all call sites.
]]
function Logging.warnOnce(messageTemplate, ...)
	local trace = debug.traceback()

	if onceUsedLocations[trace] then
		return
	end

	onceUsedLocations[trace] = true
	Logging.warn(messageTemplate, ...)
end

return Logging end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Logging"))() end)

newModule("None", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.None", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Symbol = require(script.Parent.Symbol)

-- Marker used to specify that the value is nothing, because nil cannot be
-- stored in tables.
local None = Symbol.named("None")

return None end, newEnv("SriBlox-Modern.include.node_modules.roact.src.None"))() end)

newModule("NoopRenderer", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.NoopRenderer", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Reference renderer intended for use in tests as well as for documenting the
	minimum required interface for a Roact renderer.
]]

local NoopRenderer = {}

function NoopRenderer.isHostObject(target)
	-- Attempting to use NoopRenderer to target a Roblox instance is almost
	-- certainly a mistake.
	return target == nil
end

function NoopRenderer.mountHostNode(reconciler, node)
end

function NoopRenderer.unmountHostNode(reconciler, node)
end

function NoopRenderer.updateHostNode(reconciler, node, newElement)
	return node
end

return NoopRenderer end, newEnv("SriBlox-Modern.include.node_modules.roact.src.NoopRenderer"))() end)

newModule("Portal", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Portal", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Symbol = require(script.Parent.Symbol)

local Portal = Symbol.named("Portal")

return Portal end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Portal"))() end)

newInstance("PropMarkers", "Folder", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers", "SriBlox-Modern.include.node_modules.roact.src")

newModule("Change", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Change", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers", function () return setfenv(function() --[[
	Change is used to generate special prop keys that can be used to connect to
	GetPropertyChangedSignal.

	Generally, Change is indexed by a Roblox property name:

		Roact.createElement("TextBox", {
			[Roact.Change.Text] = function(rbx)
				print("The TextBox", rbx, "changed text to", rbx.Text)
			end,
		})
]]

local Type = require(script.Parent.Parent.Type)

local Change = {}

local changeMetatable = {
	__tostring = function(self)
		return ("RoactHostChangeEvent(%s)"):format(self.name)
	end,
}

setmetatable(Change, {
	__index = function(self, propertyName)
		local changeListener = {
			[Type] = Type.HostChangeEvent,
			name = propertyName,
		}

		setmetatable(changeListener, changeMetatable)
		Change[propertyName] = changeListener

		return changeListener
	end,
})

return Change
 end, newEnv("SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Change"))() end)

newModule("Children", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Children", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers", function () return setfenv(function() local Symbol = require(script.Parent.Parent.Symbol)

local Children = Symbol.named("Children")

return Children end, newEnv("SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Children"))() end)

newModule("Event", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Event", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers", function () return setfenv(function() --[[
	Index into `Event` to get a prop key for attaching to an event on a Roblox
	Instance.

	Example:

		Roact.createElement("TextButton", {
			Text = "Hello, world!",

			[Roact.Event.MouseButton1Click] = function(rbx)
				print("Clicked", rbx)
			end
		})
]]

local Type = require(script.Parent.Parent.Type)

local Event = {}

local eventMetatable = {
	__tostring = function(self)
		return ("RoactHostEvent(%s)"):format(self.name)
	end,
}

setmetatable(Event, {
	__index = function(self, eventName)
		local event = {
			[Type] = Type.HostEvent,
			name = eventName,
		}

		setmetatable(event, eventMetatable)

		Event[eventName] = event

		return event
	end,
})

return Event
 end, newEnv("SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Event"))() end)

newModule("Ref", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Ref", "SriBlox-Modern.include.node_modules.roact.src.PropMarkers", function () return setfenv(function() local Symbol = require(script.Parent.Parent.Symbol)

local Ref = Symbol.named("Ref")

return Ref end, newEnv("SriBlox-Modern.include.node_modules.roact.src.PropMarkers.Ref"))() end)

newModule("PureComponent", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.PureComponent", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	A version of Component with a `shouldUpdate` method that forces the
	resulting component to be pure.
]]

local Component = require(script.Parent.Component)

local PureComponent = Component:extend("PureComponent")

-- When extend()ing a component, you don't get an extend method.
-- This is to promote composition over inheritance.
-- PureComponent is an exception to this rule.
PureComponent.extend = Component.extend

function PureComponent:shouldUpdate(newProps, newState)
	-- In a vast majority of cases, if state updated, something has updated.
	-- We don't bother checking in this case.
	if newState ~= self.state then
		return true
	end

	if newProps == self.props then
		return false
	end

	for key, value in pairs(newProps) do
		if self.props[key] ~= value then
			return true
		end
	end

	for key, value in pairs(self.props) do
		if newProps[key] ~= value then
			return true
		end
	end

	return false
end

return PureComponent end, newEnv("SriBlox-Modern.include.node_modules.roact.src.PureComponent"))() end)

newModule("RobloxRenderer", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.RobloxRenderer", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Renderer that deals in terms of Roblox Instances. This is the most
	well-supported renderer after NoopRenderer and is currently the only
	renderer that does anything.
]]

local Binding = require(script.Parent.Binding)
local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local SingleEventManager = require(script.Parent.SingleEventManager)
local getDefaultInstanceProperty = require(script.Parent.getDefaultInstanceProperty)
local Ref = require(script.Parent.PropMarkers.Ref)
local Type = require(script.Parent.Type)
local internalAssert = require(script.Parent.internalAssert)

local config = require(script.Parent.GlobalConfig).get()

local applyPropsError = [[
Error applying props:
	%s
In element:
%s
]]

local updatePropsError = [[
Error updating props:
	%s
In element:
%s
]]

local function identity(...)
	return ...
end

local function applyRef(ref, newHostObject)
	if ref == nil then
		return
	end

	if typeof(ref) == "function" then
		ref(newHostObject)
	elseif Type.of(ref) == Type.Binding then
		Binding.update(ref, newHostObject)
	else
		-- TODO (#197): Better error message
		error(("Invalid ref: Expected type Binding but got %s"):format(
			typeof(ref)
		))
	end
end

local function setRobloxInstanceProperty(hostObject, key, newValue)
	if newValue == nil then
		local hostClass = hostObject.ClassName
		local _, defaultValue = getDefaultInstanceProperty(hostClass, key)
		newValue = defaultValue
	end

	-- Assign the new value to the object
	hostObject[key] = newValue

	return
end

local function removeBinding(virtualNode, key)
	local disconnect = virtualNode.bindings[key]
	disconnect()
	virtualNode.bindings[key] = nil
end

local function attachBinding(virtualNode, key, newBinding)
	local function updateBoundProperty(newValue)
		local success, errorMessage = xpcall(function()
			setRobloxInstanceProperty(virtualNode.hostObject, key, newValue)
		end, identity)

		if not success then
			local source = virtualNode.currentElement.source

			if source == nil then
				source = "<enable element tracebacks>"
			end

			local fullMessage = updatePropsError:format(errorMessage, source)
			error(fullMessage, 0)
		end
	end

	if virtualNode.bindings == nil then
		virtualNode.bindings = {}
	end

	virtualNode.bindings[key] = Binding.subscribe(newBinding, updateBoundProperty)

	updateBoundProperty(newBinding:getValue())
end

local function detachAllBindings(virtualNode)
	if virtualNode.bindings ~= nil then
		for _, disconnect in pairs(virtualNode.bindings) do
			disconnect()
		end
	end
end

local function applyProp(virtualNode, key, newValue, oldValue)
	if newValue == oldValue then
		return
	end

	if key == Ref or key == Children then
		-- Refs and children are handled in a separate pass
		return
	end

	local internalKeyType = Type.of(key)

	if internalKeyType == Type.HostEvent or internalKeyType == Type.HostChangeEvent then
		if virtualNode.eventManager == nil then
			virtualNode.eventManager = SingleEventManager.new(virtualNode.hostObject)
		end

		local eventName = key.name

		if internalKeyType == Type.HostChangeEvent then
			virtualNode.eventManager:connectPropertyChange(eventName, newValue)
		else
			virtualNode.eventManager:connectEvent(eventName, newValue)
		end

		return
	end

	local newIsBinding = Type.of(newValue) == Type.Binding
	local oldIsBinding = Type.of(oldValue) == Type.Binding

	if oldIsBinding then
		removeBinding(virtualNode, key)
	end

	if newIsBinding then
		attachBinding(virtualNode, key, newValue)
	else
		setRobloxInstanceProperty(virtualNode.hostObject, key, newValue)
	end
end

local function applyProps(virtualNode, props)
	for propKey, value in pairs(props) do
		applyProp(virtualNode, propKey, value, nil)
	end
end

local function updateProps(virtualNode, oldProps, newProps)
	-- Apply props that were added or updated
	for propKey, newValue in pairs(newProps) do
		local oldValue = oldProps[propKey]

		applyProp(virtualNode, propKey, newValue, oldValue)
	end

	-- Clean up props that were removed
	for propKey, oldValue in pairs(oldProps) do
		local newValue = newProps[propKey]

		if newValue == nil then
			applyProp(virtualNode, propKey, nil, oldValue)
		end
	end
end

local RobloxRenderer = {}

function RobloxRenderer.isHostObject(target)
	return typeof(target) == "Instance"
end

function RobloxRenderer.mountHostNode(reconciler, virtualNode)
	local element = virtualNode.currentElement
	local hostParent = virtualNode.hostParent
	local hostKey = virtualNode.hostKey

	if config.internalTypeChecks then
		internalAssert(ElementKind.of(element) == ElementKind.Host, "Element at given node is not a host Element")
	end
	if config.typeChecks then
		assert(element.props.Name == nil, "Name can not be specified as a prop to a host component in Roact.")
		assert(element.props.Parent == nil, "Parent can not be specified as a prop to a host component in Roact.")
	end

	local instance = Instance.new(element.component)
	virtualNode.hostObject = instance

	local success, errorMessage = xpcall(function()
		applyProps(virtualNode, element.props)
	end, identity)

	if not success then
		local source = element.source

		if source == nil then
			source = "<enable element tracebacks>"
		end

		local fullMessage = applyPropsError:format(errorMessage, source)
		error(fullMessage, 0)
	end

	instance.Name = tostring(hostKey)

	local children = element.props[Children]

	if children ~= nil then
		reconciler.updateVirtualNodeWithChildren(virtualNode, virtualNode.hostObject, children)
	end

	instance.Parent = hostParent
	virtualNode.hostObject = instance

	applyRef(element.props[Ref], instance)

	if virtualNode.eventManager ~= nil then
		virtualNode.eventManager:resume()
	end
end

function RobloxRenderer.unmountHostNode(reconciler, virtualNode)
	local element = virtualNode.currentElement

	applyRef(element.props[Ref], nil)

	for _, childNode in pairs(virtualNode.children) do
		reconciler.unmountVirtualNode(childNode)
	end

	detachAllBindings(virtualNode)

	virtualNode.hostObject:Destroy()
end

function RobloxRenderer.updateHostNode(reconciler, virtualNode, newElement)
	local oldProps = virtualNode.currentElement.props
	local newProps = newElement.props

	if virtualNode.eventManager ~= nil then
		virtualNode.eventManager:suspend()
	end

	-- If refs changed, detach the old ref and attach the new one
	if oldProps[Ref] ~= newProps[Ref] then
		applyRef(oldProps[Ref], nil)
		applyRef(newProps[Ref], virtualNode.hostObject)
	end

	local success, errorMessage = xpcall(function()
		updateProps(virtualNode, oldProps, newProps)
	end, identity)

	if not success then
		local source = newElement.source

		if source == nil then
			source = "<enable element tracebacks>"
		end

		local fullMessage = updatePropsError:format(errorMessage, source)
		error(fullMessage, 0)
	end

	local children = newElement.props[Children]
	if children ~= nil or oldProps[Children] ~= nil then
		reconciler.updateVirtualNodeWithChildren(virtualNode, virtualNode.hostObject, children)
	end

	if virtualNode.eventManager ~= nil then
		virtualNode.eventManager:resume()
	end

	return virtualNode
end

return RobloxRenderer
 end, newEnv("SriBlox-Modern.include.node_modules.roact.src.RobloxRenderer"))() end)

newModule("SingleEventManager", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.SingleEventManager", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	A manager for a single host virtual node's connected events.
]]

local Logging = require(script.Parent.Logging)

local CHANGE_PREFIX = "Change."

local EventStatus = {
	-- No events are processed at all; they're silently discarded
	Disabled = "Disabled",

	-- Events are stored in a queue; listeners are invoked when the manager is resumed
	Suspended = "Suspended",

	-- Event listeners are invoked as the events fire
	Enabled = "Enabled",
}

local SingleEventManager = {}
SingleEventManager.__index = SingleEventManager

function SingleEventManager.new(instance)
	local self = setmetatable({
		-- The queue of suspended events
		_suspendedEventQueue = {},

		-- All the event connections being managed
		-- Events are indexed by a string key
		_connections = {},

		-- All the listeners being managed
		-- These are stored distinctly from the connections
		-- Connections can have their listeners replaced at runtime
		_listeners = {},

		-- The suspension status of the manager
		-- Managers start disabled and are "resumed" after the initial render
		_status = EventStatus.Disabled,

		-- If true, the manager is processing queued events right now.
		_isResuming = false,

		-- The Roblox instance the manager is managing
		_instance = instance,
	}, SingleEventManager)

	return self
end

function SingleEventManager:connectEvent(key, listener)
	self:_connect(key, self._instance[key], listener)
end

function SingleEventManager:connectPropertyChange(key, listener)
	local success, event = pcall(function()
		return self._instance:GetPropertyChangedSignal(key)
	end)

	if not success then
		error(("Cannot get changed signal on property %q: %s"):format(
			tostring(key),
			event
		), 0)
	end

	self:_connect(CHANGE_PREFIX .. key, event, listener)
end

function SingleEventManager:_connect(eventKey, event, listener)
	-- If the listener doesn't exist we can just disconnect the existing connection
	if listener == nil then
		if self._connections[eventKey] ~= nil then
			self._connections[eventKey]:Disconnect()
			self._connections[eventKey] = nil
		end

		self._listeners[eventKey] = nil
	else
		if self._connections[eventKey] == nil then
			self._connections[eventKey] = event:Connect(function(...)
				if self._status == EventStatus.Enabled then
					self._listeners[eventKey](self._instance, ...)
				elseif self._status == EventStatus.Suspended then
					-- Store this event invocation to be fired when resume is
					-- called.

					local argumentCount = select("#", ...)
					table.insert(self._suspendedEventQueue, { eventKey, argumentCount, ... })
				end
			end)
		end

		self._listeners[eventKey] = listener
	end
end

function SingleEventManager:suspend()
	self._status = EventStatus.Suspended
end

function SingleEventManager:resume()
	-- If we're already resuming events for this instance, trying to resume
	-- again would cause a disaster.
	if self._isResuming then
		return
	end

	self._isResuming = true

	local index = 1

	-- More events might be added to the queue when evaluating events, so we
	-- need to be careful in order to preserve correct evaluation order.
	while index <= #self._suspendedEventQueue do
		local eventInvocation = self._suspendedEventQueue[index]
		local listener = self._listeners[eventInvocation[1]]
		local argumentCount = eventInvocation[2]

		-- The event might have been disconnected since suspension started; in
		-- this case, we drop the event.
		if listener ~= nil then
			-- Wrap the listener in a coroutine to catch errors and handle
			-- yielding correctly.
			local listenerCo = coroutine.create(listener)
			local success, result = coroutine.resume(
				listenerCo,
				self._instance,
				unpack(eventInvocation, 3, 2 + argumentCount))

			-- If the listener threw an error, we log it as a warning, since
			-- there's no way to write error text in Roblox Lua without killing
			-- our thread!
			if not success then
				Logging.warn("%s", result)
			end
		end

		index = index + 1
	end

	self._isResuming = false
	self._status = EventStatus.Enabled
	self._suspendedEventQueue = {}
end

return SingleEventManager end, newEnv("SriBlox-Modern.include.node_modules.roact.src.SingleEventManager"))() end)

newModule("Symbol", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Symbol", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	A 'Symbol' is an opaque marker type.

	Symbols have the type 'userdata', but when printed to the console, the name
	of the symbol is shown.
]]

local Symbol = {}

--[[
	Creates a Symbol with the given name.

	When printed or coerced to a string, the symbol will turn into the string
	given as its name.
]]
function Symbol.named(name)
	assert(type(name) == "string", "Symbols must be created using a string name!")

	local self = newproxy(true)

	local wrappedName = ("Symbol(%s)"):format(name)

	getmetatable(self).__tostring = function()
		return wrappedName
	end

	return self
end

return Symbol end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Symbol"))() end)

newModule("Type", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.Type", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Contains markers for annotating objects with types.

	To set the type of an object, use `Type` as a key and the actual marker as
	the value:

		local foo = {
			[Type] = Type.Foo,
		}
]]

local Symbol = require(script.Parent.Symbol)
local strict = require(script.Parent.strict)

local Type = newproxy(true)

local TypeInternal = {}

local function addType(name)
	TypeInternal[name] = Symbol.named("Roact" .. name)
end

addType("Binding")
addType("Element")
addType("HostChangeEvent")
addType("HostEvent")
addType("StatefulComponentClass")
addType("StatefulComponentInstance")
addType("VirtualNode")
addType("VirtualTree")

function TypeInternal.of(value)
	if typeof(value) ~= "table" then
		return nil
	end

	return value[Type]
end

getmetatable(Type).__index = TypeInternal

getmetatable(Type).__tostring = function()
	return "RoactType"
end

strict(TypeInternal, "Type")

return Type end, newEnv("SriBlox-Modern.include.node_modules.roact.src.Type"))() end)

newModule("assertDeepEqual", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.assertDeepEqual", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	A utility used to assert that two objects are value-equal recursively. It
	outputs fairly nicely formatted messages to help diagnose why two objects
	would be different.

	This should only be used in tests.
]]

local function deepEqual(a, b)
	if typeof(a) ~= typeof(b) then
		local message = ("{1} is of type %s, but {2} is of type %s"):format(
			typeof(a),
			typeof(b)
		)
		return false, message
	end

	if typeof(a) == "table" then
		local visitedKeys = {}

		for key, value in pairs(a) do
			visitedKeys[key] = true

			local success, innerMessage = deepEqual(value, b[key])
			if not success then
				local message = innerMessage
					:gsub("{1}", ("{1}[%s]"):format(tostring(key)))
					:gsub("{2}", ("{2}[%s]"):format(tostring(key)))

				return false, message
			end
		end

		for key, value in pairs(b) do
			if not visitedKeys[key] then
				local success, innerMessage = deepEqual(value, a[key])

				if not success then
					local message = innerMessage
						:gsub("{1}", ("{1}[%s]"):format(tostring(key)))
						:gsub("{2}", ("{2}[%s]"):format(tostring(key)))

					return false, message
				end
			end
		end

		return true
	end

	if a == b then
		return true
	end

	local message = "{1} ~= {2}"
	return false, message
end

local function assertDeepEqual(a, b)
	local success, innerMessageTemplate = deepEqual(a, b)

	if not success then
		local innerMessage = innerMessageTemplate
			:gsub("{1}", "first")
			:gsub("{2}", "second")

		local message = ("Values were not deep-equal.\n%s"):format(innerMessage)

		error(message, 2)
	end
end

return assertDeepEqual end, newEnv("SriBlox-Modern.include.node_modules.roact.src.assertDeepEqual"))() end)

newModule("assign", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.assign", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local None = require(script.Parent.None)

--[[
	Merges values from zero or more tables onto a target table. If a value is
	set to None, it will instead be removed from the table.

	This function is identical in functionality to JavaScript's Object.assign.
]]
local function assign(target, ...)
	for index = 1, select("#", ...) do
		local source = select(index, ...)

		if source ~= nil then
			for key, value in pairs(source) do
				if value == None then
					target[key] = nil
				else
					target[key] = value
				end
			end
		end
	end

	return target
end

return assign end, newEnv("SriBlox-Modern.include.node_modules.roact.src.assign"))() end)

newModule("createContext", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createContext", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Symbol = require(script.Parent.Symbol)
local createFragment = require(script.Parent.createFragment)
local createSignal = require(script.Parent.createSignal)
local Children = require(script.Parent.PropMarkers.Children)
local Component = require(script.Parent.Component)

--[[
	Construct the value that is assigned to Roact's context storage.
]]
local function createContextEntry(currentValue)
	return {
		value = currentValue,
		onUpdate = createSignal(),
	}
end

local function createProvider(context)
	local Provider = Component:extend("Provider")

	function Provider:init(props)
		self.contextEntry = createContextEntry(props.value)
		self:__addContext(context.key, self.contextEntry)
	end

	function Provider:willUpdate(nextProps)
		-- If the provided value changed, immediately update the context entry.
		--
		-- During this update, any components that are reachable will receive
		-- this updated value at the same time as any props and state updates
		-- that are being applied.
		if nextProps.value ~= self.props.value then
			self.contextEntry.value = nextProps.value
		end
	end

	function Provider:didUpdate(prevProps)
		-- If the provided value changed, after we've updated every reachable
		-- component, fire a signal to update the rest.
		--
		-- This signal will notify all context consumers. It's expected that
		-- they will compare the last context value they updated with and only
		-- trigger an update on themselves if this value is different.
		--
		-- This codepath will generally only update consumer components that has
		-- a component implementing shouldUpdate between them and the provider.
		if prevProps.value ~= self.props.value then
			self.contextEntry.onUpdate:fire(self.props.value)
		end
	end

	function Provider:render()
		return createFragment(self.props[Children])
	end

	return Provider
end

local function createConsumer(context)
	local Consumer = Component:extend("Consumer")

	function Consumer.validateProps(props)
		if type(props.render) ~= "function" then
			return false, "Consumer expects a `render` function"
		else
			return true
		end
	end

	function Consumer:init(props)
		-- This value may be nil, which indicates that our consumer is not a
		-- descendant of a provider for this context item.
		self.contextEntry = self:__getContext(context.key)
	end

	function Consumer:render()
		-- Render using the latest available for this context item.
		--
		-- We don't store this value in state in order to have more fine-grained
		-- control over our update behavior.
		local value
		if self.contextEntry ~= nil then
			value = self.contextEntry.value
		else
			value = context.defaultValue
		end

		return self.props.render(value)
	end

	function Consumer:didUpdate()
		-- Store the value that we most recently updated with.
		--
		-- This value is compared in the contextEntry onUpdate hook below.
		if self.contextEntry ~= nil then
			self.lastValue = self.contextEntry.value
		end
	end

	function Consumer:didMount()
		if self.contextEntry ~= nil then
			-- When onUpdate is fired, a new value has been made available in
			-- this context entry, but we may have already updated in the same
			-- update cycle.
			--
			-- To avoid sending a redundant update, we compare the new value
			-- with the last value that we updated with (set in didUpdate) and
			-- only update if they differ. This may happen when an update from a
			-- provider was blocked by an intermediate component that returned
			-- false from shouldUpdate.
			self.disconnect = self.contextEntry.onUpdate:subscribe(function(newValue)
				if newValue ~= self.lastValue then
					-- Trigger a dummy state update.
					self:setState({})
				end
			end)
		end
	end

	function Consumer:willUnmount()
		if self.disconnect ~= nil then
			self.disconnect()
		end
	end

	return Consumer
end

local Context = {}
Context.__index = Context

function Context.new(defaultValue)
	return setmetatable({
		defaultValue = defaultValue,
		key = Symbol.named("ContextKey"),
	}, Context)
end

function Context:__tostring()
	return "RoactContext"
end

local function createContext(defaultValue)
	local context = Context.new(defaultValue)

	return {
		Provider = createProvider(context),
		Consumer = createConsumer(context),
	}
end

return createContext
 end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createContext"))() end)

newModule("createElement", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createElement", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local Logging = require(script.Parent.Logging)
local Type = require(script.Parent.Type)

local config = require(script.Parent.GlobalConfig).get()

local multipleChildrenMessage = [[
The prop `Roact.Children` was defined but was overriden by the third parameter to createElement!
This can happen when a component passes props through to a child element but also uses the `children` argument:

	Roact.createElement("Frame", passedProps, {
		child = ...
	})

Instead, consider using a utility function to merge tables of children together:

	local children = mergeTables(passedProps[Roact.Children], {
		child = ...
	})

	local fullProps = mergeTables(passedProps, {
		[Roact.Children] = children
	})

	Roact.createElement("Frame", fullProps)]]

--[[
	Creates a new element representing the given component.

	Elements are lightweight representations of what a component instance should
	look like.

	Children is a shorthand for specifying `Roact.Children` as a key inside
	props. If specified, the passed `props` table is mutated!
]]
local function createElement(component, props, children)
	if config.typeChecks then
		assert(component ~= nil, "`component` is required")
		assert(typeof(props) == "table" or props == nil, "`props` must be a table or nil")
		assert(typeof(children) == "table" or children == nil, "`children` must be a table or nil")
	end

	if props == nil then
		props = {}
	end

	if children ~= nil then
		if props[Children] ~= nil then
			Logging.warnOnce(multipleChildrenMessage)
		end

		props[Children] = children
	end

	local elementKind = ElementKind.fromComponent(component)

	local element = {
		[Type] = Type.Element,
		[ElementKind] = elementKind,
		component = component,
		props = props,
	}

	if config.elementTracing then
		-- We trim out the leading newline since there's no way to specify the
		-- trace level without also specifying a message.
		element.source = debug.traceback("", 2):sub(2)
	end

	return element
end

return createElement end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createElement"))() end)

newModule("createFragment", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createFragment", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local ElementKind = require(script.Parent.ElementKind)
local Type = require(script.Parent.Type)

local function createFragment(elements)
	return {
		[Type] = Type.Element,
		[ElementKind] = ElementKind.Fragment,
		elements = elements,
	}
end

return createFragment end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createFragment"))() end)

newModule("createReconciler", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createReconciler", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local Type = require(script.Parent.Type)
local ElementKind = require(script.Parent.ElementKind)
local ElementUtils = require(script.Parent.ElementUtils)
local Children = require(script.Parent.PropMarkers.Children)
local Symbol = require(script.Parent.Symbol)
local internalAssert = require(script.Parent.internalAssert)

local config = require(script.Parent.GlobalConfig).get()

local InternalData = Symbol.named("InternalData")

--[[
	The reconciler is the mechanism in Roact that constructs the virtual tree
	that later gets turned into concrete objects by the renderer.

	Roact's reconciler is constructed with the renderer as an argument, which
	enables switching to different renderers for different platforms or
	scenarios.

	When testing the reconciler itself, it's common to use `NoopRenderer` with
	spies replacing some methods. The default (and only) reconciler interface
	exposed by Roact right now uses `RobloxRenderer`.
]]
local function createReconciler(renderer)
	local reconciler
	local mountVirtualNode
	local updateVirtualNode
	local unmountVirtualNode

	--[[
		Unmount the given virtualNode, replacing it with a new node described by
		the given element.

		Preserves host properties, depth, and legacyContext from parent.
	]]
	local function replaceVirtualNode(virtualNode, newElement)
		local hostParent = virtualNode.hostParent
		local hostKey = virtualNode.hostKey
		local depth = virtualNode.depth
		local parent = virtualNode.parent

		-- If the node that is being replaced has modified context, we need to
		-- use the original *unmodified* context for the new node
		-- The `originalContext` field will be nil if the context was unchanged
		local context = virtualNode.originalContext or virtualNode.context
		local parentLegacyContext = virtualNode.parentLegacyContext

		unmountVirtualNode(virtualNode)
		local newNode = mountVirtualNode(newElement, hostParent, hostKey, context, parentLegacyContext)

		-- mountVirtualNode can return nil if the element is a boolean
		if newNode ~= nil then
			newNode.depth = depth
			newNode.parent = parent
		end

		return newNode
	end

	--[[
		Utility to update the children of a virtual node based on zero or more
		updated children given as elements.
	]]
	local function updateChildren(virtualNode, hostParent, newChildElements)
		if config.internalTypeChecks then
			internalAssert(Type.of(virtualNode) == Type.VirtualNode, "Expected arg #1 to be of type VirtualNode")
		end

		local removeKeys = {}

		-- Changed or removed children
		for childKey, childNode in pairs(virtualNode.children) do
			local newElement = ElementUtils.getElementByKey(newChildElements, childKey)
			local newNode = updateVirtualNode(childNode, newElement)

			if newNode ~= nil then
				virtualNode.children[childKey] = newNode
			else
				removeKeys[childKey] = true
			end
		end

		for childKey in pairs(removeKeys) do
			virtualNode.children[childKey] = nil
		end

		-- Added children
		for childKey, newElement in ElementUtils.iterateElements(newChildElements) do
			local concreteKey = childKey
			if childKey == ElementUtils.UseParentKey then
				concreteKey = virtualNode.hostKey
			end

			if virtualNode.children[childKey] == nil then
				local childNode = mountVirtualNode(
					newElement,
					hostParent,
					concreteKey,
					virtualNode.context,
					virtualNode.legacyContext
				)

				-- mountVirtualNode can return nil if the element is a boolean
				if childNode ~= nil then
					childNode.depth = virtualNode.depth + 1
					childNode.parent = virtualNode
					virtualNode.children[childKey] = childNode
				end
			end
		end
	end

	local function updateVirtualNodeWithChildren(virtualNode, hostParent, newChildElements)
		updateChildren(virtualNode, hostParent, newChildElements)
	end

	local function updateVirtualNodeWithRenderResult(virtualNode, hostParent, renderResult)
		if Type.of(renderResult) == Type.Element
			or renderResult == nil
			or typeof(renderResult) == "boolean"
		then
			updateChildren(virtualNode, hostParent, renderResult)
		else
			error(("%s\n%s"):format(
				"Component returned invalid children:",
				virtualNode.currentElement.source or "<enable element tracebacks>"
			), 0)
		end
	end

	--[[
		Unmounts the given virtual node and releases any held resources.
	]]
	function unmountVirtualNode(virtualNode)
		if config.internalTypeChecks then
			internalAssert(Type.of(virtualNode) == Type.VirtualNode, "Expected arg #1 to be of type VirtualNode")
		end

		local kind = ElementKind.of(virtualNode.currentElement)

		if kind == ElementKind.Host then
			renderer.unmountHostNode(reconciler, virtualNode)
		elseif kind == ElementKind.Function then
			for _, childNode in pairs(virtualNode.children) do
				unmountVirtualNode(childNode)
			end
		elseif kind == ElementKind.Stateful then
			virtualNode.instance:__unmount()
		elseif kind == ElementKind.Portal then
			for _, childNode in pairs(virtualNode.children) do
				unmountVirtualNode(childNode)
			end
		elseif kind == ElementKind.Fragment then
			for _, childNode in pairs(virtualNode.children) do
				unmountVirtualNode(childNode)
			end
		else
			error(("Unknown ElementKind %q"):format(tostring(kind)), 2)
		end
	end

	local function updateFunctionVirtualNode(virtualNode, newElement)
		local children = newElement.component(newElement.props)

		updateVirtualNodeWithRenderResult(virtualNode, virtualNode.hostParent, children)

		return virtualNode
	end

	local function updatePortalVirtualNode(virtualNode, newElement)
		local oldElement = virtualNode.currentElement
		local oldTargetHostParent = oldElement.props.target

		local targetHostParent = newElement.props.target

		assert(renderer.isHostObject(targetHostParent), "Expected target to be host object")

		if targetHostParent ~= oldTargetHostParent then
			return replaceVirtualNode(virtualNode, newElement)
		end

		local children = newElement.props[Children]

		updateVirtualNodeWithChildren(virtualNode, targetHostParent, children)

		return virtualNode
	end

	local function updateFragmentVirtualNode(virtualNode, newElement)
		updateVirtualNodeWithChildren(virtualNode, virtualNode.hostParent, newElement.elements)

		return virtualNode
	end

	--[[
		Update the given virtual node using a new element describing what it
		should transform into.

		`updateVirtualNode` will return a new virtual node that should replace
		the passed in virtual node. This is because a virtual node can be
		updated with an element referencing a different component!

		In that case, `updateVirtualNode` will unmount the input virtual node,
		mount a new virtual node, and return it in this case, while also issuing
		a warning to the user.
	]]
	function updateVirtualNode(virtualNode, newElement, newState)
		if config.internalTypeChecks then
			internalAssert(Type.of(virtualNode) == Type.VirtualNode, "Expected arg #1 to be of type VirtualNode")
		end
		if config.typeChecks then
			assert(
				Type.of(newElement) == Type.Element or typeof(newElement) == "boolean" or newElement == nil,
				"Expected arg #2 to be of type Element, boolean, or nil"
			)
		end

		-- If nothing changed, we can skip this update
		if virtualNode.currentElement == newElement and newState == nil then
			return virtualNode
		end

		if typeof(newElement) == "boolean" or newElement == nil then
			unmountVirtualNode(virtualNode)
			return nil
		end

		if virtualNode.currentElement.component ~= newElement.component then
			return replaceVirtualNode(virtualNode, newElement)
		end

		local kind = ElementKind.of(newElement)

		local shouldContinueUpdate = true

		if kind == ElementKind.Host then
			virtualNode = renderer.updateHostNode(reconciler, virtualNode, newElement)
		elseif kind == ElementKind.Function then
			virtualNode = updateFunctionVirtualNode(virtualNode, newElement)
		elseif kind == ElementKind.Stateful then
			shouldContinueUpdate = virtualNode.instance:__update(newElement, newState)
		elseif kind == ElementKind.Portal then
			virtualNode = updatePortalVirtualNode(virtualNode, newElement)
		elseif kind == ElementKind.Fragment then
			virtualNode = updateFragmentVirtualNode(virtualNode, newElement)
		else
			error(("Unknown ElementKind %q"):format(tostring(kind)), 2)
		end

		-- Stateful components can abort updates via shouldUpdate. If that
		-- happens, we should stop doing stuff at this point.
		if not shouldContinueUpdate then
			return virtualNode
		end

		virtualNode.currentElement = newElement

		return virtualNode
	end

	--[[
		Constructs a new virtual node but not does mount it.
	]]
	local function createVirtualNode(element, hostParent, hostKey, context, legacyContext)
		if config.internalTypeChecks then
			internalAssert(renderer.isHostObject(hostParent) or hostParent == nil, "Expected arg #2 to be a host object")
			internalAssert(typeof(context) == "table" or context == nil, "Expected arg #4 to be of type table or nil")
			internalAssert(
				typeof(legacyContext) == "table" or legacyContext == nil,
				"Expected arg #5 to be of type table or nil"
			)
		end
		if config.typeChecks then
			assert(hostKey ~= nil, "Expected arg #3 to be non-nil")
			assert(
				Type.of(element) == Type.Element or typeof(element) == "boolean",
				"Expected arg #1 to be of type Element or boolean"
			)
		end

		return {
			[Type] = Type.VirtualNode,
			currentElement = element,
			depth = 1,
			parent = nil,
			children = {},
			hostParent = hostParent,
			hostKey = hostKey,

			-- Legacy Context API
			-- A table of context values inherited from the parent node
			legacyContext = legacyContext,

			-- A saved copy of the parent context, used when replacing a node
			parentLegacyContext = legacyContext,

			-- Context API
			-- A table of context values inherited from the parent node
			context = context or {},

			-- A saved copy of the unmodified context; this will be updated when
			-- a component adds new context and used when a node is replaced
			originalContext = nil,
		}
	end

	local function mountFunctionVirtualNode(virtualNode)
		local element = virtualNode.currentElement

		local children = element.component(element.props)

		updateVirtualNodeWithRenderResult(virtualNode, virtualNode.hostParent, children)
	end

	local function mountPortalVirtualNode(virtualNode)
		local element = virtualNode.currentElement

		local targetHostParent = element.props.target
		local children = element.props[Children]

		assert(renderer.isHostObject(targetHostParent), "Expected target to be host object")

		updateVirtualNodeWithChildren(virtualNode, targetHostParent, children)
	end

	local function mountFragmentVirtualNode(virtualNode)
		local element = virtualNode.currentElement
		local children = element.elements

		updateVirtualNodeWithChildren(virtualNode, virtualNode.hostParent, children)
	end

	--[[
		Constructs a new virtual node and mounts it, but does not place it into
		the tree.
	]]
	function mountVirtualNode(element, hostParent, hostKey, context, legacyContext)
		if config.internalTypeChecks then
			internalAssert(renderer.isHostObject(hostParent) or hostParent == nil, "Expected arg #2 to be a host object")
			internalAssert(
				typeof(legacyContext) == "table" or legacyContext == nil,
				"Expected arg #5 to be of type table or nil"
			)
		end
		if config.typeChecks then
			assert(hostKey ~= nil, "Expected arg #3 to be non-nil")
			assert(
				Type.of(element) == Type.Element or typeof(element) == "boolean",
				"Expected arg #1 to be of type Element or boolean"
			)
		end

		-- Boolean values render as nil to enable terse conditional rendering.
		if typeof(element) == "boolean" then
			return nil
		end

		local kind = ElementKind.of(element)

		local virtualNode = createVirtualNode(element, hostParent, hostKey, context, legacyContext)

		if kind == ElementKind.Host then
			renderer.mountHostNode(reconciler, virtualNode)
		elseif kind == ElementKind.Function then
			mountFunctionVirtualNode(virtualNode)
		elseif kind == ElementKind.Stateful then
			element.component:__mount(reconciler, virtualNode)
		elseif kind == ElementKind.Portal then
			mountPortalVirtualNode(virtualNode)
		elseif kind == ElementKind.Fragment then
			mountFragmentVirtualNode(virtualNode)
		else
			error(("Unknown ElementKind %q"):format(tostring(kind)), 2)
		end

		return virtualNode
	end

	--[[
		Constructs a new Roact virtual tree, constructs a root node for
		it, and mounts it.
	]]
	local function mountVirtualTree(element, hostParent, hostKey)
		if config.typeChecks then
			assert(Type.of(element) == Type.Element, "Expected arg #1 to be of type Element")
			assert(renderer.isHostObject(hostParent) or hostParent == nil, "Expected arg #2 to be a host object")
		end

		if hostKey == nil then
			hostKey = "RoactTree"
		end

		local tree = {
			[Type] = Type.VirtualTree,
			[InternalData] = {
				-- The root node of the tree, which starts into the hierarchy of
				-- Roact component instances.
				rootNode = nil,
				mounted = true,
			},
		}

		tree[InternalData].rootNode = mountVirtualNode(element, hostParent, hostKey)

		return tree
	end

	--[[
		Unmounts the virtual tree, freeing all of its resources.

		No further operations should be done on the tree after it's been
		unmounted, as indicated by its the `mounted` field.
	]]
	local function unmountVirtualTree(tree)
		local internalData = tree[InternalData]
		if config.typeChecks then
			assert(Type.of(tree) == Type.VirtualTree, "Expected arg #1 to be a Roact handle")
			assert(internalData.mounted, "Cannot unmounted a Roact tree that has already been unmounted")
		end

		internalData.mounted = false

		if internalData.rootNode ~= nil then
			unmountVirtualNode(internalData.rootNode)
		end
	end

	--[[
		Utility method for updating the root node of a virtual tree given a new
		element.
	]]
	local function updateVirtualTree(tree, newElement)
		local internalData = tree[InternalData]
		if config.typeChecks then
			assert(Type.of(tree) == Type.VirtualTree, "Expected arg #1 to be a Roact handle")
			assert(Type.of(newElement) == Type.Element, "Expected arg #2 to be a Roact Element")
		end

		internalData.rootNode = updateVirtualNode(internalData.rootNode, newElement)

		return tree
	end

	local function suspendParentEvents(virtualNode)
		local parentNode = virtualNode.parent
		while parentNode do
			if parentNode.eventManager ~= nil then
				parentNode.eventManager:suspend()
			end

			parentNode = parentNode.parent
		end
	end

	local function resumeParentEvents(virtualNode)
		local parentNode = virtualNode.parent
		while parentNode do
			if parentNode.eventManager ~= nil then
				parentNode.eventManager:resume()
			end

			parentNode = parentNode.parent
		end
	end

	reconciler = {
		mountVirtualTree = mountVirtualTree,
		unmountVirtualTree = unmountVirtualTree,
		updateVirtualTree = updateVirtualTree,

		createVirtualNode = createVirtualNode,
		mountVirtualNode = mountVirtualNode,
		unmountVirtualNode = unmountVirtualNode,
		updateVirtualNode = updateVirtualNode,
		updateVirtualNodeWithChildren = updateVirtualNodeWithChildren,
		updateVirtualNodeWithRenderResult = updateVirtualNodeWithRenderResult,

		suspendParentEvents = suspendParentEvents,
		resumeParentEvents = resumeParentEvents,
	}

	return reconciler
end

return createReconciler
 end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createReconciler"))() end)

newModule("createReconcilerCompat", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createReconcilerCompat", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Contains deprecated methods from Reconciler. Broken out so that removing
	this shim is easy -- just delete this file and remove it from init.
]]

local Logging = require(script.Parent.Logging)

local reifyMessage = [[
Roact.reify has been renamed to Roact.mount and will be removed in a future release.
Check the call to Roact.reify at:
]]

local teardownMessage = [[
Roact.teardown has been renamed to Roact.unmount and will be removed in a future release.
Check the call to Roact.teardown at:
]]

local reconcileMessage = [[
Roact.reconcile has been renamed to Roact.update and will be removed in a future release.
Check the call to Roact.reconcile at:
]]

local function createReconcilerCompat(reconciler)
	local compat = {}

	function compat.reify(...)
		Logging.warnOnce(reifyMessage)

		return reconciler.mountVirtualTree(...)
	end

	function compat.teardown(...)
		Logging.warnOnce(teardownMessage)

		return reconciler.unmountVirtualTree(...)
	end

	function compat.reconcile(...)
		Logging.warnOnce(reconcileMessage)

		return reconciler.updateVirtualTree(...)
	end

	return compat
end

return createReconcilerCompat end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createReconcilerCompat"))() end)

newModule("createRef", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createRef", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	A ref is nothing more than a binding with a special field 'current'
	that maps to the getValue method of the binding
]]
local Binding = require(script.Parent.Binding)

local function createRef()
	local binding, _ = Binding.create(nil)

	local ref = {}

	--[[
		A ref is just redirected to a binding via its metatable
	]]
	setmetatable(ref, {
		__index = function(self, key)
			if key == "current" then
				return binding:getValue()
			else
				return binding[key]
			end
		end,
		__newindex = function(self, key, value)
			if key == "current" then
				error("Cannot assign to the 'current' property of refs", 2)
			end

			binding[key] = value
		end,
		__tostring = function(self)
			return ("RoactRef(%s)"):format(tostring(binding:getValue()))
		end,
	})

	return ref
end

return createRef end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createRef"))() end)

newModule("createSignal", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createSignal", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	This is a simple signal implementation that has a dead-simple API.

		local signal = createSignal()

		local disconnect = signal:subscribe(function(foo)
			print("Cool foo:", foo)
		end)

		signal:fire("something")

		disconnect()
]]

local function createSignal()
	local connections = {}
	local suspendedConnections = {}
	local firing = false

	local function subscribe(self, callback)
		assert(typeof(callback) == "function", "Can only subscribe to signals with a function.")

		local connection = {
			callback = callback,
			disconnected = false,
		}

		-- If the callback is already registered, don't add to the suspendedConnection. Otherwise, this will disable
		-- the existing one.
		if firing and not connections[callback] then
			suspendedConnections[callback] = connection
		end

		connections[callback] = connection

		local function disconnect()
			assert(not connection.disconnected, "Listeners can only be disconnected once.")

			connection.disconnected = true
			connections[callback] = nil
			suspendedConnections[callback] = nil
		end

		return disconnect
	end

	local function fire(self, ...)
		firing = true
		for callback, connection in pairs(connections) do
			if not connection.disconnected and not suspendedConnections[callback] then
				callback(...)
			end
		end

		firing = false

		for callback, _ in pairs(suspendedConnections) do
			suspendedConnections[callback] = nil
		end
	end

	return {
		subscribe = subscribe,
		fire = fire,
	}
end

return createSignal
 end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createSignal"))() end)

newModule("createSpy", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.createSpy", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	A utility used to create a function spy that can be used to robustly test
	that functions are invoked the correct number of times and with the correct
	number of arguments.

	This should only be used in tests.
]]

local assertDeepEqual = require(script.Parent.assertDeepEqual)

local function createSpy(inner)
	local self = {
		callCount = 0,
		values = {},
		valuesLength = 0,
	}

	self.value = function(...)
		self.callCount = self.callCount + 1
		self.values = {...}
		self.valuesLength = select("#", ...)

		if inner ~= nil then
			return inner(...)
		end
	end

	self.assertCalledWith = function(_, ...)
		local len = select("#", ...)

		if self.valuesLength ~= len then
			error(("Expected %d arguments, but was called with %d arguments"):format(
				self.valuesLength,
				len
			), 2)
		end

		for i = 1, len do
			local expected = select(i, ...)

			assert(self.values[i] == expected, "value differs")
		end
	end

	self.assertCalledWithDeepEqual = function(_, ...)
		local len = select("#", ...)

		if self.valuesLength ~= len then
			error(("Expected %d arguments, but was called with %d arguments"):format(
				self.valuesLength,
				len
			), 2)
		end

		for i = 1, len do
			local expected = select(i, ...)

			assertDeepEqual(self.values[i], expected)
		end
	end

	self.captureValues = function(_, ...)
		local len = select("#", ...)
		local result = {}

		assert(self.valuesLength == len, "length of expected values differs from stored values")

		for i = 1, len do
			local key = select(i, ...)
			result[key] = self.values[i]
		end

		return result
	end

	setmetatable(self, {
		__index = function(_, key)
			error(("%q is not a valid member of spy"):format(key))
		end,
	})

	return self
end

return createSpy end, newEnv("SriBlox-Modern.include.node_modules.roact.src.createSpy"))() end)

newModule("forwardRef", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.forwardRef", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local assign = require(script.Parent.assign)
local None = require(script.Parent.None)
local Ref = require(script.Parent.PropMarkers.Ref)

local config = require(script.Parent.GlobalConfig).get()

local excludeRef = {
	[Ref] = None,
}

--[[
	Allows forwarding of refs to underlying host components. Accepts a render
	callback which accepts props and a ref, and returns an element.
]]
local function forwardRef(render)
	if config.typeChecks then
		assert(typeof(render) == "function", "Expected arg #1 to be a function")
	end

	return function(props)
		local ref = props[Ref]
		local propsWithoutRef = assign({}, props, excludeRef)

		return render(propsWithoutRef, ref)
	end
end

return forwardRef end, newEnv("SriBlox-Modern.include.node_modules.roact.src.forwardRef"))() end)

newModule("getDefaultInstanceProperty", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.getDefaultInstanceProperty", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Attempts to get the default value of a given property on a Roblox instance.

	This is used by the reconciler in cases where a prop was previously set on a
	primitive component, but is no longer present in a component's new props.

	Eventually, Roblox might provide a nicer API to query the default property
	of an object without constructing an instance of it.
]]

local Symbol = require(script.Parent.Symbol)

local Nil = Symbol.named("Nil")
local _cachedPropertyValues = {}

local function getDefaultInstanceProperty(className, propertyName)
	local classCache = _cachedPropertyValues[className]

	if classCache then
		local propValue = classCache[propertyName]

		-- We have to use a marker here, because Lua doesn't distinguish
		-- between 'nil' and 'not in a table'
		if propValue == Nil then
			return true, nil
		end

		if propValue ~= nil then
			return true, propValue
		end
	else
		classCache = {}
		_cachedPropertyValues[className] = classCache
	end

	local created = Instance.new(className)
	local ok, defaultValue = pcall(function()
		return created[propertyName]
	end)

	created:Destroy()

	if ok then
		if defaultValue == nil then
			classCache[propertyName] = Nil
		else
			classCache[propertyName] = defaultValue
		end
	end

	return ok, defaultValue
end

return getDefaultInstanceProperty end, newEnv("SriBlox-Modern.include.node_modules.roact.src.getDefaultInstanceProperty"))() end)

newModule("internalAssert", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.internalAssert", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local function internalAssert(condition, message)
	if not condition then
		error(message .. " (This is probably a bug in Roact!)", 3)
	end
end

return internalAssert end, newEnv("SriBlox-Modern.include.node_modules.roact.src.internalAssert"))() end)

newModule("invalidSetStateMessages", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.invalidSetStateMessages", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	These messages are used by Component to help users diagnose when they're
	calling setState in inappropriate places.

	The indentation may seem odd, but it's necessary to avoid introducing extra
	whitespace into the error messages themselves.
]]
local ComponentLifecyclePhase = require(script.Parent.ComponentLifecyclePhase)

local invalidSetStateMessages = {}

invalidSetStateMessages[ComponentLifecyclePhase.WillUpdate] = [[
setState cannot be used in the willUpdate lifecycle method.
Consider using the didUpdate method instead, or using getDerivedStateFromProps.

Check the definition of willUpdate in the component %q.]]

invalidSetStateMessages[ComponentLifecyclePhase.WillUnmount] = [[
setState cannot be used in the willUnmount lifecycle method.
A component that is being unmounted cannot be updated!

Check the definition of willUnmount in the component %q.]]

invalidSetStateMessages[ComponentLifecyclePhase.ShouldUpdate] = [[
setState cannot be used in the shouldUpdate lifecycle method.
shouldUpdate must be a pure function that only depends on props and state.

Check the definition of shouldUpdate in the component %q.]]

invalidSetStateMessages[ComponentLifecyclePhase.Render] = [[
setState cannot be used in the render method.
render must be a pure function that only depends on props and state.

Check the definition of render in the component %q.]]

invalidSetStateMessages["default"] = [[
setState can not be used in the current situation, because Roact doesn't know
which part of the lifecycle this component is in.

This is a bug in Roact.
It was triggered by the component %q.
]]

return invalidSetStateMessages end, newEnv("SriBlox-Modern.include.node_modules.roact.src.invalidSetStateMessages"))() end)

newModule("oneChild", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.oneChild", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() --[[
	Retrieves at most one child from the children passed to a component.

	If passed nil or an empty table, will return nil.

	Throws an error if passed more than one child.
]]
local function oneChild(children)
	if not children then
		return nil
	end

	local key, child = next(children)

	if not child then
		return nil
	end

	local after = next(children, key)

	if after then
		error("Expected at most child, had more than one child.", 2)
	end

	return child
end

return oneChild end, newEnv("SriBlox-Modern.include.node_modules.roact.src.oneChild"))() end)

newModule("strict", "ModuleScript", "SriBlox-Modern.include.node_modules.roact.src.strict", "SriBlox-Modern.include.node_modules.roact.src", function () return setfenv(function() local function strict(t, name)
	name = name or tostring(t)

	return setmetatable(t, {
		__index = function(self, key)
			local message = ("%q (%s) is not a valid member of %s"):format(
				tostring(key),
				typeof(key),
				name
			)

			error(message, 2)
		end,

		__newindex = function(self, key, value)
			local message = ("%q (%s) is not a valid member of %s"):format(
				tostring(key),
				typeof(key),
				name
			)

			error(message, 2)
		end,
	})
end

return strict end, newEnv("SriBlox-Modern.include.node_modules.roact.src.strict"))() end)

newInstance("roact-hooked", "Folder", "SriBlox-Modern.include.node_modules.roact-hooked", "SriBlox-Modern.include.node_modules")

newModule("out", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out", "SriBlox-Modern.include.node_modules.roact-hooked", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local exports = {}
local _with_hooks = TS.import(script, script, "with-hooks")
local withHooks = _with_hooks.withHooks
local withHooksPure = _with_hooks.withHooksPure
for _k, _v in pairs(TS.import(script, script, "hooks")) do
	exports[_k] = _v
end
--[[
	*
	* `hooked` is a [higher-order component](https://reactjs.org/docs/higher-order-components.html) that turns your
	* Function Component into a [class component](https://roblox.github.io/roact/guide/components/).
	*
	* `hooked` allows you to hook into the Component's lifecycle through Hooks.
	*
	* @example
	* const MyComponent = hooked<Props>(
	*   (props) => {
	*     // render using props
	*   },
	* );
	*
	* @see https://reactjs.org/docs/hooks-intro.html
]]
local function hooked(functionComponent)
	return withHooks(functionComponent)
end
--[[
	*
	* `pure` is a [higher-order component](https://reactjs.org/docs/higher-order-components.html) that turns your
	* Function Component into a [PureComponent](https://roblox.github.io/roact/performance/reduce-reconciliation/#purecomponent).
	*
	* If your function component wrapped in `pure` has a {@link useState}, {@link useReducer} or {@link useContext} Hook
	* in its implementation, it will still rerender when state or context changes.
	*
	* @example
	* const MyComponent = pure<Props>(
	*   (props) => {
	*     // render using props
	*   },
	* );
	*
	* @see https://reactjs.org/docs/react-api.html
	* @see https://roblox.github.io/roact/performance/reduce-reconciliation/
]]
local function pure(functionComponent)
	return withHooksPure(functionComponent)
end
exports.hooked = hooked
exports.pure = pure
return exports
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out"))() end)

newModule("hooks", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", "SriBlox-Modern.include.node_modules.roact-hooked.out", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local exports = {}
exports.useBinding = TS.import(script, script, "use-binding").useBinding
exports.useCallback = TS.import(script, script, "use-callback").useCallback
exports.useContext = TS.import(script, script, "use-context").useContext
exports.useEffect = TS.import(script, script, "use-effect").useEffect
exports.useMemo = TS.import(script, script, "use-memo").useMemo
exports.useReducer = TS.import(script, script, "use-reducer").useReducer
exports.useState = TS.import(script, script, "use-state").useState
exports.useMutable = TS.import(script, script, "use-mutable").useMutable
exports.useRef = TS.import(script, script, "use-ref").useRef
return exports
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks"))() end)

newModule("use-binding", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-binding", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local createBinding = TS.import(script, TS.getModule(script, "@rbxts", "roact").src).createBinding
local memoizedHook = TS.import(script, script.Parent.Parent, "memoized-hook").memoizedHook
--[[
	*
	* `useBinding` returns a memoized *`Binding`*, a special object that Roact automatically unwraps into values. When a
	* binding is updated, Roact will only change the specific properties that are subscribed to it.
	*
	* The first value returned is a `Binding` object, which will typically be passed as a prop to a Roact host component.
	* The second is a function that can be called with a new value to update the binding.
	*
	* @example
	* const [binding, setBindingValue] = useBinding(initialValue);
	*
	* @param initialValue - Initialized as the `.current` property
	* @returns A memoized `Binding` object, and a function to update the value of the binding.
	*
	* @see https://roblox.github.io/roact/advanced/bindings-and-refs/#bindings
]]
local function useBinding(initialValue)
	return memoizedHook(function()
		local bindingSet = { createBinding(initialValue) }
		return bindingSet
	end).state
end
return {
	useBinding = useBinding,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-binding"))() end)

newModule("use-callback", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-callback", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local useMemo = TS.import(script, script.Parent, "use-memo").useMemo
--[[
	*
	* Returns a memoized version of the callback that only changes if one of the dependencies has changed.
	*
	* This is useful when passing callbacks to optimized child components that rely on reference equality to prevent
	* unnecessary renders.
	*
	* `useCallback(fn, deps)` is equivalent to `useMemo(() => fn, deps)`.
	*
	* @example
	* const memoizedCallback = useCallback(
	*   () => {
	*     doSomething(a, b);
	*   },
	*   [a, b],
	* );
	*
	* @param callback - An inline callback
	* @param deps - An array of dependencies
	* @returns A memoized version of the callback
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usecallback
]]
local function useCallback(callback, deps)
	return useMemo(function()
		return callback
	end, deps)
end
return {
	useCallback = useCallback,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-callback"))() end)

newModule("use-context", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-context", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
--[[
	*
	* @see https://github.com/Kampfkarren/roact-hooks/blob/main/src/createUseContext.lua
]]
local _memoized_hook = TS.import(script, script.Parent.Parent, "memoized-hook")
local memoizedHook = _memoized_hook.memoizedHook
local resolveCurrentComponent = _memoized_hook.resolveCurrentComponent
local useEffect = TS.import(script, script.Parent, "use-effect").useEffect
local useState = TS.import(script, script.Parent, "use-state").useState
local function copyComponent(component)
	return setmetatable({}, {
		__index = component,
	})
end
--[[
	*
	* Accepts a context object (the value returned from `Roact.createContext`) and returns the current context value, as
	* given by the nearest context provider for the given context.
	*
	* When the nearest `Context.Provider` above the component updates, this Hook will trigger a rerender with the latest
	* context value.
	*
	* If there is no Provider, `useContext` returns the default value of the context.
	*
	* @param context - The Context object to read from
	* @returns The latest context value of the nearest Provider
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usecontext
]]
local function useContext(context)
	local thisContext = context
	local _binding = memoizedHook(function()
		local consumer = copyComponent(resolveCurrentComponent())
		thisContext.Consumer.init(consumer)
		return consumer.contextEntry
	end)
	local contextEntry = _binding.state
	if contextEntry then
		local _binding_1 = useState(contextEntry.value)
		local value = _binding_1[1]
		local setValue = _binding_1[2]
		useEffect(function()
			return contextEntry.onUpdate:subscribe(setValue)
		end, {})
		return value
	else
		return thisContext.defaultValue
	end
end
return {
	useContext = useContext,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-context"))() end)

newModule("use-effect", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-effect", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local areDepsEqual = TS.import(script, script.Parent.Parent, "utils", "are-deps-equal").areDepsEqual
local _memoized_hook = TS.import(script, script.Parent.Parent, "memoized-hook")
local memoizedHook = _memoized_hook.memoizedHook
local resolveCurrentComponent = _memoized_hook.resolveCurrentComponent
local function scheduleEffect(effect)
	local _binding = resolveCurrentComponent()
	local effects = _binding.effects
	if effects.tail == nil then
		-- This is the first effect in the list
		effects.tail = effect
		effects.head = effects.tail
	else
		-- Append to the end of the list
		local _exp = effects.tail
		_exp.next = effect
		effects.tail = _exp.next
	end
	return effect
end
--[[
	*
	* Accepts a function that contains imperative, possibly effectful code. The function passed to `useEffect` will run
	* synchronously (thread-blocking) after the Roblox Instance is created and rendered.
	*
	* The clean-up function (returned by the effect) runs before the component is removed from the UI to prevent memory
	* leaks. Additionally, if a component renders multiple times, the **previous effect is cleaned up before executing
	* the next effect**.
	*
	*`useEffect` runs in the same phase as `didMount` and `didUpdate`. All cleanup functions are called on `willUnmount`.
	*
	* @example
	* useEffect(() => {
	*   // use value
	*   return () => {
	*     // cleanup
	*   }
	* }, [value]);
	*
	* useEffect(() => {
	*   // did update
	* });
	*
	* useEffect(() => {
	*   // did mount
	*   return () => {
	*     // will unmount
	*   }
	* }, []);
	*
	* @param callback - Imperative function that can return a cleanup function
	* @param deps - If present, effect will only activate if the values in the list change
	*
	* @see https://reactjs.org/docs/hooks-reference.html#useeffect
]]
local function useEffect(callback, deps)
	local hook = memoizedHook(nil)
	local _prevDeps = hook.state
	if _prevDeps ~= nil then
		_prevDeps = _prevDeps.deps
	end
	local prevDeps = _prevDeps
	if deps and areDepsEqual(deps, prevDeps) then
		return nil
	end
	hook.state = scheduleEffect({
		id = hook.id,
		callback = callback,
		deps = deps,
	})
end
return {
	useEffect = useEffect,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-effect"))() end)

newModule("use-memo", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-memo", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local areDepsEqual = TS.import(script, script.Parent.Parent, "utils", "are-deps-equal").areDepsEqual
local memoizedHook = TS.import(script, script.Parent.Parent, "memoized-hook").memoizedHook
--[[
	*
	* `useMemo` will only recompute the memoized value when one of the `deps` has changed. This optimization helps to
	* avoid expensive calculations on every render.
	*
	* Remember that the function passed to `useMemo` runs during rendering. Don’t do anything there that you wouldn’t
	* normally do while rendering. For example, side effects belong in `useEffect`, not `useMemo`.
	*
	* If no array is provided, a new value will be computed on every render. This is usually a mistake, so `deps` must be
	* explicitly written as `undefined`.
	*
	* @example
	* const memoizedValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);
	*
	* @param factory - A "create" function that computes a value
	* @param deps - An array of dependencies
	* @returns A memoized value
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usememo
]]
local function useMemo(factory, deps)
	local hook = memoizedHook(function()
		return {}
	end)
	local _binding = hook.state
	local prevValue = _binding[1]
	local prevDeps = _binding[2]
	if prevValue ~= nil and (deps and areDepsEqual(deps, prevDeps)) then
		return prevValue
	end
	local nextValue = factory()
	hook.state = { nextValue, deps }
	return nextValue
end
return {
	useMemo = useMemo,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-memo"))() end)

newModule("use-mutable", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-mutable", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local memoizedHook = TS.import(script, script.Parent.Parent, "memoized-hook").memoizedHook
-- Function overloads from https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/react/index.d.ts#L1061
--[[
	*
	* `useMutable` returns a mutable object whose `.current` property is initialized to the argument `initialValue`.
	* The returned object will persist for the full lifetime of the component.
	*
	* `useMutable()` is handy for keeping any mutable value around similar to how you’d use instance fields in classes.
	*
	* This cannot be used as a [Roact Ref](https://roblox.github.io/roact/advanced/bindings-and-refs/#refs). If you want
	* to reference a Roblox Instance, refer to {@link useRef}.
	*
	* @example
	* const container = useMutable(initialValue);
	* useEffect(() => {
	*   container.current = value;
	* });
	*
	* @param initialValue - Initialized as the `.current` property
	* @returns A memoized, mutable object
	*
	* @see https://reactjs.org/docs/hooks-reference.html#useref
]]
--[[
	*
	* `useMutable` returns a mutable object whose `.current` property is initialized to the argument `initialValue`.
	* The returned object will persist for the full lifetime of the component.
	*
	* `useMutable()` is handy for keeping any mutable value around similar to how you’d use instance fields in classes.
	*
	* This cannot be used as a [Roact Ref](https://roblox.github.io/roact/advanced/bindings-and-refs/#refs). If you want
	* to reference a Roblox Instance, refer to {@link useRef}.
	*
	* @example
	* const container = useMutable(initialValue);
	* useEffect(() => {
	*   container.current = value;
	* });
	*
	* @param initialValue - Initialized as the `.current` property
	* @returns A memoized, mutable object
	*
	* @see https://reactjs.org/docs/hooks-reference.html#useref
]]
-- convenience overload for refs given as a ref prop as they typically start with a null value
--[[
	*
	* `useMutable` returns a mutable object whose `.current` property is initialized to the argument `initialValue`.
	* The returned object will persist for the full lifetime of the component.
	*
	* `useMutable()` is handy for keeping any mutable value around similar to how you’d use instance fields in classes.
	*
	* This cannot be used as a [Roact Ref](https://roblox.github.io/roact/advanced/bindings-and-refs/#refs). If you want
	* to reference a Roblox Instance, refer to {@link useRef}.
	*
	* @example
	* const container = useMutable(initialValue);
	* useEffect(() => {
	*   container.current = value;
	* });
	*
	* @returns A memoized, mutable object
	*
	* @see https://reactjs.org/docs/hooks-reference.html#useref
]]
-- convenience overload for potentially undefined initialValue / call with 0 arguments
-- has a default to stop it from defaulting to {} instead
--[[
	*
	* `useMutable` returns a mutable object whose `.current` property is initialized to the argument `initialValue`.
	* The returned object will persist for the full lifetime of the component.
	*
	* `useMutable()` is handy for keeping any mutable value around similar to how you’d use instance fields in classes.
	*
	* This cannot be used as a [Roact Ref](https://roblox.github.io/roact/advanced/bindings-and-refs/#refs). If you want
	* to reference a Roblox Instance, refer to {@link useRef}.
	*
	* @example
	* const container = useMutable(initialValue);
	* useEffect(() => {
	*   container.current = value;
	* });
	*
	* @param initialValue - Initialized as the `.current` property
	* @returns A memoized, mutable object
	*
	* @see https://reactjs.org/docs/hooks-reference.html#useref
]]
local function useMutable(initialValue)
	return memoizedHook(function()
		return {
			current = initialValue,
		}
	end).state
end
return {
	useMutable = useMutable,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-mutable"))() end)

newModule("use-reducer", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-reducer", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local _memoized_hook = TS.import(script, script.Parent.Parent, "memoized-hook")
local memoizedHook = _memoized_hook.memoizedHook
local resolveCurrentComponent = _memoized_hook.resolveCurrentComponent
--[[
	*
	* Accepts a reducer of type `(state, action) => newState`, and returns the current state paired with a `dispatch`
	* method.
	*
	* If a new state is the same value as the current state, this will bail out without rerendering the component.
	*
	* `useReducer` is usually preferable to `useState` when you have complex state logic that involves multiple sub-values.
	* It also lets you optimize performance for components that trigger deep updates because [you can pass `dispatch` down
	* instead of callbacks](https://reactjs.org/docs/hooks-faq.html#how-to-avoid-passing-callbacks-down).
	*
	* There are two different ways to initialize `useReducer` state. You can use the initial state as a second argument,
	* or [create the initial state lazily](https://reactjs.org/docs/hooks-reference.html#lazy-initialization). To do this,
	* you can pass an init function as the third argument. The initial state will be set to `initializer(initialArg)`.
	*
	* @param reducer - Function that returns a state given the current state and an action
	* @param initializerArg - State used during the initial render, or passed to `initializer` if provided
	* @param initializer - Optional function that returns an initial state given `initializerArg`
	* @returns The current state, and an action dispatcher
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usereducer
]]
-- overload where dispatch could accept 0 arguments.
--[[
	*
	* Accepts a reducer of type `(state, action) => newState`, and returns the current state paired with a `dispatch`
	* method.
	*
	* If a new state is the same value as the current state, this will bail out without rerendering the component.
	*
	* `useReducer` is usually preferable to `useState` when you have complex state logic that involves multiple sub-values.
	* It also lets you optimize performance for components that trigger deep updates because [you can pass `dispatch` down
	* instead of callbacks](https://reactjs.org/docs/hooks-faq.html#how-to-avoid-passing-callbacks-down).
	*
	* There are two different ways to initialize `useReducer` state. You can use the initial state as a second argument,
	* or [create the initial state lazily](https://reactjs.org/docs/hooks-reference.html#lazy-initialization). To do this,
	* you can pass an init function as the third argument. The initial state will be set to `initializer(initialArg)`.
	*
	* @param reducer - Function that returns a state given the current state and an action
	* @param initializerArg - State used during the initial render, or passed to `initializer` if provided
	* @param initializer - Optional function that returns an initial state given `initializerArg`
	* @returns The current state, and an action dispatcher
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usereducer
]]
-- overload where dispatch could accept 0 arguments.
--[[
	*
	* Accepts a reducer of type `(state, action) => newState`, and returns the current state paired with a `dispatch`
	* method.
	*
	* If a new state is the same value as the current state, this will bail out without rerendering the component.
	*
	* `useReducer` is usually preferable to `useState` when you have complex state logic that involves multiple sub-values.
	* It also lets you optimize performance for components that trigger deep updates because [you can pass `dispatch` down
	* instead of callbacks](https://reactjs.org/docs/hooks-faq.html#how-to-avoid-passing-callbacks-down).
	*
	* There are two different ways to initialize `useReducer` state. You can use the initial state as a second argument,
	* or [create the initial state lazily](https://reactjs.org/docs/hooks-reference.html#lazy-initialization). To do this,
	* you can pass an init function as the third argument. The initial state will be set to `initializer(initialArg)`.
	*
	* @param reducer - Function that returns a state given the current state and an action
	* @param initializerArg - State used during the initial render, or passed to `initializer` if provided
	* @param initializer - Optional function that returns an initial state given `initializerArg`
	* @returns The current state, and an action dispatcher
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usereducer
]]
-- overload for free "I"; all goes as long as initializer converts it into "ReducerState<R>".
--[[
	*
	* Accepts a reducer of type `(state, action) => newState`, and returns the current state paired with a `dispatch`
	* method.
	*
	* If a new state is the same value as the current state, this will bail out without rerendering the component.
	*
	* `useReducer` is usually preferable to `useState` when you have complex state logic that involves multiple sub-values.
	* It also lets you optimize performance for components that trigger deep updates because [you can pass `dispatch` down
	* instead of callbacks](https://reactjs.org/docs/hooks-faq.html#how-to-avoid-passing-callbacks-down).
	*
	* There are two different ways to initialize `useReducer` state. You can use the initial state as a second argument,
	* or [create the initial state lazily](https://reactjs.org/docs/hooks-reference.html#lazy-initialization). To do this,
	* you can pass an init function as the third argument. The initial state will be set to `initializer(initialArg)`.
	*
	* @param reducer - Function that returns a state given the current state and an action
	* @param initializerArg - State used during the initial render, or passed to `initializer` if provided
	* @param initializer - Optional function that returns an initial state given `initializerArg`
	* @returns The current state, and an action dispatcher
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usereducer
]]
-- overload where "I" may be a subset of ReducerState<R>; used to provide autocompletion.
-- If "I" matches ReducerState<R> exactly then the last overload will allow initializer to be omitted.
--[[
	*
	* Accepts a reducer of type `(state, action) => newState`, and returns the current state paired with a `dispatch`
	* method.
	*
	* If a new state is the same value as the current state, this will bail out without rerendering the component.
	*
	* `useReducer` is usually preferable to `useState` when you have complex state logic that involves multiple sub-values.
	* It also lets you optimize performance for components that trigger deep updates because [you can pass `dispatch` down
	* instead of callbacks](https://reactjs.org/docs/hooks-faq.html#how-to-avoid-passing-callbacks-down).
	*
	* There are two different ways to initialize `useReducer` state. You can use the initial state as a second argument,
	* or [create the initial state lazily](https://reactjs.org/docs/hooks-reference.html#lazy-initialization). To do this,
	* you can pass an init function as the third argument. The initial state will be set to `initializer(initialArg)`.
	*
	* @param reducer - Function that returns a state given the current state and an action
	* @param initializerArg - State used during the initial render, or passed to `initializer` if provided
	* @param initializer - Optional function that returns an initial state given `initializerArg`
	* @returns The current state, and an action dispatcher
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usereducer
]]
-- Implementation matches a previous overload, is this required?
local function useReducer(reducer, initializerArg, initializer)
	local currentComponent = resolveCurrentComponent()
	local hook = memoizedHook(function()
		if initializer then
			return initializer(initializerArg)
		else
			return initializerArg
		end
	end)
	local function dispatch(action)
		local nextState = reducer(hook.state, action)
		if hook.state ~= nextState then
			currentComponent:setHookState(hook.id, function()
				hook.state = nextState
				return hook.state
			end)
		end
	end
	return { hook.state, dispatch }
end
return {
	useReducer = useReducer,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-reducer"))() end)

newModule("use-ref", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-ref", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local createRef = TS.import(script, TS.getModule(script, "@rbxts", "roact").src).createRef
local memoizedHook = TS.import(script, script.Parent.Parent, "memoized-hook").memoizedHook
--[[
	*
	* `useRef` returns a memoized *`Ref`*, a special type of binding that points to Roblox Instance objects that are
	* created by Roact. The returned object will persist for the full lifetime of the component.
	*
	* `useMutable()` is handy for keeping any mutable value around similar to how you’d use instance fields in classes.
	*
	* This is not mutable like React's `useRef` hook. If you want to use a mutable object, refer to {@link useMutable}.
	*
	* @example
	* const ref = useRef<TextBox>();
	*
	* useEffect(() => {
	* 	const textBox = ref.getValue();
	* 	if (textBox) {
	* 		textBox.CaptureFocus();
	* 	}
	* }, []);
	*
	* return <textbox Ref={ref} />;
	*
	* @returns A memoized `Ref` object
	*
	* @see https://roblox.github.io/roact/advanced/bindings-and-refs/#refs
]]
local function useRef()
	return memoizedHook(function()
		return createRef()
	end).state
end
return {
	useRef = useRef,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-ref"))() end)

newModule("use-state", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-state", "SriBlox-Modern.include.node_modules.roact-hooked.out.hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local resolve = TS.import(script, script.Parent.Parent, "utils", "resolve").resolve
local useReducer = TS.import(script, script.Parent, "use-reducer").useReducer
--[[
	*
	* Returns a stateful value, and a function to update it.
	*
	* During the initial render, the returned state (`state`) is the same as the value passed as the first argument
	* (`initialState`).
	*
	* The `setState` function is used to update the state. It always knows the current state, so it's safe to omit from
	* the `useEffect` or `useCallback` dependency lists.
	*
	* If you update a State Hook to the same value as the current state, this will bail out without rerendering the
	* component.
	*
	* @example
	* const [state, setState] = useState(initialState);
	* const [state, setState] = useState(() => someExpensiveComputation());
	* setState(newState);
	* setState((prevState) => prevState + 1)
	*
	* @param initialState - State used during the initial render. Can be a function, which will be executed on initial render
	* @returns A stateful value, and an updater function
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usestate
]]
--[[
	*
	* Returns a stateful value, and a function to update it.
	*
	* During the initial render, the returned state (`state`) is the same as the value passed as the first argument
	* (`initialState`).
	*
	* The `setState` function is used to update the state. It always knows the current state, so it's safe to omit from
	* the `useEffect` or `useCallback` dependency lists.
	*
	* If you update a State Hook to the same value as the current state, this will bail out without rerendering the
	* component.
	*
	* @example
	* const [state, setState] = useState(initialState);
	* const [state, setState] = useState(() => someExpensiveComputation());
	* setState(newState);
	* setState((prevState) => prevState + 1)
	*
	* @param initialState - State used during the initial render. Can be a function, which will be executed on initial render
	* @returns A stateful value, and an updater function
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usestate
]]
--[[
	*
	* Returns a stateful value, and a function to update it.
	*
	* During the initial render, the returned state (`state`) is the same as the value passed as the first argument
	* (`initialState`).
	*
	* The `setState` function is used to update the state. It always knows the current state, so it's safe to omit from
	* the `useEffect` or `useCallback` dependency lists.
	*
	* If you update a State Hook to the same value as the current state, this will bail out without rerendering the
	* component.
	*
	* @example
	* const [state, setState] = useState(initialState);
	* const [state, setState] = useState(() => someExpensiveComputation());
	* setState(newState);
	* setState((prevState) => prevState + 1)
	*
	* @param initialState - State used during the initial render. Can be a function, which will be executed on initial render
	* @returns A stateful value, and an updater function
	*
	* @see https://reactjs.org/docs/hooks-reference.html#usestate
]]
local function useState(initialState)
	local _binding = useReducer(function(state, action)
		return resolve(action, state)
	end, nil, function()
		return resolve(initialState)
	end)
	local state = _binding[1]
	local dispatch = _binding[2]
	return { state, dispatch }
end
return {
	useState = useState,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.hooks.use-state"))() end)

newModule("memoized-hook", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.memoized-hook", "SriBlox-Modern.include.node_modules.roact-hooked.out", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local resolve = TS.import(script, script.Parent, "utils", "resolve").resolve
local EXCEPTION_INVALID_HOOK_CALL = table.concat({ "Invalid hook call. Hooks can only be called inside of the body of a function component.", "This is usually the result of conflicting versions of roact-hooked.", "See https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem." }, "\n")
local EXCEPTION_RENDER_NOT_DONE = "Failed to render hook! (Another hooked component is rendering)"
local EXCEPTION_RENDER_OVERLAP = "Failed to render hook! (Another hooked component rendered during this one)"
local currentHook
local currentlyRenderingComponent
--[[
	*
	* Prepares for an upcoming render.
]]
local function renderReady(component)
	local _arg0 = currentlyRenderingComponent == nil
	assert(_arg0, EXCEPTION_RENDER_NOT_DONE)
	currentlyRenderingComponent = component
end
--[[
	*
	* Cleans up hooks. Must be called after finishing a render!
]]
local function renderDone(component)
	local _arg0 = currentlyRenderingComponent == component
	assert(_arg0, EXCEPTION_RENDER_OVERLAP)
	currentlyRenderingComponent = nil
	currentHook = nil
end
--[[
	*
	* Returns the currently-rendering component. Throws an error if a component is not mid-render.
]]
local function resolveCurrentComponent()
	return currentlyRenderingComponent or error(EXCEPTION_INVALID_HOOK_CALL, 3)
end
--[[
	*
	* Gets or creates a new hook. Hooks are memoized for every component. See the original source
	* {@link https://github.com/facebook/react/blob/main/packages/react-reconciler/src/ReactFiberHooks.new.js#L619 here}.
	*
	* @param initialValue - Initial value for `Hook.state` and `Hook.baseState`.
]]
local function memoizedHook(initialValue)
	local currentlyRenderingComponent = resolveCurrentComponent()
	local nextHook
	if currentHook then
		nextHook = currentHook.next
	else
		nextHook = currentlyRenderingComponent.firstHook
	end
	if nextHook then
		-- The hook has already been created
		currentHook = nextHook
	else
		-- This is a new hook, should be from an initial render
		local state = resolve(initialValue)
		local id = 0
		if currentHook then
			id = currentHook.id + 1
		end
		local newHook = {
			id = id,
			state = state,
			baseState = state,
		}
		if not currentHook then
			-- This is the first hook in the list
			currentHook = newHook
			currentlyRenderingComponent.firstHook = currentHook
		else
			-- Append to the end of the list
			currentHook.next = newHook
			currentHook = currentHook.next
		end
	end
	return currentHook
end
return {
	renderReady = renderReady,
	renderDone = renderDone,
	resolveCurrentComponent = resolveCurrentComponent,
	memoizedHook = memoizedHook,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.memoized-hook"))() end)

newModule("types", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.types", "SriBlox-Modern.include.node_modules.roact-hooked.out", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
-- Roact
-- Reducers
-- Utility types
-- Hooks
return nil
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.types"))() end)

newInstance("utils", "Folder", "SriBlox-Modern.include.node_modules.roact-hooked.out.utils", "SriBlox-Modern.include.node_modules.roact-hooked.out")

newModule("are-deps-equal", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.utils.are-deps-equal", "SriBlox-Modern.include.node_modules.roact-hooked.out.utils", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local function areDepsEqual(nextDeps, prevDeps)
	if prevDeps == nil then
		return false
	end
	if #nextDeps ~= #prevDeps then
		return false
	end
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < #nextDeps) then
				break
			end
			if nextDeps[i + 1] == prevDeps[i + 1] then
				continue
			end
			return false
		end
	end
	return true
end
return {
	areDepsEqual = areDepsEqual,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.utils.are-deps-equal"))() end)

newModule("resolve", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.utils.resolve", "SriBlox-Modern.include.node_modules.roact-hooked.out.utils", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local function resolve(fn, ...)
	local args = { ... }
	if type(fn) == "function" then
		return fn(unpack(args))
	else
		return fn
	end
end
return {
	resolve = resolve,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.utils.resolve"))() end)

newModule("with-hooks", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks", "SriBlox-Modern.include.node_modules.roact-hooked.out", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local exports = {}
local _with_hooks = TS.import(script, script, "with-hooks")
exports.withHooks = _with_hooks.withHooks
exports.withHooksPure = _with_hooks.withHooksPure
return exports
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks"))() end)

newModule("component-with-hooks", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks.component-with-hooks", "SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local _memoized_hook = TS.import(script, script.Parent.Parent, "memoized-hook")
local renderDone = _memoized_hook.renderDone
local renderReady = _memoized_hook.renderReady
local ComponentWithHooks
do
	ComponentWithHooks = {}
	function ComponentWithHooks:constructor()
	end
	function ComponentWithHooks:init()
		self.effects = {}
		self.effectHandles = {}
	end
	function ComponentWithHooks:setHookState(id, reducer)
		self:setState(function(state)
			return {
				[id] = reducer(state[id]),
			}
		end)
	end
	function ComponentWithHooks:render()
		renderReady(self)
		local _functionComponent = self.functionComponent
		local _props = self.props
		local _success, _valueOrError = pcall(_functionComponent, _props)
		local result = _success and {
			success = true,
			value = _valueOrError,
		} or {
			success = false,
			error = _valueOrError,
		}
		renderDone(self)
		if not result.success then
			error("(ComponentWithHooks) " .. result.error)
		end
		return result.value
	end
	function ComponentWithHooks:didMount()
		self:flushEffects()
	end
	function ComponentWithHooks:didUpdate()
		self:flushEffects()
	end
	function ComponentWithHooks:willUnmount()
		self:unmountEffects()
		self.effects.head = nil
	end
	function ComponentWithHooks:flushEffectsHelper(effect)
		if not effect then
			return nil
		end
		local _effectHandles = self.effectHandles
		local _id = effect.id
		local _result = _effectHandles[_id]
		if _result ~= nil then
			_result()
		end
		local handle = effect.callback()
		if handle then
			local _effectHandles_1 = self.effectHandles
			local _id_1 = effect.id
			-- ▼ Map.set ▼
			_effectHandles_1[_id_1] = handle
			-- ▲ Map.set ▲
		else
			local _effectHandles_1 = self.effectHandles
			local _id_1 = effect.id
			-- ▼ Map.delete ▼
			_effectHandles_1[_id_1] = nil
			-- ▲ Map.delete ▲
		end
		self:flushEffectsHelper(effect.next)
	end
	function ComponentWithHooks:flushEffects()
		self:flushEffectsHelper(self.effects.head)
		self.effects.head = nil
		self.effects.tail = nil
	end
	function ComponentWithHooks:unmountEffects()
		-- This does not clean up effects by order of id, but it should not matter
		-- because this is on unmount
		local _effectHandles = self.effectHandles
		local _arg0 = function(handle)
			return handle()
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _k, _v in pairs(_effectHandles) do
			_arg0(_v, _k, _effectHandles)
		end
		-- ▲ ReadonlyMap.forEach ▲
		-- ▼ Map.clear ▼
		table.clear(self.effectHandles)
		-- ▲ Map.clear ▲
	end
end
return {
	ComponentWithHooks = ComponentWithHooks,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks.component-with-hooks"))() end)

newModule("with-hooks", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks.with-hooks", "SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks", function () return setfenv(function() -- Compiled with roblox-ts v1.2.7
local TS = _G[script]
local ComponentWithHooks = TS.import(script, script.Parent, "component-with-hooks").ComponentWithHooks
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local function componentWithHooksMixin(ctor)
	for k, v in pairs(ComponentWithHooks) do
		ctor[k] = v
	end
end
local function withHooks(functionComponent)
	local ComponentClass
	do
		ComponentClass = Roact.Component:extend("ComponentClass")
		function ComponentClass:init()
		end
		ComponentClass.functionComponent = functionComponent
	end
	componentWithHooksMixin(ComponentClass)
	return ComponentClass
end
local function withHooksPure(functionComponent)
	local ComponentClass
	do
		ComponentClass = Roact.PureComponent:extend("ComponentClass")
		function ComponentClass:init()
		end
		ComponentClass.functionComponent = functionComponent
	end
	componentWithHooksMixin(ComponentClass)
	return ComponentClass
end
return {
	withHooks = withHooks,
	withHooksPure = withHooksPure,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.out.with-hooks.with-hooks"))() end)

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-hooked.package", "SriBlox-Modern.include.node_modules.roact-hooked", function () return setfenv(function() return {
	author = "littensy",
	bugs = {
		url = "https://github.com/littensy/rbxts-roact-hooked/issues/",
	},
	contributors = {"Spectrius"},
	description = "Roact hooks based on Kampfkarren's hooks & React Hooks",
	devDependencies = {
		["@rbxts/compiler-types"] = "^1.2.3-types.0",
		["@rbxts/roact"] = "^1.4.0-ts.2",
		["@rbxts/types"] = "^1.0.521",
		["@typescript-eslint/eslint-plugin"] = "^4.29.3",
		["@typescript-eslint/parser"] = "^4.29.3",
		eslint = "^7.32.0",
		["eslint-config-prettier"] = "^8.3.0",
		["eslint-plugin-prettier"] = "^3.4.1",
		["eslint-plugin-roblox-ts"] = "0.0.30",
		["eslint-plugin-sort-imports-es6-autofix"] = "^0.6.0",
		prettier = "^2.3.2",
		["roblox-ts"] = "^1.2.7",
		typescript = "^4.4.2",
	},
	files = {"out"},
	keywords = {"roblox", "typescript", "roact", "hooks"},
	license = "MIT",
	main = "out/init.lua",
	name = "@rbxts/roact-hooked",
	peerDependencies = {
		["@rbxts/roact"] = "^1.4.0-ts.2",
	},
	publishConfig = {
		access = "public",
	},
	repository = {
		type = "git",
		url = "https://github.com/littensy/rbxts-roact-hooked.git",
	},
	scripts = {
		build = "rbxtsc",
		["build:tests"] = "rbxtsc --type=model -p ./tests -i ./include",
		["dev:tests"] = "concurrently npm:watch:tests npm:serve:tests",
		prepublishOnly = "npm run build",
		["serve:tests"] = "rojo serve ./tests/default.project.json",
		watch = "rbxtsc -w",
		["watch:tests"] = "rbxtsc -w --type=model -p ./tests -i ./include",
	},
	types = "out/index.d.ts",
	version = "1.2.7",
} end, newEnv("SriBlox-Modern.include.node_modules.roact-hooked.package"))() end)

newInstance("roact-rodux-hooked", "Folder", "SriBlox-Modern.include.node_modules.roact-rodux-hooked", "SriBlox-Modern.include.node_modules")

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.package", "SriBlox-Modern.include.node_modules.roact-rodux-hooked", function () return setfenv(function() return {
	author = "littensy",
	bugs = {
		url = "https://github.com/littensy/roact-rodux-hooked/issues/",
	},
	description = "Hooks for Rodux with roact-hooked",
	devDependencies = {
		["@rbxts/compiler-types"] = "^1.2.3-types.0",
		["@rbxts/roact"] = "^1.4.2-ts.2",
		["@rbxts/roact-hooked"] = "^2.0.0",
		["@rbxts/rodux"] = "^3.0.0-ts.3",
		["@rbxts/roselect"] = "0.0.1",
		["@rbxts/types"] = "^1.0.523",
		["@typescript-eslint/eslint-plugin"] = "^4.30.0",
		["@typescript-eslint/parser"] = "^4.30.0",
		eslint = "^7.32.0",
		["eslint-config-prettier"] = "^8.3.0",
		["eslint-plugin-jsdoc"] = "^36.0.8",
		["eslint-plugin-prettier"] = "^4.0.0",
		["eslint-plugin-roblox-ts"] = "0.0.31",
		["eslint-plugin-sort-imports-es6-autofix"] = "^0.6.0",
		prettier = "^2.3.2",
		typescript = "^4.4.2",
	},
	files = {"src"},
	keywords = {"roblox", "typescript", "roact", "roact-hooks", "rodux"},
	license = "MIT",
	main = "src/init.lua",
	name = "@rbxts/roact-rodux-hooked",
	peerDependencies = {
		["@rbxts/roact"] = "*",
		["@rbxts/roact-hooked"] = "^2.0.0",
	},
	publishConfig = {
		access = "public",
	},
	repository = {
		type = "git",
		url = "https://github.com/littensy/roact-rodux-hooked.git",
	},
	scripts = {
		serve = "rojo serve ./test/default.project.json",
		watch = "rbxtsc -w --type=model -p ./test -i ./include",
	},
	types = "src/index.d.ts",
	version = "1.1.3",
} end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.package"))() end)

newModule("src", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src", "SriBlox-Modern.include.node_modules.roact-rodux-hooked", function () return setfenv(function() local RoactRoduxContext = require(script.components.Context)
local StoreProvider = require(script.components.StoreProvider)

local useDispatch = require(script.hooks.useDispatch)
local useSelector = require(script.hooks.useSelector)
local useStore = require(script.hooks.useStore)

local shallowEqual = require(script.utils.shallowEqual)

return {
	useDispatch = useDispatch,
	useSelector = useSelector,
	useStore = useStore,
	shallowEqual = shallowEqual,
	StoreProvider = StoreProvider,
	RoactRoduxContext = RoactRoduxContext,
}
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src"))() end)

newInstance("components", "Folder", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src")

newModule("Context", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components.Context", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components", function () return setfenv(function() local Roact = require(script.Parent.Parent.vendor.Roact)

local RoactRoduxContext = Roact.createContext()

return RoactRoduxContext
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components.Context"))() end)

newModule("StoreProvider", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components.StoreProvider", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components", function () return setfenv(function() local Roact = require(script.Parent.Parent.vendor.Roact)
local RoactRoduxContext = require(script.Parent.Context)

local function StoreProvider(props)
	return (
		Roact.createElement(RoactRoduxContext.Provider, {
			value = props.store,
		}, props[Roact.Children])
	)
end

return StoreProvider
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.components.StoreProvider"))() end)

newInstance("hooks", "Folder", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src")

newModule("useDispatch", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks.useDispatch", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks", function () return setfenv(function() local Hooks = require(script.Parent.Parent.vendor.RoactHooked)
local useStore = require(script.Parent.useStore)

local function useDispatch()
	local store = useStore()

	local dispatch = Hooks.useCallback(function(action)
		store:dispatch(action)
	end, { store })

	return dispatch
end

return useDispatch
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks.useDispatch"))() end)

newModule("useSelector", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks.useSelector", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks", function () return setfenv(function() -- https://github.com/reduxjs/react-redux/blob/7.x/src/hooks/useSelector.js

local Hooks = require(script.Parent.Parent.vendor.RoactHooked)
local useStore = require(script.Parent.useStore)

local function refEquality(a, b)
	return a == b
end

local function useSelector(selector, isEqual)
	if isEqual == nil then
		isEqual = refEquality
	end

	local _, forceRender = Hooks.useReducer(function(n)
		return n + 1
	end, 0)

	local store = useStore()

	local latestSubscriptionCallbackError = Hooks.useMutable()
	local latestSelector = Hooks.useMutable()
	local latestStoreState = Hooks.useMutable()
	local latestSelectedState = Hooks.useMutable()

	local storeState = store:getState()
	local selectedState

	local success, err = pcall(function()
		if 
			selector ~= latestSelector.current or
			storeState ~= latestStoreState.current or
			latestSubscriptionCallbackError.current
		then
			local newSelectedState = selector(storeState)

			-- ensure latest selected state is reused so that a custom equality
			-- function can result in identical references
			if
				latestSelectedState.current == nil or
				not isEqual(newSelectedState, latestSelectedState.current)
			then
				selectedState = newSelectedState
			else
				selectedState = latestSelectedState.current
			end
		else
			selectedState = latestSelectedState.current
		end
	end)

	if not success then
		if latestSubscriptionCallbackError.current then
			err ..= (
				"\nThe error may be correlated with this previous error:\n" ..
				latestSubscriptionCallbackError.current ..
				"\n\n"
			)

			error(err)
		end
	end

	Hooks.useEffect(function()
		latestSelector.current = selector
		latestStoreState.current = storeState
		latestSelectedState.current = selectedState
		latestSubscriptionCallbackError.current = nil
	end)

	Hooks.useEffect(function()
		local function checkForUpdates(newStoreState)
			local success, shouldRender = pcall(function()
				-- Avoid calling selector multiple times if the store's state has not changed
				if newStoreState == latestStoreState.current then
					return false
				end

				local newSelectedState = latestSelector.current(newStoreState)

				if isEqual(newSelectedState, latestSelectedState.current) then
					return false
				end

				latestSelectedState.current = newSelectedState
				latestStoreState.current = newStoreState

				return true
			end)

			if not success then
				-- we ignore all errors here, since when the component
				-- is re-rendered, the selectors are called again, and
				-- will throw again, if neither props nor store state
				-- changed
				latestSubscriptionCallbackError.current = shouldRender
			elseif shouldRender then
				-- pcall will not block this rerender in the guard clauses,
				-- so use the returned boolean value to decide
				task.spawn(forceRender)
			end
		end

		local subscription = store.changed:connect(checkForUpdates)

		checkForUpdates(storeState)

		return function()
			subscription:disconnect()
		end
	end, { store })

	return selectedState
end

return useSelector
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks.useSelector"))() end)

newModule("useStore", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks.useStore", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks", function () return setfenv(function() local Hooks = require(script.Parent.Parent.vendor.RoactHooked)
local RoactRoduxContext = require(script.Parent.Parent.components.Context)

local function useStore()
	return Hooks.useContext(RoactRoduxContext)
end

return useStore
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.hooks.useStore"))() end)

newInstance("utils", "Folder", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.utils", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src")

newModule("shallowEqual", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.utils.shallowEqual", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.utils", function () return setfenv(function() local function shallowEqual(left, right)
	if left == right then
		return true
	end

	if type(left) ~= "table" or type(right) ~= "table" then
		return false
	end

	if #left ~= #right then
		return false
	end

	for key, value in pairs(left) do
		if right[key] ~= value then
			return false
		end
	end

	return true
end

return shallowEqual
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.utils.shallowEqual"))() end)

newInstance("vendor", "Folder", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src")

newModule("Roact", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor.Roact", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor", function () return setfenv(function() local modules = script:FindFirstAncestor("node_modules")

if modules:FindFirstChild("@rbxts") then
	return require(modules["@rbxts"].roact.src)
elseif modules:FindFirstChild("roact") then
	return require(modules.roact.src)
elseif script.Parent.Parent.Parent:FindFirstChild("Roact") then
	return require(script.Parent.Parent.Parent.Roact)
else
	error("Could not find Roact or @rbxts/roact in the parent hierarchy.")
end
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor.Roact"))() end)

newModule("RoactHooked", "ModuleScript", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor.RoactHooked", "SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor", function () return setfenv(function() local modules = script:FindFirstAncestor("node_modules")

if modules:FindFirstChild("@rbxts") then
	return require(modules["@rbxts"]["roact-hooked"].src)
elseif modules:FindFirstChild("roact-hooked") then
	return require(modules["roact-hooked"].src)
elseif script.Parent.Parent.Parent:FindFirstChild("roact-hooked") then
	return require(script.Parent.Parent.Parent["roact-hooked"])
else
	error("Could not find @rbxts/roact-hooked in the parent hierarchy.")
end
 end, newEnv("SriBlox-Modern.include.node_modules.roact-rodux-hooked.src.vendor.RoactHooked"))() end)

newInstance("rodux", "Folder", "SriBlox-Modern.include.node_modules.rodux", "SriBlox-Modern.include.node_modules")

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.package", "SriBlox-Modern.include.node_modules.rodux", function () return setfenv(function() return {
	author = "",
	contributors = {{
		name = "Jonathan Holmes",
		url = "https://github.com/Vorlias",
	}},
	description = "Rodux for Roblox TypeScript",
	devDependencies = {
		["@rbxts/compiler-types"] = "^1.0.0-types.0",
	},
	keywords = {"roblox", "typescript", "rodux"},
	licenses = {{
		type = "Apache 2.0",
		url = "https://github.com/Roblox/rodux/blob/master/LICENSE",
	}},
	main = "src/init.lua",
	name = "@rbxts/rodux",
	scripts = {
	},
	typings = "src/index.d.ts",
	version = "3.0.0-ts.3",
} end, newEnv("SriBlox-Modern.include.node_modules.rodux.package"))() end)

newModule("src", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src", "SriBlox-Modern.include.node_modules.rodux", function () return setfenv(function() local Store = require(script.Store)
local createReducer = require(script.createReducer)
local combineReducers = require(script.combineReducers)
local makeActionCreator = require(script.makeActionCreator)
local loggerMiddleware = require(script.loggerMiddleware)
local thunkMiddleware = require(script.thunkMiddleware)

return {
	Store = Store,
	createReducer = createReducer,
	combineReducers = combineReducers,
	makeActionCreator = makeActionCreator,
	loggerMiddleware = loggerMiddleware.middleware,
	thunkMiddleware = thunkMiddleware,
}
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src"))() end)

newModule("NoYield", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.NoYield", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() --!nocheck

--[[
	Calls a function and throws an error if it attempts to yield.

	Pass any number of arguments to the function after the callback.

	This function supports multiple return; all results returned from the
	given function will be returned.
]]

local function resultHandler(co, ok, ...)
	if not ok then
		local message = (...)
		error(debug.traceback(co, message), 2)
	end

	if coroutine.status(co) ~= "dead" then
		error(debug.traceback(co, "Attempted to yield inside changed event!"), 2)
	end

	return ...
end

local function NoYield(callback, ...)
	local co = coroutine.create(callback)

	return resultHandler(co, coroutine.resume(co, ...))
end

return NoYield
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.NoYield"))() end)

newModule("Signal", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.Signal", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() --[[
	A limited, simple implementation of a Signal.

	Handlers are fired in order, and (dis)connections are properly handled when
	executing an event.
]]
local function immutableAppend(list, ...)
	local new = {}
	local len = #list

	for key = 1, len do
		new[key] = list[key]
	end

	for i = 1, select("#", ...) do
		new[len + i] = select(i, ...)
	end

	return new
end

local function immutableRemoveValue(list, removeValue)
	local new = {}

	for i = 1, #list do
		if list[i] ~= removeValue then
			table.insert(new, list[i])
		end
	end

	return new
end

local Signal = {}

Signal.__index = Signal

function Signal.new(store)
	local self = {
		_listeners = {},
		_store = store
	}

	setmetatable(self, Signal)

	return self
end

function Signal:connect(callback)
	if typeof(callback) ~= "function" then
		error("Expected the listener to be a function.")
	end

	if self._store and self._store._isDispatching then
		error(
			'You may not call store.changed:connect() while the reducer is executing. ' ..
				'If you would like to be notified after the store has been updated, subscribe from a ' ..
				'component and invoke store:getState() in the callback to access the latest state. '
		)
	end

	local listener = {
		callback = callback,
		disconnected = false,
		connectTraceback = debug.traceback(),
		disconnectTraceback = nil
	}

	self._listeners = immutableAppend(self._listeners, listener)

	local function disconnect()
		if listener.disconnected then
			error((
				"Listener connected at: \n%s\n" ..
				"was already disconnected at: \n%s\n"
			):format(
				tostring(listener.connectTraceback),
				tostring(listener.disconnectTraceback)
			))
		end

		if self._store and self._store._isDispatching then
			error("You may not unsubscribe from a store listener while the reducer is executing.")
		end

		listener.disconnected = true
		listener.disconnectTraceback = debug.traceback()
		self._listeners = immutableRemoveValue(self._listeners, listener)
	end

	return {
		disconnect = disconnect
	}
end

function Signal:fire(...)
	for _, listener in ipairs(self._listeners) do
		if not listener.disconnected then
			listener.callback(...)
		end
	end
end

return Signal end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.Signal"))() end)

newModule("Store", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.Store", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() local RunService = game:GetService("RunService")

local Signal = require(script.Parent.Signal)
local NoYield = require(script.Parent.NoYield)

local ACTION_LOG_LENGTH = 3

local rethrowErrorReporter = {
	reportReducerError = function(prevState, action, errorResult)
		error(string.format("Received error: %s\n\n%s", errorResult.message, errorResult.thrownValue))
	end,
	reportUpdateError = function(prevState, currentState, lastActions, errorResult)
		error(string.format("Received error: %s\n\n%s", errorResult.message, errorResult.thrownValue))
	end,
}

local function tracebackReporter(message)
	return debug.traceback(tostring(message))
end

local Store = {}

-- This value is exposed as a private value so that the test code can stay in
-- sync with what event we listen to for dispatching the Changed event.
-- It may not be Heartbeat in the future.
Store._flushEvent = RunService.Heartbeat

Store.__index = Store

--[[
	Create a new Store whose state is transformed by the given reducer function.

	Each time an action is dispatched to the store, the new state of the store
	is given by:

		state = reducer(state, action)

	Reducers do not mutate the state object, so the original state is still
	valid.
]]
function Store.new(reducer, initialState, middlewares, errorReporter)
	assert(typeof(reducer) == "function", "Bad argument #1 to Store.new, expected function.")
	assert(middlewares == nil or typeof(middlewares) == "table", "Bad argument #3 to Store.new, expected nil or table.")
	if middlewares ~= nil then
		for i=1, #middlewares, 1 do
			assert(
				typeof(middlewares[i]) == "function",
				("Expected the middleware ('%s') at index %d to be a function."):format(tostring(middlewares[i]), i)
			)
		end
	end

	local self = {}

	self._errorReporter = errorReporter or rethrowErrorReporter
	self._isDispatching = false
	self._reducer = reducer
	local initAction = {
		type = "@@INIT",
	}
	self._actionLog = { initAction }
	local ok, result = xpcall(function()
		self._state = reducer(initialState, initAction)
	end, tracebackReporter)
	if not ok then
		self._errorReporter.reportReducerError(initialState, initAction, {
			message = "Caught error in reducer with init",
			thrownValue = result,
		})
		self._state = initialState
	end
	self._lastState = self._state

	self._mutatedSinceFlush = false
	self._connections = {}

	self.changed = Signal.new(self)

	setmetatable(self, Store)

	local connection = self._flushEvent:Connect(function()
		self:flush()
	end)
	table.insert(self._connections, connection)

	if middlewares then
		local unboundDispatch = self.dispatch
		local dispatch = function(...)
			return unboundDispatch(self, ...)
		end

		for i = #middlewares, 1, -1 do
			local middleware = middlewares[i]
			dispatch = middleware(dispatch, self)
		end

		self.dispatch = function(_self, ...)
			return dispatch(...)
		end
	end

	return self
end

--[[
	Get the current state of the Store. Do not mutate this!
]]
function Store:getState()
	if self._isDispatching then
		error(("You may not call store:getState() while the reducer is executing. " ..
			"The reducer (%s) has already received the state as an argument. " ..
			"Pass it down from the top reducer instead of reading it from the store."):format(tostring(self._reducer)))
	end

	return self._state
end

--[[
	Dispatch an action to the store. This allows the store's reducer to mutate
	the state of the application by creating a new copy of the state.

	Listeners on the changed event of the store are notified when the state
	changes, but not necessarily on every Dispatch.
]]
function Store:dispatch(action)
	if typeof(action) ~= "table" then
		error(("Actions must be tables. " ..
			"Use custom middleware for %q actions."):format(typeof(action)),
			2
		)
	end

	if action.type == nil then
		error("Actions may not have an undefined 'type' property. " ..
			"Have you misspelled a constant? \n" ..
			tostring(action), 2)
	end

	if self._isDispatching then
		error("Reducers may not dispatch actions.")
	end

	local ok, result = pcall(function()
		self._isDispatching = true
		self._state = self._reducer(self._state, action)
		self._mutatedSinceFlush = true
	end)

	self._isDispatching = false

	if not ok then
		self._errorReporter.reportReducerError(
			self._state,
			action,
			{
				message = "Caught error in reducer",
				thrownValue = result,
			}
		)
	end

	if #self._actionLog == ACTION_LOG_LENGTH then
		table.remove(self._actionLog, 1)
	end
	table.insert(self._actionLog, action)
end

--[[
	Marks the store as deleted, disconnecting any outstanding connections.
]]
function Store:destruct()
	for _, connection in ipairs(self._connections) do
		connection:Disconnect()
	end

	self._connections = nil
end

--[[
	Flush all pending actions since the last change event was dispatched.
]]
function Store:flush()
	if not self._mutatedSinceFlush then
		return
	end

	self._mutatedSinceFlush = false

	-- On self.changed:fire(), further actions may be immediately dispatched, in
	-- which case self._lastState will be set to the most recent self._state,
	-- unless we cache this value first
	local state = self._state

	local ok, errorResult = xpcall(function()
		-- If a changed listener yields, *very* surprising bugs can ensue.
		-- Because of that, changed listeners cannot yield.
		NoYield(function()
			self.changed:fire(state, self._lastState)
		end)
	end, tracebackReporter)

	if not ok then
		self._errorReporter.reportUpdateError(
			self._lastState,
			state,
			self._actionLog,
			{
				message = "Caught error flushing store updates",
				thrownValue = errorResult,
			}
		)
	end

	self._lastState = state
end

return Store
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.Store"))() end)

newModule("combineReducers", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.combineReducers", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() --[[
	Create a composite reducer from a map of keys and sub-reducers.
]]
local function combineReducers(map)
	return function(state, action)
		-- If state is nil, substitute it with a blank table.
		if state == nil then
			state = {}
		end

		local newState = {}

		for key, reducer in pairs(map) do
			-- Each reducer gets its own state, not the entire state table
			newState[key] = reducer(state[key], action)
		end

		return newState
	end
end

return combineReducers
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.combineReducers"))() end)

newModule("createReducer", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.createReducer", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() return function(initialState, handlers)
	return function(state, action)
		if state == nil then
			state = initialState
		end

		local handler = handlers[action.type]

		if handler then
			return handler(state, action)
		end

		return state
	end
end
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.createReducer"))() end)

newModule("loggerMiddleware", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.loggerMiddleware", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() -- We want to be able to override outputFunction in tests, so the shape of this
-- module is kind of unconventional.
--
-- We fix it this weird shape in init.lua.
local prettyPrint = require(script.Parent.prettyPrint)
local loggerMiddleware = {
	outputFunction = print,
}

function loggerMiddleware.middleware(nextDispatch, store)
	return function(action)
		local result = nextDispatch(action)

		loggerMiddleware.outputFunction(("Action dispatched: %s\nState changed to: %s"):format(
			prettyPrint(action),
			prettyPrint(store:getState())
		))

		return result
	end
end

return loggerMiddleware
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.loggerMiddleware"))() end)

newModule("makeActionCreator", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.makeActionCreator", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() --[[
	A helper function to define a Rodux action creator with an associated name.
]]
local function makeActionCreator(name, fn)
	assert(type(name) == "string", "Bad argument #1: Expected a string name for the action creator")

	assert(type(fn) == "function", "Bad argument #2: Expected a function that creates action objects")

	return setmetatable({
		name = name,
	}, {
		__call = function(self, ...)
			local result = fn(...)

			assert(type(result) == "table", "Invalid action: An action creator must return a table")

			result.type = name

			return result
		end
	})
end

return makeActionCreator
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.makeActionCreator"))() end)

newModule("prettyPrint", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.prettyPrint", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() local indent = "    "

local function prettyPrint(value, indentLevel)
	indentLevel = indentLevel or 0
	local output = {}

	if typeof(value) == "table" then
		table.insert(output, "{\n")

		for tableKey, tableValue in pairs(value) do
			table.insert(output, indent:rep(indentLevel + 1))
			table.insert(output, tostring(tableKey))
			table.insert(output, " = ")

			table.insert(output, prettyPrint(tableValue, indentLevel + 1))
			table.insert(output, "\n")
		end

		table.insert(output, indent:rep(indentLevel))
		table.insert(output, "}")
	elseif typeof(value) == "string" then
		table.insert(output, string.format("%q", value))
		table.insert(output, " (string)")
	else
		table.insert(output, tostring(value))
		table.insert(output, " (")
		table.insert(output, typeof(value))
		table.insert(output, ")")
	end

	return table.concat(output, "")
end

return prettyPrint end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.prettyPrint"))() end)

newModule("thunkMiddleware", "ModuleScript", "SriBlox-Modern.include.node_modules.rodux.src.thunkMiddleware", "SriBlox-Modern.include.node_modules.rodux.src", function () return setfenv(function() --[[
	A middleware that allows for functions to be dispatched.
	Functions will receive a single argument, the store itself.
	This middleware consumes the function; middleware further down the chain
	will not receive it.
]]
local function tracebackReporter(message)
	return debug.traceback(message)
end

local function thunkMiddleware(nextDispatch, store)
	return function(action)
		if typeof(action) == "function" then
			local ok, result = xpcall(function()
				return action(store)
			end, tracebackReporter)

			if not ok then
				-- report the error and move on so it's non-fatal app
				store._errorReporter.reportReducerError(store:getState(), action, {
					message = "Caught error in thunk",
					thrownValue = result,
				})
				return nil
			end

			return result
		end

		return nextDispatch(action)
	end
end

return thunkMiddleware
 end, newEnv("SriBlox-Modern.include.node_modules.rodux.src.thunkMiddleware"))() end)

newModule("services", "ModuleScript", "SriBlox-Modern.include.node_modules.services", "SriBlox-Modern.include.node_modules", function () return setfenv(function() return setmetatable({}, {
	__index = function(self, serviceName)
		local service = game:GetService(serviceName)
		self[serviceName] = service
		return service
	end,
})
 end, newEnv("SriBlox-Modern.include.node_modules.services"))() end)

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.services.package", "SriBlox-Modern.include.node_modules.services", function () return setfenv(function() return {
	author = "",
	description = "",
	devDependencies = {
		["@rbxts/compiler-types"] = "^3.0.0-types.0",
		["@rbxts/types"] = "^1.0.855",
	},
	files = {"init.lua", "index.d.ts", "plugin.d.ts"},
	license = "ISC",
	main = "init.lua",
	name = "@rbxts/services",
	scripts = {
	},
	typings = "index.d.ts",
	version = "1.6.0",
} end, newEnv("SriBlox-Modern.include.node_modules.services.package"))() end)

newInstance("types", "Folder", "SriBlox-Modern.include.node_modules.types", "SriBlox-Modern.include.node_modules")

newInstance("include", "Folder", "SriBlox-Modern.include.node_modules.types.include", "SriBlox-Modern.include.node_modules.types")

newInstance("generated", "Folder", "SriBlox-Modern.include.node_modules.types.include.generated", "SriBlox-Modern.include.node_modules.types.include")

newModule("package", "ModuleScript", "SriBlox-Modern.include.node_modules.types.package", "SriBlox-Modern.include.node_modules.types", function () return setfenv(function() return {
	author = "roblox-ts",
	bugs = {
		url = "https://github.com/roblox-ts/types/issues",
	},
	dependencies = {
	},
	description = "TypeScript typings for the Roblox platform. Partially handwritten and partially automatically generated.",
	homepage = "https://github.com/roblox-ts/types#readme",
	keywords = {"types", "Roblox", "typescript"},
	license = "MIT",
	main = "include/roblox.d.ts",
	name = "@rbxts/types",
	publishConfig = {
		access = "public",
	},
	repository = {
		type = "git",
		url = "git+https://github.com/roblox-ts/types.git",
	},
	scripts = {
	},
	types = "include/roblox.d.ts",
	version = "1.0.890",
} end, newEnv("SriBlox-Modern.include.node_modules.types.package"))() end)

init()