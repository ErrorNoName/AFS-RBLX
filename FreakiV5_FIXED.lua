-- FreakiScript V4 - Fixed Version
-- Corrigé pour utiliser correctement l'API Kavo UI Library

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

------- Create Tabs and Sections using CORRECT Kavo API

-- Home Tab
local Home = library:NewTab("🏠 Home")
local HomeSection = Home:NewSection("Note📃")
HomeSection:NewLabel("⚠️Toutes les fonctionnalités ne fonctionnent pas correctement et nécessitent")
HomeSection:NewLabel("encore quelques ajustements, alors ne soyez pas en colère, je travaille sur des choses 😊")

HomeSection = Home:NewSection("Welcome")
HomeSection:NewLabel("👋 Bienvenue dans mon Exploit!")

HomeSection = Home:NewSection("Version 4.0")
HomeSection:NewLabel("✏️ Présentation de nouvelles fonctionnalités et améliorations du script")

HomeSection = Home:NewSection("Thank You")
HomeSection:NewLabel("💖 Merci d'avoir utilisé mon script!")

HomeSection = Home:NewSection("DiscordInfo")
HomeSection:NewLabel("📣 Rejoignez mon Discord pour les mises à jour et le support!")

HomeSection = Home:NewSection("Early Development")
HomeSection:NewLabel(" ")
HomeSection:NewLabel("🌱 Ce script est actuellement en début de développement, mais nous travaillons dur pour le rendre encore meilleur !")
HomeSection:NewLabel("Nous apprécions votre soutien et votre patience alors que nous continuons à nous améliorer et à ajouter de nouvelles fonctionnalités.")
HomeSection:NewLabel(" ")
HomeSection:NewLabel("Restez à l'écoute pour des mises à jour passionnantes! 💪😊")

HomeSection = Home:NewSection("Update Log")
HomeSection:NewLabel("- Ajout de nouveaux scripts de jeux.")
HomeSection:NewLabel("- Correction de bugs et amélioration des performances.")
HomeSection:NewLabel("- Nouveaux éléments dans l'exploit et options.")

-- Settings Tab
local Settings = library:NewTab("⚙ Hubs Settings")
local SettingsSection = Settings:NewSection("Cursor")

SettingsSection:NewButton("Basic Cursor", "Change cursor to default", function()
    while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end
    local mouse = game.Players.LocalPlayer:GetMouse()
    mouse.Icon = "http://www.roblox.com/asset/?id=None"
end)

SettingsSection:NewButton("FreakiCursor Basic", "FreakiScript cursor", function()
    while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end
    local mouse = game.Players.LocalPlayer:GetMouse()
    mouse.Icon = "http://www.roblox.com/asset/?id=13731611108"
end)

SettingsSection:NewButton("FreakiCursor FPSPecision", "FPS precision cursor", function()
    while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end
    local mouse = game.Players.LocalPlayer:GetMouse()
    mouse.Icon = "http://www.roblox.com/asset/?id=13731718651"
end)

SettingsSection = Settings:NewSection("Visual")

SettingsSection:NewButton("ESP", "Enable ESP for all players", function()
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
        if playerRemoved.Character and playerRemoved.Character:FindFirstChild("HumanoidRootPart") and playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight then
            playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
        end
    end)

    RunService.Heartbeat:Connect(function()
        for i, v in pairs(Players) do
            if v.Character then
                if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                    local highlightClone = highlight:Clone()
                    highlightClone.Adornee = v.Character
                    highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                    highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlightClone.Name = "Highlight"
                    task.wait()
                end
            end
        end
    end)
end)

SettingsSection:NewButton("Fog Remover", "Remove fog and improve lighting", function()
    game.Lighting.FogEnd = 100000
    game.Lighting.FogStart = 0
    game.Lighting.ClockTime = 14
    game.Lighting.Brightness = 2
    game.Lighting.GlobalShadows = false
end)

SettingsSection:NewButton("Tracers", "Enable tracers to players", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

-- GameSupport Tab
local GameSupport = library:NewTab("🔓 Game Support")
local GameSupportSection = GameSupport:NewSection("Auto Detect")

GameSupportSection:NewButton("Detect the script for this game", "Auto-detect and load game-specific script", function()
    repeat task.wait() until game:IsLoaded()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.G-Hub-Games-List"))()
end)

-- Utils Tab
local Utils = library:NewTab("🛠 Utils")
local UtilsSection = Utils:NewSection("Utility Scripts")

UtilsSection:NewButton("Rejoin", "Rejoin the current server", function()
    loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Rejoin-Game-2583"))()
end)

UtilsSection:NewButton("AntiAFK", "Prevent being kicked for AFK", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

UtilsSection:NewButton("Remote Spy", "Spy on game remotes", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

UtilsSection:NewButton("DexExplorer V5", "Open Dex Explorer", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

-- Games Tab
local Games = library:NewTab("🎮 Games")
local GamesSection = Games:NewSection("Game Scripts")

GamesSection:NewButton("Blox Fruits", "Load Blox Fruits script", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

GamesSection:NewButton("BedWars", "Load BedWars script", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

GamesSection:NewButton("MM2", "Load Murder Mystery 2 script", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

GamesSection:NewButton("Pet Simulator X", "Load PSX script", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/kW9kjCSZ'))()
end)

-- About Tab
local About = library:NewTab("📰 About")
local AboutSection = About:NewSection("Information")

AboutSection:NewLabel("FreakiScript V4")
AboutSection:NewLabel("Created by FreakiDev")
AboutSection:NewLabel("Discord: [Your Discord]")
AboutSection:NewLabel("Thank you for using FreakiScript!")

print("FreakiScript V4 loaded successfully!")
