--[[
@author depso (depthso)
@description Grow a Garden auto-farm script (Rayfield UI)
https://www.roblox.com/games/126884695634066
]]

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Leaderstats = LocalPlayer.leaderstats
local Backpack = LocalPlayer.Backpack
local PlayerGui = LocalPlayer.PlayerGui

local ShecklesCount = Leaderstats.Sheckles
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)

--// Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/source.lua"))()
local Window = Rayfield:CreateWindow({
    Name = GameInfo.Name .. " | Novalis",
    LoadingTitle = "Grow a Garden Auto-Farm",
    LoadingSubtitle = "by Novalis",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GrowAGarden",
        FileName = "AutoFarmConfig"
    },
    KeySystem = false
})

--// Tabs
local tabFarm = Window:CreateTab("Auto-Farm", 4483362458) print("[DEBUG] tabFarm:", tabFarm)
local tabBuy = Window:CreateTab("Auto-Buy", 4483362458) print("[DEBUG] tabBuy:", tabBuy)
local tabSell = Window:CreateTab("Auto-Sell", 4483362458) print("[DEBUG] tabSell:", tabSell)
local tabWalk = Window:CreateTab("Auto-Walk", 4483362458) print("[DEBUG] tabWalk:", tabWalk)
local tabFeed = Window:CreateTab("Feed Oiseau", 4483362458) print("[DEBUG] tabFeed:", tabFeed)
local tabInv = Window:CreateTab("Inventaire", 4483362458) print("[DEBUG] tabInv:", tabInv)

--// Sections
local sectionPlant = tabFarm:CreateSection("Planting") print("[DEBUG] sectionPlant:", sectionPlant)
print("[DEBUG] sectionPlant metatable:", getmetatable(sectionPlant))
print("[DEBUG] sectionPlant.CreateDropdown:", sectionPlant.CreateDropdown)
local sectionHarvest = tabFarm:CreateSection("Harvesting") print("[DEBUG] sectionHarvest:", sectionHarvest)
local sectionBuy = tabBuy:CreateSection("Seed Purchase") print("[DEBUG] sectionBuy:", sectionBuy)
local sectionSell = tabSell:CreateSection("Selling") print("[DEBUG] sectionSell:", sectionSell)
local sectionWalk = tabWalk:CreateSection("Walk/Noclip") print("[DEBUG] sectionWalk:", sectionWalk)
local sectionFeed = tabFeed:CreateSection("Feed") print("[DEBUG] sectionFeed:", sectionFeed)
local sectionInv = tabInv:CreateSection("Classement & Tri") print("[DEBUG] sectionInv:", sectionInv)

--// Folders
local GameEvents = ReplicatedStorage.GameEvents
local Farms = workspace.Farm

local Accent = {
    DarkGreen = Color3.fromRGB(45, 95, 25),
    Green = Color3.fromRGB(69, 142, 40),
    Brown = Color3.fromRGB(43, 33, 13),
}

--// Dicts
local SeedStock = {}
local OwnedSeeds = {}
local HarvestIgnores = {
	Normal = false,
	Gold = false,
	Rainbow = false
}

--// Globals
local SelectedSeed, AutoPlantRandom, AutoPlant, AutoHarvest, AutoBuy, SellThreshold, NoClip, AutoWalkAllowRandom

--// Interface functions
local function Plant(Position: Vector3, Seed: string)
	GameEvents.Plant_RE:FireServer(Position, Seed)
	wait(.3)
end

local function GetFarms()
	return Farms:GetChildren()
end

local function GetFarmOwner(Farm: Folder): string
	local Important = Farm.Important
	local Data = Important.Data
	local Owner = Data.Owner

	return Owner.Value
end

local function GetFarm(PlayerName: string): Folder?
	local Farms = GetFarms()
	for _, Farm in next, Farms do
		local Owner = GetFarmOwner(Farm)
		if Owner == PlayerName then
			return Farm
		end
	end
    return
end

local IsSelling = false
local function SellInventory()
	local Character = LocalPlayer.Character
	local Previous = Character:GetPivot()
	local PreviousSheckles = ShecklesCount.Value

	--// Prevent conflict
	if IsSelling then return end
	IsSelling = true

	Character:PivotTo(CFrame.new(62, 4, -26))
	while wait() do
		if ShecklesCount.Value ~= PreviousSheckles then break end
		GameEvents.Sell_Inventory:FireServer()
	end
	Character:PivotTo(Previous)

	wait(0.2)
	IsSelling = false
end

local function BuySeed(Seed: string)
	GameEvents.BuySeedStock:FireServer(Seed)
end

local function BuyAllSelectedSeeds()
    local Seed = SelectedSeedStock.Selected
    local Stock = SeedStock[Seed]

	if not Stock or Stock <= 0 then return end

    for i = 1, Stock do
        BuySeed(Seed)
    end
end

local function GetSeedInfo(Seed: Tool): number?
	local PlantName = Seed:FindFirstChild("Plant_Name")
	local Count = Seed:FindFirstChild("Numbers")
	if not PlantName then return end

	return PlantName.Value, Count.Value
end

-- Correction : version robuste de CollectSeedsFromParent
local function CollectSeedsFromParent(Parent, Seeds)
    for _, Tool in next, (Parent and Parent:GetChildren() or {}) do
        if Tool and Tool:IsA("Tool") then
            local Name, Count = GetSeedInfo(Tool)
            if Name then
                Seeds[Name] = {
                    Count = Count,
                    Tool = Tool
                }
            else
                warn("[CollectSeedsFromParent] Tool sans Plant_Name:", Tool.Name)
            end
        end
    end
end

-- Correction : version robuste de CollectCropsFromParent
local function CollectCropsFromParent(Parent, Crops)
    for _, Tool in next, (Parent and Parent:GetChildren() or {}) do
        if Tool and Tool:IsA("Tool") then
            local NameObj = Tool:FindFirstChild("Item_String")
            if NameObj and NameObj.Value then
                table.insert(Crops, Tool)
            else
                warn("[CollectCropsFromParent] Tool sans Item_String:", Tool.Name)
            end
        end
    end
end

local function GetOwnedSeeds(): table
	local Character = LocalPlayer.Character
	
	CollectSeedsFromParent(Backpack, OwnedSeeds)
	CollectSeedsFromParent(Character, OwnedSeeds)

	return OwnedSeeds
end

local function GetInvCrops(): table
	local Character = LocalPlayer.Character
	
	local Crops = {}
	CollectCropsFromParent(Backpack, Crops)
	CollectCropsFromParent(Character, Crops)

	return Crops
end

local function GetArea(Base: BasePart)
	local Center = Base:GetPivot()
	local Size = Base.Size

	--// Bottom left
	local X1 = math.ceil(Center.X - (Size.X/2))
	local Z1 = math.ceil(Center.Z - (Size.Z/2))

	--// Top right
	local X2 = math.floor(Center.X + (Size.X/2))
	local Z2 = math.floor(Center.Z + (Size.Z/2))

	return X1, Z1, X2, Z2
end

local function EquipCheck(Tool)
    local Character = LocalPlayer.Character
    local Humanoid = Character.Humanoid

    if Tool.Parent ~= Backpack then return end
    Humanoid:EquipTool(Tool)
end

--// Auto farm functions
local MyFarm = GetFarm(LocalPlayer.Name)
local MyImportant = MyFarm.Important
local PlantLocations = MyImportant.Plant_Locations
local PlantsPhysical = MyImportant.Plants_Physical

local Dirt = PlantLocations:FindFirstChildOfClass("Part")
local X1, Z1, X2, Z2 = GetArea(Dirt)

local function GetRandomFarmPoint(): Vector3
    local FarmLands = PlantLocations:GetChildren()
    local FarmLand = FarmLands[math.random(1, #FarmLands)]

    local X1, Z1, X2, Z2 = GetArea(FarmLand)
    local X = math.random(X1, X2)
    local Z = math.random(Z1, Z2)

    return Vector3.new(X, 4, Z)
end

local function AutoPlantLoop()
	local Seed = SelectedSeed.Selected

	local SeedData = OwnedSeeds[Seed]
	if not SeedData then return end

    local Count = SeedData.Count
    local Tool = SeedData.Tool

	--// Check for stock
	if Count <= 0 then return end

    local Planted = 0
	local Step = 1

	--// Check if the client needs to equip the tool
    EquipCheck(Tool)

	--// Plant at random points
	if AutoPlantRandom.Value then
		for i = 1, Count do
			local Point = GetRandomFarmPoint()
			Plant(Point, Seed)
		end
	end
	
	--// Plant on the farmland area
	for X = X1, X2, Step do
		for Z = Z1, Z2, Step do
			if Planted > Count then break end
			local Point = Vector3.new(X, 0.13, Z)

			Planted += 1
			Plant(Point, Seed)
		end
	end
end

local function HarvestPlant(Plant: Model)
	local Prompt = Plant:FindFirstChild("ProximityPrompt", true)

	--// Check if it can be harvested
	if not Prompt then return end
	fireproximityprompt(Prompt)
end

local function GetSeedStock(IgnoreNoStock)
    local SeedShop = PlayerGui:FindFirstChild("Seed_Shop")
    if not SeedShop then
        -- Ne spam pas, retourne juste la table vide
        return IgnoreNoStock and {} or SeedStock
    end
    local ItemSize = SeedShop:FindFirstChild("Item_Size", true)
    if not ItemSize then
        -- Ne spam pas, retourne juste la table vide
        return IgnoreNoStock and {} or SeedStock
    end
    local Items = ItemSize.Parent
    local NewList = {}
    for _, Item in next, Items:GetChildren() do
        local MainFrame = Item:FindFirstChild("Main_Frame")
        if not MainFrame then continue end
        local StockText = MainFrame.Stock_Text.Text
        local StockCount = tonumber(StockText:match("%d+"))
        --// Seperate list
        if IgnoreNoStock then
            if StockCount <= 0 then continue end
            NewList[Item.Name] = StockCount
            continue
        end
        SeedStock[Item.Name] = StockCount
    end
    return IgnoreNoStock and NewList or SeedStock
end

local function CanHarvest(Plant): boolean?
    local Prompt = Plant:FindFirstChild("ProximityPrompt", true)
	if not Prompt then return end
    if not Prompt.Enabled then return end

    return true
end

local function CollectHarvestable(Parent, Plants, IgnoreDistance: boolean?)
	local Character = LocalPlayer.Character
	local PlayerPosition = Character:GetPivot().Position

    for _, Plant in next, Parent:GetChildren() do
        --// Fruits
		local Fruits = Plant:FindFirstChild("Fruits")
		if Fruits then
			CollectHarvestable(Fruits, Plants, IgnoreDistance)
		end

		--// Distance check
		local PlantPosition = Plant:GetPivot().Position
		local Distance = (PlayerPosition-PlantPosition).Magnitude
		if not IgnoreDistance and Distance > 15 then continue end

		--// Ignore check
		local Variant = Plant:FindFirstChild("Variant")
		if HarvestIgnores[Variant.Value] then return end

        --// Collect
        if CanHarvest(Plant) then
            table.insert(Plants, Plant)
        end
	end
    return Plants
end

local function GetHarvestablePlants(IgnoreDistance: boolean?)
    local Plants = {}
    CollectHarvestable(PlantsPhysical, Plants, IgnoreDistance)
    return Plants
end

local function HarvestPlants(Parent: Model)
	local Plants = GetHarvestablePlants()
    for _, Plant in next, Plants do
        HarvestPlant(Plant)
    end
end

local function AutoSellCheck()
    local CropCount = #GetInvCrops()

    if not AutoSell.Value then return end
    if CropCount < SellThreshold.Value then return end

    SellInventory()
end

-- ESP Highlight sur la cible
local function SetPlantESP(plant)
    if not plant then return end
    if not plant:FindFirstChild("_AutoESP") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "_AutoESP"
        highlight.Adornee = plant
        highlight.FillColor = Color3.fromRGB(255, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = plant
    end
end
local function ClearAllPlantESP()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") and obj.Name == "_AutoESP" then
            obj:Destroy()
        end
    end
end

-- Ligne de chemin (Beam) entre joueur et cible
local function DrawPathLine(pathPoints)
    -- Nettoie les anciens beams
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("Beam") and v.Name == "_AutoPathBeam" then v:Destroy() end
    end
    if not pathPoints or #pathPoints < 2 then return end
    for i = 1, #pathPoints-1 do
        local a, b = pathPoints[i], pathPoints[i+1]
        local att0 = Instance.new("Attachment", workspace.Terrain)
        att0.WorldPosition = a
        local att1 = Instance.new("Attachment", workspace.Terrain)
        att1.WorldPosition = b
        local beam = Instance.new("Beam")
        beam.Name = "_AutoPathBeam"
        beam.Attachment0 = att0
        beam.Attachment1 = att1
        beam.Color = ColorSequence.new(Color3.fromRGB(0,255,0))
        beam.Width0 = 0.2
        beam.Width1 = 0.2
        beam.Parent = workspace
        game:GetService("Debris"):AddItem(att0, 1)
        game:GetService("Debris"):AddItem(att1, 1)
        game:GetService("Debris"):AddItem(beam, 1)
    end
end

--// SimplePath integration
local SimplePath = loadstring(game:HttpGet('https://raw.githubusercontent.com/grayzcale/simplepath/refs/heads/main/src/SimplePath.lua'))()
local PathSettings = {
    TIME_VARIANCE = 0.07,
    JUMP_WHEN_STUCK = true,
    COMPARISON_CHECKS = 1
}
local SimplePathObj = nil

local function GetSimplePathObj()
    local Character = LocalPlayer.Character
    if not Character or not Character.PrimaryPart then return nil end
    if not SimplePathObj or SimplePathObj._agent ~= Character then
        SimplePathObj = SimplePath.new(Character, {
            AgentRadius = 2,
            AgentHeight = 5,
            AgentCanJump = true,
            AgentJumpHeight = 10,
            AgentMaxSlope = 45,
            WaypointSpacing = 2,
            Costs = {}
        }, PathSettings)
    end
    return SimplePathObj
end

-- Remplacement de WalkToWithPathfinding par SimplePath
local function WalkToWithPathfinding(targetPos)
    local pathObj = GetSimplePathObj()
    if not pathObj then
        Rayfield:Notify({Title = "Pathfinding", Content = "Impossible d'initialiser SimplePath.", Duration = 3})
        return
    end
    local ok = pathObj:Run(targetPos)
    if not ok then
        Rayfield:Notify({Title = "Pathfinding", Content = "Aucun chemin trouvé (SimplePath).", Duration = 3})
    end
end

-- Amélioration AutoWalkLoop avec pathfinding, ESP et ligne
local function AutoWalkLoop()
    if IsSelling then return end

    local Character = LocalPlayer.Character
    local Humanoid = Character.Humanoid

    local Plants = GetHarvestablePlants(true)
	local RandomAllowed = AutoWalkAllowRandom.Value
	local DoRandom = #Plants == 0 or math.random(1, 3) == 2

    --// Random point
    if RandomAllowed and DoRandom then
        local Position = GetRandomFarmPoint()
        Humanoid:MoveTo(Position)
		AutoWalkStatus.Text = "Random point"
        ClearAllPlantESP()
        DrawPathLine(nil)
        return
    end
   
    --// Move to each plant
    local closest, minDist = nil, math.huge
    local myPos = Character:GetPivot().Position
    for _, Plant in ipairs(Plants) do
        local pos = Plant:GetPivot().Position
        local dist = (myPos - pos).Magnitude
        if dist < minDist then
            minDist = dist
            closest = Plant
        end
    end
    if closest then
        SetPlantESP(closest)
        WalkToWithPathfinding(closest:GetPivot().Position)
        AutoWalkStatus.Text = closest.Name
    else
        ClearAllPlantESP()
        DrawPathLine(nil)
    end
end

local function NoclipLoop()
    local Character = LocalPlayer.Character
    if not NoClip.Value then return end
    if not Character then return end

    for _, Part in Character:GetDescendants() do
        if Part:IsA("BasePart") then
            Part.CanCollide = false
        end
    end
end

local function MakeLoop(Toggle, Func)
	coroutine.wrap(function()
		while wait(.01) do
			if not Toggle.Value then continue end
			Func()
		end
	end)()
end

local function StartServices()
	--// Auto-Walk
	MakeLoop(AutoWalk, function()
		local MaxWait = AutoWalkMaxWait.Value
		AutoWalkLoop()
		wait(math.random(1, MaxWait))
	end)

	--// Auto-Harvest
	MakeLoop(AutoHarvest, function()
		HarvestPlants(PlantsPhysical)
	end)

	--// Auto-Buy
	MakeLoop(AutoBuy, BuyAllSelectedSeeds)

	--// Auto-Plant
	MakeLoop(AutoPlant, AutoPlantLoop)

	--// Get stocks
	while wait(.1) do
		GetSeedStock()
		GetOwnedSeeds()
	end
end

--// Rayfield UI element objects
local SelectedSeedDropdown, AutoPlantToggle, AutoPlantRandomToggle
local AutoHarvestToggle, AutoBuyToggle, OnlyShowStockToggle, SelectedSeedStockDropdown
local AutoSellToggle, SellThresholdSlider
local AutoWalkToggle, AutoWalkAllowRandomToggle, NoClipToggle, AutoWalkMaxWaitSlider, AutoWalkStatusLabel
local AutoFeedToggle

--// Auto-Plant (Rayfield)
SelectedSeedDropdown = tabFarm:CreateDropdown({
    SectionParent = sectionPlant,
    Name = "Seed",
    Options = {},
    CurrentOption = "",
    Flag = "SelectedSeed",
    Callback = function(option)
        SelectedSeed = option
    end
})
AutoPlantToggle = tabFarm:CreateToggle({
    SectionParent = sectionPlant,
    Name = "Enabled",
    CurrentValue = false,
    Flag = "AutoPlant",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
AutoPlantRandomToggle = tabFarm:CreateToggle({
    SectionParent = sectionPlant,
    Name = "Plant at random points",
    CurrentValue = false,
    Flag = "AutoPlantRandom",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
tabFarm:CreateButton({
    SectionParent = sectionPlant,
    Name = "Plant all",
    Callback = function()
        local ok, err = pcall(AutoPlantLoop)
        if not ok then
            Rayfield:Notify({Title = "Plant Error", Content = tostring(err), Duration = 4})
        end
    end
})

--// Auto-Harvest (Rayfield)
AutoHarvestToggle = tabFarm:CreateToggle({
    SectionParent = sectionHarvest,
    Name = "Enabled",
    CurrentValue = false,
    Flag = "AutoHarvest",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
for k, v in pairs(HarvestIgnores) do
    tabFarm:CreateToggle({
        SectionParent = sectionHarvest,
        Name = "Ignore: " .. k,
        CurrentValue = v,
        Flag = "Ignore_"..k,
        Callback = function(val)
            HarvestIgnores[k] = val
        end
    })
end

--// Auto-Buy (Rayfield)
SelectedSeedStockDropdown = tabBuy:CreateDropdown({
    SectionParent = sectionBuy,
    Name = "Seed",
    Options = {},
    CurrentOption = "",
    Flag = "SelectedSeedStock",
    Callback = function(option)
        SelectedSeedStock = option
    end
})
AutoBuyToggle = tabBuy:CreateToggle({
    SectionParent = sectionBuy,
    Name = "Enabled",
    CurrentValue = false,
    Flag = "AutoBuy",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
OnlyShowStockToggle = tabBuy:CreateToggle({
    SectionParent = sectionBuy,
    Name = "Only list stock",
    CurrentValue = false,
    Flag = "OnlyShowStock",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
tabBuy:CreateButton({
    SectionParent = sectionBuy,
    Name = "Buy all",
    Callback = function()
        local ok, err = pcall(BuyAllSelectedSeeds)
        if not ok then
            Rayfield:Notify({Title = "Buy Error", Content = tostring(err), Duration = 4})
        end
    end
})

--// Auto-Sell (Rayfield)
tabSell:CreateButton({
    SectionParent = sectionSell,
    Name = "Sell inventory",
    Callback = function()
        local ok, err = pcall(SellInventory)
        if not ok then
            Rayfield:Notify({Title = "Sell Error", Content = tostring(err), Duration = 4})
        end
    end
})
AutoSellToggle = tabSell:CreateToggle({
    SectionParent = sectionSell,
    Name = "Enabled",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
SellThresholdSlider = tabSell:CreateSlider({
    SectionParent = sectionSell,
    Name = "Crops threshold",
    Range = {1, 199},
    Increment = 1,
    Suffix = "Crops",
    CurrentValue = 15,
    Flag = "SellThreshold",
    Callback = function(val)
        -- No-op, handled in loop
    end
})

--// Auto-Walk (Rayfield)
AutoWalkToggle = tabWalk:CreateToggle({
    SectionParent = sectionWalk,
    Name = "Enabled",
    CurrentValue = false,
    Flag = "AutoWalk",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
AutoWalkAllowRandomToggle = tabWalk:CreateToggle({
    SectionParent = sectionWalk,
    Name = "Allow random points",
    CurrentValue = true,
    Flag = "AutoWalkAllowRandom",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
NoClipToggle = tabWalk:CreateToggle({
    SectionParent = sectionWalk,
    Name = "NoClip",
    CurrentValue = false,
    Flag = "NoClip",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
AutoWalkMaxWaitSlider = tabWalk:CreateSlider({
    SectionParent = sectionWalk,
    Name = "Max delay",
    Range = {1, 120},
    Increment = 1,
    Suffix = "s",
    CurrentValue = 10,
    Flag = "AutoWalkMaxWait",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
AutoWalkStatusLabel = tabWalk:CreateLabel("None")

--// Feed Oiseau (Rayfield)
AutoFeedToggle = tabFeed:CreateToggle({
    SectionParent = sectionFeed,
    Name = "Auto-Feed",
    CurrentValue = false,
    Flag = "AutoFeed",
    Callback = function(val)
        -- No-op, handled in loop
    end
})
tabFeed:CreateButton({
    SectionParent = sectionFeed,
    Name = "Feed (x20)",
    Callback = function()
        for i = 1, 20 do
            GameEvents.NightQuestRemoteEvent:FireServer()
            wait(0.05)
        end
        Rayfield:Notify({Title = "Feed", Content = "Fed Oiseau 20x!", Duration = 2})
    end
})

--// Inventory Ranking (Rayfield)
tabInv:CreateButton({
    SectionParent = sectionInv,
    Name = "Afficher Classement Inventaire",
    Callback = ShowInventoryRanking
})
tabInv:CreateButton({
    SectionParent = sectionInv,
    Name = "Sort Backpack",
    Callback = SortBackpack
})
tabInv:CreateButton({
    SectionParent = sectionInv,
    Name = "Afficher Inventaire détaillé",
    Callback = ShowDetailedInventory
})
tabInv:CreateButton({
    SectionParent = sectionInv,
    Name = "Ouvrir tous les packs de graines",
    Callback = OpenAllSeedPacks
})
tabInv:CreateButton({
    SectionParent = sectionInv,
    Name = "Equiper le meilleur gear",
    Callback = EquipBestGear
})

--// Remove legacy UI code
CreateCheckboxes = nil
Window.TreeNode = nil
Window.Button = nil

--// Dynamic Dropdown Refresh
local function RefreshDropdowns()
    local seeds = {}
    for k, v in pairs(GetSeedStock()) do table.insert(seeds, k) end
    SelectedSeedDropdown:Refresh(seeds)
    SelectedSeedStockDropdown:Refresh(seeds)
end

--// Classement et prévision d'inventaire (Rayfield)
local function ShowInventoryRanking()
    print("[DEBUG] ShowInventoryRanking called")
    -- Récupérer les récoltes et graines
    local crops = GetInvCrops() or {}
    local seeds = GetOwnedSeeds() or {}
    -- Tableaux pour classement
    local cropCounts, cropValues = {}, {}
    local totalCropValue = 0
    -- Analyse des récoltes (crops)
    for _, tool in ipairs(crops) do
        local nameObj = tool:FindFirstChild("Item_String")
        local valueObj = tool:FindFirstChild("Sell_Value")
        local name = nameObj and nameObj.Value or tool.Name
        local value = valueObj and tonumber(valueObj.Value) or 0
        cropCounts[name] = (cropCounts[name] or 0) + 1
        cropValues[name] = value
        totalCropValue = totalCropValue + value
    end
    -- Générer classement récoltes (par valeur totale)
    local cropRanking = {}
    for name, count in pairs(cropCounts) do
        local value = cropValues[name] or 0
        table.insert(cropRanking, {name = name, count = count, value = value, total = value * count})
    end
    table.sort(cropRanking, function(a, b) return a.total > b.total end)
    -- Analyse des graines (seeds)
    local seedRanking = {}
    for name, data in pairs(seeds) do
        table.insert(seedRanking, {name = name, count = data.Count})
    end
    table.sort(seedRanking, function(a, b) return a.count > b.count end)
    -- Estimation prévisionnelle (revenus futurs)
    local estimatedFuture = 0
    for _, seed in ipairs(seedRanking) do
        local cropValue = cropValues[seed.name] or 0
        estimatedFuture = estimatedFuture + (cropValue * seed.count)
    end
    -- Affichage Rayfield
    local lines = {}
    table.insert(lines, "[Inventaire] Classement des récoltes :")
    for i, crop in ipairs(cropRanking) do
        table.insert(lines, string.format("%d. %s x%d (valeur: %d, total: %d)", i, crop.name, crop.count, crop.value, crop.total))
    end
    table.insert(lines, "\n[Inventaire] Classement des graines :")
    for i, seed in ipairs(seedRanking) do
        table.insert(lines, string.format("%d. %s x%d", i, seed.name, seed.count))
    end
    table.insert(lines, "\nValeur totale récoltes: " .. totalCropValue)
    table.insert(lines, "Estimation revenus futurs (si tout farm): " .. estimatedFuture)
    -- Nettoyage UI sectionInv
    if sectionInv and sectionInv.Clear then pcall(function() sectionInv:Clear() end) end
    -- Affichage dans Rayfield (labels)
    for _, line in ipairs(lines) do
        tabInv:CreateLabel({SectionParent = sectionInv, Name = line})
    end
    print("[DEBUG] Classement inventaire affiché dans Rayfield.")
end

--// Main automation loops using Rayfield state
local function MainLoops()
    coroutine.wrap(function()
        while wait(.01) do
            if AutoPlantToggle.CurrentValue then
                AutoPlantLoop()
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(.01) do
            if AutoHarvestToggle.CurrentValue then
                HarvestPlants(PlantsPhysical)
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(.01) do
            if AutoBuyToggle.CurrentValue then
                BuyAllSelectedSeeds()
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(.01) do
            if AutoSellToggle.CurrentValue then
                AutoSellCheck()
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(.01) do
            if AutoWalkToggle.CurrentValue then
                AutoWalkLoop()
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(.01) do
            if NoClipToggle.CurrentValue then
                NoclipLoop()
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(.01) do
            if AutoFeedToggle.CurrentValue then
                for i = 1, 20 do
                    GameEvents.NightQuestRemoteEvent:FireServer()
                    wait(0.05)
                end
            end
        end
    end)()
    coroutine.wrap(function()
        while wait(1) do
            RefreshDropdowns()
        end
    end)()
end

--// Start all services
MainLoops()

print("[GrowAGarden] Script lancé. (Rayfield UI)")

-- Fonction pour clear toutes les UI Rayfield et relancer proprement
local function ResetRayfieldUI()
    print("[GrowAGarden] Reset Rayfield UI...")
    if Window and typeof(Window.Destroy) == "function" then
        Window:Destroy()
        print("[GrowAGarden] Rayfield Window destroyed.")
    end
    -- Recharger Rayfield et la fenêtre principale
    Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/source.lua"))()
    Window = Rayfield:CreateWindow({
        Name = GameInfo.Name .. " | Novalis",
        LoadingTitle = "Grow a Garden Auto-Farm",
        LoadingSubtitle = "by Novalis",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "GrowAGarden",
            FileName = "AutoFarmConfig"
        },
        KeySystem = false
    })
    print("[GrowAGarden] Rayfield Window relaunched.")
    -- Ici tu peux relancer la création des tabs/sections si besoin
end

-- Appel automatique au lancement pour debug
-- (Décommente la ligne suivante pour reset à chaque lancement)
-- ResetRayfieldUI()
print("[GrowAGarden] Initialisation UI terminée.")

--// OUVERTURE AUTOMATIQUE DES PACKS DE GRAINES
local function OpenAllSeedPacks()
    print("[DEBUG] OpenAllSeedPacks called")
    local Character = LocalPlayer.Character
    local opened = 0
    -- Parcours Backpack et Character
    for _, parent in ipairs({Backpack, Character}) do
        for _, tool in ipairs(parent:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("SeedPack") then
                local prompt = tool:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then
                    fireproximityprompt(prompt)
                    opened = opened + 1
                    wait(0.1)
                end
            end
        end
    end
    Rayfield:Notify({Title = "Seed Packs", Content = "Packs ouverts: "..opened, Duration = 3})
    print("[DEBUG] OpenAllSeedPacks finished, total:", opened)
end

--// Gestion automatique du meilleur gear
local function EquipBestGear()
    print("[DEBUG] EquipBestGear called")
    local Character = LocalPlayer.Character
    local bestTool, bestValue = nil, -math.huge
    -- Parcours Backpack et Character
    for _, parent in ipairs({Backpack, Character}) do
        for _, tool in ipairs(parent:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("GearStats") then
                local stats = tool.GearStats
                local value = 0
                -- Additionne tous les stats numériques pour estimer la "valeur" du gear
                for _, stat in ipairs(stats:GetChildren()) do
                    if tonumber(stat.Value) then value = value + tonumber(stat.Value) end
                end
                if value > bestValue then
                    bestValue = value
                    bestTool = tool
                end
            end
        end
    end
    if bestTool then
        EquipCheck(bestTool)
        Rayfield:Notify({Title = "Gear", Content = "Gear équipé: "..bestTool.Name, Duration = 3})
        print("[DEBUG] EquipBestGear: equipped", bestTool.Name)
    else
        Rayfield:Notify({Title = "Gear", Content = "Aucun gear trouvé.", Duration = 3})
        print("[DEBUG] EquipBestGear: aucun gear trouvé")
    end
end

--// Ajout des boutons Rayfield dans la section Inventaire
if tabInv and sectionInv then
    tabInv:CreateButton({
        SectionParent = sectionInv,
        Name = "Ouvrir tous les packs de graines",
        Callback = OpenAllSeedPacks
    })
    tabInv:CreateButton({
        SectionParent = sectionInv,
        Name = "Equiper le meilleur gear",
        Callback = EquipBestGear
    })
end

--// TP/Auto-Walk vers points d'intérêt
local function TeleportTo(pos)
    local Character = LocalPlayer.Character
    if Character then
        Character:PivotTo(CFrame.new(pos))
    end
end

local function GetSellStand()
    -- Stand de vente (exemple: coordonnées du stand)
    return Vector3.new(62, 4, -26)
end
local function GetSeedStand()
    -- Stand d'achat (exemple: coordonnées du shop)
    return Vector3.new(70, 4, -26)
end
local function GetFarmZone()
    -- Zone de farm principale (premier Plant_Locations)
    local farm = PlantLocations:GetChildren()[1]
    return farm and farm.Position or Vector3.new(0,4,0)
end
local function GetFirstPickup()
    -- Premier objet ramassable (exemple: premier fruit au sol)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Parent == workspace then
            return obj.Position
        end
    end
end

-- Ajout Rayfield boutons TP/Auto-Walk
if tabWalk and sectionWalk then
    tabWalk:CreateButton({
        SectionParent = sectionWalk,
        Name = "TP Stand de Vente",
        Callback = function() TeleportTo(GetSellStand()) end
    })
    tabWalk:CreateButton({
        SectionParent = sectionWalk,
        Name = "TP Stand d'Achat",
        Callback = function() TeleportTo(GetSeedStand()) end
    })
    tabWalk:CreateButton({
        SectionParent = sectionWalk,
        Name = "TP Zone de Farm",
        Callback = function() TeleportTo(GetFarmZone()) end
    })
    tabWalk:CreateButton({
        SectionParent = sectionWalk,
        Name = "TP Premier Objet à Ramasser",
        Callback = function() TeleportTo(GetFirstPickup()) end
    })
    tabWalk:CreateButton({
        SectionParent = sectionWalk,
        Name = "Auto-Walk vers Plante à Récolter (Pathfinding)",
        Callback = function() AutoWalkLoop() end
    })
end