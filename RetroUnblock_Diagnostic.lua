-- 🔧 DIAGNOSTIC RETROUNBLOCK - Script de test et dépannage
-- Vérification et diagnostic des problèmes de chargement

print("🔍 === DIAGNOSTIC RETROUNBLOCK ===")
print("🛠️ Test des composants et dépannage")

-- Test 1: Environnement Roblox
print("\n📋 TEST 1: Environnement Roblox")
local hasGame = game ~= nil
local hasPlayers = game and game:GetService("Players") ~= nil
local hasLocalPlayer = hasPlayers and game.Players.LocalPlayer ~= nil
local hasPlayerGui = hasLocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui") ~= nil
local hasHttpService = game and pcall(function() return game:GetService("HttpService") end)

print("   Game disponible:", hasGame and "✅" or "❌")
print("   Players service:", hasPlayers and "✅" or "❌") 
print("   LocalPlayer:", hasLocalPlayer and "✅" or "❌")
print("   PlayerGui:", hasPlayerGui and "✅" or "❌")
print("   HttpService:", hasHttpService and "✅" or "❌")

-- Test 2: Accès HTTP
print("\n📡 TEST 2: Connectivité HTTP")
local httpEnabled = false
local canAccessPastebin = false

if hasHttpService then
    local httpSuccess, httpResult = pcall(function()
        return game:GetService("HttpService"):GetAsync("https://httpbin.org/get", true)
    end)
    httpEnabled = httpSuccess
    print("   HTTP requests:", httpEnabled and "✅" or "❌")
    
    if httpEnabled then
        local pastebinSuccess, pastebinResult = pcall(function()
            return game:GetService("HttpService"):GetAsync("https://pastebin.com/raw/nScauqfC", true)
        end)
        canAccessPastebin = pastebinSuccess and pastebinResult and #pastebinResult > 100
        print("   Pastebin HtmlOnLua:", canAccessPastebin and "✅" or "❌")
        
        if not canAccessPastebin then
            print("   ⚠️ Erreur Pastebin:", pastebinResult or "Réponse vide")
        end
    end
end

-- Test 3: Chargement HtmlOnLua
print("\n🎨 TEST 3: Chargement HtmlOnLua")
local HtmlOnLua = nil
local engine = nil

if canAccessPastebin then
    local loadSuccess, loadResult = pcall(function()
        local code = game:GetService("HttpService"):GetAsync("https://pastebin.com/raw/nScauqfC", true)
        return loadstring(code)()
    end)
    
    if loadSuccess and loadResult then
        HtmlOnLua = loadResult
        print("   Module HtmlOnLua:", "✅")
        
        local engineSuccess, engineResult = pcall(function()
            return HtmlOnLua.new()
        end)
        
        if engineSuccess then
            engine = engineResult
            print("   Moteur HtmlOnLua:", "✅")
        else
            print("   Moteur HtmlOnLua:", "❌", engineResult)
        end
    else
        print("   Module HtmlOnLua:", "❌", loadResult)
    end
else
    print("   Module HtmlOnLua: ❌ (Pastebin inaccessible)")
end

-- Test 4: Interface de secours
print("\n🖼️ TEST 4: Interface Roblox Native")
local function createTestInterface()
    if not hasPlayerGui then
        error("PlayerGui non disponible")
    end
    
    -- Nettoyage d'anciennes interfaces
    local existing = game.Players.LocalPlayer.PlayerGui:FindFirstChild("RetroUnblockTest")
    if existing then existing:Destroy() end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RetroUnblockTest"
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 300)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 15)
    Corner.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.Position = UDim2.new(0, 0, 0, 20)
    Title.BackgroundTransparency = 1
    Title.Text = "🚀 RetroUnblock Test"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = Frame
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, 0, 0, 40)
    Status.Position = UDim2.new(0, 0, 0, 100)
    Status.BackgroundTransparency = 1
    Status.Text = "Interface de test fonctionnelle ✅"
    Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    Status.TextScaled = true
    Status.Font = Enum.Font.SourceSans
    Status.Parent = Frame
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 50)
    Button.Position = UDim2.new(0.5, -100, 0, 180)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    Button.Text = "Fermer Test"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.SourceSans
    Button.Parent = Frame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    return true
end

local nativeSuccess, nativeError = pcall(createTestInterface)
print("   Interface native:", nativeSuccess and "✅" or "❌")
if not nativeSuccess then
    print("   Erreur:", nativeError)
end

-- Résumé et recommandations
print("\n📊 === RÉSUMÉ DIAGNOSTIC ===")

if engine then
    print("🟢 ÉTAT: HtmlOnLua prêt - Interface complète disponible")
    print("✅ Recommandation: Utilisez RetroUnblock_Ultimate.lua normalement")
elseif HtmlOnLua then
    print("🟡 ÉTAT: HtmlOnLua chargé mais moteur défaillant")
    print("⚠️ Recommandation: Vérifiez la compatibilité de votre exploit")
elseif httpEnabled then
    print("🟠 ÉTAT: HTTP OK mais Pastebin inaccessible")
    print("🔧 Recommandation: Vérifiez le lien Pastebin ou utilisez une copie locale")
elseif hasPlayerGui then
    print("🔴 ÉTAT: HTTP désactivé - Interface native uniquement")
    print("🎮 Recommandation: Utilisez l'interface Roblox native intégrée")
else
    print("⛔ ÉTAT: Environnement incompatible")
    print("❌ Recommandation: Vérifiez votre environnement Roblox")
end

print("\n🚀 === SOLUTIONS DISPONIBLES ===")
print("1. 🌐 Interface HtmlOnLua complète (si disponible)")
print("2. 🎮 Interface Roblox native (toujours disponible)")  
print("3. 🔧 Mode diagnostic et test (ce script)")

print("\n✅ Diagnostic terminé - Consultez les résultats ci-dessus")

-- Auto-nettoyage après 10 secondes
if nativeSuccess then
    spawn(function()
        wait(10)
        local testGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("RetroUnblockTest")
        if testGui then
            testGui:Destroy()
            print("🧹 Interface de test fermée automatiquement")
        end
    end)
end
