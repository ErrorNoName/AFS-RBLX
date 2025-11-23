-- 🔧 TEST PASTEBIN HTMLONLUA - Vérification de chargement pour exécuteur
-- Script de test pour vérifier que HtmlOnLua se charge correctement depuis Pastebin

print("🧪 === TEST DE CHARGEMENT HTMLONLUA ===")
print("🎯 Vérification du chargement depuis Pastebin pour exécuteur Roblox")

-- Test 1: Vérification de l'environnement
print("\n📋 ÉTAPE 1: Vérification de l'environnement")

local hasGame = pcall(function() return game end)
local hasHttpService = false
local hasHttpGet = false

if hasGame then
    print("✅ Environnement Roblox détecté")
    
    -- Test HttpService
    local httpSuccess, httpService = pcall(function()
        return game:GetService("HttpService")
    end)
    
    if httpSuccess then
        hasHttpService = true
        print("✅ HttpService disponible")
    else
        print("❌ HttpService non disponible")
    end
    
    -- Test game:HttpGet (méthode exécuteur)
    local httpGetSuccess = pcall(function()
        return game.HttpGet ~= nil
    end)
    
    if httpGetSuccess then
        hasHttpGet = true
        print("✅ game:HttpGet disponible (exécuteur)")
    else
        print("⚠️ game:HttpGet non disponible")
    end
else
    print("❌ Environnement Roblox non détecté")
end

-- Test 2: Test de connectivité Pastebin
print("\n📡 ÉTAPE 2: Test de connectivité Pastebin")

local pastebinLinks = {
    "https://pastebin.com/raw/nScauqfC",  -- Lien principal
    "https://raw.githubusercontent.com/example/HtmlOnLua/main/HtmlOnLua.lua", -- Alternative GitHub
}

local loadedCode = nil
local workingLink = nil

for i, link in ipairs(pastebinLinks) do
    print("🔗 Test du lien " .. i .. ": " .. link)
    
    if hasHttpGet then
        local success, result = pcall(function()
            return game:HttpGet(link)
        end)
        
        if success and result and #result > 100 then
            loadedCode = result
            workingLink = link
            print("✅ Lien fonctionnel - Code téléchargé (" .. #result .. " caractères)")
            break
        else
            print("❌ Échec - " .. (result or "Erreur inconnue"))
        end
    elseif hasHttpService then
        local success, result = pcall(function()
            return game:GetService("HttpService"):GetAsync(link, true)
        end)
        
        if success and result and #result > 100 then
            loadedCode = result
            workingLink = link
            print("✅ Lien fonctionnel - Code téléchargé (" .. #result .. " caractères)")
            break
        else
            print("❌ Échec - " .. (result or "Erreur inconnue"))
        end
    end
end

-- Test 3: Compilation et test du module
print("\n🔄 ÉTAPE 3: Compilation et test du module")

local HtmlOnLua = nil
local engine = nil

if loadedCode then
    print("💾 Code HtmlOnLua disponible")
    
    -- Tentative de compilation
    local compileSuccess, compileResult = pcall(function()
        return loadstring(loadedCode)
    end)
    
    if compileSuccess and compileResult then
        print("✅ Compilation réussie")
        
        -- Exécution du module
        local executeSuccess, executeResult = pcall(function()
            return compileResult()
        end)
        
        if executeSuccess and executeResult then
            HtmlOnLua = executeResult
            print("✅ Module HtmlOnLua chargé")
            
            -- Test de création d'engine
            local engineSuccess, engineResult = pcall(function()
                return HtmlOnLua.new()
            end)
            
            if engineSuccess and engineResult then
                engine = engineResult
                print("✅ Moteur HtmlOnLua créé avec succès")
            else
                print("❌ Erreur de création du moteur:", engineResult)
            end
        else
            print("❌ Erreur d'exécution du module:", executeResult)
        end
    else
        print("❌ Erreur de compilation:", compileResult)
    end
else
    print("❌ Aucun code HtmlOnLua disponible")
end

-- Test 4: Test de rendu simple
print("\n🎨 ÉTAPE 4: Test de rendu")

if engine then
    print("🚀 Test de rendu avec HtmlOnLua...")
    
    local testHTML = [[
    <div class="test-container">
        <h1>Test HtmlOnLua</h1>
        <p>Si vous voyez cette interface, HtmlOnLua fonctionne parfaitement !</p>
        <button class="test-btn">Bouton Test</button>
    </div>
    ]]
    
    local testCSS = [[
    .test-container {
        background-color: #2c3e50;
        width: 600px;
        height: 400px;
        border-radius: 15px;
        color: white;
        text-align: center;
        padding: 50px;
    }
    
    h1 {
        color: #e74c3c;
        font-size: 32px;
        margin-bottom: 20px;
    }
    
    p {
        font-size: 18px;
        margin-bottom: 30px;
    }
    
    .test-btn {
        background-color: #3498db;
        color: white;
        width: 200px;
        height: 60px;
        border-radius: 10px;
        font-size: 20px;
    }
    ]]
    
    local renderSuccess, renderError = pcall(function()
        engine:render(testHTML, testCSS)
    end)
    
    if renderSuccess then
        print("✅ SUCCÈS ! Interface de test rendue")
        print("🎮 Vous devriez voir une interface de test sur votre écran")
    else
        print("❌ Erreur de rendu:", renderError)
    end
else
    print("⚠️ Moteur non disponible - Création d'interface native de test")
    
    local nativeSuccess, nativeError = pcall(function()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "HtmlOnLuaTest"
        ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 500, 0, 300)
        Frame.Position = UDim2.new(0.5, -250, 0.5, -150)
        Frame.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
        Frame.BorderSizePixel = 0
        Frame.Parent = ScreenGui
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 15)
        Corner.Parent = Frame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 60)
        Title.Position = UDim2.new(0, 0, 0, 20)
        Title.BackgroundTransparency = 1
        Title.Text = "❌ HtmlOnLua Test Échoué"
        Title.TextColor3 = Color3.fromRGB(231, 76, 60)
        Title.TextScaled = true
        Title.Font = Enum.Font.SourceSansBold
        Title.Parent = Frame
        
        local Message = Instance.new("TextLabel")
        Message.Size = UDim2.new(1, 0, 0, 100)
        Message.Position = UDim2.new(0, 0, 0, 100)
        Message.BackgroundTransparency = 1
        Message.Text = "Le chargement de HtmlOnLua a échoué.\nVérifiez votre connexion et l'exécuteur."
        Message.TextColor3 = Color3.fromRGB(255, 255, 255)
        Message.TextScaled = true
        Message.Font = Enum.Font.SourceSans
        Message.Parent = Frame
        
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 150, 0, 40)
        CloseBtn.Position = UDim2.new(0.5, -75, 0, 230)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
        CloseBtn.Text = "Fermer"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.TextScaled = true
        CloseBtn.Font = Enum.Font.SourceSans
        CloseBtn.Parent = Frame
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = CloseBtn
        
        CloseBtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
        
        return true
    end)
    
    if nativeSuccess then
        print("✅ Interface native de test créée")
    else
        print("❌ Erreur interface native:", nativeError)
    end
end

-- Résumé final
print("\n📊 === RÉSUMÉ FINAL ===")

if engine then
    print("🟢 SUCCÈS COMPLET - HtmlOnLua opérationnel")
    print("✅ Lien fonctionnel:", workingLink)
    print("✅ Module chargé et moteur créé")
    print("🎯 Vous pouvez maintenant utiliser RetroUnblock_Ultimate.lua")
elseif HtmlOnLua then
    print("🟡 SUCCÈS PARTIEL - Module chargé mais moteur défaillant")
    print("⚠️ Problème avec l'initialisation du moteur")
elseif loadedCode then
    print("🟠 ÉCHEC - Code téléchargé mais compilation échouée")
    print("🔧 Problème avec le code Pastebin")
elseif hasHttpGet or hasHttpService then
    print("🔴 ÉCHEC - Connectivité réseau")
    print("❌ Impossible d'accéder à Pastebin")
    print("🔗 Vérifiez votre connexion internet")
else
    print("⛔ ÉCHEC COMPLET - Environnement incompatible")
    print("❌ Environnement d'exécution non supporté")
end

print("\n🎯 Test terminé - Consultez les résultats ci-dessus")

-- Nettoyage automatique de l'interface de test après 15 secondes
spawn(function()
    wait(15)
    local testGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("HtmlOnLuaTest")
    if testGui then
        testGui:Destroy()
        print("🧹 Interface de test nettoyée automatiquement")
    end
end)
