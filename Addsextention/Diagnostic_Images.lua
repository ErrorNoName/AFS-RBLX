--[[
    ╔════════════════════════════════════════════════════════════╗
    ║   DIAGNOSTIC COMPLET - Affichage Images Roblox            ║
    ║   Identifie pourquoi les images ne s'affichent pas        ║
    ╚════════════════════════════════════════════════════════════╝
]]

print("╔════════════════════════════════════════════════════════════╗")
print("║         DIAGNOSTIC AFFICHAGE IMAGES ROBLOX                ║")
print("╚════════════════════════════════════════════════════════════╝\n")

-- ===== TEST 1: FONCTIONS DISPONIBLES =====
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📋 TEST 1: Fonctions Executor Disponibles")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

local functions = {
    {name = "syn.request", func = syn and syn.request},
    {name = "http_request", func = http_request},
    {name = "request", func = request},
    {name = "getcustomasset", func = getcustomasset},
    {name = "getsynasset", func = getsynasset},
    {name = "writefile", func = writefile},
    {name = "readfile", func = readfile},
    {name = "isfile", func = isfile},
    {name = "makefolder", func = makefolder},
    {name = "setclipboard", func = setclipboard},
}

for i, item in ipairs(functions) do
    local status = item.func and "✅ Disponible" or "❌ Non disponible"
    print(string.format("  %s: %s", item.name, status))
end

-- ===== TEST 2: REQUÊTE HTTP IMAGE A-ADS =====
print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📋 TEST 2: Requête HTTP Image A-Ads")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

local testUrls = {
    "https://static.a-ads.com/a-ads-banners/531599/970x250",
    "https://static.a-ads.com/a-ads-advert-illustrations/442/475x250",
    "https://ad.a-ads.com/2417103.png",
}

for i, url in ipairs(testUrls) do
    print(string.format("🔗 Test URL %d: %s", i, url:sub(1, 60) .. "..."))
    
    local success, result = pcall(function()
        local request = syn and syn.request or http_request or request
        if not request then
            error("Fonction request non disponible")
        end
        
        local response = request({
            Url = url,
            Method = "GET",
        })
        
        return response
    end)
    
    if success then
        print("  ✅ Status Code:", result.StatusCode)
        print("  📦 Body Size:", #result.Body, "bytes")
        print("  📋 Headers:", result.Headers and "Oui" or "Non")
        
        -- Vérifier si c'est une vraie image
        local isPng = result.Body:sub(1, 8):find("\137PNG")
        local isJpg = result.Body:sub(1, 3):find("\255\216\255")
        local isGif = result.Body:sub(1, 6):find("GIF89a") or result.Body:sub(1, 6):find("GIF87a")
        
        if isPng then
            print("  🖼️ Format: PNG valide")
        elseif isJpg then
            print("  🖼️ Format: JPEG valide")
        elseif isGif then
            print("  🖼️ Format: GIF valide")
        else
            print("  ⚠️ Format: Inconnu (premiers bytes:", result.Body:sub(1, 10):byte(1, 10), ")")
        end
    else
        print("  ❌ Erreur:", result)
    end
    
    print()
end

-- ===== TEST 3: CHARGEMENT IMAGE DANS ROBLOX =====
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📋 TEST 3: Chargement Direct Image dans ImageLabel")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

local testImageUrls = {
    "https://static.a-ads.com/a-ads-banners/531599/970x250",
    "rbxassetid://1234567", -- Test asset Roblox
    "https://www.roblox.com/asset/?id=1234567", -- Test asset URL
}

local sg = Instance.new("ScreenGui")
sg.Name = "DiagnosticTest"
sg.Parent = game:GetService("CoreGui")

for i, url in ipairs(testImageUrls) do
    print(string.format("🔗 Test %d: %s", i, url))
    
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, 100, 0, 50)
    img.Position = UDim2.new(0, 10 + ((i-1) * 110), 0, 10)
    img.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    img.BorderSizePixel = 1
    img.BorderColor3 = Color3.fromRGB(255, 255, 255)
    img.ScaleType = Enum.ScaleType.Fit
    img.Parent = sg
    
    local success, err = pcall(function()
        img.Image = url
    end)
    
    if success then
        print("  ✅ Assignation réussie (Image property)")
        
        -- Attendre chargement
        wait(2)
        
        -- Vérifier si vraiment chargée
        if img.ImageTransparency < 1 then
            print("  ✅ Image visible (ImageTransparency < 1)")
        else
            print("  ⚠️ Image transparente (peut-être non chargée)")
        end
    else
        print("  ❌ Erreur assignation:", err)
    end
    
    -- Label texte
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 1, 2)
    label.Text = "Test " .. i
    label.TextSize = 10
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Code
    label.Parent = img
    
    print()
end

-- ===== TEST 4: GETCUSTOMASSET (si disponible) =====
if getcustomasset or getsynasset then
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📋 TEST 4: GetCustomAsset (fichiers locaux)")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    local assetFunc = getcustomasset or getsynasset
    
    -- Test 1: Télécharger image et sauver
    print("📥 Téléchargement image test...")
    
    local testUrl = "https://static.a-ads.com/a-ads-banners/531599/970x250"
    
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
        print("  ✅ Image téléchargée:", #imageData, "bytes")
        
        -- Sauver localement
        if writefile then
            local filename = "diagnostic_test_image.png"
            writefile(filename, imageData)
            print("  ✅ Image sauvegardée:", filename)
            
            -- Charger via getcustomasset
            local assetUrl = assetFunc(filename)
            print("  ✅ Asset URL:", assetUrl)
            
            -- Tester dans ImageLabel
            local img = Instance.new("ImageLabel")
            img.Size = UDim2.new(0, 200, 0, 100)
            img.Position = UDim2.new(0, 10, 0, 100)
            img.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            img.BorderSizePixel = 2
            img.BorderColor3 = Color3.fromRGB(0, 255, 0)
            img.ScaleType = Enum.ScaleType.Fit
            img.Parent = sg
            
            local loadSuccess = pcall(function()
                img.Image = assetUrl
            end)
            
            if loadSuccess then
                print("  ✅ Image chargée via getcustomasset!")
                print("  💡 SOLUTION: Utiliser getcustomasset() pour fichiers locaux")
            else
                print("  ❌ Échec chargement via getcustomasset")
            end
            
            -- Label
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Position = UDim2.new(0, 0, 1, 2)
            label.Text = "Via getcustomasset()"
            label.TextSize = 12
            label.TextColor3 = Color3.fromRGB(0, 255, 0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.GothamBold
            label.Parent = img
        else
            print("  ❌ writefile non disponible")
        end
    else
        print("  ❌ Erreur téléchargement:", imageData)
    end
    
    print()
else
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("⚠️ TEST 4: SKIPPED (getcustomasset non disponible)")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
end

-- ===== RÉSULTAT FINAL =====
print("╔════════════════════════════════════════════════════════════╗")
print("║                 RÉSUMÉ DIAGNOSTIC                          ║")
print("╚════════════════════════════════════════════════════════════╝\n")

print("💡 VÉRIFICATIONS:")
print("  1. Regarder images test affichées en haut à gauche écran")
print("  2. Si fond gris uniquement → Roblox bloque URLs externes")
print("  3. Si image verte visible → getcustomasset() fonctionne!\n")

print("🔧 SOLUTIONS POSSIBLES:\n")

if getcustomasset or getsynasset then
    print("  ✅ SOLUTION 1 (RECOMMANDÉE): getcustomasset()")
    print("     → Télécharger image → Sauver fichier → getcustomasset()")
    print("     → Code déjà dans Integration_Simple_AAds.lua (lignes 151-183)\n")
else
    print("  ❌ Solution 1: getcustomasset NON DISPONIBLE\n")
end

if writefile then
    print("  ✅ SOLUTION 2: Upload Roblox Assets")
    print("     → Télécharger image (déjà fait)")
    print("     → Upload sur roblox.com/develop → Images → Upload")
    print("     → Utiliser rbxassetid://ID\n")
else
    print("  ❌ Solution 2: writefile NON DISPONIBLE\n")
end

print("  ⚠️ SOLUTION 3 (Temporaire): Discord CDN")
print("     → Upload image sur Discord (DM bot)")
print("     → Copier lien CDN (cdn.discordapp.com)")
print("     → Utiliser URL Discord\n")

print("  ⚠️ SOLUTION 4 (Workaround): Afficher texte")
print("     → Remplacer image par TextLabel avec URL")
print("     → Click ouvre lien dans clipboard\n")

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📊 UI Test créée en haut écran (3 carrés)")
print("🗑️ Pour fermer: sg:Destroy() ou relancer script")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- Bouton fermer
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 100, 0, 30)
closeBtn.Position = UDim2.new(0, 10, 0, 200)
closeBtn.Text = "Fermer Tests"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
    print("🗑️ UI Diagnostic fermée")
end)

-- Sauver référence globale
_G.DiagnosticUI = sg
print("\n💾 UI sauvegardée: _G.DiagnosticUI")
print("🔧 Commandes utiles:")
print("   _G.DiagnosticUI:Destroy()  -- Fermer UI")
