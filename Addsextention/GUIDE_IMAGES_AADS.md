# 🖼️ Guide Images & Formats A-Ads

## 📐 Formats de publicités A-Ads

Les publicités A-Ads sont disponibles en **images statiques** ou **GIF animés** dans différentes tailles standard :

### Formats Standard IAB

| Taille | Dimensions | Type | URL Pattern |
|--------|------------|------|-------------|
| **Banner** | 468x60 | Standard | `//static.a-ads.com/a-ads-banners/{ID}/468x60` |
| **Leaderboard** | 728x90 | Large | `//static.a-ads.com/a-ads-banners/{ID}/728x90` |
| **Medium Rectangle** | 300x250 | Carré | `//static.a-ads.com/a-ads-banners/{ID}/300x250` |
| **Wide Skyscraper** | 160x600 | Vertical | `//static.a-ads.com/a-ads-banners/{ID}/160x600` |
| **Billboard** | 970x250 | Extra large | `//static.a-ads.com/a-ads-banners/{ID}/970x250` |
| **Large Rectangle** | 336x280 | Carré large | `//static.a-ads.com/a-ads-banners/{ID}/336x280` |

### Formats Illustrations (Teasers)

| Taille | Usage | URL Pattern |
|--------|-------|-------------|
| 475x250 | Teaser article | `//static.a-ads.com/a-ads-advert-illustrations/{ID}/475x250` |
| 950x500 | Teaser grand format | `//static.a-ads.com/a-ads-advert-illustrations/{ID}/950x500` |

---

## 📋 Exemples extraits de votre iframe

Voici les formats détectés dans votre Ad Unit **2417103** :

```html
<!-- Illustration Teaser (Trading) -->
<img alt="Commencez à trader avec seulement $1" 
     class="teaser-advert-illustration" 
     src="//static.a-ads.com/a-ads-advert-illustrations/442/475x250?region=eu-central-1">

<!-- Billboard Banner (Casino Crypto) -->
<img class="image-item" 
     src="//static.a-ads.com/a-ads-banners/531599/970x250?region=eu-central-1" 
     alt="Casino cryptographique n°1">
```

### Détection automatique

Le système extrait automatiquement :
- ✅ **URL complète** : `https://static.a-ads.com/...`
- ✅ **Dimensions** : `970x250`, `475x250`, etc.
- ✅ **Texte alternatif** : Description de la pub

---

## ⚙️ Configuration Adaptation UI

### Dans `Integration_Simple_AAds.lua`

```lua
local CONFIG = {
    AdUnitID = "2417103",
    Position = "BOTTOM_LEFT",
    RotateInterval = 30,           -- Rotation toutes les 30s
    MaxAdWidth = 970,              -- ✏️ Largeur max écran
    MaxAdHeight = 250,             -- ✏️ Hauteur max écran
    PreferredScale = 0.5,          -- ✏️ 50% taille originale
}
```

### Exemples Adaptation

| Pub Originale | Scale 0.5 | Scale 1.0 | Note |
|---------------|-----------|-----------|------|
| 970x250 | **485x125** | 970x250 | Billboard réduit |
| 728x90 | **364x45** | 728x90 | Leaderboard |
| 468x60 | **234x30** | 468x60 | Banner standard |
| 475x250 | **237x125** | 475x250 | Teaser illustration |

**Recommandation** : Scale `0.4-0.6` pour ne pas envahir l'écran Roblox.

---

## 🔄 Rotation Automatique

Le système charge **toutes** les images trouvées et les affiche en rotation :

```lua
-- Détection automatique (exemple)
🔄 Récupération pubs depuis: https://acceptable.a-ads.com/2417103/?size=Adaptive

✅ 3 publicité(s) extraite(s):
  [1] 475x250 - https://static.a-ads.com/a-ads-advert-illustrations/442/475x250...
  [2] 970x250 - https://static.a-ads.com/a-ads-banners/531599/970x250...
  [3] 468x60  - https://ad.a-ads.com/2417103.png (fallback)

📐 Taille adaptée: 475x250 → 237x125 (scale 0.50)
```

### Timeline Rotation

```
Secondes    Pub Affichée
    0       [1] 475x250 (Teaser Trading)
   30       [2] 970x250 (Casino Crypto) ← Resize automatique!
   60       [3] 468x60  (Fallback)
   90       [1] 475x250 (Boucle)
```

---

## 🎮 Contrôles Manuels

```lua
-- Passer à la pub suivante
_G.AAdsController:NextAd()
-- 🔄 Pub [2/3] affichée - 970x250

-- Retour pub précédente
_G.AAdsController:PreviousAd()
-- 🔄 Pub [1/3] affichée - 475x250

-- Désactiver rotation auto
_G.AAdsController:ToggleRotation()
-- 🔄 Rotation automatique: Désactivée

-- Lister toutes les pubs
_G.AAdsController:ListAds()
-- 📋 3 publicité(s) chargée(s):
--   [1] 475x250 - https://static.a-ads.com/a-ads-advert-illustrations/442/475x250
--   [2] 970x250 - https://static.a-ads.com/a-ads-banners/531599/970x250
--   [3] 468x60  - https://ad.a-ads.com/2417103.png

-- Voir stats
_G.AAdsController:GetStats()
-- {
--     Impressions = 5,
--     Clicks = 1,
--     Revenue = 0.0075,
--     CTR = 20.0,
--     CurrentAd = "2/3",
--     TotalAds = 3
-- }
```

---

## 🎨 Personnalisation Taille

### Option 1: Scale Global
```lua
-- Ligne 16
PreferredScale = 0.7,  -- 70% taille originale (plus gros)
```

### Option 2: Limites Max
```lua
-- Ligne 14-15
MaxAdWidth = 1200,   -- Accepter pubs jusqu'à 1200px largeur
MaxAdHeight = 300,   -- Hauteur max 300px
```

### Option 3: Taille Fixe (Ignorer dimensions originales)
```lua
-- Ligne 174 (après extraction)
container.Size = UDim2.new(0, 400, 0, 100) -- ✏️ Taille fixe 400x100
```

---

## 🔍 Debugging

### Voir HTML brut (pour tester extraction)
```lua
-- Après ligne 96 (dans pcall extraction)
print("HTML Preview:")
print(html:sub(1, 500)) -- Premiers 500 chars
```

### Forcer URLs manuellement (si extraction échoue)
```lua
-- Remplacer lignes 109-115 par:
adsList = {
    {Image = "https://static.a-ads.com/a-ads-banners/531599/970x250", Width = 970, Height = 250},
    {Image = "https://static.a-ads.com/a-ads-advert-illustrations/442/475x250", Width = 475, Height = 250},
    {Image = "https://ad.a-ads.com/2417103.png", Width = 468, Height = 60},
}
```

---

## 📊 Optimisation Revenue

### 1. Maximiser impressions
- ✅ Position visible (`BOTTOM_RIGHT` meilleur CTR)
- ✅ Rotation rapide (`RotateInterval = 20` secondes)
- ✅ Plusieurs positions simultanées (dupliquer script)

### 2. Tracking Discord
```lua
-- À ajouter après ligne 285 (track impression)
local webhook = "https://discord.com/api/webhooks/VOTRE_WEBHOOK"
local http = game:GetService("HttpService")

pcall(function()
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = http:JSONEncode({
            content = string.format("📊 Impression #%d | Pub %d/%d | Revenue: $%.4f", 
                Stats.Impressions, currentAdIndex, #adsList, Stats.Revenue)
        })
    })
end)
```

### 3. Heatmap Clicks
```lua
-- Après ligne 320 (click handler)
print(string.format("🖱️ Click position: %d, %d", mouse.X, mouse.Y))
```

---

## 🚀 Intégration SriBlox Modern

```lua
-- Fin de SriBloxModern.lua (après interface chargée)
spawn(function()
    wait(2) -- Attendre splash screen

    -- Charger système pubs
    local AAds = loadstring(readfile("Addsextention/Integration_Simple_AAds.lua"))()
    
    -- Hotkey F7: Toggle pubs
    local UIS = game:GetService("UserInputService")
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F7 then
            _G.AAdsController:Toggle()
        end
    end)
    
    print("💡 F7 = Toggle Publicités")
end)
```

---

## ⚠️ Troubleshooting

### Problème: Image ne s'affiche pas
**Cause** : Roblox bloque URLs externes HTTP  
**Solution** :
1. Upload image sur Roblox Assets
2. Remplacer URL par `rbxassetid://ID`
3. Ou utiliser service proxy (Discord CDN)

### Problème: Rotation ne fonctionne pas
**Cause** : `spawn()` bloqué ou `wait()` erreur  
**Solution** :
```lua
-- Remplacer ligne 296 par:
task.spawn(function()
    while rotationEnabled and task.wait(CONFIG.RotateInterval) do
        ...
    end
end)
```

### Problème: Extraction vide (0 pubs)
**Cause** : Iframe charge contenu JavaScript dynamique  
**Solution** : Fallback automatique activé (lignes 109-115)

### Problème: Taille UI incorrecte
**Cause** : Regex dimensions échoue  
**Solution** : Dimensions par défaut `468x60` appliquées automatiquement

---

## 📚 Ressources

- **Dashboard A-Ads** : https://a-ads.com/campaigns/2417103
- **API Docs** : https://a-ads.com/api
- **Formats IAB** : https://www.iab.com/newadportfolio/
- **Support A-Ads** : support@a-ads.com

---

## ✅ Checklist Test

1. [ ] Script exécuté sans erreur
2. [ ] Au moins 1 pub extraite (voir console)
3. [ ] UI Roblox affichée (bottom-left par défaut)
4. [ ] Dimensions adaptées correctement
5. [ ] Rotation automatique après 30s
6. [ ] Click fonctionne (lien copié)
7. [ ] Stats accessibles (`GetStats()`)
8. [ ] Hotkeys fonctionnels (`NextAd()`, `Toggle()`)

---

**Version** : 2.0 - Multi-images avec rotation dynamique  
**Ad Unit** : 2417103  
**Date** : Novembre 2025
