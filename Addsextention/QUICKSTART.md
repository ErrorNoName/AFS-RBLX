# 🚀 Quick Start - Installation en 5 minutes

## Étape 1 : Créer compte A-Ads (GRATUIT, ANONYME)

1. **Aller sur** : https://a-ads.com
2. **Cliquer** : "Sign Up" (pas de KYC requis)
3. **Créer compte** avec email temporaire (optionnel)
4. **Naviguer** : Dashboard → "New Ad Unit"
5. **Configurer** :
   - Type: **Banner**
   - Size: **200×100** (Medium Rectangle)
   - Name: "Roblox Script Ad"
6. **Copier l'ID** qui apparaît (ex: `123456`)

**URL complète de votre pub** : `https://ad.a-ads.com/123456.png`

---

## Étape 2 : Télécharger les fichiers

Deux options :

### Option A - Dossier Complet
```
Télécharger le dossier Addsextention/ dans votre workspace exploit
```

### Option B - Fichiers Individuels
Télécharger dans `Addsextention/` :
- `AdManager.lua`
- `AdPositions.lua`
- `AdDisplay.lua`
- `AdController.lua`

---

## Étape 3 : Code de Base (Copier/Coller)

### **Version Ultra Simple** (3 lignes)
```lua
local Ads = loadstring(readfile("Addsextention/AdManager.lua"))().new()
Ads:Init({Provider = "A-Ads", AdUnitID = "123456"})  -- Remplacer 123456
Ads:Show()
```

### **Version Complète** (recommandé)
```lua
-- Charger système
local AdManager = loadstring(readfile("Addsextention/AdManager.lua"))()

-- Créer instance
local MyAds = AdManager.new()

-- Configurer
MyAds:Init({
    Provider = "A-Ads",           -- ou "Custom", "PropellerAds", "Adsterra"
    AdUnitID = "123456",          -- ⚠️ REMPLACER PAR VOTRE ID
    Position = "BOTTOM_LEFT",     -- TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT
    AutoRotate = false,           -- true si plusieurs pubs
    CPM = 1.50,                   -- Estimation pour stats
})

-- Afficher
MyAds:Show()

-- (Optionnel) Contrôles
print("Stats:", MyAds:GetStats())
MyAds.Controller:SetPosition("TOP_RIGHT")  -- Changer position
MyAds.Controller:NextAd()                  -- Prochaine pub
```

---

## Étape 4 : Intégration dans Script Existant

### **Exemple : Intégration SriBlox Modern**

Ouvrir `SriBloxModern.lua` et **ajouter à la fin** :

```lua
-- === SYSTÈME PUBLICITÉS ===
spawn(function()
    wait(2)  -- Attendre chargement UI principale
    
    local success, AdManager = pcall(function()
        return loadstring(readfile("Addsextention/AdManager.lua"))()
    end)
    
    if success then
        _G.SriBloxAds = AdManager.new()
        _G.SriBloxAds:Init({
            Provider = "A-Ads",
            AdUnitID = "123456",           -- ⚠️ VOTRE ID ICI
            Position = "BOTTOM_LEFT",
            AutoRotate = false,
            CPM = 1.50,
        })
        
        _G.SriBloxAds:Show()
        
        print("[SriBlox] Publicités activées ✅")
    else
        warn("[SriBlox] Erreur chargement publicités:", AdManager)
    end
end)
```

### **Raccourcis clavier (optionnel)**
```lua
-- Toggle pubs avec F7
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- F7 = Afficher/Masquer
    if input.KeyCode == Enum.KeyCode.F7 then
        if _G.SriBloxAds then
            _G.SriBloxAds.Controller:ToggleAds()
        end
    end
    
    -- F8 = Prochaine pub
    if input.KeyCode == Enum.KeyCode.F8 then
        if _G.SriBloxAds then
            _G.SriBloxAds.Controller:NextAd()
        end
    end
end)
```

---

## Étape 5 : Test

1. **Exécuter le script** dans Roblox executor
2. **Vérifier** : Bannière apparaît en bas à gauche
3. **Cliquer dessus** : Lien copié dans clipboard
4. **Tester commandes** (si hotkeys activés) :
   - `F7` : Toggle on/off
   - `F8` : Prochaine pub

---

## ⚡ Configuration Multiple Publicités

### Pool Custom (sans API)
```lua
MyAds:Init({
    Provider = "Custom",
    AdsPool = {
        {
            Image = "rbxassetid://10723434711",
            Link = "https://discord.gg/votreserveur",
            Title = "Discord",
        },
        {
            Image = "rbxassetid://10723407389",
            Link = "https://youtube.com/@votrechaine",
            Title = "YouTube",
        },
        {
            Image = "rbxassetid://10723415766",
            Link = "https://github.com/votrerepo",
            Title = "GitHub",
        },
    },
    Position = "BOTTOM_RIGHT",
    AutoRotate = true,
    RotateInterval = 15,  -- Changer toutes les 15 secondes
})
```

### Trouver Asset IDs Images
1. Chercher "Roblox icons" sur Google Images
2. Uploader image sur Roblox : https://create.roblox.com/dashboard/creations
3. Copier Asset ID (ex: `rbxassetid://1234567890`)

---

## 📊 Analytics Discord (Optionnel)

### Créer Webhook
1. Discord → Paramètres serveur → Intégrations → Webhooks
2. Nouveau webhook → Copier URL

### Ajouter au code
```lua
MyAds:Init({
    Provider = "A-Ads",
    AdUnitID = "123456",
    Webhook = "https://discord.com/api/webhooks/VOTRE_WEBHOOK",
    TrackClicks = true,
    TrackImpressions = true,
})
```

Vous recevrez messages Discord à chaque impression/click !

---

## 🐛 Dépannage

### ❌ "AdManager.lua not found"
**Solution** : Vérifier chemin fichier
```lua
-- Essayer chemin absolu
local AdManager = loadstring(readfile("C:/Users/VOUS/Documents/MyExploit/Addsextention/AdManager.lua"))()
```

### ❌ "Image ne s'affiche pas"
**Solution** : Vérifier URL image
- A-Ads : `https://ad.a-ads.com/VOTRE_ID.png`
- Asset Roblox : `rbxassetid://1234567890`

### ❌ "Publicité invisible"
**Solution** : Vérifier position/overlap
```lua
MyAds.Controller:SetPosition("TOP_LEFT")  -- Essayer autre position
```

### ❌ "readfile not found"
**Solution** : Executor ne supporte pas filesystem
- Utiliser loadstring depuis Pastebin/GitHub
- Exemple : `loadstring(game:HttpGet("https://pastebin.com/raw/PASTE_ID"))()`

---

## 💰 Estimation Revenue

| Utilisateurs/jour | Impressions | CPM $1.50 | Revenue/mois |
|-------------------|-------------|-----------|--------------|
| 100               | 50          | $1.50     | ~$2.25       |
| 500               | 250         | $1.50     | ~$11.25      |
| 1,000             | 500         | $1.50     | ~$22.50      |
| 5,000             | 2,500       | $1.50     | ~$112.50     |

*Basé sur 30 secondes viewing time moyen*

---

## 📞 Support

- **Discord** : [Votre serveur Discord]
- **GitHub Issues** : [Lien repo]
- **Email** : [Votre email]

---

## ✅ Checklist Installation

- [ ] Compte A-Ads créé
- [ ] Ad Unit créé (200×100)
- [ ] ID copié
- [ ] Fichiers Addsextention/ téléchargés
- [ ] Code ajouté au script
- [ ] ID remplacé dans code
- [ ] Script testé dans Roblox
- [ ] Bannière visible ✅

**C'est tout ! Vous monétisez maintenant votre script 🎉**
