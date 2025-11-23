--[[
    DIAGNOSTIC VISUEL - Est-ce que l'image s'affiche?
    Vérifie si ViewportFrame affiche réellement l'image A-Ads
]]

print("🔍 DIAGNOSTIC VISUEL - ViewportFrame\n")

-- Vérifier si ViewportFrame existe
local screenGui = game:GetService("CoreGui"):FindFirstChild("AAdsViewportUI")

if not screenGui then
    print("❌ AAdsViewportUI introuvable!")
    print("💡 Exécutez d'abord Integration_ViewportFrame.lua")
    return
end

print("✅ AAdsViewportUI trouvée")

local container = screenGui:FindFirstChild("AdContainer")
if not container then
    print("❌ AdContainer introuvable!")
    return
end

print("✅ AdContainer trouvée")
print("   Position:", container.Position)
print("   Taille:", container.Size)
print("   Couleur fond:", container.BackgroundColor3)

-- Trouver ViewportFrame
local viewport = container:FindFirstChildOfClass("ViewportFrame")
if not viewport then
    print("❌ ViewportFrame introuvable!")
    return
end

print("✅ ViewportFrame trouvée")
print("   Taille:", viewport.Size)

-- Trouver Part
local part = viewport:FindFirstChildOfClass("Part")
if not part then
    print("❌ Part introuvable!")
    return
end

print("✅ Part trouvée")
print("   Taille 3D:", part.Size)
print("   Transparence:", part.Transparency)

-- Trouver SurfaceGui
local surfaceGui = part:FindFirstChildOfClass("SurfaceGui")
if not surfaceGui then
    print("❌ SurfaceGui introuvable!")
    return
end

print("✅ SurfaceGui trouvée")
print("   Face:", surfaceGui.Face)
print("   CanvasSize:", surfaceGui.CanvasSize)

-- Trouver ImageLabel
local imageLabel = surfaceGui:FindFirstChildOfClass("ImageLabel")
if not imageLabel then
    print("❌ ImageLabel introuvable!")
    return
end

print("✅ ImageLabel trouvée")
print("   Image URL:", imageLabel.Image)
print("   Taille:", imageLabel.Size)
print("   ScaleType:", imageLabel.ScaleType)

-- Vérifier Camera
local camera = viewport.CurrentCamera
if not camera then
    print("❌ Camera introuvable!")
    return
end

print("✅ Camera trouvée")
print("   CFrame:", camera.CFrame)
print("   FieldOfView:", camera.FieldOfView)

print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📊 RÉSUMÉ DIAGNOSTIC")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

-- Test si image chargée
if imageLabel.Image ~= "" then
    print("✅ ImageLabel.Image contient une URL")
    print("   URL: " .. imageLabel.Image:sub(1, 80))
    
    -- Vérifier si ImageLabel est visible
    if imageLabel.ImageTransparency == 1 then
        print("⚠️ PROBLÈME: ImageTransparency = 1 (image invisible!)")
        print("💡 Fix: imageLabel.ImageTransparency = 0")
        
        -- Auto-fix
        imageLabel.ImageTransparency = 0
        print("✅ Fix appliqué!")
    else
        print("✅ ImageTransparency OK:", imageLabel.ImageTransparency)
    end
    
    -- Vérifier ImageColor3
    if imageLabel.ImageColor3 == Color3.fromRGB(0, 0, 0) then
        print("⚠️ PROBLÈME: ImageColor3 = noir (image invisible!)")
        print("💡 Fix: ImageColor3 = blanc")
        
        imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
        print("✅ Fix appliqué!")
    else
        print("✅ ImageColor3 OK:", imageLabel.ImageColor3)
    end
    
    print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🎯 QUESTION IMPORTANTE:")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    print("Est-ce que vous VOYEZ l'image A-Ads maintenant?")
    print("")
    print("A) ✅ OUI - Je vois l'image pub (970x250 ou autre)")
    print("B) ⚠️ NON - Je vois toujours un fond gris")
    print("C) ❓ Je vois un rectangle noir/blanc vide")
    print("")
    print("Répondez dans le chat!")
    
else
    print("❌ PROBLÈME: ImageLabel.Image est VIDE!")
    print("   Cela signifie que l'URL n'a pas été assignée")
    print("")
    print("💡 Cause possible:")
    print("   1. ExtractAllAdsFromHTML() a échoué")
    print("   2. Fallback URLs aussi échouées")
    print("   3. Bug dans CreateViewportImage()")
    print("")
    print("🔧 Solution: Exécutez Integration_ViewportFrame.lua à nouveau")
end

print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("💡 TESTS ADDITIONNELS")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")

-- Test URL directe
print("🧪 Test 1: URL A-Ads accessible?")

local testSuccess = pcall(function()
    local testUrl = "https://static.a-ads.com/a-ads-banners/531599/970x250"
    local data = game:HttpGet(testUrl)
    print("   ✅ URL accessible, taille:", #data, "bytes")
end)

if not testSuccess then
    print("   ❌ URL inaccessible (réseau bloqué?)")
end

-- Test SurfaceGui support
print("\n🧪 Test 2: SurfaceGui supporte ImageLabel.Image?")
print("   → C'est le test principal!")
print("   → Si vous voyez fond gris = SurfaceGui BLOQUE aussi les URLs")
print("   → Solution alors: Drawing API (Integration_Drawing_API.lua)")

print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
