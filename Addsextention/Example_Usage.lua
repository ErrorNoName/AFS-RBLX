--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║          Test & Exemple - AdSystem Complet               ║
    ╚═══════════════════════════════════════════════════════════╝
    
    Ce fichier montre comment utiliser le système de publicités
    dans différents scénarios.
]]

print("=== AdSystem Test & Exemples ===\n")

-- ============================================================
-- EXEMPLE 1 : Configuration Simple (A-Ads)
-- ============================================================
print("--- Exemple 1: A-Ads Basic ---")

local AdManager = loadstring(readfile("Addsextention/AdManager.lua"))()

local adSystem = AdManager.new()

-- Initialiser avec A-Ads
adSystem:Init({
    Provider = "A-Ads",
    AdUnitID = "123456",           -- Remplacer par votre ID
    Position = "BOTTOM_LEFT",
    AutoRotate = false,            -- Pas de rotation (1 seule pub)
    CPM = 1.50,                    -- Estimation CPM A-Ads
})

-- Afficher
adSystem:Show()

print("✅ A-Ads configuré et affiché\n")

wait(3)

-- ============================================================
-- EXEMPLE 2 : Pool Publicités Custom
-- ============================================================
print("--- Exemple 2: Custom Ads Pool ---")

local customAds = AdManager.new()

customAds:Init({
    Provider = "Custom",
    AdsPool = {
        {
            Image = "rbxassetid://10723434711",   -- Icône Search
            Link = "https://discord.gg/votreserveur",
            Title = "Rejoins notre Discord !",
        },
        {
            Image = "rbxassetid://10723407389",   -- Icône Star
            Link = "https://youtube.com/@votrechaine",
            Title = "Abonne-toi sur YouTube",
        },
        {
            Image = "rbxassetid://10723415766",   -- Icône Clock
            Link = "https://github.com/votrerepo",
            Title = "Découvre nos projets",
        },
    },
    Position = "TOP_RIGHT",
    AutoRotate = true,
    RotateInterval = 10,           -- Changer toutes les 10 secondes
    TrackClicks = true,
    TrackImpressions = true,
})

customAds:Show()

print("✅ 3 publicités custom en rotation\n")

wait(3)

-- ============================================================
-- EXEMPLE 3 : Utilisation Controller
-- ============================================================
print("--- Exemple 3: Controller Controls ---")

local controller = customAds.Controller

-- Obtenir stats
local stats = controller:GetStats()
print("Impressions:", stats.Impressions)
print("Clicks:", stats.Clicks)
print("Revenue:", "$" .. stats.Revenue)

-- Changer position
print("\n🔄 Changement position...")
controller:SetPosition("BOTTOM_RIGHT")
wait(2)

-- Prochaine pub
print("➡️ Prochaine publicité...")
controller:NextAd()
wait(2)

-- Afficher config
controller:PrintConfig()

print("\n")

-- ============================================================
-- EXEMPLE 4 : PropellerAds avec API Token
-- ============================================================
print("--- Exemple 4: PropellerAds API ---")

local propellerAds = AdManager.new()

propellerAds:Init({
    Provider = "PropellerAds",
    AdUnitID = "789012",           -- Zone ID PropellerAds
    APIToken = "votre_api_token",  -- Token depuis dashboard
    Position = "TOP_LEFT",
    AutoRotate = true,
    RotateInterval = 30,
    CPM = 5.00,                    -- PropellerAds CPM plus élevé
    Webhook = "https://discord.com/api/webhooks/YOUR_WEBHOOK",
})

-- Note: Ne fonctionnera pas sans vrai token
-- propellerAds:Show()

print("⚠️ Exemple PropellerAds (nécessite vrai API Token)\n")

-- ============================================================
-- EXEMPLE 5 : Hotkeys et Contrôles Avancés
-- ============================================================
print("--- Exemple 5: Setup Hotkeys ---")

-- Activer raccourcis clavier
controller:SetupHotkeys()

print([[
🎮 Raccourcis clavier activés:
   Ctrl+Alt+N : Prochaine publicité
   Ctrl+Alt+H : Afficher/Masquer pubs
   Ctrl+Alt+P : Changer position

]])

-- ============================================================
-- EXEMPLE 6 : Intégration SriBlox Modern
-- ============================================================
print("--- Exemple 6: Intégration SriBlox ---")

--[[ 
    Pour intégrer dans SriBlox Modern, ajouter dans le fichier principal:
    
    -- Après chargement UI principale
    local AdSystem = loadstring(readfile("Addsextention/AdManager.lua"))()
    
    _G.SriBloxAds = AdSystem.new()
    _G.SriBloxAds:Init({
        Provider = "A-Ads",
        AdUnitID = "VOTRE_ID",
        Position = "BOTTOM_LEFT",
        AutoRotate = true,
        RotateInterval = 30,
    })
    
    _G.SriBloxAds:Show()
    
    -- Toggle pubs avec F7 (optionnel)
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.F7 then
            _G.SriBloxAds.Controller:ToggleAds()
        end
    end)
]]

print("📖 Voir exemple code ci-dessus pour intégration\n")

-- ============================================================
-- EXEMPLE 7 : Analytics et Webhook Discord
-- ============================================================
print("--- Exemple 7: Discord Analytics ---")

local analyticsAds = AdManager.new()

analyticsAds:Init({
    Provider = "Custom",
    AdsPool = {
        {
            Image = "rbxassetid://10723434711",
            Link = "https://example.com",
            Title = "Test Analytics",
        },
    },
    Position = "BOTTOM_RIGHT",
    Webhook = "https://discord.com/api/webhooks/VOTRE_WEBHOOK",
    TrackClicks = true,
    TrackImpressions = true,
})

analyticsAds:Show()

print([[
📊 Webhook Discord configuré:
   - Chaque impression envoyée
   - Chaque click enregistré
   - Stats temps réel

]])

-- ============================================================
-- EXEMPLE 8 : Gestion Erreurs et Fallback
-- ============================================================
print("--- Exemple 8: Error Handling ---")

local safeAds = AdManager.new()

local success, err = pcall(function()
    safeAds:Init({
        Provider = "InvalidProvider",  -- Provider invalide
        Position = "INVALID_POS",      -- Position invalide
    })
end)

if not success then
    print("❌ Erreur détectée (normal):", err)
    
    -- Fallback configuration valide
    safeAds:Init({
        Provider = "Custom",
        AdsPool = {
            {
                Image = "rbxassetid://10723434711",
                Link = "https://fallback.com",
                Title = "Fallback Ad",
            },
        },
        Position = "BOTTOM_LEFT",  -- Position corrigée automatiquement
    })
    
    print("✅ Fallback configuration appliquée\n")
end

-- ============================================================
-- INFORMATIONS FINALES
-- ============================================================
print("=== Informations Utiles ===\n")

print([[
📝 Providers Disponibles:
   - A-Ads       : Anonyme, Bitcoin, facile
   - PropellerAds: CPM élevé, API avancée
   - Adsterra    : Flexible, paiement $5 min
   - Custom      : Vos propres publicités

📍 Positions:
   - TOP_LEFT, TOP_RIGHT
   - BOTTOM_LEFT, BOTTOM_RIGHT

💰 Estimation Revenue:
   A-Ads       : $0.50 - $2.00 CPM
   PropellerAds: $0.50 - $15.00 CPM
   Adsterra    : $0.30 - $10.00 CPM

🔗 Resources:
   - A-Ads: https://a-ads.com
   - PropellerAds: https://publishers.propellerads.com
   - Adsterra: https://publishers.adsterra.com

📚 Documentation complète: README.md
]])

-- ============================================================
-- Cleanup après tests
-- ============================================================
print("\n🧹 Nettoyage après 10 secondes...")

wait(10)

-- Détruire instances
adSystem:Destroy()
customAds:Destroy()
analyticsAds:Destroy()
safeAds:Destroy()

print("✅ Tests terminés, système nettoyé\n")
print("=== Fin des exemples ===")
