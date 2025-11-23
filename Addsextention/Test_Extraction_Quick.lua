--[[
    ╔════════════════════════════════════════════════════════════╗
    ║   TEST RAPIDE - Extraction & Affichage Images A-Ads       ║
    ║   Ad Unit ID: 2417103                                      ║
    ╚════════════════════════════════════════════════════════════╝
    
    UTILISATION:
    1. Exécuter ce script dans votre executor Roblox
    2. Vérifier console pour extraction images
    3. Vérifier UI bottom-left écran
    4. Tester contrôles console
]]

print("╔════════════════════════════════════════════════════════════╗")
print("║            DÉMARRAGE TEST EXTRACTION A-ADS                ║")
print("╚════════════════════════════════════════════════════════════╝")

-- ===== CONFIG =====
local AD_UNIT_ID = "2417103"
local TEST_MODE = true -- Affiche debug verbose

-- ===== SERVICES =====
local HttpService = game:GetService("HttpService")

-- ===== FONCTION EXTRACTION =====
local function ExtractAllImages(html)
    local images = {}
    
    print("\n🔍 ANALYSE HTML (" .. #html .. " caractères)")
    
    -- Pattern 1: Illustrations A-Ads (teasers)
    print("\n📌 Pattern 1: a-ads-advert-illustrations")
    for src, width, height, alt in html:gmatch('src="(//static%.a%-ads%.com/a%-ads%-advert%-illustrations/[^"]+/(%d+)x(%d+)[^"]*)"[^>]*alt="([^"]*)"') do
        local url = "https:" .. src
        table.insert(images, {
            Type = "Illustration",
            URL = url,
            Width = tonumber(width),
            Height = tonumber(height),
            Alt = alt,
        })
        print(string.format("  ✅ %dx%d - %s", width, height, alt:sub(1, 40)))
    end
    
    -- Pattern 2: Banners A-Ads
    print("\n📌 Pattern 2: a-ads-banners")
    for src, width, height, alt in html:gmatch('src="(//static%.a%-ads%.com/a%-ads%-banners/[^"]+/(%d+)x(%d+)[^"]*)"[^>]*alt="([^"]*)"') do
        local url = "https:" .. src
        table.insert(images, {
            Type = "Banner",
            URL = url,
            Width = tonumber(width),
            Height = tonumber(height),
            Alt = alt,
        })
        print(string.format("  ✅ %dx%d - %s", width, height, alt:sub(1, 40)))
    end
    
    -- Pattern 3: <img> tags génériques
    print("\n📌 Pattern 3: Images génériques")
    for src in html:gmatch('<img[^>]+src="(https?://[^"]+%.[pngjifPNGJIF]+)"') do
        if not src:match("a%-ads") then -- Skip déjà trouvées
            table.insert(images, {
                Type = "Generic",
                URL = src,
                Width = 468,
                Height = 60,
                Alt = "Generic Ad",
            })
            print("  ✅ " .. src:sub(1, 60))
        end
    end
    
    return images
end

-- ===== TEST REQUÊTE HTTP =====
print("\n🌐 REQUÊTE HTTP A-ADS...")

local iframeUrl = "https://acceptable.a-ads.com/" .. AD_UNIT_ID .. "/?size=Adaptive"
print("📍 URL: " .. iframeUrl)

local success, result = pcall(function()
    local request = syn and syn.request or http_request or request
    
    if not request then
        error("❌ Fonction request non disponible (executor incompatible)")
    end
    
    print("⏳ Envoi requête HTTP...")
    
    local response = request({
        Url = iframeUrl,
        Method = "GET",
    })
    
    print("📊 Status Code: " .. response.StatusCode)
    print("📦 Body Size: " .. #response.Body .. " bytes")
    
    if response.StatusCode ~= 200 then
        error("❌ HTTP Error: " .. response.StatusCode)
    end
    
    return response.Body
end)

if not success then
    print("\n❌ ERREUR REQUÊTE:")
    print(result)
    print("\n⚠️ Utilisation fallback URLs...")
    
    -- Fallback
    local fallbackImages = {
        {Type = "Fallback", URL = "https://ad.a-ads.com/" .. AD_UNIT_ID .. ".png", Width = 468, Height = 60, Alt = "Default Ad"},
    }
    
    print("\n📋 RÉSULTAT FINAL (Fallback):")
    for i, img in ipairs(fallbackImages) do
        print(string.format("[%d] %s - %dx%d", i, img.Type, img.Width, img.Height))
        print("    " .. img.URL)
    end
    
    return
end

-- ===== EXTRACTION IMAGES =====
local html = result
print("\n✅ HTML RÉCUPÉRÉ")

if TEST_MODE then
    print("\n📄 PREVIEW HTML (500 premiers chars):")
    print("─────────────────────────────────────────────────────────────")
    print(html:sub(1, 500))
    print("─────────────────────────────────────────────────────────────")
end

local images = ExtractAllImages(html)

-- ===== RÉSULTAT =====
print("\n╔════════════════════════════════════════════════════════════╗")
print("║                   RÉSULTAT EXTRACTION                      ║")
print("╚════════════════════════════════════════════════════════════╝")

if #images == 0 then
    print("⚠️ AUCUNE IMAGE TROUVÉE")
    print("💡 Vérifier patterns regex ou utiliser fallback")
else
    print("✅ " .. #images .. " IMAGE(S) EXTRAITE(S):\n")
    
    for i, img in ipairs(images) do
        print(string.format("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"))
        print(string.format("📌 [%d/%d] %s", i, #images, img.Type))
        print(string.format("📐 Dimensions: %dx%d", img.Width, img.Height))
        print(string.format("📝 Description: %s", img.Alt))
        print(string.format("🔗 URL: %s", img.URL))
    end
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

-- ===== TEST AFFICHAGE ROBLOX (PREMIÈRE IMAGE) =====
if #images > 0 then
    print("\n🎨 CRÉATION UI ROBLOX (test première image)...\n")
    
    local firstImg = images[1]
    local scale = 0.5
    local displayWidth = math.floor(firstImg.Width * scale)
    local displayHeight = math.floor(firstImg.Height * scale)
    
    print(string.format("📐 Taille adaptée: %dx%d → %dx%d (scale %.2f)", 
        firstImg.Width, firstImg.Height, displayWidth, displayHeight, scale))
    
    -- ScreenGui
    local sg = Instance.new("ScreenGui")
    sg.Name = "AAdsTest_" .. AD_UNIT_ID
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    
    if syn and syn.protect_gui then
        syn.protect_gui(sg)
    end
    
    sg.Parent = game:GetService("CoreGui")
    
    -- Container
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, displayWidth + 10, 0, displayHeight + 30)
    frame.Position = UDim2.new(0, 10, 1, -(displayHeight + 40))
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    frame.Parent = sg
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Image
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, displayWidth, 0, displayHeight)
    img.Position = UDim2.new(0, 5, 0, 25)
    img.Image = firstImg.URL
    img.BackgroundTransparency = 1
    img.ScaleType = Enum.ScaleType.Fit
    img.Parent = frame
    
    -- Titre
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 20)
    title.Position = UDim2.new(0, 5, 0, 2)
    title.Text = "TEST A-ADS #" .. AD_UNIT_ID .. " [1/" .. #images .. "]"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 12
    title.Font = Enum.Font.GothamBold
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    -- Bouton fermer
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -25, 0, 2)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = frame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
        print("🗑️ UI Test fermée")
    end)
    
    print("✅ UI créée (bottom-left)")
    print("💡 Cliquer [×] pour fermer\n")
end

-- ===== INSTRUCTIONS FINALES =====
print("╔════════════════════════════════════════════════════════════╗")
print("║                    TEST TERMINÉ                            ║")
print("╠════════════════════════════════════════════════════════════╣")
print("║  ✅ Extraction réussie: " .. #images .. " image(s)                          ║")
print("║  ✅ UI test affichée (si images trouvées)                  ║")
print("╠════════════════════════════════════════════════════════════╣")
print("║  PROCHAINES ÉTAPES:                                        ║")
print("║  1. Vérifier images s'affichent correctement               ║")
print("║  2. Exécuter Integration_Simple_AAds.lua                   ║")
print("║  3. Tester rotation automatique                            ║")
print("║  4. Intégrer dans SriBlox Modern                           ║")
print("╚════════════════════════════════════════════════════════════╝")
