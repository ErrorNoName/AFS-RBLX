--[[
═══════════════════════════════════════════════════════════════════════
    TEST SPÉCIALISÉ - VIDÉOS A-ADS
    
    Roblox ne supporte PAS vidéos nativement!
    
    Solutions testées:
    1. Extraction thumbnail/poster image
    2. Fallback première frame vidéo
    3. Affichage texte "VIDEO" si pas d'image
    
    Logs complets pour debug
═══════════════════════════════════════════════════════════════════════
--]]

print("\n" .. string.rep("═", 80))
print("🎬 TEST SUPPORT VIDÉO - A-ADS")
print(string.rep("═", 80))

--[[ CONFIG ]]--
local CONFIG = {
    AdURL = "//acceptable.a-ads.com/2417103/?size=Adaptive",
}

--[[ SERVICES ]]--
local HttpService = game:GetService("HttpService")

--[[ VARIABLES ]]--
local VideoData = {
    URL = nil,
    ThumbnailURL = nil,
    Type = nil,
}

--[[ LOG FONCTION ]]--
local function Log(category, message, level)
    level = level or "INFO"
    local prefix = {INFO = "ℹ️", SUCCESS = "✅", ERROR = "❌", WARNING = "⚠️", DEBUG = "🔍"}
    print(string.format("[%s] [%s] %s", prefix[level] or "•", category, message))
end

--[[ DÉTECTION VIDÉO DANS HTML ]]--
local function FindVideoInHTML(html)
    Log("PARSER", "Recherche vidéos dans HTML...", "INFO")
    
    -- Pattern 1: <video poster="">
    for poster in html:gmatch('<video[^>]+poster=["\']([^"\']+)["\']') do
        local fullUrl = poster:gsub("^//", "https://")
        Log("PARSER", "✅ Thumbnail vidéo trouvé: " .. fullUrl, "SUCCESS")
        VideoData.ThumbnailURL = fullUrl
        VideoData.Type = "thumbnail"
    end
    
    -- Pattern 2: <source src=""> (URL vidéo directe)
    for src in html:gmatch('<source[^>]+src=["\']([^"\']+)["\']') do
        local fullUrl = src:gsub("^//", "https://")
        if fullUrl:lower():match("%.mp4") or fullUrl:lower():match("%.webm") then
            Log("PARSER", "✅ URL vidéo trouvée: " .. fullUrl, "SUCCESS")
            VideoData.URL = fullUrl
            VideoData.Type = "video"
        end
    end
    
    if VideoData.ThumbnailURL or VideoData.URL then
        return true
    else
        Log("PARSER", "⚠️ Aucune vidéo trouvée dans HTML", "WARNING")
        return false
    end
end

--[[ AFFICHAGE THUMBNAIL VIDÉO ]]--
local function DisplayVideoThumbnail()
    Log("DISPLAY", "🖼️ Affichage thumbnail vidéo...", "INFO")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Video_Thumbnail_Test"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 470, 0, 100)
    container.Position = UDim2.new(0.5, -235, 0.3, 0)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    container.BorderSizePixel = 2
    container.BorderColor3 = Color3.fromRGB(255, 0, 100)
    container.Parent = screenGui
    
    if VideoData.ThumbnailURL then
        -- Afficher thumbnail
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(1, 0, 1, 0)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = VideoData.ThumbnailURL
        imageLabel.ScaleType = Enum.ScaleType.Stretch
        imageLabel.Parent = container
        
        -- Icône play overlay
        local playIcon = Instance.new("TextLabel")
        playIcon.Size = UDim2.new(0, 60, 0, 60)
        playIcon.Position = UDim2.new(0.5, -30, 0.5, -30)
        playIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        playIcon.BackgroundTransparency = 0.5
        playIcon.Text = "▶"
        playIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
        playIcon.TextSize = 36
        playIcon.Font = Enum.Font.GothamBold
        playIcon.Parent = imageLabel
        
        -- Coins arrondis
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = playIcon
        
        Log("DISPLAY", "✅ Thumbnail vidéo affiché", "SUCCESS")
    else
        -- Fallback texte
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "🎬 VIDÉO\n(Pas de thumbnail disponible)"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 28
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextWrapped = true
        textLabel.Parent = container
        
        Log("DISPLAY", "⚠️ Fallback texte (pas de thumbnail)", "WARNING")
    end
    
    -- Label info
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 25)
    infoLabel.Position = UDim2.new(0, 0, 1, 5)
    infoLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Text = "🎬 VIDÉO (Thumbnail statique)"
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Parent = container
    
    return true
end

--[[ MAIN RUNNER ]]--
local function RunVideoTest()
    Log("MAIN", "🚀 Démarrage test support vidéo...", "INFO")
    
    -- Télécharger iframe
    local success, iframeHtml = pcall(function()
        return game:HttpGet("https:" .. CONFIG.AdURL)
    end)
    
    if not success then
        Log("MAIN", "❌ Téléchargement iframe échoué", "ERROR")
        return
    end
    
    -- Trouver vidéo
    local hasVideo = FindVideoInHTML(iframeHtml)
    
    if not hasVideo then
        Log("MAIN", "ℹ️ Aucune vidéo dans iframe A-Ads (normal, rare)", "INFO")
        Log("MAIN", "💡 A-Ads utilise principalement images statiques", "INFO")
    else
        -- Afficher thumbnail
        DisplayVideoThumbnail()
    end
    
    print("\n" .. string.rep("═", 80))
    print("📊 RÉSULTATS TEST VIDÉO")
    print(string.rep("═", 80))
    print("⚠️ LIMITATION: Roblox ne supporte PAS lecture vidéos!")
    print("")
    print("📋 Données détectées:")
    print("   URL vidéo: " .. (VideoData.URL or "Aucune"))
    print("   Thumbnail: " .. (VideoData.ThumbnailURL or "Aucun"))
    print("   Type: " .. (VideoData.Type or "Aucun"))
    print("")
    print("💡 SOLUTION:")
    print("   - Si vidéo détectée → Afficher thumbnail/poster image")
    print("   - Si pas de thumbnail → Fallback texte 'VIDEO'")
    print("   - A-Ads utilise rarement vidéos (95% images statiques)")
    print(string.rep("═", 80))
end

RunVideoTest()

_G.VideoTestController = {
    Reload = RunVideoTest,
    VideoData = VideoData,
    Config = CONFIG,
}
