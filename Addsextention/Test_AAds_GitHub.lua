--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║      Test A-Ads avec Page GitHub HTML                    ║
    ║      ID: 2417103 (votre Ad Unit)                         ║
    ╚═══════════════════════════════════════════════════════════╝
]]

print("=== Test A-Ads Système ===\n")

-- Configuration
local AD_UNIT_ID = "2417103"  -- Votre ID A-Ads
local GITHUB_PAGE = "https://errornoname.github.io/AdsRblx/index.html"  -- Remplacer

-- Services
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Fonction extraction URL image depuis HTML
local function ExtractImageFromHTML(html)
    -- Pattern 1: Balise <img src="...">
    local imgUrl = html:match('<img[^>]+src="(https?://[^"]+)"')
        or html:match("<img[^>]+src='(https?://[^']+)'")
    
    if imgUrl then
        return imgUrl
    end
    
    -- Pattern 2: background-image: url(...)
    imgUrl = html:match('background%-image:%s*url%("(https?://[^"]+)"%)')
        or html:match("background%-image:%s*url%('(https?://[^']+)'%)")
        or html:match("background%-image:%s*url%(([^)]+)%)")
    
    if imgUrl then
        return imgUrl:gsub("^['\"]", ""):gsub("['\"]$", "")
    end
    
    -- Pattern 3: A-Ads specific (data-aa)
    imgUrl = html:match('data%-aa="[^"]*"[^>]*src="(https?://[^"]+)"')
    
    return imgUrl
end

-- Fonction extraction lien click depuis HTML
local function ExtractClickUrlFromHTML(html)
    -- Pattern href dans <a>
    local clickUrl = html:match('<a[^>]+href="(https?://[^"]+)"')
        or html:match("<a[^>]+href='(https?://[^']+)'")
    
    return clickUrl or ("https://a-ads.com/" .. AD_UNIT_ID)
end

-- ========== MÉTHODE 1: Via Page GitHub HTML ==========
print("📄 Méthode 1: Chargement depuis page GitHub...")

local success1, githubResult = pcall(function()
    local request = syn and syn.request or http_request or request
    
    if not request then
        warn("❌ Fonction request non disponible")
        return nil
    end
    
    local response = request({
        Url = GITHUB_PAGE,
        Method = "GET",
    })
    
    if response.StatusCode == 200 then
        local html = response.Body
        
        print("✅ Page GitHub chargée (" .. #html .. " bytes)")
        
        -- Extraire iframe src
        local iframeUrl = html:match('src="(//[^"]+)"')
            or html:match("src='(//[^']+)'")
        
        if iframeUrl then
            -- Ajouter https:
            if not iframeUrl:match("^https?://") then
                iframeUrl = "https:" .. iframeUrl
            end
            
            print("🔗 Iframe trouvée:", iframeUrl)
            
            -- Charger contenu iframe
            local iframeResponse = request({
                Url = iframeUrl,
                Method = "GET",
            })
            
            if iframeResponse.StatusCode == 200 then
                local iframeHtml = iframeResponse.Body
                
                print("✅ Contenu iframe chargé (" .. #iframeHtml .. " bytes)")
                
                -- Extraire image
                local imageUrl = ExtractImageFromHTML(iframeHtml)
                local clickUrl = ExtractClickUrlFromHTML(iframeHtml)
                
                if imageUrl then
                    print("🖼️ Image extraite:", imageUrl)
                    print("🔗 Lien click:", clickUrl)
                    
                    return {
                        Image = imageUrl,
                        Link = clickUrl,
                        Title = "A-Ads #" .. AD_UNIT_ID,
                    }
                else
                    warn("❌ Aucune image trouvée dans iframe HTML")
                    
                    -- Debug: Afficher début HTML
                    print("\n📝 Début HTML iframe (200 chars):")
                    print(iframeHtml:sub(1, 200))
                end
            else
                warn("❌ Erreur chargement iframe:", iframeResponse.StatusCode)
            end
        else
            warn("❌ Iframe src non trouvée dans HTML")
        end
    else
        warn("❌ Erreur chargement page GitHub:", response.StatusCode)
    end
    
    return nil
end)

-- ========== MÉTHODE 2: Direct iframe A-Ads ==========
print("\n📄 Méthode 2: Chargement direct iframe A-Ads...")

local success2, iframeResult = pcall(function()
    local request = syn and syn.request or http_request or request
    
    if not request then
        return nil
    end
    
    local iframeUrl = "https://acceptable.a-ads.com/" .. AD_UNIT_ID .. "/?size=Adaptive"
    
    local response = request({
        Url = iframeUrl,
        Method = "GET",
    })
    
    if response.StatusCode == 200 then
        local html = response.Body
        
        print("✅ Iframe A-Ads chargée (" .. #html .. " bytes)")
        
        -- Extraire image
        local imageUrl = ExtractImageFromHTML(html)
        local clickUrl = ExtractClickUrlFromHTML(html)
        
        if imageUrl then
            print("🖼️ Image extraite:", imageUrl)
            print("🔗 Lien click:", clickUrl)
            
            return {
                Image = imageUrl,
                Link = clickUrl,
                Title = "A-Ads Direct #" .. AD_UNIT_ID,
            }
        else
            warn("❌ Aucune image trouvée")
            
            -- Debug
            print("\n📝 Début HTML (500 chars):")
            print(html:sub(1, 500))
        end
    else
        warn("❌ Erreur:", response.StatusCode)
    end
    
    return nil
end)

-- ========== MÉTHODE 3: Fallback URL Directe ==========
print("\n📄 Méthode 3: Fallback URL directe A-Ads...")

local fallbackAd = {
    Image = "https://ad.a-ads.com/" .. AD_UNIT_ID .. ".png",
    Link = "https://a-ads.com/" .. AD_UNIT_ID,
    Title = "A-Ads Fallback #" .. AD_UNIT_ID,
}

print("🖼️ Image fallback:", fallbackAd.Image)
print("🔗 Lien fallback:", fallbackAd.Link)

-- ========== SÉLECTION MEILLEURE MÉTHODE ==========
local finalAd = nil

if success1 and githubResult then
    print("\n✅ Utilisation Méthode 1 (GitHub)")
    finalAd = githubResult
elseif success2 and iframeResult then
    print("\n✅ Utilisation Méthode 2 (Iframe direct)")
    finalAd = iframeResult
else
    print("\n⚠️ Utilisation Méthode 3 (Fallback)")
    finalAd = fallbackAd
end

-- ========== AFFICHAGE PUBLICITÉ ==========
print("\n🎨 Création affichage Roblox...\n")

-- Créer ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AAdsTest"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end

screenGui.Parent = CoreGui

-- Container
local container = Instance.new("Frame")
container.Name = "AdContainer"
container.Size = UDim2.new(0, 200, 0, 100)
container.Position = UDim2.new(0, 10, 1, -110)  -- Bottom-left
container.BackgroundTransparency = 1
container.Parent = screenGui

-- Border
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
border.BackgroundTransparency = 0.5
border.BorderSizePixel = 0
border.Parent = container

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 8)
borderCorner.Parent = border

-- ImageButton
local adButton = Instance.new("ImageButton")
adButton.Name = "AdBanner"
adButton.Size = UDim2.new(1, 0, 1, 0)
adButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
adButton.BorderSizePixel = 0
adButton.Image = finalAd.Image
adButton.ScaleType = Enum.ScaleType.Fit
adButton.Parent = container

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = adButton

-- Loading label
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 1, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Chargement publicité..."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.TextSize = 12
loadingLabel.Font = Enum.Font.GothamMedium
loadingLabel.Parent = adButton

-- Ad label
local adLabel = Instance.new("TextLabel")
adLabel.Size = UDim2.new(0, 30, 0, 15)
adLabel.Position = UDim2.new(0, 5, 0, 5)
adLabel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
adLabel.BackgroundTransparency = 0.3
adLabel.Text = "Ad"
adLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
adLabel.TextSize = 10
adLabel.Font = Enum.Font.GothamBold
adLabel.BorderSizePixel = 0
adLabel.Parent = container

local adCorner = Instance.new("UICorner")
adCorner.CornerRadius = UDim.new(0, 4)
adCorner.Parent = adLabel

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = container

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

-- Events
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("✅ Publicité fermée")
end)

adButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(finalAd.Link)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "📋 Lien copié !",
            Text = finalAd.Title,
            Duration = 3,
        })
    end
    print("🔗 Click:", finalAd.Link)
end)

-- Animation fade-in
adButton.ImageTransparency = 1
loadingLabel.Visible = true

spawn(function()
    wait(1)
    
    loadingLabel.Visible = false
    
    TweenService:Create(adButton, TweenInfo.new(0.5), {
        ImageTransparency = 0
    }):Play()
    
    print("✅ Publicité affichée !")
end)

-- ========== RÉCAPITULATIF ==========
print([[

╔═══════════════════════════════════════════════════════════╗
║              Test A-Ads Terminé                           ║
╚═══════════════════════════════════════════════════════════╝

📊 Résultat:
   ✅ Méthode utilisée: ]] .. (success1 and "GitHub" or success2 and "Iframe" or "Fallback") .. [[

   
🖼️  Image URL:
   ]] .. finalAd.Image .. [[

   
🔗 Click URL:
   ]] .. finalAd.Link .. [[

   
💡 NOTES:

1️⃣  Pour utiliser votre page GitHub:
   - Remplacer GITHUB_PAGE ligne 8
   - Format: https://USERNAME.github.io/REPO/ad.html

2️⃣  Votre Ad Unit ID: ]] .. AD_UNIT_ID .. [[


3️⃣  Pour intégrer dans AdManager.lua:
   AdManager:Init({
       Provider = "A-Ads",
       AdUnitID = "]] .. AD_UNIT_ID .. [[",
       Position = "BOTTOM_LEFT"
   })

════════════════════════════════════════════════════════════

]])
