--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║     INTÉGRATION RAPIDE A-ADS (ID: 2417103)               ║
    ║     Copier ce code à la fin de votre script              ║
    ╚═══════════════════════════════════════════════════════════╝
]]

-- ⚙️ CONFIGURATION
local CONFIG = {
    AdUnitID = "2417103",           -- Votre Ad Unit A-Ads
    Position = "BOTTOM_LEFT",       -- TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT
    ShowCloseButton = true,         -- Bouton fermeture (X)
    CPM = 1.50,                     -- Estimation CPM pour tracking
    RotateInterval = 30,            -- Secondes entre chaque rotation pub
    MaxAdWidth = 970,               -- Largeur maximum (scaling)
    MaxAdHeight = 250,              -- Hauteur maximum (scaling)
    PreferredScale = 0.5,           -- Scale par défaut (50% taille originale)
}

-- 📊 TRACKING STATS
local Stats = {
    Impressions = 0,
    Clicks = 0,
    Revenue = 0,
    CurrentAdIndex = 1,
}

print("╔═══════════════════════════════════════════════════════╗")
print("║        Chargement publicités A-Ads...               ║")
print("╚═══════════════════════════════════════════════════════╝")

-- ===== SERVICES =====
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- ===== POSITIONS =====
local POSITIONS = {
    TOP_LEFT = UDim2.new(0, 10, 0, 10),
    TOP_RIGHT = UDim2.new(1, -210, 0, 10),
    BOTTOM_LEFT = UDim2.new(0, 10, 1, -110),
    BOTTOM_RIGHT = UDim2.new(1, -210, 1, -110),
}

-- ===== CHARGEMENT IMAGES PUBLICITÉS =====
local adsList = {} -- Pool de toutes les pubs trouvées
local currentAdIndex = 1

-- Fonction extraction TOUTES les images du HTML
local function ExtractAllAdsFromHTML(html)
    local ads = {}
    
    -- Pattern 1: <img> tags avec src A-Ads
    for src, alt in html:gmatch('<img[^>]+src="(//static%.a%-ads%.com/[^"]+)"[^>]*alt="([^"]*)"') do
        -- Extraire dimensions depuis URL (ex: 475x250, 970x250)
        local width, height = src:match("(%d+)x(%d+)")
        
        table.insert(ads, {
            Image = "https:" .. src, -- Ajouter https:
            Width = tonumber(width) or 468,
            Height = tonumber(height) or 60,
            Alt = alt,
        })
    end
    
    -- Pattern 2: <img> tags classiques
    for src in html:gmatch('<img[^>]+src="(https?://[^"]+%.[pngjifPNGJIF]+)"') do
        local width, height = src:match("(%d+)x(%d+)")
        
        table.insert(ads, {
            Image = src,
            Width = tonumber(width) or 468,
            Height = tonumber(height) or 60,
        })
    end
    
    -- Pattern 3: background-image CSS
    for url in html:gmatch('background%-image:%s*url%(["\'](https?://[^"\']+)["\']\)') do
        table.insert(ads, {
            Image = url,
            Width = 468,
            Height = 60,
        })
    end
    
    return ads
end

-- Requête HTTP pour récupérer les pubs
local success, result = pcall(function()
    local request = syn and syn.request or http_request or request
    if request then
        local iframeUrl = "https://acceptable.a-ads.com/" .. CONFIG.AdUnitID .. "/?size=Adaptive"
        
        print("🔄 Récupération pubs depuis:", iframeUrl)
        
        local response = request({
            Url = iframeUrl,
            Method = "GET",
        })
        
        if response.StatusCode == 200 then
            local html = response.Body
            
            -- Extraire TOUTES les images
            adsList = ExtractAllAdsFromHTML(html)
            
            if #adsList > 0 then
                print("✅ " .. #adsList .. " publicité(s) extraite(s):")
                for i, ad in ipairs(adsList) do
                    print(string.format("  [%d] %dx%d - %s", i, ad.Width, ad.Height, ad.Image:sub(1, 50) .. "..."))
                end
            else
                print("⚠️ Aucune image trouvée, fallback...")
            end
        end
    end
end)

-- Fallback: Créer pubs par défaut si extraction échoue
if #adsList == 0 then
    print("⚠️ Utilisation fallback URLs A-Ads standard")
    adsList = {
        {Image = "https://ad.a-ads.com/" .. CONFIG.AdUnitID .. ".png", Width = 468, Height = 60},
        {Image = "https://static.a-ads.com/a-ads-banners/" .. CONFIG.AdUnitID .. "/468x60", Width = 468, Height = 60},
        {Image = "https://static.a-ads.com/a-ads-banners/" .. CONFIG.AdUnitID .. "/728x90", Width = 728, Height = 90},
    }
end

-- Fonction calcul taille adaptée Roblox
local function CalculateAdaptedSize(originalWidth, originalHeight)
    local scale = CONFIG.PreferredScale
    
    -- Si trop grand, scale down
    if originalWidth > CONFIG.MaxAdWidth then
        scale = CONFIG.MaxAdWidth / originalWidth
    end
    
    if originalHeight > CONFIG.MaxAdHeight then
        local heightScale = CONFIG.MaxAdHeight / originalHeight
        scale = math.min(scale, heightScale)
    end
    
    local finalWidth = math.floor(originalWidth * scale)
    local finalHeight = math.floor(originalHeight * scale)
    
    return finalWidth, finalHeight
end

-- ===== FONCTION CHARGEMENT IMAGE (contourner blocage Roblox) =====
local function LoadImageSafe(imageUrl)
    -- Méthode 1: Essayer URL directe (Synapse/exploit moderne)
    local testUrl = imageUrl
    
    -- Si URL commence par //, ajouter https:
    if testUrl:sub(1, 2) == "//" then
        testUrl = "https:" .. testUrl
    end
    
    print("🖼️ Tentative chargement:", testUrl:sub(1, 60) .. "...")
    
    -- Méthode 2: Télécharger et sauver localement (si filesystem disponible)
    if writefile and readfile and isfile then
        local filename = "cache_ad_" .. CONFIG.AdUnitID .. ".png"  -- Nom simple
        
        -- Vérifier si déjà en cache
        if not isfile(filename) then
            print("📥 Téléchargement image en cache...")
            
            local success, imageData = pcall(function()
                local request = syn and syn.request or http_request or request
                if request then
                    local response = request({
                        Url = testUrl,
                        Method = "GET",
                    })
                    
                    if response.StatusCode == 200 then
                        return response.Body
                    end
                end
            end)
            
            if success and imageData then
                writefile(filename, imageData)
                print("✅ Image mise en cache:", filename)
            end
        else
            print("✅ Image trouvée en cache")
        end
        
        -- Retourner path local si existe
        if isfile(filename) then
            -- Note: getcustomasset() ou getsynasset() requis
            local assetFunc = getcustomasset or getsynasset
            
            if assetFunc then
                local success2, assetUrl = pcall(function()
                    return assetFunc(filename)
                end)
                
                if success2 and assetUrl then
                    print("✅ URL asset local:", assetUrl)
                    return assetUrl
                else
                    warn("⚠️ getcustomasset() erreur:", assetUrl)
                    print("💡 Essai méthode alternative...")
                end
            end
        end
    end
    
    -- Méthode 3: Pour A-Ads, essayer asset proxy
    if testUrl:match("a%-ads%.com") then
        local imageTest = pcall(function()
            return game:HttpGet(testUrl, true) -- true = binary mode
        end)
        
        if imageTest then
            print("✅ Image accessible via HttpGet")
        end
    end
    
    -- Fallback: Retourner URL quand même (certains executors gèrent)
    return testUrl
end

-- ===== CRÉATION INTERFACE =====

-- Calculer taille initiale
local initialAd = adsList[1]
local adWidth, adHeight = CalculateAdaptedSize(initialAd.Width, initialAd.Height)

print(string.format("📐 Taille adaptée: %dx%d → %dx%d (scale %.2f)", 
    initialAd.Width, initialAd.Height, adWidth, adHeight, CONFIG.PreferredScale))

-- Charger image de manière safe
local loadedImageUrl = LoadImageSafe(initialAd.Image)

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AAdsSystem_" .. CONFIG.AdUnitID
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end

screenGui.Parent = CoreGui

-- Container principal (taille dynamique)
local container = Instance.new("Frame")
container.Name = "AdContainer"
container.Size = UDim2.new(0, adWidth, 0, adHeight)
container.Position = POSITIONS[CONFIG.Position] or POSITIONS.BOTTOM_LEFT
container.BackgroundTransparency = 1
container.ZIndex = 10
container.Parent = screenGui

-- Border/Shadow (s'adapte au container)
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
border.BackgroundTransparency = 0.5
border.BorderSizePixel = 0
border.ZIndex = 9
border.Parent = container

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 8)
borderCorner.Parent = border

-- ImageButton (cliquable)
local adButton = Instance.new("ImageButton")
adButton.Name = "AdBanner"
adButton.Size = UDim2.new(1, 0, 1, 0)
adButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
adButton.BorderSizePixel = 0
adButton.ScaleType = Enum.ScaleType.Fit
adButton.ZIndex = 10
adButton.AutoButtonColor = false
adButton.Parent = container

-- ⚠️ IMPORTANT: Chargement asynchrone de l'image
spawn(function()
    local success, err = pcall(function()
        adButton.Image = loadedImageUrl
    end)
    
    if not success then
        warn("❌ Erreur chargement image:", err)
        warn("💡 L'image ne peut pas être chargée directement dans Roblox")
        warn("💡 Solutions:")
        warn("   1. Upload l'image sur Roblox Assets → rbxassetid://ID")
        warn("   2. Utiliser service proxy compatible Roblox")
        warn("   3. Utiliser Discord CDN (via webhook upload)")
        
        -- Afficher URL dans TextLabel à la place
        local urlLabel = Instance.new("TextLabel")
        urlLabel.Size = UDim2.new(1, -10, 1, -10)
        urlLabel.Position = UDim2.new(0, 5, 0, 5)
        urlLabel.BackgroundTransparency = 1
        urlLabel.Text = "🖼️ Image Pub\n\n" .. loadedImageUrl:sub(1, 50) .. "...\n\n⚠️ Roblox bloque URLs externes"
        urlLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        urlLabel.TextSize = 10
        urlLabel.Font = Enum.Font.Code
        urlLabel.TextWrapped = true
        urlLabel.TextYAlignment = Enum.TextYAlignment.Top
        urlLabel.ZIndex = 11
        urlLabel.Parent = adButton
    else
        print("✅ Image chargée dans UI")
    end
end)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = adButton

-- Label "Ad" (transparence pub)
local adLabel = Instance.new("TextLabel")
adLabel.Size = UDim2.new(0, 30, 0, 15)
adLabel.Position = UDim2.new(0, 5, 0, 5)
adLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
adLabel.BackgroundTransparency = 0.3
adLabel.Text = "Ad"
adLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
adLabel.TextSize = 10
adLabel.Font = Enum.Font.GothamBold
adLabel.ZIndex = 12
adLabel.BorderSizePixel = 0
adLabel.Parent = container

local adCorner = Instance.new("UICorner")
adCorner.CornerRadius = UDim.new(0, 4)
adCorner.Parent = adLabel

-- Bouton fermeture (optionnel)
if CONFIG.ShowCloseButton then
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -25, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.ZIndex = 12
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = container
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("📢 Publicités fermées")
    end)
end

-- ===== EVENTS =====

-- Fonction changer de publicité
local function SwitchToAd(index)
    if index < 1 or index > #adsList then return end
    
    local ad = adsList[index]
    currentAdIndex = index
    
    -- Calculer nouvelle taille
    local newWidth, newHeight = CalculateAdaptedSize(ad.Width, ad.Height)
    
    -- Animation transition
    local fadeTween = TweenService:Create(adButton, TweenInfo.new(0.3), {
        ImageTransparency = 1
    })
    
    fadeTween.Completed:Connect(function()
        -- Changer image
        adButton.Image = ad.Image
        
        -- Resize container
        TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, newWidth, 0, newHeight)
        }):Play()
        
        -- Fade-in nouvelle image
        TweenService:Create(adButton, TweenInfo.new(0.3), {
            ImageTransparency = 0
        }):Play()
        
        -- Track impression
        Stats.Impressions = Stats.Impressions + 1
        Stats.Revenue = (Stats.Impressions / 1000) * CONFIG.CPM
        Stats.CurrentAdIndex = index
        
        print(string.format("🔄 Pub [%d/%d] affichée - %dx%d", index, #adsList, ad.Width, ad.Height))
    end)
    
    fadeTween:Play()
end

-- Rotation automatique des pubs
local rotationEnabled = true
spawn(function()
    while rotationEnabled and wait(CONFIG.RotateInterval) do
        if #adsList > 1 then
            local nextIndex = (currentAdIndex % #adsList) + 1
            SwitchToAd(nextIndex)
        end
    end
end)

-- Click handler
local adClickUrl = "https://a-ads.com/" .. CONFIG.AdUnitID
adButton.MouseButton1Click:Connect(function()
    Stats.Clicks = Stats.Clicks + 1
    
    -- Copier lien
    if setclipboard then
        setclipboard(adClickUrl)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "📋 Lien pub copié !",
            Text = "A-Ads #" .. CONFIG.AdUnitID,
            Duration = 3,
        })
    end
    
    print("🔗 Click publicité:", adClickUrl)
    print("📊 Stats - Impressions:", Stats.Impressions, "| Clicks:", Stats.Clicks)
end)

-- Hover effet
adButton.MouseEnter:Connect(function()
    TweenService:Create(adButton, TweenInfo.new(0.2), {
        ImageTransparency = 0.1
    }):Play()
end)

adButton.MouseLeave:Connect(function()
    TweenService:Create(adButton, TweenInfo.new(0.2), {
        ImageTransparency = 0
    }):Play()
end)

-- ===== ANIMATION FADE-IN =====
adButton.ImageTransparency = 1

spawn(function()
    wait(0.5)
    
    TweenService:Create(adButton, TweenInfo.new(0.5), {
        ImageTransparency = 0
    }):Play()
end)

-- ===== CONTRÔLES GLOBAUX =====
_G.AAdsController = {
    -- Afficher stats
    GetStats = function()
        return {
            Impressions = Stats.Impressions,
            Clicks = Stats.Clicks,
            Revenue = math.floor(Stats.Revenue * 100) / 100,
            CTR = Stats.Impressions > 0 and (Stats.Clicks / Stats.Impressions * 100) or 0,
            CurrentAd = currentAdIndex .. "/" .. #adsList,
            TotalAds = #adsList,
        }
    end,
    
    -- Changer publicité manuellement
    NextAd = function()
        local nextIndex = (currentAdIndex % #adsList) + 1
        SwitchToAd(nextIndex)
    end,
    
    PreviousAd = function()
        local prevIndex = currentAdIndex - 1
        if prevIndex < 1 then prevIndex = #adsList end
        SwitchToAd(prevIndex)
    end,
    
    -- Changer position
    SetPosition = function(posName)
        if POSITIONS[posName] then
            TweenService:Create(container, TweenInfo.new(0.3), {
                Position = POSITIONS[posName]
            }):Play()
            print("📍 Position changée:", posName)
        end
    end,
    
    -- Toggle rotation auto
    ToggleRotation = function()
        rotationEnabled = not rotationEnabled
        print("🔄 Rotation automatique:", rotationEnabled and "Activée" or "Désactivée")
    end,
    
    -- Toggle visibilité
    Toggle = function()
        container.Visible = not container.Visible
        print("👁️ Publicité:", container.Visible and "Visible" or "Cachée")
    end,
    
    -- Destroy
    Destroy = function()
        rotationEnabled = false
        screenGui:Destroy()
        print("🗑️ Publicités supprimées")
    end,
    
    -- Liste toutes les pubs
    ListAds = function()
        print("📋 " .. #adsList .. " publicité(s) chargée(s):")
        for i, ad in ipairs(adsList) do
            print(string.format("  [%d] %dx%d - %s", i, ad.Width, ad.Height, ad.Image:sub(1, 60)))
        end
    end,
}

-- ===== NOTIFICATION SUCCESS =====
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "📢 A-Ads Activé",
    Text = #adsList .. " pub(s) | Rotation " .. CONFIG.RotateInterval .. "s",
    Duration = 5,
})

print("╔═══════════════════════════════════════════════════════╗")
print("║        ✅ Publicités A-Ads chargées !               ║")
print("╠═══════════════════════════════════════════════════════╣")
print("║  Ad Unit ID    : " .. CONFIG.AdUnitID .. "                            ║")
print("║  Pubs trouvées : " .. #adsList .. "                                    ║")
print("║  Rotation      : " .. CONFIG.RotateInterval .. "s                                  ║")
print("║  Position      : " .. CONFIG.Position .. "                   ║")
print("╠═══════════════════════════════════════════════════════╣")
print("║  CONTRÔLES DISPONIBLES:                              ║")
print("║  _G.AAdsController:GetStats()                        ║")
print("║  _G.AAdsController:NextAd()                          ║")
print("║  _G.AAdsController:PreviousAd()                      ║")
print("║  _G.AAdsController:ToggleRotation()                  ║")
print("║  _G.AAdsController:SetPosition('TOP_RIGHT')          ║")
print("║  _G.AAdsController:ListAds()                         ║")
print("║  _G.AAdsController:Toggle()                          ║")
print("║  _G.AAdsController:Destroy()                         ║")
print("╚═══════════════════════════════════════════════════════╝")

-- Track impression initiale
Stats.Impressions = 1
Stats.Revenue = (Stats.Impressions / 1000) * CONFIG.CPM
