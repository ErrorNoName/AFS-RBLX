--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║   A-ADS INTEGRATION - DRAWING API (SOLUTION ULTIME)            ║
    ║   Affiche images via Drawing.new("Image") - KRNL/Synapse       ║
    ║   Contourne TOUS les blocages Roblox                            ║
    ╚══════════════════════════════════════════════════════════════════╝
    
    TECHNIQUE: Drawing API (exploit-level rendering)
    - Drawing.new("Image") affiche directement sur écran
    - Bypass complet sécurité Roblox (pas dans ScreenGui)
    - Fonctionne avec URLs HTTP/HTTPS externes
    
    REQUIS: Executor avec Drawing API (Synapse, KRNL, Script-Ware)
]]

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🚀 A-ADS INTEGRATION - DRAWING API v3.1")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

-- ===== VÉRIFICATION DRAWING API =====
if not Drawing then
    error("❌ Drawing API non disponible! Executor requis: Synapse/KRNL/Script-Ware")
end

print("✅ Drawing API détectée!")

-- ===== CONFIGURATION =====
local CONFIG = {
    AdUnitID = "2417103",
    Position = Vector2.new(10, 500),  -- Position écran (x, y)
    RotateInterval = 30,
    MaxWidth = 500,
    MaxHeight = 300,
}

-- ===== SERVICES =====
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- ===== VARIABLES =====
local adsList = {}
local currentAdIndex = 1
local rotationEnabled = true
local adClickUrl = ""
local Stats = {
    Impressions = 0,
    Clicks = 0,
    StartTime = os.time(),
}

-- ===== DRAWING OBJECTS =====
local adImage = nil
local adBackground = nil
local adBadge = nil
local closeButton = nil
local adText = nil

-- ===== FONCTION EXTRACTION =====
local function ExtractAllAdsFromHTML(html)
    local extractedAds = {}
    
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
    
    return extractedAds
end

-- ===== TÉLÉCHARGEMENT IFRAME =====
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
            
            adsList = ExtractAllAdsFromHTML(html)
            adClickUrl = html:match('href="(https?://[^"]+)"') or "https://a-ads.com"
            
            if #adsList > 0 then
                print("✅ " .. #adsList .. " publicité(s) extraite(s)")
            end
        end
    end)
end

-- Fallback
if #adsList == 0 then
    print("⚠️ Utilisation pubs par défaut")
    adsList = {
        {Image = "https://static.a-ads.com/a-ads-banners/531599/970x250", Width = 970, Height = 250},
        {Image = "https://static.a-ads.com/a-ads-banners/531599/728x90", Width = 728, Height = 90},
    }
    adClickUrl = "https://a-ads.com/?partner=" .. CONFIG.AdUnitID
end

-- ===== CALCUL TAILLE =====
local function CalculateDisplaySize(originalWidth, originalHeight)
    local scaleW = CONFIG.MaxWidth / originalWidth
    local scaleH = CONFIG.MaxHeight / originalHeight
    local scale = math.min(scaleW, scaleH, 1.0)
    
    return math.floor(originalWidth * scale), math.floor(originalHeight * scale)
end

-- ===== CRÉATION DRAWING IMAGE =====
local function CreateDrawingAd(imageUrl, width, height)
    local displayWidth, displayHeight = CalculateDisplaySize(width, height)
    
    -- Background
    if adBackground then adBackground:Remove() end
    adBackground = Drawing.new("Square")
    adBackground.Size = Vector2.new(displayWidth, displayHeight)
    adBackground.Position = CONFIG.Position
    adBackground.Color = Color3.fromRGB(30, 30, 30)
    adBackground.Filled = true
    adBackground.Visible = true
    adBackground.Transparency = 0.9
    
    -- Image principale
    if adImage then adImage:Remove() end
    
    local success, imageObj = pcall(function()
        local img = Drawing.new("Image")
        img.Size = Vector2.new(displayWidth, displayHeight)
        img.Position = CONFIG.Position
        img.Visible = true
        img.Transparency = 1
        
        -- TECHNIQUE 1: Charger depuis URL (si supporté)
        if img.Data then
            local imageData = game:HttpGet(imageUrl)
            img.Data = imageData
            print("✅ Image chargée via Data")
        -- TECHNIQUE 2: Charger depuis cache local
        elseif writefile and getcustomasset then
            local cachePath = "aads_temp.png"
            writefile(cachePath, game:HttpGet(imageUrl))
            img.Data = readfile(cachePath)
            print("✅ Image chargée via cache")
        else
            print("⚠️ img.Data non supporté")
        end
        
        return img
    end)
    
    if success and imageObj then
        adImage = imageObj
        print("✅ Drawing.Image créé:", imageUrl:sub(1, 50) .. "...")
    else
        print("❌ Échec Drawing.Image:", imageObj)
        
        -- Fallback: Afficher texte
        if adText then adText:Remove() end
        adText = Drawing.new("Text")
        adText.Text = "A-Ads [" .. width .. "x" .. height .. "]"
        adText.Size = 18
        adText.Position = CONFIG.Position + Vector2.new(10, displayHeight / 2)
        adText.Color = Color3.fromRGB(255, 255, 255)
        adText.Visible = true
        adText.Center = false
        adText.Outline = true
        adText.Font = 2
    end
    
    -- Badge "Ad"
    if adBadge then adBadge:Remove() end
    adBadge = Drawing.new("Text")
    adBadge.Text = "Ad"
    adBadge.Size = 14
    adBadge.Position = CONFIG.Position + Vector2.new(5, 5)
    adBadge.Color = Color3.fromRGB(255, 193, 7)
    adBadge.Visible = true
    adBadge.Center = false
    adBadge.Outline = true
    adBadge.Font = 3
    
    -- Bouton fermeture
    if closeButton then closeButton:Remove() end
    closeButton = Drawing.new("Text")
    closeButton.Text = "×"
    closeButton.Size = 24
    closeButton.Position = CONFIG.Position + Vector2.new(displayWidth - 20, 5)
    closeButton.Color = Color3.fromRGB(220, 53, 69)
    closeButton.Visible = true
    closeButton.Center = false
    closeButton.Outline = true
    closeButton.Font = 3
    
    return displayWidth, displayHeight
end

-- ===== AFFICHAGE INITIAL =====
local initialAd = adsList[1]
local currentWidth, currentHeight = CreateDrawingAd(initialAd.Image, initialAd.Width, initialAd.Height)

-- ===== GESTION CLICKS =====
local clickBounds = {
    Left = CONFIG.Position.X,
    Top = CONFIG.Position.Y,
    Right = CONFIG.Position.X + currentWidth,
    Bottom = CONFIG.Position.Y + currentHeight,
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        
        -- Check si click sur pub
        if mousePos.X >= clickBounds.Left and mousePos.X <= clickBounds.Right and
           mousePos.Y >= clickBounds.Top and mousePos.Y <= clickBounds.Bottom then
            
            -- Check si click sur bouton fermeture
            if mousePos.X >= clickBounds.Right - 30 and mousePos.Y <= clickBounds.Top + 30 then
                print("❌ Publicités fermées")
                
                -- Supprimer tous drawings
                if adImage then adImage:Remove() end
                if adBackground then adBackground:Remove() end
                if adBadge then adBadge:Remove() end
                if closeButton then closeButton:Remove() end
                if adText then adText:Remove() end
                
                rotationEnabled = false
            else
                -- Click sur pub
                Stats.Clicks = Stats.Clicks + 1
                print("🖱️ Click pub -> " .. adClickUrl)
                
                if setclipboard then
                    setclipboard(adClickUrl)
                    print("✅ URL copiée!")
                end
            end
        end
    end
end)

-- ===== ROTATION =====
local function SwitchToAd(index)
    local ad = adsList[index]
    if not ad then return end
    
    currentAdIndex = index
    currentWidth, currentHeight = CreateDrawingAd(ad.Image, ad.Width, ad.Height)
    
    -- Update click bounds
    clickBounds.Right = CONFIG.Position.X + currentWidth
    clickBounds.Bottom = CONFIG.Position.Y + currentHeight
    
    Stats.Impressions = Stats.Impressions + 1
    print(string.format("✅ Pub [%d/%d] %dx%d", index, #adsList, ad.Width, ad.Height))
end

spawn(function()
    while rotationEnabled and wait(CONFIG.RotateInterval) do
        if #adsList > 1 then
            currentAdIndex = (currentAdIndex % #adsList) + 1
            SwitchToAd(currentAdIndex)
        end
    end
end)

-- ===== CONTRÔLEUR =====
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
        print("📋 " .. #adsList .. " publicité(s):")
        for i, ad in ipairs(adsList) do
            print(string.format("[%d] %dx%d - %s", i, ad.Width, ad.Height, ad.Image:sub(1, 60)))
        end
    end,
    
    PauseRotation = function()
        rotationEnabled = not rotationEnabled
        print("⏸️ Rotation:", rotationEnabled and "Activée" or "Pausée")
    end,
    
    Destroy = function()
        if adImage then adImage:Remove() end
        if adBackground then adBackground:Remove() end
        if adBadge then adBadge:Remove() end
        if closeButton then closeButton:Remove() end
        if adText then adText:Remove() end
        rotationEnabled = false
        print("❌ Système détruit")
    end,
}

print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ SYSTÈME DÉMARRÉ!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("💡 Pub affichée à gauche de l'écran (Drawing API)")
print("💡 Click sur × pour fermer")
print("💡 Commandes: _G.AAdsController:GetStats(), :NextAd(), etc.")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
