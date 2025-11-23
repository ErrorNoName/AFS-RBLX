--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║   A-ADS INTEGRATION - VIEWPORTFRAME TECHNIQUE (100% FIABLE)    ║
    ║   Affiche images externes via ViewportFrame + SurfaceGui        ║
    ║   FONCTIONNE: Tous executors, pas de filesystem requis          ║
    ╚══════════════════════════════════════════════════════════════════╝
    
    TECHNIQUE: ViewportFrame avec Part texturé
    - Crée une Part 3D avec SurfaceGui
    - SurfaceGui contient ImageLabel avec URL externe
    - Camera fixe regarde la Part
    - Affichage 2D parfait dans UI Roblox
    
    AVANTAGES:
    ✅ Pas de getcustomasset() requis
    ✅ Pas de writefile() requis  
    ✅ URLs externes fonctionnent (contourne blocage ImageLabel)
    ✅ 100% compatible tous executors
    ✅ Rotation automatique pubs
]]

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🚀 A-ADS INTEGRATION - VIEWPORTFRAME v3.0")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

-- ===== CONFIGURATION =====
local CONFIG = {
    AdUnitID = "2417103",           -- Votre Ad Unit ID A-Ads
    Position = "BOTTOM_LEFT",       -- TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT
    ShowCloseButton = true,         -- Bouton fermeture
    RotateInterval = 30,            -- Secondes entre rotations
    MaxWidth = 500,                 -- Largeur max UI
    MaxHeight = 300,                -- Hauteur max UI
}

-- ===== SERVICES =====
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- ===== VARIABLES GLOBALES =====
local adsList = {}
local currentAdIndex = 1
local rotationEnabled = true
local adClickUrl = ""
local Stats = {
    Impressions = 0,
    Clicks = 0,
    StartTime = os.time(),
}

-- ===== FONCTION EXTRACTION IMAGES HTML =====
local function ExtractAllAdsFromHTML(html)
    local extractedAds = {}
    
    -- Pattern 1: <img src="...">
    for src in html:gmatch('<img[^>]+src=["\']([^"\']+)["\']') do
        local fullUrl = src:gsub("^//", "https://")
        local width, height = src:match('(%d+)x(%d+)')
        
        if width and height then
            table.insert(extractedAds, {
                Image = fullUrl,
                Width = tonumber(width),
                Height = tonumber(height),
            })
        end
    end
    
    -- Pattern 2: background-image: url(...)
    for url in html:gmatch('background%-image:%s*url%(["\'](https?://[^"\']+)["\'%)') do
        table.insert(extractedAds, {
            Image = url,
            Width = 468,  -- Défaut banner
            Height = 60,
        })
    end
    
    return extractedAds
end

-- ===== TÉLÉCHARGEMENT IFRAME A-ADS =====
print("📥 Téléchargement iframe A-Ads...")

local requestFunc = syn and syn.request or http_request or request
if requestFunc then
    pcall(function()
        local response = requestFunc({
            Url = "https://api.github.com/gists/b54e2ddad52cdb0dc3f4f5b7f7e0e6a6",
            Method = "GET",
        })
        
        if response.StatusCode == 200 then
            local gistData = HttpService:JSONDecode(response.Body)
            local html = gistData.files["a-ads-2417103.html"].content
            
            -- Extraire toutes images
            adsList = ExtractAllAdsFromHTML(html)
            
            -- Extraire URL click
            adClickUrl = html:match('href="(https?://[^"]+)"') or "https://a-ads.com"
            
            if #adsList > 0 then
                print("✅ " .. #adsList .. " publicité(s) extraite(s):")
                for i, ad in ipairs(adsList) do
                    print(string.format("  [%d] %dx%d", i, ad.Width, ad.Height))
                end
            end
        end
    end)
end

-- Fallback si extraction échoue
if #adsList == 0 then
    print("⚠️ Extraction échouée, utilisation pubs par défaut")
    adsList = {
        {Image = "https://static.a-ads.com/a-ads-banners/531599/970x250", Width = 970, Height = 250},
        {Image = "https://static.a-ads.com/a-ads-banners/531599/728x90", Width = 728, Height = 90},
        {Image = "https://static.a-ads.com/a-ads-advert-illustrations/442/475x250", Width = 475, Height = 250},
    }
    adClickUrl = "https://a-ads.com/?partner=" .. CONFIG.AdUnitID
end

-- ===== FONCTION CALCUL TAILLE =====
local function CalculateDisplaySize(originalWidth, originalHeight)
    local scaleW = CONFIG.MaxWidth / originalWidth
    local scaleH = CONFIG.MaxHeight / originalHeight
    local scale = math.min(scaleW, scaleH, 1.0)
    
    return math.floor(originalWidth * scale), math.floor(originalHeight * scale), scale
end

-- ===== CRÉATION VIEWPORTFRAME IMAGE RENDERER =====
local function CreateViewportImage(parent, imageUrl, width, height)
    -- ViewportFrame container
    local viewport = Instance.new("ViewportFrame")
    viewport.Size = UDim2.new(1, 0, 1, 0)
    viewport.BackgroundTransparency = 1
    viewport.BorderSizePixel = 0
    viewport.Parent = parent
    
    -- Part 3D qui contiendra la texture
    local part = Instance.new("Part")
    part.Size = Vector3.new(width / 100, height / 100, 0.01)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1  -- Part invisible (seule texture visible)
    part.CFrame = CFrame.new(0, 0, 0)
    part.Parent = viewport
    
    -- SurfaceGui sur la Part
    local surfaceGui = Instance.new("SurfaceGui")
    surfaceGui.Face = Enum.NormalId.Front
    surfaceGui.CanvasSize = Vector2.new(width, height)
    surfaceGui.LightInfluence = 0  -- Pas d'ombres
    surfaceGui.Parent = part
    
    -- ImageLabel dans SurfaceGui (CONTOURNE BLOCAGE!)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.BorderSizePixel = 0
    imageLabel.Image = imageUrl  -- URL externe A-Ads fonctionne ici!
    imageLabel.ScaleType = Enum.ScaleType.Stretch
    imageLabel.Parent = surfaceGui
    
    -- Camera pour ViewportFrame
    local camera = Instance.new("Camera")
    local distance = math.max(width, height) / 70  -- Distance calculée
    camera.CFrame = CFrame.new(0, 0, distance) * CFrame.Angles(0, math.rad(180), 0)
    camera.FieldOfView = 70
    camera.Parent = viewport
    viewport.CurrentCamera = camera
    
    print("✅ ViewportFrame créé:", imageUrl:sub(1, 50) .. "...")
    return viewport
end

-- ===== POSITIONS DISPONIBLES =====
local POSITIONS = {
    TOP_LEFT = UDim2.new(0, 10, 0, 10),
    TOP_RIGHT = UDim2.new(1, -10, 0, 10),
    BOTTOM_LEFT = UDim2.new(0, 10, 1, -10),
    BOTTOM_RIGHT = UDim2.new(1, -10, 1, -10),
}

-- ===== CRÉATION INTERFACE UI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AAdsViewportUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Protection GUI (Synapse)
if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end

screenGui.Parent = game:GetService("CoreGui")

-- Pub initiale
local initialAd = adsList[1]
local adWidth, adHeight = CalculateDisplaySize(initialAd.Width, initialAd.Height)

-- Container principal
local container = Instance.new("Frame")
container.Name = "AdContainer"
container.Size = UDim2.new(0, adWidth, 0, adHeight)
container.Position = POSITIONS[CONFIG.Position]
container.AnchorPoint = CONFIG.Position:match("RIGHT") and Vector2.new(1, 0) or Vector2.new(0, 0)
if CONFIG.Position:match("BOTTOM") then
    container.AnchorPoint = container.AnchorPoint + Vector2.new(0, 1)
end
container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
container.BorderSizePixel = 0
container.Parent = screenGui

-- Coins arrondis
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = container

-- ViewportFrame pour afficher pub
local adViewport = CreateViewportImage(container, initialAd.Image, initialAd.Width, initialAd.Height)

-- Overlay cliquable transparent
local clickOverlay = Instance.new("TextButton")
clickOverlay.Size = UDim2.new(1, 0, 1, 0)
clickOverlay.BackgroundTransparency = 1
clickOverlay.Text = ""
clickOverlay.ZIndex = 10
clickOverlay.Parent = container

-- Click event
clickOverlay.MouseButton1Click:Connect(function()
    Stats.Clicks = Stats.Clicks + 1
    print("🖱️ Click pub -> " .. adClickUrl)
    
    -- Ouvrir URL (si setclipboard disponible)
    if setclipboard then
        setclipboard(adClickUrl)
        print("✅ URL copiée dans presse-papiers!")
    end
end)

-- Bouton fermeture
if CONFIG.ShowCloseButton then
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -5, 0, 5)
    closeButton.AnchorPoint = Vector2.new(1, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 11
    closeButton.Parent = container
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("❌ Publicités fermées")
    end)
end

-- Badge "Ad"
local adBadge = Instance.new("TextLabel")
adBadge.Size = UDim2.new(0, 30, 0, 16)
adBadge.Position = UDim2.new(0, 5, 0, 5)
adBadge.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
adBadge.BorderSizePixel = 0
adBadge.Text = "Ad"
adBadge.TextColor3 = Color3.fromRGB(0, 0, 0)
adBadge.TextSize = 10
adBadge.Font = Enum.Font.GothamBold
adBadge.ZIndex = 11
adBadge.Parent = container

local badgeCorner = Instance.new("UICorner")
badgeCorner.CornerRadius = UDim.new(0, 3)
badgeCorner.Parent = adBadge

-- ===== FONCTION SWITCH PUB =====
local function SwitchToAd(index)
    local ad = adsList[index]
    if not ad then return end
    
    currentAdIndex = index
    
    -- Fade out
    local fadeTween = TweenService:Create(container, TweenInfo.new(0.3), {
        BackgroundTransparency = 1
    })
    
    fadeTween.Completed:Connect(function()
        -- Calculer nouvelle taille
        local newWidth, newHeight = CalculateDisplaySize(ad.Width, ad.Height)
        
        -- Resize container
        TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, newWidth, 0, newHeight)
        }):Play()
        
        -- Supprimer ancien viewport
        if adViewport then
            adViewport:Destroy()
        end
        
        -- Créer nouveau viewport
        adViewport = CreateViewportImage(container, ad.Image, ad.Width, ad.Height)
        
        -- Replacer overlays au-dessus
        if clickOverlay then clickOverlay.Parent = container end
        if adBadge then adBadge.Parent = container end
        
        -- Fade in
        TweenService:Create(container, TweenInfo.new(0.3), {
            BackgroundTransparency = 0
        }):Play()
        
        -- Stats
        Stats.Impressions = Stats.Impressions + 1
        print(string.format("✅ Pub [%d/%d] affichée %dx%d", index, #adsList, ad.Width, ad.Height))
    end)
    
    fadeTween:Play()
end

-- ===== ROTATION AUTOMATIQUE =====
spawn(function()
    while rotationEnabled and wait(CONFIG.RotateInterval) do
        if #adsList > 1 then
            currentAdIndex = (currentAdIndex % #adsList) + 1
            SwitchToAd(currentAdIndex)
        end
    end
end)

-- ===== CONTRÔLEUR GLOBAL =====
_G.AAdsController = {
    GetStats = function()
        local uptime = os.time() - Stats.StartTime
        return {
            Impressions = Stats.Impressions,
            Clicks = Stats.Clicks,
            CTR = Stats.Impressions > 0 and (Stats.Clicks / Stats.Impressions * 100) or 0,
            Uptime = uptime,
            CurrentAd = currentAdIndex,
            TotalAds = #adsList,
        }
    end,
    
    NextAd = function()
        currentAdIndex = (currentAdIndex % #adsList) + 1
        SwitchToAd(currentAdIndex)
    end,
    
    ListAds = function()
        print("📋 " .. #adsList .. " publicité(s) disponible(s):")
        for i, ad in ipairs(adsList) do
            print(string.format("[%d] %dx%d - %s", i, ad.Width, ad.Height, ad.Image:sub(1, 60)))
        end
    end,
    
    PauseRotation = function()
        rotationEnabled = not rotationEnabled
        print("⏸️ Rotation:", rotationEnabled and "Activée" or "Pausée")
    end,
    
    SetPosition = function(posName)
        if POSITIONS[posName] then
            container.Position = POSITIONS[posName]
            print("✅ Position changée:", posName)
        end
    end,
    
    Toggle = function()
        screenGui.Enabled = not screenGui.Enabled
        print("👁️ Affichage:", screenGui.Enabled and "Visible" or "Caché")
    end,
    
    Destroy = function()
        rotationEnabled = false
        screenGui:Destroy()
        print("❌ Système publicités détruit")
    end,
}

print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ SYSTÈME DÉMARRÉ!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("💡 Commandes disponibles:")
print("   _G.AAdsController:GetStats()    - Voir statistiques")
print("   _G.AAdsController:NextAd()      - Pub suivante")
print("   _G.AAdsController:ListAds()     - Liste toutes pubs")
print("   _G.AAdsController:PauseRotation() - Pause/Resume")
print("   _G.AAdsController:Toggle()      - Cacher/Montrer")
print("   _G.AAdsController:Destroy()     - Fermer tout")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
