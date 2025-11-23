--[[
═══════════════════════════════════════════════════════════════════════
    TEST SPÉCIALISÉ - GIFs ANIMÉS A-ADS
    
    Méthodes d'affichage GIFs:
    1. Frame-by-frame avec EditableImage (extraction frames)
    2. Drawing API rotation rapide
    3. AnimatedImageLabel (si supporté Roblox)
    
    Logs complets pour debug
═══════════════════════════════════════════════════════════════════════
--]]

print("\n" .. string.rep("═", 80))
print("🎞️ TEST GIF ANIMÉ - A-ADS")
print(string.rep("═", 80))

--[[ CONFIG ]]--
local CONFIG = {
    AdURL = "//acceptable.a-ads.com/2417103/?size=Adaptive",
    GIFFrameRate = 10, -- FPS pour playback
    MaxFrames = 30, -- Limite frames extraction (performance)
}

--[[ SERVICES ]]--
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

--[[ VARIABLES ]]--
local GIFData = {
    URL = nil,
    Frames = {},
    CurrentFrame = 1,
    IsPlaying = false,
}

--[[ LOG FONCTION ]]--
local function Log(category, message, level)
    level = level or "INFO"
    local prefix = {INFO = "ℹ️", SUCCESS = "✅", ERROR = "❌", WARNING = "⚠️", DEBUG = "🔍"}
    print(string.format("[%s] [%s] %s", prefix[level] or "•", category, message))
end

--[[ DÉTECTION GIF DANS HTML ]]--
local function FindGIFInHTML(html)
    Log("PARSER", "Recherche GIFs dans HTML...", "INFO")
    
    for src in html:gmatch('<img[^>]+src=["\']([^"\']+)["\']') do
        local fullUrl = src:gsub("^//", "https://")
        if fullUrl:lower():match("%.gif") then
            Log("PARSER", "✅ GIF trouvé: " .. fullUrl, "SUCCESS")
            return fullUrl
        end
    end
    
    Log("PARSER", "⚠️ Aucun GIF trouvé dans HTML", "WARNING")
    return nil
end

--[[ MÉTHODE 1: Frame-by-Frame EditableImage ]]--
local function PlayGIFFrameByFrame(gifUrl)
    Log("METHOD1", "🎬 Lecture GIF frame-by-frame...", "INFO")
    
    -- Note: Extraction frames GIF nécessite bibliothèque externe
    -- Pour ce test, on simule avec rotation images statiques
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GIF_FrameByFrame_Test"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 470, 0, 100)
    imageLabel.Position = UDim2.new(0.5, -235, 0.3, 0)
    imageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    imageLabel.BorderSizePixel = 2
    imageLabel.BorderColor3 = Color3.fromRGB(255, 0, 0)
    imageLabel.Parent = screenGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 1, 5)
    statusLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.Text = "🎞️ GIF (Frame-by-Frame) - EN DÉVELOPPEMENT"
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = imageLabel
    
    Log("METHOD1", "⚠️ Extraction frames GIF nécessite bibliothèque spécialisée", "WARNING")
    Log("METHOD1", "💡 Alternative: Télécharger frames pré-extraits ou utiliser image statique", "INFO")
    
    -- Pour démo: afficher image statique du GIF
    imageLabel.Image = gifUrl
    
    return true
end

--[[ MÉTHODE 2: Drawing API Rotation ]]--
local function PlayGIFDrawingAPI(gifUrl)
    Log("METHOD2", "🎨 Test Drawing API pour GIF...", "INFO")
    
    if not Drawing then
        Log("METHOD2", "❌ Drawing API non supportée", "ERROR")
        return false
    end
    
    -- Télécharger GIF data
    local success, gifData = pcall(function()
        return game:HttpGet(gifUrl)
    end)
    
    if not success then
        Log("METHOD2", "❌ Téléchargement GIF échoué", "ERROR")
        return false
    end
    
    Log("METHOD2", string.format("✅ GIF téléchargé (%d bytes)", #gifData), "SUCCESS")
    
    -- Note: Drawing.new("Image") affiche première frame seulement
    local supportsImage = pcall(function()
        local test = Drawing.new("Image")
        test:Remove()
    end)
    
    if not supportsImage then
        Log("METHOD2", "❌ Drawing.new('Image') non supporté", "ERROR")
        return false
    end
    
    local gifImage = Drawing.new("Image")
    gifImage.Data = gifData
    gifImage.Size = Vector2.new(470, 100)
    gifImage.Position = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2 - 235, 350)
    gifImage.Visible = true
    
    local border = Drawing.new("Square")
    border.Size = Vector2.new(474, 104)
    border.Position = Vector2.new(gifImage.Position.X - 2, gifImage.Position.Y - 2)
    border.Color = Color3.fromRGB(255, 255, 0)
    border.Filled = false
    border.Thickness = 2
    border.Visible = true
    
    Log("METHOD2", "⚠️ Drawing API affiche frame statique GIF (pas d'animation)", "WARNING")
    Log("METHOD2", "✅ Première frame GIF affichée", "SUCCESS")
    
    return true
end

--[[ MAIN RUNNER ]]--
local function RunGIFTest()
    Log("MAIN", "🚀 Démarrage test GIF animé...", "INFO")
    
    -- Télécharger iframe
    local iframeHtml = game:HttpGet("https:" .. CONFIG.AdURL)
    
    -- Trouver GIF
    local gifUrl = FindGIFInHTML(iframeHtml)
    
    if not gifUrl then
        Log("MAIN", "⚠️ Aucun GIF dans iframe, utilisation GIF test", "WARNING")
        gifUrl = "https://media.giphy.com/media/3o7btPCcdNniyf0ArS/giphy.gif" -- GIF test
    end
    
    GIFData.URL = gifUrl
    Log("MAIN", "🎯 Test avec: " .. gifUrl, "INFO")
    
    print("\n" .. string.rep("─", 80))
    
    -- Test méthodes
    task.spawn(PlayGIFFrameByFrame, gifUrl)
    task.wait(2)
    task.spawn(PlayGIFDrawingAPI, gifUrl)
    
    print("\n" .. string.rep("═", 80))
    print("📊 RÉSULTATS TEST GIF")
    print(string.rep("═", 80))
    print("⚠️ LIMITATION: Roblox ne supporte PAS nativement animation GIFs")
    print("💡 SOLUTIONS:")
    print("   1. Extraire frames GIF → Rotation manuelle (complexe)")
    print("   2. Afficher première frame statique (simple)")
    print("   3. Utiliser image statique alternative A-Ads")
    print(string.rep("═", 80))
end

RunGIFTest()

_G.GIFTestController = {
    Reload = RunGIFTest,
    GIFData = GIFData,
    Config = CONFIG,
}
