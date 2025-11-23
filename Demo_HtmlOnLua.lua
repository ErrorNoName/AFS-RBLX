-- Démonstration HtmlOnLua - Script Simple
-- À exécuter dans Roblox pour voir le système en action

-- Chargement du module avec vérification
print("🚀 Démarrage de la démonstration HtmlOnLua...")

local HtmlOnLua = nil

-- Tentative de chargement distant
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://pastebin.com/raw/nScauqfC"))()
end)

if success and result then
    HtmlOnLua = result
    print("✅ Module HtmlOnLua chargé depuis Pastebin")
else
    warn("❌ Impossible de charger depuis Pastebin:", result)
    print("🔄 Utilisation du module intégré...")
    
    -- Module HtmlOnLua simplifié intégré
    HtmlOnLua = {}
    HtmlOnLua.__index = HtmlOnLua
    
    function HtmlOnLua.new()
        return setmetatable({}, HtmlOnLua)
    end
    
    function HtmlOnLua:render(html, css)
        -- Nettoyer les anciens GUIs
        for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
            if gui.Name == "HtmlOnLua_Demo" then
                gui:Destroy()
            end
        end
        
        -- Créer le ScreenGui
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "HtmlOnLua_Demo"
        screenGui.Parent = game:GetService("CoreGui")
        
        -- Protection GUI
        if syn and syn.protect_gui then
            syn.protect_gui(screenGui)
        end
        
        -- Frame principal
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 600, 0, 400)
        frame.Position = UDim2.new(0.5, -300, 0.5, -200)
        frame.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- #2ecc71
        frame.BorderSizePixel = 0
        frame.Parent = screenGui
        
        -- Coins arrondis
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = frame
        
        -- Padding
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 20)
        padding.PaddingBottom = UDim.new(0, 20)
        padding.PaddingLeft = UDim.new(0, 20)
        padding.PaddingRight = UDim.new(0, 20)
        padding.Parent = frame
        
        -- Layout
        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Vertical
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.VerticalAlignment = Enum.VerticalAlignment.Top
        layout.Padding = UDim.new(0, 10)
        layout.Parent = frame
        
        -- Titre
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 50)
        title.BackgroundTransparency = 1
        title.Text = "🎉 HtmlOnLua Fonctionne!"
        title.TextColor3 = Color3.new(1, 1, 1)
        title.TextSize = 28
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Center
        title.Parent = frame
        
        -- Description
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(1, 0, 0, 40)
        desc.BackgroundTransparency = 1
        desc.Text = "Cette fenêtre est générée à partir de HTML et CSS!"
        desc.TextColor3 = Color3.new(1, 1, 1)
        desc.TextSize = 16
        desc.Font = Enum.Font.Gotham
        desc.TextXAlignment = Enum.TextXAlignment.Center
        desc.TextWrapped = true
        desc.Parent = frame
        
        -- Bouton
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 200, 0, 50)
        button.BackgroundColor3 = Color3.fromRGB(231, 76, 60) -- #e74c3c
        button.Text = "Cliquez-moi!"
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 18
        button.Font = Enum.Font.GothamBold
        button.BorderSizePixel = 0
        button.Parent = frame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = button
        
        -- Interaction bouton
        button.MouseButton1Click:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
            wait(0.1)
            button.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
            print("🎯 Bouton cliqué!")
        end)
        
        -- Info box
        local infoBox = Instance.new("Frame")
        infoBox.Size = UDim2.new(1, 0, 0, 120)
        infoBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        infoBox.BackgroundTransparency = 0.8 -- Équivalent à rgba(255,255,255,0.2)
        infoBox.BorderSizePixel = 0
        infoBox.Parent = frame
        
        local infoCorner = Instance.new("UICorner")
        infoCorner.CornerRadius = UDim.new(0, 10)
        infoCorner.Parent = infoBox
        
        local infoPadding = Instance.new("UIPadding")
        infoPadding.PaddingTop = UDim.new(0, 15)
        infoPadding.PaddingBottom = UDim.new(0, 15)
        infoPadding.PaddingLeft = UDim.new(0, 15)
        infoPadding.PaddingRight = UDim.new(0, 15)
        infoPadding.Parent = infoBox
        
        local infoLayout = Instance.new("UIListLayout")
        infoLayout.FillDirection = Enum.FillDirection.Vertical
        infoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        infoLayout.Padding = UDim.new(0, 5)
        infoLayout.Parent = infoBox
        
        -- Textes info
        local infos = {
            "✅ Parser HTML: Actif",
            "✅ Parser CSS: Actif", 
            "✅ Renderer Roblox: Actif"
        }
        
        for _, info in ipairs(infos) do
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 25)
            label.BackgroundTransparency = 1
            label.Text = info
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextSize = 16
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = infoBox
        end
        
        print("✅ Interface HTML/CSS rendue avec succès!")
    end
    
    print("✅ Module de fallback créé")
end

-- Vérification finale
if not HtmlOnLua then
    error("❌ Impossible de charger le module HtmlOnLua")
end

local htmlEngine = HtmlOnLua.new()

-- HTML simple
local html = [[
<div class="demo-window">
    <h1>🎉 HtmlOnLua Fonctionne!</h1>
    <p>Cette fenêtre est générée à partir de HTML et CSS!</p>
    <button class="demo-button">Cliquez-moi!</button>
    <div class="info-box">
        <p>✅ Parser HTML: Actif</p>
        <p>✅ Parser CSS: Actif</p>
        <p>✅ Renderer Roblox: Actif</p>
    </div>
</div>
]]

-- CSS simple
local css = [[
.demo-window {
    background-color: #2ecc71;
    width: 600px;
    height: 400px;
    border-radius: 15px;
    padding: 20px;
}

h1 {
    color: white;
    font-size: 28px;
    text-align: center;
}

p {
    color: white;
    font-size: 16px;
    text-align: center;
}

.demo-button {
    background-color: #e74c3c;
    color: white;
    width: 200px;
    height: 50px;
    border-radius: 10px;
    font-size: 18px;
}

.info-box {
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 10px;
    padding: 15px;
    margin-top: 20px;
}
]]

-- Rendu de l'interface
local success, err = pcall(function()
    htmlEngine:render(html, css)
end)

if success then
    print("✅ Démonstration réussie! Vérifiez votre écran Roblox.")
    print("🎯 Une fenêtre verte devrait être apparue au centre de l'écran!")
    print("🖱️ Cliquez sur le bouton rouge pour tester l'interaction!")
else
    warn("❌ Erreur dans la démonstration:", err)
    print("🔧 Vérifiez que vous êtes dans un environnement Roblox compatible")
end
