--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║         DEMO INSTANTANÉE - Système Publicités            ║
    ║                  Copier/Coller Direct                     ║
    ╚═══════════════════════════════════════════════════════════╝
    
    ⚡ TEST EN 10 SECONDES :
    1. Copier ce fichier entier
    2. Coller dans executor Roblox
    3. Exécuter
    
    ✅ Publicité de démo apparaîtra automatiquement !
]]

-- Protection erreurs
local success, result = pcall(function()

-- ========== CONFIGURATION RAPIDE ==========
local CONFIG = {
    -- 🎨 Choisir position (changer si vous voulez)
    Position = "BOTTOM_LEFT",  -- TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT
    
    -- 🔄 Rotation automatique ?
    AutoRotate = true,
    
    -- ⏱️ Temps entre chaque pub (secondes)
    RotateInterval = 10,
    
    -- 💰 Votre provider (changer quand vous avez compte)
    Provider = "Custom",  -- "A-Ads", "PropellerAds", "Adsterra", "Custom"
    
    -- 🆔 Votre Ad Unit ID (quand vous avez compte A-Ads)
    AdUnitID = nil,  -- Ex: "123456"
}

-- ========== PUBLICITÉS DÉMO ==========
local DEMO_ADS = {
    {
        Image = "rbxassetid://10723434711",  -- Icône Search (blanc)
        Link = "https://discord.gg/example",
        Title = "🎮 Rejoins notre Discord !",
    },
    {
        Image = "rbxassetid://10723407389",  -- Icône Star (blanc)
        Link = "https://youtube.com/@example",
        Title = "⭐ Abonne-toi sur YouTube",
    },
    {
        Image = "rbxassetid://10723415766",  -- Icône Clock (blanc)
        Link = "https://github.com/example",
        Title = "🚀 Découvre nos projets",
    },
}

-- ========== NOTIFICATION ==========
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5,
        Icon = "rbxassetid://10723434711",
    })
end

-- ========== CHARGEMENT SYSTÈME ==========
Notify("📢 AdSystem", "Chargement système publicités...", 3)

-- Vérifier si fichiers disponibles
local hasFiles = readfile and isfile and isfile("Addsextention/AdManager.lua")

if hasFiles then
    -- Mode fichiers locaux
    print("[AdSystem] Chargement depuis fichiers locaux...")
    
    local AdManager = loadstring(readfile("Addsextention/AdManager.lua"))()
    
    _G.DemoAds = AdManager.new()
    
    _G.DemoAds:Init({
        Provider = CONFIG.Provider,
        AdUnitID = CONFIG.AdUnitID,
        AdsPool = DEMO_ADS,
        Position = CONFIG.Position,
        AutoRotate = CONFIG.AutoRotate,
        RotateInterval = CONFIG.RotateInterval,
        CPM = 1.50,
    })
    
    _G.DemoAds:Show()
    
    Notify("✅ AdSystem", "Publicités actives ! Regardez " .. CONFIG.Position, 5)
    
else
    -- Mode simplifié sans fichiers
    print("[AdSystem] Mode simplifié - Création display basique...")
    
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    
    -- Positions
    local POSITIONS = {
        TOP_LEFT = UDim2.new(0, 10, 0, 10),
        TOP_RIGHT = UDim2.new(1, -210, 0, 10),
        BOTTOM_LEFT = UDim2.new(0, 10, 1, -110),
        BOTTOM_RIGHT = UDim2.new(1, -210, 1, -110),
    }
    
    -- Créer ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdSystemDemo"
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
    container.Position = POSITIONS[CONFIG.Position] or POSITIONS.BOTTOM_LEFT
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
    
    -- Image Button
    local adButton = Instance.new("ImageButton")
    adButton.Name = "AdBanner"
    adButton.Size = UDim2.new(1, 0, 1, 0)
    adButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    adButton.BorderSizePixel = 0
    adButton.Image = DEMO_ADS[1].Image
    adButton.ScaleType = Enum.ScaleType.Fit
    adButton.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = adButton
    
    -- Label "Ad"
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
    
    -- Bouton fermeture
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
    local currentAdIndex = 1
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        Notify("👋 AdSystem", "Publicités désactivées", 3)
    end)
    
    adButton.MouseButton1Click:Connect(function()
        local ad = DEMO_ADS[currentAdIndex]
        if setclipboard then
            setclipboard(ad.Link)
            Notify("📋 Lien copié !", ad.Title, 3)
        else
            print("[AdSystem] Lien:", ad.Link)
        end
    end)
    
    -- Rotation auto
    if CONFIG.AutoRotate and #DEMO_ADS > 1 then
        spawn(function()
            while container and container.Parent do
                wait(CONFIG.RotateInterval)
                
                currentAdIndex = currentAdIndex + 1
                if currentAdIndex > #DEMO_ADS then
                    currentAdIndex = 1
                end
                
                -- Fade out
                TweenService:Create(adButton, TweenInfo.new(0.3), {
                    ImageTransparency = 1
                }):Play()
                
                wait(0.3)
                
                -- Change image
                adButton.Image = DEMO_ADS[currentAdIndex].Image
                
                -- Fade in
                TweenService:Create(adButton, TweenInfo.new(0.3), {
                    ImageTransparency = 0
                }):Play()
            end
        end)
    end
    
    Notify("✅ AdSystem Demo", "Publicité affichée ! (Mode simplifié)", 5)
end

-- ========== INFORMATIONS ==========
print([[

╔═══════════════════════════════════════════════════════════╗
║              AdSystem - Démo Activée ✅                   ║
╚═══════════════════════════════════════════════════════════╝

📍 Position    : ]] .. CONFIG.Position .. [[

🔄 Auto-Rotate : ]] .. tostring(CONFIG.AutoRotate) .. [[

⏱️  Intervalle  : ]] .. CONFIG.RotateInterval .. [[s

💡 PROCHAINES ÉTAPES:

1️⃣  Créer compte A-Ads (gratuit): https://a-ads.com
2️⃣  Obtenir Ad Unit ID (ex: 123456)
3️⃣  Modifier CONFIG.AdUnitID ci-dessus
4️⃣  Changer CONFIG.Provider = "A-Ads"
5️⃣  Gagner de l'argent avec chaque impression ! 💰

📚 Documentation complète: README.md
🚀 Guide rapide: QUICKSTART.md
💻 Exemples: Example_Usage.lua

════════════════════════════════════════════════════════════

]])

end) -- Fin pcall

-- Gestion erreurs
if not success then
    warn("[AdSystem] ERREUR:", result)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ AdSystem Erreur",
        Text = "Voir console pour détails",
        Duration = 5,
    })
end
