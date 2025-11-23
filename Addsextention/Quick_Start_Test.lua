--[[
═══════════════════════════════════════════════════════════════════════
    🚀 QUICK START - TEST RAPIDE A-ADS
    
    Exécution rapide pour validation immédiate
    URL: //acceptable.a-ads.com/2417103/?size=Adaptive
    
    Ce script teste la méthode la plus probable de fonctionner
    et affiche résultat en 5 secondes
═══════════════════════════════════════════════════════════════════════
--]]

print("\n" .. string.rep("═", 80))
print("🚀 QUICK START - TEST RAPIDE A-ADS")
print(string.rep("═", 80) .. "\n")

--[[ CONFIG ]]--
local TEST_IMAGE_URL = "https://static.a-ads.com/a-ads-banners/531599/970x250_eed0a7ea7e.png"
local CLOUDFLARE_API = "https://image-parser.tyrannizerdev.workers.dev"

--[[ SERVICES ]]--
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")

--[[ TEST FONCTION ]]--
local function QuickTest()
    print("📋 Test méthodes dans ordre priorité...\n")
    
    -- TEST 1: EditableImage (PRIORITÉ #1)
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🧪 TEST 1: EditableImage (Roblox 2024)")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    
    if AssetService.CreateEditableImage then
        print("✅ CreateEditableImage supporté")
        print("🌐 Requête API Cloudflare Worker...")
        
        local encodedUrl = HttpService:UrlEncode(TEST_IMAGE_URL)
        local apiUrl = CLOUDFLARE_API .. "/?url=" .. encodedUrl .. "&resize=512"
        
        local success, response = pcall(function()
            return HttpService:RequestAsync({
                Url = apiUrl,
                Method = "GET"
            })
        end)
        
        if success and response.Success and response.StatusCode == 200 then
            print("✅ API réponse OK (" .. #response.Body .. " bytes)")
            
            local ok, pixelData = pcall(HttpService.JSONDecode, HttpService, response.Body)
            
            if ok and pixelData.width and pixelData.height then
                print("✅ Pixel matrix parsé: " .. pixelData.width .. "x" .. pixelData.height)
                print("🎨 Création EditableImage...")
                
                local editableImage = AssetService:CreateEditableImage({
                    Size = Vector2.new(pixelData.width, pixelData.height)
                })
                
                print("📝 WritePixelsBuffer...")
                local bufferSize = pixelData.width * pixelData.height * 4
                local pixelBuffer = buffer.create(bufferSize)
                
                local index = 0
                for y = 1, pixelData.height do
                    for x = 1, pixelData.width do
                        local pixel = pixelData.pixels[y][x]
                        buffer.writeu8(pixelBuffer, index, pixel[1])
                        buffer.writeu8(pixelBuffer, index + 1, pixel[2])
                        buffer.writeu8(pixelBuffer, index + 2, pixel[3])
                        buffer.writeu8(pixelBuffer, index + 3, 255)
                        index = index + 4
                    end
                end
                
                editableImage:WritePixelsBuffer(
                    Vector2.new(0, 0),
                    Vector2.new(pixelData.width, pixelData.height),
                    pixelBuffer
                )
                
                print("🖼️ Affichage GUI...")
                local screenGui = Instance.new("ScreenGui")
                screenGui.Name = "QuickTest_AAds"
                screenGui.ResetOnSpawn = false
                if syn and syn.protect_gui then
                    syn.protect_gui(screenGui)
                end
                screenGui.Parent = game:GetService("CoreGui")
                
                local imageLabel = Instance.new("ImageLabel")
                imageLabel.Size = UDim2.new(0, 470, 0, 100)
                imageLabel.Position = UDim2.new(0.5, -235, 0.5, -50)
                imageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                imageLabel.BorderSizePixel = 3
                imageLabel.BorderColor3 = Color3.fromRGB(0, 255, 0)
                imageLabel.ImageContent = Content.fromObject(editableImage)
                imageLabel.Parent = screenGui
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 30)
                label.Position = UDim2.new(0, 0, 1, 5)
                label.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                label.TextColor3 = Color3.fromRGB(0, 0, 0)
                label.Text = "✅ EditableImage FONCTIONNE!"
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = imageLabel
                
                print("\n" .. string.rep("═", 80))
                print("✅ ✅ ✅ SUCCESS! EditableImage fonctionne parfaitement!")
                print(string.rep("═", 80))
                print("💡 Utilisez EditableImage pour votre système A-Ads")
                print("📖 Voir: Test_All_Methods.lua pour implémentation complète")
                print(string.rep("═", 80) .. "\n")
                return
            else
                print("❌ Erreur parsing pixel matrix")
            end
        else
            print("❌ API Cloudflare Worker échec")
            print("💡 Vérifiez connexion internet")
        end
    else
        print("❌ CreateEditableImage non supporté (Roblox version ancienne)")
    end
    
    print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    -- TEST 2: Drawing API (PRIORITÉ #2)
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🧪 TEST 2: Drawing API (Executor)")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    
    if Drawing then
        print("✅ Drawing API disponible")
        print("📥 Téléchargement image...")
        
        local success, imageData = pcall(function()
            return game:HttpGet(TEST_IMAGE_URL)
        end)
        
        if success and imageData then
            print("✅ Image téléchargée (" .. #imageData .. " bytes)")
            
            local supportsImage = pcall(function()
                local test = Drawing.new("Image")
                test:Remove()
            end)
            
            if supportsImage then
                print("✅ Drawing.new('Image') supporté")
                print("🎨 Affichage Drawing...")
                
                local img = Drawing.new("Image")
                img.Data = imageData
                img.Size = Vector2.new(470, 100)
                img.Position = Vector2.new(
                    game.Workspace.CurrentCamera.ViewportSize.X / 2 - 235,
                    game.Workspace.CurrentCamera.ViewportSize.Y / 2 - 50
                )
                img.Visible = true
                
                local border = Drawing.new("Square")
                border.Size = Vector2.new(474, 104)
                border.Position = Vector2.new(img.Position.X - 2, img.Position.Y - 2)
                border.Color = Color3.fromRGB(0, 100, 255)
                border.Filled = false
                border.Thickness = 3
                border.Visible = true
                
                local text = Drawing.new("Text")
                text.Text = "✅ Drawing API FONCTIONNE!"
                text.Size = 20
                text.Center = true
                text.Position = Vector2.new(
                    img.Position.X + 235,
                    img.Position.Y + 110
                )
                text.Color = Color3.fromRGB(0, 100, 255)
                text.Font = 3
                text.Visible = true
                
                print("\n" .. string.rep("═", 80))
                print("✅ ✅ ✅ SUCCESS! Drawing API fonctionne!")
                print(string.rep("═", 80))
                print("💡 Utilisez Drawing API pour votre système A-Ads")
                print("📖 Voir: Test_All_Methods.lua pour implémentation complète")
                print(string.rep("═", 80) .. "\n")
                return
            else
                print("❌ Drawing.new('Image') non supporté par executor")
                print("💡 Fallback texte...")
                
                local bg = Drawing.new("Square")
                bg.Size = Vector2.new(470, 100)
                bg.Position = Vector2.new(
                    game.Workspace.CurrentCamera.ViewportSize.X / 2 - 235,
                    game.Workspace.CurrentCamera.ViewportSize.Y / 2 - 50
                )
                bg.Color = Color3.fromRGB(30, 30, 30)
                bg.Filled = true
                bg.Visible = true
                
                local text = Drawing.new("Text")
                text.Text = "⚠️ AD (Drawing API - texte only)"
                text.Size = 24
                text.Center = true
                text.Position = Vector2.new(
                    game.Workspace.CurrentCamera.ViewportSize.X / 2,
                    game.Workspace.CurrentCamera.ViewportSize.Y / 2
                )
                text.Color = Color3.fromRGB(255, 193, 7)
                text.Font = 3
                text.Visible = true
                
                print("⚠️ Drawing API partiel (texte seulement)")
            end
        else
            print("❌ Téléchargement image échoué")
        end
    else
        print("❌ Drawing API non disponible")
    end
    
    print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    -- TEST 3: getcustomasset (PRIORITÉ #3)
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🧪 TEST 3: getcustomasset() (Legacy)")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    
    if getcustomasset or getsynasset then
        local getasset = getcustomasset or getsynasset
        print("✅ getcustomasset disponible")
        print("📥 Téléchargement image...")
        
        local success, imageData = pcall(function()
            return game:HttpGet(TEST_IMAGE_URL)
        end)
        
        if success and imageData then
            print("✅ Image téléchargée (" .. #imageData .. " bytes)")
            
            local folder = "workspace/AAds_QuickTest"
            if not isfolder(folder) then
                makefolder(folder)
            end
            
            local filename = folder .. "/test.png"
            writefile(filename, imageData)
            print("💾 Fichier sauvegardé: " .. filename)
            
            local assetUrl = getasset(filename)
            print("✅ Asset URL: " .. assetUrl)
            
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "QuickTest_GetCustomAsset"
            screenGui.ResetOnSpawn = false
            if syn and syn.protect_gui then
                syn.protect_gui(screenGui)
            end
            screenGui.Parent = game:GetService("CoreGui")
            
            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(0, 470, 0, 100)
            imageLabel.Position = UDim2.new(0.5, -235, 0.5, -50)
            imageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            imageLabel.BorderSizePixel = 3
            imageLabel.BorderColor3 = Color3.fromRGB(255, 0, 255)
            imageLabel.Image = assetUrl
            imageLabel.ScaleType = Enum.ScaleType.Stretch
            imageLabel.Parent = screenGui
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 30)
            label.Position = UDim2.new(0, 0, 1, 5)
            label.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Text = "✅ getcustomasset FONCTIONNE!"
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = imageLabel
            
            print("\n" .. string.rep("═", 80))
            print("✅ ✅ ✅ SUCCESS! getcustomasset fonctionne!")
            print(string.rep("═", 80))
            print("💡 Utilisez getcustomasset pour votre système A-Ads")
            print("📖 Voir: Test_All_Methods.lua pour implémentation complète")
            print(string.rep("═", 80) .. "\n")
            return
        else
            print("❌ Téléchargement image échoué")
        end
    else
        print("❌ getcustomasset non disponible")
    end
    
    print("\n" .. string.rep("═", 80))
    print("❌ ÉCHEC: Aucune méthode fonctionnelle trouvée!")
    print(string.rep("═", 80))
    print("💡 SOLUTIONS:")
    print("   1. Mettre à jour Roblox (2024+) pour EditableImage")
    print("   2. Utiliser executor avec Drawing API (Synapse/KRNL)")
    print("   3. Vérifier connexion internet")
    print("   4. Voir GUIDE_TESTS.md section Troubleshooting")
    print(string.rep("═", 80) .. "\n")
end

-- Exécuter test
QuickTest()

print("💡 Tests complets disponibles:")
print("   - Test_All_Methods.lua (4 méthodes)")
print("   - Test_GIF_Animation.lua (GIFs)")
print("   - Test_Video_Support.lua (Vidéos)")
print("\n📖 Documentation:")
print("   - GUIDE_TESTS.md (Guide complet)")
print("   - RECHERCHE_WEB_RESULTATS.md (Résultats recherche)")
print("   - RECAP_FINAL.md (Récapitulatif)\n")
