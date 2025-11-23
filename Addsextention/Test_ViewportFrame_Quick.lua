--[[
    TEST RAPIDE VIEWPORTFRAME
    Affiche une image A-Ads de test sans extraction iframe
    Pour valider que la technique fonctionne
]]

print("🧪 TEST VIEWPORTFRAME - Affichage image A-Ads externe\n")

-- ===== IMAGE TEST A-ADS =====
local TEST_IMAGE = "https://static.a-ads.com/a-ads-banners/531599/970x250"
local TEST_WIDTH = 970
local TEST_HEIGHT = 250

-- ===== SERVICES =====
local TweenService = game:GetService("TweenService")

-- ===== GUI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TestViewportFrame"
screenGui.ResetOnSpawn = false
if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end
screenGui.Parent = game:GetService("CoreGui")

-- Container
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 500, 0, 129)  -- Scaled version
container.Position = UDim2.new(0.5, -250, 0.5, -65)
container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
container.BorderSizePixel = 2
container.BorderColor3 = Color3.fromRGB(0, 255, 0)  -- Bordure verte = test
container.Parent = screenGui

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, -35)
title.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
title.BorderSizePixel = 0
title.Text = "🧪 TEST VIEWPORTFRAME - Image externe A-Ads"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = container

-- ===== CRÉATION VIEWPORTFRAME =====
print("📐 Création ViewportFrame...")

local viewport = Instance.new("ViewportFrame")
viewport.Size = UDim2.new(1, 0, 1, 0)
viewport.BackgroundTransparency = 1
viewport.BorderSizePixel = 0
viewport.Parent = container

-- Part 3D
local part = Instance.new("Part")
part.Size = Vector3.new(TEST_WIDTH / 100, TEST_HEIGHT / 100, 0.01)
part.Anchored = true
part.CanCollide = false
part.Transparency = 1
part.CFrame = CFrame.new(0, 0, 0)
part.Parent = viewport

-- SurfaceGui sur Part
local surfaceGui = Instance.new("SurfaceGui")
surfaceGui.Face = Enum.NormalId.Front
surfaceGui.CanvasSize = Vector2.new(TEST_WIDTH, TEST_HEIGHT)
surfaceGui.LightInfluence = 0
surfaceGui.Parent = part

-- ImageLabel dans SurfaceGui
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.BackgroundTransparency = 1
imageLabel.BorderSizePixel = 0
imageLabel.Image = TEST_IMAGE  -- URL EXTERNE A-ADS
imageLabel.ScaleType = Enum.ScaleType.Stretch
imageLabel.Parent = surfaceGui

-- Camera
local camera = Instance.new("Camera")
local distance = math.max(TEST_WIDTH, TEST_HEIGHT) / 70
camera.CFrame = CFrame.new(0, 0, distance) * CFrame.Angles(0, math.rad(180), 0)
camera.FieldOfView = 70
camera.Parent = viewport
viewport.CurrentCamera = camera

print("✅ ViewportFrame créé!\n")

-- ===== STATUS LABEL =====
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 50)
status.Position = UDim2.new(0, 0, 1, 5)
status.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
status.BorderSizePixel = 0
status.Text = "Attente chargement image..."
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.TextWrapped = true
status.Parent = container

-- Check chargement après 3 secondes
spawn(function()
    wait(3)
    
    if imageLabel.Image ~= "" then
        status.Text = "✅ SUCCÈS! Image A-Ads affichée via ViewportFrame"
        status.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        status.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("✅ TEST RÉUSSI!")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("Image URL: " .. TEST_IMAGE)
        print("Dimensions: " .. TEST_WIDTH .. "x" .. TEST_HEIGHT)
        print("Technique: ViewportFrame + SurfaceGui")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
        print("💡 Si vous voyez l'image A-Ads ci-dessus:")
        print("   → ViewportFrame fonctionne!")
        print("   → Integration_ViewportFrame.lua prêt!")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    else
        status.Text = "❌ ÉCHEC: Image non chargée (vérifier réseau)"
        status.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("❌ TEST ÉCHOUÉ")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("Possible causes:")
        print("1. Réseau lent/bloqué")
        print("2. URL A-Ads expirée")
        print("3. Executor ne supporte pas SurfaceGui")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    end
end)

-- Bouton fermeture
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, -35)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = container

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("❌ Test fermé")
end)

print("💡 Regardez le centre de l'écran!")
print("   Vous devriez voir l'image A-Ads Banner 970x250")
print("   Si visible → Technique fonctionne! ✅\n")
