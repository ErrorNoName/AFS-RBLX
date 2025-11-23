--[[
═══════════════════════════════════════════════════════════════════════
    A-ADS SYSTÈME FINAL - getcustomasset()
    
    ✅ Rotation automatique publicités
    ✅ Click pour ouvrir lien pub
    ✅ Adaptation taille automatique suivant image
    ✅ Impossible à fermer (publicité persistante)
    ✅ Flèche pour changer position (4 coins écran)
    ✅ Toujours visible, jamais hors écran
    
    URL: //acceptable.a-ads.com/2417103/?size=Adaptive
═══════════════════════════════════════════════════════════════════════
--]]

print("\n" .. string.rep("═", 80))
print("🎯 A-ADS SYSTÈME FINAL v1.0 - getcustomasset()")
print(string.rep("═", 80))

--[[ CONFIGURATION ]]--
local CONFIG = {
    AdURL = "//acceptable.a-ads.com/2417103/?size=Adaptive",
    RotationInterval = 15, -- Secondes entre changement pubs
    DefaultPosition = "TopRight", -- TopLeft, TopRight, BottomLeft, BottomRight
    Padding = 10, -- Pixels entre bord écran et pub
    
    -- Pubs par défaut (fallback si téléchargement échoue)
    DefaultAds = {
        {
            URL = "https://static.a-ads.com/a-ads-banners/531599/970x250_eed0a7ea7e.png",
            Width = 970,
            Height = 250,
            Link = "https://a-ads.com",
        },
        {
            URL = "https://static.a-ads.com/a-ads-banners/531599/728x90_eed0a7ea7e.png",
            Width = 728,
            Height = 90,
            Link = "https://a-ads.com",
        },
        {
            URL = "https://static.a-ads.com/a-ads-banners/531599/468x60_eed0a7ea7e.png",
            Width = 468,
            Height = 60,
            Link = "https://a-ads.com",
        },
    },
}

--[[ SERVICES ]]--
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

--[[ VARIABLES GLOBALES ]]--
local Player = Players.LocalPlayer
local AdsList = {}
local CurrentAdIndex = 1
local CurrentPosition = CONFIG.DefaultPosition
local RotationEnabled = true
local MainGui = nil
local AdContainer = nil
local AdImageLabel = nil
local PositionButton = nil

local Stats = {
    TotalViews = 0,
    TotalClicks = 0,
    StartTime = os.time(),
}

--[[ UTILITAIRES ]]--
local getasset = getcustomasset or getsynasset

local function Log(message, level)
    level = level or "INFO"
    local prefix = {INFO = "ℹ️", SUCCESS = "✅", ERROR = "❌", WARNING = "⚠️", DEBUG = "🔍"}
    print(string.format("[A-ADS] %s %s", prefix[level] or "•", message))
end

-- Créer dossier cache
local CACHE_FOLDER = "workspace/AAds_Cache"
if not isfolder(CACHE_FOLDER) then
    makefolder(CACHE_FOLDER)
    Log("Dossier cache créé: " .. CACHE_FOLDER, "DEBUG")
end

--[[ CALCUL POSITIONS ]]--
local function CalculatePosition(adWidth, adHeight, position)
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local padding = CONFIG.Padding
    
    local positions = {
        TopLeft = UDim2.new(0, padding, 0, padding),
        TopRight = UDim2.new(1, -(adWidth + padding), 0, padding),
        BottomLeft = UDim2.new(0, padding, 1, -(adHeight + padding)),
        BottomRight = UDim2.new(1, -(adWidth + padding), 1, -(adHeight + padding)),
    }
    
    return positions[position] or positions.TopRight
end

--[[ TÉLÉCHARGEMENT IFRAME A-ADS ]]--
local function DownloadIframe()
    Log("Téléchargement iframe A-Ads...", "INFO")
    
    local fullUrl = "https:" .. CONFIG.AdURL
    local success, html = pcall(function()
        return game:HttpGet(fullUrl)
    end)
    
    if success and html then
        Log("✅ Iframe téléchargé (" .. #html .. " bytes)", "SUCCESS")
        return html
    else
        Log("❌ Téléchargement iframe échoué: " .. tostring(html), "ERROR")
        return nil
    end
end

--[[ EXTRACTION PUBLICITÉS HTML AMÉLIORÉE ]]--
local function ParseAds(html)
    Log("Parsing HTML pour extraction publicités...", "INFO")
    
    local ads = {}
    local processedUrls = {} -- Éviter doublons
    
    -- Pattern 1: <picture> avec <source> (RESPONSIVE - PRIORITÉ)
    Log("🔍 Recherche balises <picture>...", "DEBUG")
    for pictureBlock in html:gmatch('<picture[^>]*>(.-)</picture>') do
        -- Extraire toutes les sources
        local sources = {}
        
        for srcset in pictureBlock:gmatch('srcset=["\']([^"\']+)["\']') do
            local fullUrl = srcset:gsub("^//", "https://")
            
            -- Parser URL pour extraire dimensions
            -- Format: https://static.a-ads.com/a-ads-banners/531599/970x250?region=eu-central-1
            local width, height = fullUrl:match('/(%d+)x(%d+)')
            
            if width and height then
                table.insert(sources, {
                    URL = fullUrl,
                    Width = tonumber(width),
                    Height = tonumber(height),
                })
            end
        end
        
        -- Extraire aussi l'image principale <img> dans <picture>
        local mainSrc = pictureBlock:match('<img[^>]+src=["\']([^"\']+)["\']')
        if mainSrc then
            local fullUrl = mainSrc:gsub("^//", "https://")
            local width, height = fullUrl:match('/(%d+)x(%d+)')
            
            if width and height then
                table.insert(sources, {
                    URL = fullUrl,
                    Width = tonumber(width),
                    Height = tonumber(height),
                })
            end
        end
        
        -- Ajouter toutes les sources uniques trouvées
        for _, source in ipairs(sources) do
            if not processedUrls[source.URL] then
                processedUrls[source.URL] = true
                
                table.insert(ads, {
                    URL = source.URL,
                    Width = source.Width,
                    Height = source.Height,
                    Link = "https://a-ads.com", -- Sera mis à jour après
                })
                
                Log("📷 Source <picture>: " .. source.Width .. "x" .. source.Height, "DEBUG")
            end
        end
    end
    
    -- Pattern 2: <img src="..."> DIRECT (fallback)
    Log("🔍 Recherche balises <img> directes...", "DEBUG")
    for imgTag in html:gmatch('<img[^>]+>') do
        local src = imgTag:match('src=["\']([^"\']+)["\']')
        
        if src and not src:match('teaser%-advert%-logo') then -- Ignorer logos
            local fullUrl = src:gsub("^//", "https://")
            
            if not processedUrls[fullUrl] then
                -- Parser dimensions depuis URL ou attributs
                local width, height = fullUrl:match('/(%d+)x(%d+)')
                
                if not width then
                    -- Essayer extraire des attributs width/height
                    width = imgTag:match('width=["\'](%d+)["\']')
                    height = imgTag:match('height=["\'](%d+)["\']')
                end
                
                width = tonumber(width) or 468
                height = tonumber(height) or 60
                
                processedUrls[fullUrl] = true
                
                table.insert(ads, {
                    URL = fullUrl,
                    Width = width,
                    Height = height,
                    Link = "https://a-ads.com",
                })
                
                Log("📷 Image directe: " .. width .. "x" .. height, "DEBUG")
            end
        end
    end
    
    -- Pattern 3: Extraire liens <a href="..."> pour associer aux pubs
    Log("🔍 Recherche liens cliquables...", "DEBUG")
    local adLinks = {}
    for href in html:gmatch('<a[^>]+href=["\']([^"\']+)["\']') do
        if href:match("^http") and not href:match("a%-ads%.com") then
            table.insert(adLinks, href)
            Log("🔗 Lien trouvé: " .. href, "DEBUG")
        end
    end
    
    -- Associer premier lien à toutes les pubs (généralement même annonceur)
    if #adLinks > 0 then
        local mainLink = adLinks[1]
        for _, ad in ipairs(ads) do
            ad.Link = mainLink
        end
        Log("✅ Lien principal associé: " .. mainLink, "SUCCESS")
    end
    
    -- Filtrer pubs invalides (taille aberrante ou URL vide)
    local validAds = {}
    for _, ad in ipairs(ads) do
        if ad.Width > 0 and ad.Width <= 2000 and 
           ad.Height > 0 and ad.Height <= 1000 and
           ad.URL and #ad.URL > 0 then
            table.insert(validAds, ad)
        else
            Log("⚠️ Pub invalide ignorée: " .. (ad.URL or "NO_URL"), "WARNING")
        end
    end
    
    Log("✅ " .. #validAds .. " publicité(s) valide(s) extraite(s)", "SUCCESS")
    return validAds
end

--[[ TÉLÉCHARGEMENT IMAGE + CACHE + VALIDATION ]]--
local function DownloadAndCacheImage(imageUrl, adIndex)
    Log("Téléchargement image " .. adIndex .. ": " .. imageUrl, "DEBUG")
    
    -- Valider URL
    if not imageUrl or #imageUrl == 0 then
        Log("❌ URL vide/invalide", "ERROR")
        return nil
    end
    
    -- Ajouter ?region si manquant (fix A-Ads)
    if not imageUrl:match("%?region=") then
        imageUrl = imageUrl .. "?region=eu-central-1"
        Log("🔧 Ajout paramètre region: " .. imageUrl, "DEBUG")
    end
    
    local success, imageData = pcall(function()
        return game:HttpGet(imageUrl)
    end)
    
    if not success then
        Log("❌ Erreur HTTP: " .. tostring(imageData), "ERROR")
        return nil
    end
    
    -- Validation contenu
    if not imageData or #imageData == 0 then
        Log("❌ Image vide (0 bytes)", "ERROR")
        return nil
    end
    
    -- Vérifier si c'est vraiment une image (header PNG/JPEG)
    local isPNG = imageData:sub(1, 4) == "\137PNG"
    local isJPEG = imageData:sub(1, 2) == "\255\216"
    local isGIF = imageData:sub(1, 3) == "GIF"
    
    if not isPNG and not isJPEG and not isGIF then
        Log("❌ Format image invalide (pas PNG/JPEG/GIF)", "ERROR")
        Log("🔍 Header: " .. imageData:sub(1, 10):byte(1, 10), "DEBUG")
        
        -- Peut-être HTML d'erreur?
        if imageData:match("<html") or imageData:match("<!DOCTYPE") then
            Log("⚠️ Réponse HTML au lieu d'image (404 ou erreur serveur)", "WARNING")
        end
        
        return nil
    end
    
    Log("✅ Image téléchargée (" .. #imageData .. " bytes, " .. (isPNG and "PNG" or isJPEG and "JPEG" or "GIF") .. ")", "SUCCESS")
    
    -- Sauvegarder dans cache
    local extension = isPNG and ".png" or isJPEG and ".jpg" or ".gif"
    local filename = CACHE_FOLDER .. "/ad_" .. adIndex .. extension
    
    local writeSuccess = pcall(function()
        writefile(filename, imageData)
    end)
    
    if not writeSuccess then
        Log("❌ Erreur écriture fichier: " .. filename, "ERROR")
        return nil
    end
    
    Log("💾 Cache: " .. filename, "DEBUG")
    
    -- Convertir en rbxasset://
    local assetSuccess, assetUrl = pcall(function()
        return getasset(filename)
    end)
    
    if not assetSuccess or not assetUrl then
        Log("❌ Erreur getcustomasset: " .. tostring(assetUrl), "ERROR")
        return nil
    end
    
    Log("✅ Asset URL créé: " .. assetUrl, "SUCCESS")
    
    return assetUrl
end

--[[ AFFICHAGE PUBLICITÉ ]]--
local function DisplayAd(ad, assetUrl)
    if not AdImageLabel then return end
    
    Log("🖼️ Affichage pub " .. ad.Width .. "x" .. ad.Height, "INFO")
    
    -- Adapter taille
    AdContainer.Size = UDim2.new(0, ad.Width, 0, ad.Height)
    
    -- Calculer nouvelle position (rester dans même coin)
    AdContainer.Position = CalculatePosition(ad.Width, ad.Height, CurrentPosition)
    
    -- Afficher image
    AdImageLabel.Image = assetUrl
    AdImageLabel.Size = UDim2.new(1, 0, 1, 0)
    
    -- Stocker lien pour click
    AdImageLabel:SetAttribute("AdLink", ad.Link)
    
    -- Animation transition
    AdImageLabel.ImageTransparency = 1
    TweenService:Create(AdImageLabel, TweenInfo.new(0.5), {
        ImageTransparency = 0
    }):Play()
    
    Stats.TotalViews = Stats.TotalViews + 1
    Log("✅ Pub affichée (Views: " .. Stats.TotalViews .. ")", "SUCCESS")
end

--[[ ROTATION PUBLICITÉS AVEC RETRY ]]--
local function NextAd()
    if #AdsList == 0 then
        Log("⚠️ Aucune pub disponible", "WARNING")
        return
    end
    
    local maxRetries = #AdsList -- Essayer toutes les pubs au pire
    local retries = 0
    local assetUrl = nil
    
    while not assetUrl and retries < maxRetries do
        CurrentAdIndex = (CurrentAdIndex % #AdsList) + 1
        local ad = AdsList[CurrentAdIndex]
        
        Log("🔄 Tentative pub " .. CurrentAdIndex .. "/" .. #AdsList .. " (" .. ad.Width .. "x" .. ad.Height .. ")", "INFO")
        
        -- Télécharger et afficher
        assetUrl = DownloadAndCacheImage(ad.URL, CurrentAdIndex)
        
        if assetUrl then
            DisplayAd(ad, assetUrl)
            Log("✅ Pub " .. CurrentAdIndex .. " affichée avec succès", "SUCCESS")
            return true
        else
            Log("⚠️ Pub " .. CurrentAdIndex .. " échouée, essai suivante...", "WARNING")
            retries = retries + 1
        end
    end
    
    -- Si toutes les pubs échouent
    if not assetUrl then
        Log("❌ ERREUR: Toutes les pubs ont échoué!", "ERROR")
        Log("💡 Tentative chargement pub par défaut...", "INFO")
        
        -- Essayer pubs par défaut en dernier recours
        for i, defaultAd in ipairs(CONFIG.DefaultAds) do
            local fallbackUrl = DownloadAndCacheImage(defaultAd.URL, "fallback_" .. i)
            if fallbackUrl then
                DisplayAd(defaultAd, fallbackUrl)
                Log("✅ Pub par défaut affichée", "SUCCESS")
                return true
            end
        end
        
        Log("❌ Impossible d'afficher une publicité", "ERROR")
        return false
    end
end

--[[ CHANGEMENT POSITION ]]--
local function ChangePosition()
    local positions = {"TopLeft", "TopRight", "BottomLeft", "BottomRight"}
    local currentIndex = table.find(positions, CurrentPosition) or 2
    local nextIndex = (currentIndex % #positions) + 1
    
    CurrentPosition = positions[nextIndex]
    
    Log("📍 Position changée: " .. CurrentPosition, "INFO")
    
    -- Animer déplacement
    if AdContainer then
        local currentAd = AdsList[CurrentAdIndex]
        local newPosition = CalculatePosition(currentAd.Width, currentAd.Height, CurrentPosition)
        
        TweenService:Create(AdContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = newPosition
        }):Play()
        
        -- Repositionner bouton flèche
        UpdatePositionButtonLocation()
    end
end

--[[ UPDATE BOUTON POSITION ]]--
function UpdatePositionButtonLocation()
    if not PositionButton or not AdContainer then return end
    
    -- Placer bouton opposé au coin actuel
    local buttonPositions = {
        TopLeft = UDim2.new(1, 5, 0, 0), -- Droite
        TopRight = UDim2.new(0, -25, 0, 0), -- Gauche
        BottomLeft = UDim2.new(1, 5, 1, -20), -- Droite bas
        BottomRight = UDim2.new(0, -25, 1, -20), -- Gauche bas
    }
    
    PositionButton.Position = buttonPositions[CurrentPosition] or UDim2.new(1, 5, 0, 0)
end

--[[ CRÉATION INTERFACE ]]--
local function CreateUI()
    Log("🎨 Création interface...", "INFO")
    
    -- ScreenGui principal
    MainGui = Instance.new("ScreenGui")
    MainGui.Name = "AAds_Final_System"
    MainGui.ResetOnSpawn = false
    MainGui.DisplayOrder = 999999999 -- Toujours au-dessus
    MainGui.IgnoreGuiInset = true
    
    -- Protection executor
    if syn and syn.protect_gui then
        syn.protect_gui(MainGui)
    end
    
    MainGui.Parent = game:GetService("CoreGui")
    
    -- Container pub (taille adaptative)
    AdContainer = Instance.new("Frame")
    AdContainer.Name = "AdContainer"
    AdContainer.Size = UDim2.new(0, 468, 0, 60) -- Taille initiale
    AdContainer.Position = CalculatePosition(468, 60, CurrentPosition)
    AdContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    AdContainer.BorderSizePixel = 0
    AdContainer.Parent = MainGui
    
    -- ImageLabel pub
    AdImageLabel = Instance.new("ImageLabel")
    AdImageLabel.Name = "AdImage"
    AdImageLabel.Size = UDim2.new(1, 0, 1, 0)
    AdImageLabel.Position = UDim2.new(0, 0, 0, 0)
    AdImageLabel.BackgroundTransparency = 1
    AdImageLabel.ScaleType = Enum.ScaleType.Stretch
    AdImageLabel.Parent = AdContainer
    
    -- Bouton invisible pour click
    local clickButton = Instance.new("TextButton")
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Position = UDim2.new(0, 0, 0, 0)
    clickButton.BackgroundTransparency = 1
    clickButton.Text = ""
    clickButton.Parent = AdImageLabel
    
    clickButton.MouseButton1Click:Connect(function()
        local adLink = AdImageLabel:GetAttribute("AdLink")
        if adLink then
            setclipboard(adLink)
            Stats.TotalClicks = Stats.TotalClicks + 1
            Log("🔗 Lien copié: " .. adLink, "SUCCESS")
            
            -- Feedback visuel
            local feedback = Instance.new("TextLabel")
            feedback.Size = UDim2.new(1, 0, 1, 0)
            feedback.Position = UDim2.new(0, 0, 0, 0)
            feedback.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            feedback.BackgroundTransparency = 0.5
            feedback.Text = "✅ LIEN COPIÉ!\nCollé dans navigateur"
            feedback.TextColor3 = Color3.fromRGB(255, 255, 255)
            feedback.TextSize = 24
            feedback.Font = Enum.Font.GothamBold
            feedback.TextWrapped = true
            feedback.Parent = AdImageLabel
            
            wait(2)
            feedback:Destroy()
        end
    end)
    
    -- Bouton changement position (flèche)
    PositionButton = Instance.new("TextButton")
    PositionButton.Name = "PositionButton"
    PositionButton.Size = UDim2.new(0, 20, 0, 20)
    PositionButton.Position = UDim2.new(1, 5, 0, 0) -- Initialement à droite
    PositionButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
    PositionButton.BorderSizePixel = 0
    PositionButton.Text = "↔️"
    PositionButton.TextSize = 14
    PositionButton.Font = Enum.Font.GothamBold
    PositionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    PositionButton.Parent = AdContainer
    
    -- Corner arrondi bouton
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = PositionButton
    
    PositionButton.MouseButton1Click:Connect(function()
        ChangePosition()
    end)
    
    -- Hover effect bouton
    PositionButton.MouseEnter:Connect(function()
        TweenService:Create(PositionButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 220, 100)
        }):Play()
    end)
    
    PositionButton.MouseLeave:Connect(function()
        TweenService:Create(PositionButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 193, 7)
        }):Play()
    end)
    
    -- Tooltip position
    local tooltip = Instance.new("TextLabel")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(0, 120, 0, 30)
    tooltip.Position = UDim2.new(0, -125, 0, -5)
    tooltip.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tooltip.BackgroundTransparency = 0.2
    tooltip.BorderSizePixel = 0
    tooltip.Text = "📍 Changer position"
    tooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
    tooltip.TextSize = 12
    tooltip.Font = Enum.Font.Gotham
    tooltip.TextWrapped = true
    tooltip.Visible = false
    tooltip.Parent = PositionButton
    
    local tooltipCorner = Instance.new("UICorner")
    tooltipCorner.CornerRadius = UDim.new(0, 4)
    tooltipCorner.Parent = tooltip
    
    PositionButton.MouseEnter:Connect(function()
        tooltip.Visible = true
    end)
    
    PositionButton.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)
    
    Log("✅ Interface créée", "SUCCESS")
    
    -- Adapter position initiale bouton
    UpdatePositionButtonLocation()
end

--[[ AUTO-AJUSTEMENT SI RESIZE ÉCRAN ]]--
local function MonitorScreenResize()
    local lastViewportSize = workspace.CurrentCamera.ViewportSize
    
    RunService.RenderStepped:Connect(function()
        local currentViewportSize = workspace.CurrentCamera.ViewportSize
        
        if currentViewportSize ~= lastViewportSize then
            lastViewportSize = currentViewportSize
            
            -- Recalculer position pour rester dans écran
            if AdContainer and AdsList[CurrentAdIndex] then
                local ad = AdsList[CurrentAdIndex]
                AdContainer.Position = CalculatePosition(ad.Width, ad.Height, CurrentPosition)
                UpdatePositionButtonLocation()
                Log("🔄 Position adaptée au resize écran", "DEBUG")
            end
        end
    end)
end

--[[ ROTATION AUTOMATIQUE ]]--
local function StartRotation()
    spawn(function()
        while RotationEnabled do
            wait(CONFIG.RotationInterval)
            
            if RotationEnabled and #AdsList > 1 then
                NextAd()
            end
        end
    end)
    
    Log("🔄 Rotation automatique démarrée (" .. CONFIG.RotationInterval .. "s)", "INFO")
end

--[[ INITIALISATION SYSTÈME ]]--
local function Initialize()
    Log("🚀 Initialisation système A-Ads...", "INFO")
    
    -- Télécharger iframe
    local html = DownloadIframe()
    
    if html then
        -- Parser publicités
        local extractedAds = ParseAds(html)
        
        if #extractedAds > 0 then
            AdsList = extractedAds
            Log("✅ " .. #AdsList .. " pub(s) chargée(s) depuis A-Ads", "SUCCESS")
        else
            Log("⚠️ Aucune pub extraite, utilisation pubs par défaut", "WARNING")
            AdsList = CONFIG.DefaultAds
        end
    else
        Log("⚠️ Iframe téléchargement échoué, utilisation pubs par défaut", "WARNING")
        AdsList = CONFIG.DefaultAds
    end
    
    -- Créer interface
    CreateUI()
    
    -- Afficher première pub
    NextAd()
    
    -- Démarrer rotation
    StartRotation()
    
    -- Monitorer resize écran
    MonitorScreenResize()
    
    print("\n" .. string.rep("═", 80))
    print("✅ SYSTÈME A-ADS DÉMARRÉ!")
    print(string.rep("═", 80))
    print("📊 Statistiques:")
    print("   • Publicités chargées: " .. #AdsList)
    print("   • Position initiale: " .. CurrentPosition)
    print("   • Rotation: " .. CONFIG.RotationInterval .. " secondes")
    print("")
    print("🎮 Contrôles:")
    print("   • 🖱️ Click pub → Copier lien (ouvrir navigateur)")
    print("   • ↔️ Bouton flèche → Changer position coin")
    print("   • 📍 Positions: TopLeft/TopRight/BottomLeft/BottomRight")
    print("")
    print("⚙️ Commandes console:")
    print("   _G.AAdsSystem.NextAd() - Pub suivante")
    print("   _G.AAdsSystem.ChangePosition() - Changer position")
    print("   _G.AAdsSystem.GetStats() - Voir statistiques")
    print("   _G.AAdsSystem.Destroy() - Arrêter système")
    print(string.rep("═", 80) .. "\n")
end

--[[ CONTRÔLES GLOBAUX ]]--
_G.AAdsSystem = {
    -- Pub suivante
    NextAd = function()
        NextAd()
        return "✅ Pub suivante affichée"
    end,
    
    -- Changer position
    ChangePosition = function()
        ChangePosition()
        return "✅ Position changée: " .. CurrentPosition
    end,
    
    -- Statistiques
    GetStats = function()
        local uptime = os.time() - Stats.StartTime
        return {
            TotalViews = Stats.TotalViews,
            TotalClicks = Stats.TotalClicks,
            CurrentAd = CurrentAdIndex .. "/" .. #AdsList,
            Position = CurrentPosition,
            Uptime = uptime .. " secondes",
            RotationEnabled = RotationEnabled,
        }
    end,
    
    -- Liste pubs
    ListAds = function()
        print("\n📋 Liste publicités:")
        for i, ad in ipairs(AdsList) do
            local marker = (i == CurrentAdIndex) and "→" or " "
            print(string.format("  %s %d. %dx%d - %s", marker, i, ad.Width, ad.Height, ad.URL))
        end
        return #AdsList .. " pub(s)"
    end,
    
    -- Pause/Resume rotation
    ToggleRotation = function()
        RotationEnabled = not RotationEnabled
        return RotationEnabled and "✅ Rotation activée" or "⏸️ Rotation pausée"
    end,
    
    -- Détruire système (si vraiment nécessaire)
    Destroy = function()
        RotationEnabled = false
        if MainGui then
            MainGui:Destroy()
        end
        _G.AAdsSystem = nil
        return "❌ Système A-Ads arrêté"
    end,
}

-- Démarrer
Initialize()
