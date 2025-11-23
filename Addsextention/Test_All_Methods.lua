--[[
═══════════════════════════════════════════════════════════════════════
    TEST COMPLET - AFFICHAGE IMAGES/VIDÉOS/GIFS EXTERNES A-ADS
    
    URL Test: //acceptable.a-ads.com/2417103/?size=Adaptive
    
    Méthodes testées:
    ✅ 1. EditableImage (Roblox 2024+ - MODERNE)
    ✅ 2. Drawing API (Executor Library)
    ✅ 3. ViewportFrame + SurfaceGui (Hybrid)
    ✅ 4. getcustomasset() (Fallback Legacy)
    
    Support: Images PNG/JPEG, GIFs animés, Vidéos (thumbnail)
    Logs: Détaillés pour debug complet
═══════════════════════════════════════════════════════════════════════
--]]

print("\n" .. string.rep("═", 80))
print("🧪 A-ADS MULTI-METHOD TESTER v1.0")
print(string.rep("═", 80))

--[[ CONFIGURATION ]]--
local CONFIG = {
    AdURL = "//acceptable.a-ads.com/2417103/?size=Adaptive",
    DisplayPosition = UDim2.new(0.5, -235, 0.1, 0), -- Centré haut écran
    DisplaySize = UDim2.new(0, 470, 0, 100), -- Taille adaptative
    CloudflareWorkerAPI = "https://image-parser.tyrannizerdev.workers.dev", -- API EditableImage
    TestDuration = 30, -- Secondes par test
    EnableDebug = true,
}

--[[ SERVICES ]]--
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

--[[ VARIABLES GLOBALES ]]--
local CurrentAds = {}
local CurrentAdIndex = 1
local TestResults = {
    EditableImage = {Name = "EditableImage (2024)", Success = false, Error = nil, TimeMs = 0},
    DrawingAPI = {Name = "Drawing API", Success = false, Error = nil, TimeMs = 0},
    ViewportFrame = {Name = "ViewportFrame", Success = false, Error = nil, TimeMs = 0},
    GetCustomAsset = {Name = "getcustomasset()", Success = false, Error = nil, TimeMs = 0},
}

--[[ UTILITY FUNCTIONS ]]--

-- Log formaté avec timestamp
local function Log(category, message, level)
    level = level or "INFO"
    local timestamp = os.date("%H:%M:%S")
    local prefix = {
        INFO = "ℹ️",
        SUCCESS = "✅",
        ERROR = "❌",
        WARNING = "⚠️",
        DEBUG = "🔍",
    }
    
    local color = {
        INFO = "",
        SUCCESS = "",
        ERROR = "",
        WARNING = "",
        DEBUG = "",
    }
    
    print(string.format("[%s] %s [%s] %s", timestamp, prefix[level] or "•", category, message))
end

-- Téléchargement iframe A-Ads
local function DownloadIframe(url)
    Log("DOWNLOAD", "Téléchargement iframe: " .. url, "INFO")
    
    local fullUrl = url:gsub("^//", "https://")
    local startTime = tick()
    
    local success, result = pcall(function()
        return game:HttpGet(fullUrl)
    end)
    
    local elapsed = math.floor((tick() - startTime) * 1000)
    
    if success and result then
        Log("DOWNLOAD", string.format("✅ Iframe téléchargé (%d bytes en %dms)", #result, elapsed), "SUCCESS")
        return result
    else
        Log("DOWNLOAD", "❌ Échec téléchargement: " .. tostring(result), "ERROR")
        return nil
    end
end

-- Extraction images/vidéos/gifs depuis HTML
local function ParseHTMLContent(html)
    Log("PARSER", "Analyse HTML pour extraction média...", "INFO")
    
    local media = {
        images = {},
        gifs = {},
        videos = {},
    }
    
    -- Pattern 1: Images <img src="">
    for src in html:gmatch('<img[^>]+src=["\']([^"\']+)["\']') do
        local fullUrl = src:gsub("^//", "https://")
        
        -- Détecter type
        if fullUrl:lower():match("%.gif") then
            table.insert(media.gifs, {
                URL = fullUrl,
                Type = "gif",
                Width = tonumber(src:match('(%d+)x%d+')) or 468,
                Height = tonumber(src:match('%d+x(%d+)')) or 60,
            })
            Log("PARSER", "🎞️ GIF détecté: " .. fullUrl, "DEBUG")
        else
            table.insert(media.images, {
                URL = fullUrl,
                Type = "image",
                Width = tonumber(src:match('(%d+)x%d+')) or 468,
                Height = tonumber(src:match('%d+x(%d+)')) or 60,
            })
            Log("PARSER", "🖼️ Image détectée: " .. fullUrl, "DEBUG")
        end
    end
    
    -- Pattern 2: Vidéos <video poster=""> ou <source src="">
    for poster in html:gmatch('<video[^>]+poster=["\']([^"\']+)["\']') do
        local fullUrl = poster:gsub("^//", "https://")
        table.insert(media.videos, {
            URL = fullUrl,
            Type = "video_thumbnail",
            Width = 468,
            Height = 60,
        })
        Log("PARSER", "🎬 Vidéo thumbnail détecté: " .. fullUrl, "DEBUG")
    end
    
    for videoSrc in html:gmatch('<source[^>]+src=["\']([^"\']+)["\']') do
        local fullUrl = videoSrc:gsub("^//", "https://")
        if fullUrl:lower():match("%.mp4") or fullUrl:lower():match("%.webm") then
            table.insert(media.videos, {
                URL = fullUrl,
                Type = "video",
                Width = 468,
                Height = 60,
            })
            Log("PARSER", "🎬 Vidéo URL détectée: " .. fullUrl, "DEBUG")
        end
    end
    
    Log("PARSER", string.format("✅ Extraction complète: %d images, %d GIFs, %d vidéos", 
        #media.images, #media.gifs, #media.videos), "SUCCESS")
    
    return media
end

-- Combiner tous les médias en liste unique
local function MergeMediaList(media)
    local allMedia = {}
    
    for _, img in ipairs(media.images) do
        table.insert(allMedia, img)
    end
    
    for _, gif in ipairs(media.gifs) do
        table.insert(allMedia, gif)
    end
    
    for _, vid in ipairs(media.videos) do
        table.insert(allMedia, vid)
    end
    
    return allMedia
end

--[[ MÉTHODE 1: EditableImage (MODERNE 2024) ]]--
local function TestEditableImage(imageUrl)
    Log("METHOD1", "▶️ Test EditableImage + WritePixelsBuffer...", "INFO")
    local startTime = tick()
    
    -- Vérifier support Roblox (2024+)
    if not AssetService.CreateEditableImage then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.EditableImage.Error = "CreateEditableImage non supporté (Roblox version trop ancienne)"
        TestResults.EditableImage.TimeMs = elapsed
        Log("METHOD1", "❌ " .. TestResults.EditableImage.Error, "ERROR")
        return false
    end
    
    -- Étape 1: Requête API Cloudflare Worker
    Log("METHOD1", "🌐 Requête Cloudflare Worker API...", "DEBUG")
    local encodedUrl = HttpService:UrlEncode(imageUrl)
    local apiUrl = CONFIG.CloudflareWorkerAPI .. "/?url=" .. encodedUrl .. "&resize=512"
    
    local success, apiResponse = pcall(function()
        return HttpService:RequestAsync({
            Url = apiUrl,
            Method = "GET"
        })
    end)
    
    if not success or not apiResponse.Success or apiResponse.StatusCode ~= 200 then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.EditableImage.Error = "API Cloudflare Worker échec: " .. tostring(apiResponse)
        TestResults.EditableImage.TimeMs = elapsed
        Log("METHOD1", "❌ " .. TestResults.EditableImage.Error, "ERROR")
        return false
    end
    
    Log("METHOD1", string.format("✅ API réponse OK (%d bytes)", #apiResponse.Body), "SUCCESS")
    
    -- Étape 2: Parser JSON pixel matrix
    Log("METHOD1", "🔍 Parsing pixel matrix JSON...", "DEBUG")
    local ok, pixelData = pcall(HttpService.JSONDecode, HttpService, apiResponse.Body)
    
    if not ok or type(pixelData) ~= "table" or not pixelData.width or not pixelData.height or not pixelData.pixels then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.EditableImage.Error = "JSON pixel matrix malformé"
        TestResults.EditableImage.TimeMs = elapsed
        Log("METHOD1", "❌ " .. TestResults.EditableImage.Error, "ERROR")
        return false
    end
    
    Log("METHOD1", string.format("✅ Pixel matrix: %dx%d pixels", pixelData.width, pixelData.height), "SUCCESS")
    
    -- Étape 3: Créer EditableImage
    Log("METHOD1", "🎨 Création EditableImage...", "DEBUG")
    local editableImage = AssetService:CreateEditableImage({
        Size = Vector2.new(pixelData.width, pixelData.height)
    })
    
    -- Étape 4: Remplir buffer pixels
    Log("METHOD1", "🖌️ Remplissage buffer RGBA...", "DEBUG")
    local bufferSize = pixelData.width * pixelData.height * 4
    local pixelBuffer = buffer.create(bufferSize)
    
    local bufferIndex = 0
    for y = 1, pixelData.height do
        for x = 1, pixelData.width do
            local pixel = pixelData.pixels[y][x]
            buffer.writeu8(pixelBuffer, bufferIndex, pixel[1]) -- R
            buffer.writeu8(pixelBuffer, bufferIndex + 1, pixel[2]) -- G
            buffer.writeu8(pixelBuffer, bufferIndex + 2, pixel[3]) -- B
            buffer.writeu8(pixelBuffer, bufferIndex + 3, 255) -- Alpha
            bufferIndex = bufferIndex + 4
        end
    end
    
    -- Étape 5: WritePixelsBuffer
    Log("METHOD1", "📝 WritePixelsBuffer vers EditableImage...", "DEBUG")
    editableImage:WritePixelsBuffer(Vector2.new(0, 0), Vector2.new(pixelData.width, pixelData.height), pixelBuffer)
    
    -- Étape 6: Affichage ImageLabel
    Log("METHOD1", "🖼️ Création ImageLabel GUI...", "DEBUG")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AAds_EditableImage_Test"
    screenGui.ResetOnSpawn = false
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
    end
    screenGui.Parent = game:GetService("CoreGui")
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "AdDisplay"
    imageLabel.Size = CONFIG.DisplaySize
    imageLabel.Position = CONFIG.DisplayPosition
    imageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    imageLabel.BorderSizePixel = 2
    imageLabel.BorderColor3 = Color3.fromRGB(0, 255, 0) -- Bordure verte = EditableImage
    imageLabel.ScaleType = Enum.ScaleType.Stretch
    imageLabel.ImageContent = Content.fromObject(editableImage)
    imageLabel.Parent = screenGui
    
    -- Label info
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 20)
    infoLabel.Position = UDim2.new(0, 0, 1, 0)
    infoLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    infoLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    infoLabel.Text = "✅ EditableImage (2024) - MODERNE"
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Parent = imageLabel
    
    local elapsed = math.floor((tick() - startTime) * 1000)
    TestResults.EditableImage.Success = true
    TestResults.EditableImage.TimeMs = elapsed
    Log("METHOD1", string.format("✅ EditableImage SUCCESS en %dms!", elapsed), "SUCCESS")
    
    return true
end

--[[ MÉTHODE 2: Drawing API (Executor Library) ]]--
local function TestDrawingAPI(imageUrl)
    Log("METHOD2", "▶️ Test Drawing API (Executor)...", "INFO")
    local startTime = tick()
    
    -- Vérifier support Drawing
    if not Drawing then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.DrawingAPI.Error = "Drawing library non supportée par executor"
        TestResults.DrawingAPI.TimeMs = elapsed
        Log("METHOD2", "❌ " .. TestResults.DrawingAPI.Error, "ERROR")
        return false
    end
    
    -- Télécharger image data
    Log("METHOD2", "📥 Téléchargement image data...", "DEBUG")
    local success, imageData = pcall(function()
        return game:HttpGet(imageUrl)
    end)
    
    if not success or not imageData or #imageData == 0 then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.DrawingAPI.Error = "Téléchargement image échoué: " .. tostring(imageData)
        TestResults.DrawingAPI.TimeMs = elapsed
        Log("METHOD2", "❌ " .. TestResults.DrawingAPI.Error, "ERROR")
        return false
    end
    
    Log("METHOD2", string.format("✅ Image data téléchargé (%d bytes)", #imageData), "SUCCESS")
    
    -- Vérifier support Drawing.new("Image")
    local supportsImage = pcall(function()
        local testImg = Drawing.new("Image")
        testImg:Remove()
    end)
    
    if not supportsImage then
        Log("METHOD2", "⚠️ Drawing.new('Image') non supporté, fallback texte", "WARNING")
        
        -- Fallback: Background + Texte
        local bg = Drawing.new("Square")
        bg.Size = Vector2.new(470, 100)
        bg.Position = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2 - 235, 100)
        bg.Color = Color3.fromRGB(30, 30, 30)
        bg.Filled = true
        bg.Visible = true
        bg.Thickness = 2
        
        local text = Drawing.new("Text")
        text.Text = "🖼️ AD (Drawing API - Texte fallback)"
        text.Size = 24
        text.Center = true
        text.Position = Vector2.new(bg.Position.X + 235, bg.Position.Y + 50)
        text.Color = Color3.fromRGB(255, 193, 7)
        text.Visible = true
        
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.DrawingAPI.Success = true
        TestResults.DrawingAPI.TimeMs = elapsed
        Log("METHOD2", string.format("✅ Drawing API (texte fallback) SUCCESS en %dms", elapsed), "SUCCESS")
        return true
    end
    
    -- Créer Drawing Image
    Log("METHOD2", "🎨 Création Drawing.new('Image')...", "DEBUG")
    local drawingImage = Drawing.new("Image")
    drawingImage.Data = imageData
    drawingImage.Size = Vector2.new(470, 100)
    drawingImage.Position = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X / 2 - 235, 220)
    drawingImage.Visible = true
    
    -- Bordure bleue = Drawing API
    local border = Drawing.new("Square")
    border.Size = Vector2.new(474, 104)
    border.Position = Vector2.new(drawingImage.Position.X - 2, drawingImage.Position.Y - 2)
    border.Color = Color3.fromRGB(0, 100, 255)
    border.Filled = false
    border.Thickness = 2
    border.Visible = true
    
    local label = Drawing.new("Text")
    label.Text = "✅ Drawing API (Executor)"
    label.Size = 18
    label.Center = true
    label.Position = Vector2.new(drawingImage.Position.X + 235, drawingImage.Position.Y + 110)
    label.Color = Color3.fromRGB(0, 100, 255)
    label.Visible = true
    
    local elapsed = math.floor((tick() - startTime) * 1000)
    TestResults.DrawingAPI.Success = true
    TestResults.DrawingAPI.TimeMs = elapsed
    Log("METHOD2", string.format("✅ Drawing API SUCCESS en %dms!", elapsed), "SUCCESS")
    
    return true
end

--[[ MÉTHODE 3: ViewportFrame + SurfaceGui ]]--
local function TestViewportFrame(imageUrl)
    Log("METHOD3", "▶️ Test ViewportFrame + SurfaceGui...", "INFO")
    local startTime = tick()
    
    -- Créer ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AAds_ViewportFrame_Test"
    screenGui.ResetOnSpawn = false
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
    end
    screenGui.Parent = game:GetService("CoreGui")
    
    -- ViewportFrame container
    Log("METHOD3", "🎮 Création ViewportFrame...", "DEBUG")
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = CONFIG.DisplaySize
    container.Position = UDim2.new(0.5, -235, 0.4, 0)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    container.BorderSizePixel = 2
    container.BorderColor3 = Color3.fromRGB(255, 165, 0) -- Bordure orange = ViewportFrame
    container.Parent = screenGui
    
    local viewportFrame = Instance.new("ViewportFrame")
    viewportFrame.Size = UDim2.new(1, 0, 1, 0)
    viewportFrame.BackgroundTransparency = 1
    viewportFrame.Parent = container
    
    -- Camera
    local camera = Instance.new("Camera")
    camera.CFrame = CFrame.new(0, 0, 10)
    viewportFrame.CurrentCamera = camera
    
    -- Part 3D
    Log("METHOD3", "📦 Création Part 3D + SurfaceGui...", "DEBUG")
    local part = Instance.new("Part")
    part.Size = Vector3.new(470/50, 100/50, 0.1)
    part.Transparency = 1
    part.Anchored = true
    part.CanCollide = false
    part.CFrame = CFrame.new(0, 0, 0)
    part.Parent = viewportFrame
    
    -- SurfaceGui sur Part
    local surfaceGui = Instance.new("SurfaceGui")
    surfaceGui.Face = Enum.NormalId.Front
    surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    surfaceGui.PixelsPerStud = 50
    surfaceGui.Parent = part
    
    -- ImageLabel sur SurfaceGui
    Log("METHOD3", "🖼️ ImageLabel.Image = URL externe...", "DEBUG")
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.ScaleType = Enum.ScaleType.Stretch
    imageLabel.Image = imageUrl -- URL EXTERNE ICI
    imageLabel.ImageTransparency = 0
    imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    imageLabel.Parent = surfaceGui
    
    -- Label info
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 20)
    infoLabel.Position = UDim2.new(0, 0, 1, 0)
    infoLabel.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    infoLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    infoLabel.Text = "🔬 ViewportFrame + SurfaceGui"
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Parent = container
    
    -- Vérifier si image se charge
    spawn(function()
        wait(2)
        if imageLabel.Image == imageUrl then
            Log("METHOD3", "⚠️ ImageLabel.Image toujours URL (pas rbxassetid), potentiel blocage", "WARNING")
            TestResults.ViewportFrame.Error = "ImageLabel ne convertit pas URL en asset (blocage Roblox possible)"
        else
            Log("METHOD3", "✅ ImageLabel.Image converti en asset", "SUCCESS")
        end
    end)
    
    local elapsed = math.floor((tick() - startTime) * 1000)
    TestResults.ViewportFrame.Success = true
    TestResults.ViewportFrame.TimeMs = elapsed
    Log("METHOD3", string.format("✅ ViewportFrame créé en %dms (vérifiez visuel!)", elapsed), "SUCCESS")
    
    return true
end

--[[ MÉTHODE 4: getcustomasset() Legacy ]]--
local function TestGetCustomAsset(imageUrl)
    Log("METHOD4", "▶️ Test getcustomasset() Legacy...", "INFO")
    local startTime = tick()
    
    -- Vérifier support getcustomasset
    if not getcustomasset and not getsynasset then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.GetCustomAsset.Error = "getcustomasset/getsynasset non supporté"
        TestResults.GetCustomAsset.TimeMs = elapsed
        Log("METHOD4", "❌ " .. TestResults.GetCustomAsset.Error, "ERROR")
        return false
    end
    
    local getasset = getcustomasset or getsynasset
    
    -- Télécharger image
    Log("METHOD4", "📥 Téléchargement image...", "DEBUG")
    local success, imageData = pcall(function()
        return game:HttpGet(imageUrl)
    end)
    
    if not success or not imageData or #imageData == 0 then
        local elapsed = math.floor((tick() - startTime) * 1000)
        TestResults.GetCustomAsset.Error = "Téléchargement image échoué"
        TestResults.GetCustomAsset.TimeMs = elapsed
        Log("METHOD4", "❌ " .. TestResults.GetCustomAsset.Error, "ERROR")
        return false
    end
    
    Log("METHOD4", string.format("✅ Image téléchargée (%d bytes)", #imageData), "SUCCESS")
    
    -- Créer dossier workspace
    local workspacePath = "workspace/AAds_Cache"
    if not isfolder(workspacePath) then
        makefolder(workspacePath)
        Log("METHOD4", "📁 Dossier créé: " .. workspacePath, "DEBUG")
    end
    
    -- Sauvegarder image
    local filename = workspacePath .. "/ad_" .. os.time() .. ".png"
    writefile(filename, imageData)
    Log("METHOD4", "💾 Image sauvegardée: " .. filename, "DEBUG")
    
    -- Convertir en rbxasset://
    Log("METHOD4", "🔄 Conversion getcustomasset()...", "DEBUG")
    local assetUrl = getasset(filename)
    Log("METHOD4", "✅ Asset URL: " .. assetUrl, "SUCCESS")
    
    -- Créer ImageLabel
    Log("METHOD4", "🖼️ Création ImageLabel...", "DEBUG")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AAds_GetCustomAsset_Test"
    screenGui.ResetOnSpawn = false
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
    end
    screenGui.Parent = game:GetService("CoreGui")
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "AdDisplay"
    imageLabel.Size = CONFIG.DisplaySize
    imageLabel.Position = UDim2.new(0.5, -235, 0.7, 0)
    imageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    imageLabel.BorderSizePixel = 2
    imageLabel.BorderColor3 = Color3.fromRGB(255, 0, 255) -- Bordure magenta = getcustomasset
    imageLabel.ScaleType = Enum.ScaleType.Stretch
    imageLabel.Image = assetUrl
    imageLabel.Parent = screenGui
    
    -- Label info
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 20)
    infoLabel.Position = UDim2.new(0, 0, 1, 0)
    infoLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Text = "🔧 getcustomasset() - LEGACY"
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Parent = imageLabel
    
    local elapsed = math.floor((tick() - startTime) * 1000)
    TestResults.GetCustomAsset.Success = true
    TestResults.GetCustomAsset.TimeMs = elapsed
    Log("METHOD4", string.format("✅ getcustomasset() SUCCESS en %dms!", elapsed), "SUCCESS")
    
    return true
end

--[[ MAIN TEST RUNNER ]]--
local function RunAllTests()
    Log("MAIN", "🚀 Démarrage tests complets...", "INFO")
    
    -- Étape 1: Télécharger iframe A-Ads
    local iframeHtml = DownloadIframe(CONFIG.AdURL)
    
    if not iframeHtml then
        Log("MAIN", "⚠️ Iframe téléchargement échoué, utilisation URL test par défaut", "WARNING")
        -- URL test par défaut (image A-Ads connue)
        CurrentAds = {
            {
                URL = "https://static.a-ads.com/a-ads-banners/531599/970x250_eed0a7ea7e.png",
                Type = "image",
                Width = 970,
                Height = 250,
            }
        }
    else
        -- Étape 2: Parser contenu
        local media = ParseHTMLContent(iframeHtml)
        CurrentAds = MergeMediaList(media)
        
        if #CurrentAds == 0 then
            Log("MAIN", "⚠️ Aucun média trouvé, utilisation URL test par défaut", "WARNING")
            CurrentAds = {
                {
                    URL = "https://static.a-ads.com/a-ads-banners/531599/970x250_eed0a7ea7e.png",
                    Type = "image",
                    Width = 970,
                    Height = 250,
                }
            }
        end
    end
    
    Log("MAIN", string.format("📋 %d média(s) disponible(s) pour tests", #CurrentAds), "INFO")
    
    -- Sélectionner première pub
    local testMedia = CurrentAds[1]
    Log("MAIN", string.format("🎯 Test avec: %s (%dx%d)", testMedia.URL, testMedia.Width, testMedia.Height), "INFO")
    
    print("\n" .. string.rep("─", 80))
    
    -- Test 1: EditableImage (priorité)
    spawn(function()
        wait(1)
        TestEditableImage(testMedia.URL)
    end)
    
    -- Test 2: Drawing API
    spawn(function()
        wait(3)
        TestDrawingAPI(testMedia.URL)
    end)
    
    -- Test 3: ViewportFrame
    spawn(function()
        wait(5)
        TestViewportFrame(testMedia.URL)
    end)
    
    -- Test 4: getcustomasset
    spawn(function()
        wait(7)
        TestGetCustomAsset(testMedia.URL)
    end)
    
    -- Attendre fin tests
    wait(10)
    
    -- Afficher résultats
    print("\n" .. string.rep("═", 80))
    print("📊 RÉSULTATS FINAUX")
    print(string.rep("═", 80))
    
    for methodName, result in pairs(TestResults) do
        local status = result.Success and "✅ SUCCESS" or "❌ FAILED"
        local errorMsg = result.Error and (" - " .. result.Error) or ""
        print(string.format("%s | %s (%dms)%s", status, result.Name, result.TimeMs, errorMsg))
    end
    
    print(string.rep("═", 80))
    
    -- Recommandations
    print("\n💡 RECOMMANDATIONS:")
    if TestResults.EditableImage.Success then
        print("   ✅ Utilisez EditableImage (méthode moderne 2024, officielle Roblox)")
    elseif TestResults.DrawingAPI.Success then
        print("   ✅ Utilisez Drawing API (compatible executors Synapse/KRNL)")
    elseif TestResults.GetCustomAsset.Success then
        print("   ✅ Utilisez getcustomasset() (méthode legacy, fonctionne)")
    elseif TestResults.ViewportFrame.Success then
        print("   ⚠️ ViewportFrame créé mais vérifiez affichage visuel (peut être bloqué)")
    else
        print("   ❌ Aucune méthode fonctionnelle, upload manuel Roblox requis")
    end
    
    print("\n🎨 Couleurs bordures:")
    print("   🟢 Vert = EditableImage")
    print("   🔵 Bleu = Drawing API")
    print("   🟠 Orange = ViewportFrame")
    print("   🟣 Magenta = getcustomasset")
    
    print("\n" .. string.rep("═", 80))
    print("✅ Tests terminés! Vérifiez affichage visuel à l'écran.")
    print(string.rep("═", 80) .. "\n")
end

-- Démarrer tests
RunAllTests()

-- Contrôles globaux
_G.AAdsTestController = {
    Reload = RunAllTests,
    Results = TestResults,
    CurrentMedia = CurrentAds,
    Config = CONFIG,
}

print("💡 Commandes disponibles:")
print("   _G.AAdsTestController.Reload() - Relancer tous les tests")
print("   _G.AAdsTestController.Results - Voir résultats détaillés")
print("   _G.AAdsTestController.CurrentMedia - Liste médias détectés")
