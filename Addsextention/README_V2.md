# 📢 Addsextention - Système Multi-Publicités A-Ads v2.0

## 🎯 Vue d'ensemble

Système **avancé de monétisation** pour scripts Roblox exploits. Extrait et affiche automatiquement **toutes les publicités A-Ads** avec rotation dynamique et adaptation intelligente des tailles.

### 🆕 Nouveautés Version 2.0

- ✅ **Extraction multiple images** depuis iframe A-Ads
- ✅ **Rotation automatique** toutes les X secondes
- ✅ **Adaptation dynamique UI** selon dimensions pub
- ✅ **3 patterns détection** (illustrations, banners, génériques)
- ✅ **Contrôles étendus** (NextAd, PreviousAd, ToggleRotation)
- ✅ **Stats détaillées** (CurrentAd, TotalAds)

---

## 📁 Fichiers Système

### 🚀 **UTILISATION RAPIDE** (Recommandé)

| Fichier | Description | Usage |
|---------|-------------|-------|
| **Integration_Simple_AAds.lua** | 🔥 **COPIER/COLLER INSTANT** | `loadstring(readfile("..."))()` |
| **Test_Extraction_Quick.lua** | Test extraction rapide | Vérifier images trouvées |
| **GUIDE_IMAGES_AADS.md** | Doc formats & personnalisation | Lire pour optimiser |
| **RECAP_MULTI_IMAGES.md** | Récapitulatif complet v2.0 | Workflow détaillé |

### ⚙️ **SYSTÈME AVANCÉ** (Modulaire)

| Fichier | Description | Taille |
|---------|-------------|--------|
| **AdManager.lua** | Core système multi-provider | 600 lignes |
| **AdPositions.lua** | Gestion 4 positions écran | 200 lignes |
| **AdDisplay.lua** | Renderer ImageLabel | 350 lignes |
| **AdController.lua** | Contrôles utilisateur | 350 lignes |

### 📚 **DOCUMENTATION**

| Fichier | Description |
|---------|-------------|
| **README.md** | Ce fichier (index) |
| **QUICKSTART.md** | Installation 5 minutes |
| **GUIDE_AADS_GITHUB.md** | Setup page GitHub proxy |
| **SUMMARY.md** | Récapitulatif système général |
| **Example_Usage.lua** | 8 exemples complets |
| **DEMO_INSTANT.lua** | Démo copier/coller |

---

## ⚡ Démarrage Ultra-Rapide (30 secondes)

### Méthode 1: Instant (Un seul fichier)

```lua
-- Dans votre executor Roblox
loadstring(readfile("Addsextention/Integration_Simple_AAds.lua"))()
```

**Résultat** : Pub A-Ads affichée bottom-left, rotation auto 30s

### Méthode 2: Test Extraction (Vérification)

```lua
-- Tester extraction images
loadstring(readfile("Addsextention/Test_Extraction_Quick.lua"))()
```

**Résultat** : Console affiche pubs trouvées, UI test visible

---

## 🎨 Configuration Rapide

Modifier **lignes 11-18** de `Integration_Simple_AAds.lua` :

```lua
local CONFIG = {
    AdUnitID = "2417103",           -- ✏️ VOTRE ID A-ADS ICI
    Position = "BOTTOM_LEFT",       -- TOP_LEFT | TOP_RIGHT | BOTTOM_LEFT | BOTTOM_RIGHT
    ShowCloseButton = true,         -- Bouton × fermer
    CPM = 1.50,                     -- Estimation CPM (pour stats)
    RotateInterval = 30,            -- Rotation auto (secondes)
    MaxAdWidth = 970,               -- Largeur max écran
    MaxAdHeight = 250,              -- Hauteur max écran
    PreferredScale = 0.5,           -- Taille (0.5 = 50% originale)
}
```

---

## 💰 Setup A-Ads (5 minutes)

### Étape 1: Créer Compte

1. Aller sur **https://a-ads.com**
2. S'inscrire (email + password, **pas de KYC**)
3. Confirmer email

### Étape 2: Créer Ad Unit

1. Dashboard → **"Campaigns"** → **"Create Campaign"**
2. Type: **"Ad Unit"** (pas banner ni anything)
3. Format: **"Adaptive"** (multi-tailles)
4. Copier **ID** (ex: `2417103`)

### Étape 3: Intégrer ID

```lua
-- Ligne 11
AdUnitID = "2417103",  -- ✏️ Remplacer par votre ID
```

### Étape 4: Tester

```lua
loadstring(readfile("Addsextention/Integration_Simple_AAds.lua"))()
```

**Vérifier** :
- ✅ Console: `✅ 2 publicité(s) extraite(s)`
- ✅ UI bottom-left visible
- ✅ Après 30s → Change automatiquement

---

## 🎮 Contrôles Console

```lua
-- Stats complètes
_G.AAdsController:GetStats()
-- Output: {Impressions = 5, Clicks = 1, Revenue = 0.0075, CTR = 20.0, CurrentAd = "2/3", TotalAds = 3}

-- Navigation manuelle
_G.AAdsController:NextAd()        -- Pub suivante
_G.AAdsController:PreviousAd()    -- Pub précédente

-- Rotation automatique
_G.AAdsController:ToggleRotation()  -- Activer/désactiver

-- Informations
_G.AAdsController:ListAds()       -- Liste toutes les pubs

-- Affichage
_G.AAdsController:SetPosition("TOP_RIGHT")  -- Changer position
_G.AAdsController:Toggle()        -- Cacher/afficher
_G.AAdsController:Destroy()       -- Supprimer complètement
```

---

## 📊 Exemple Console Output

```
╔═══════════════════════════════════════════════════════╗
║        Chargement publicités A-Ads...               ║
╚═══════════════════════════════════════════════════════╝

🔄 Récupération pubs depuis: https://acceptable.a-ads.com/2417103/?size=Adaptive

✅ 2 publicité(s) extraite(s):
  [1] 475x250 - https://static.a-ads.com/a-ads-advert-illustrations/442/475x250...
  [2] 970x250 - https://static.a-ads.com/a-ads-banners/531599/970x250...

📐 Taille adaptée: 475x250 → 237x125 (scale 0.50)

╔═══════════════════════════════════════════════════════╗
║        ✅ Publicités A-Ads chargées !               ║
╠═══════════════════════════════════════════════════════╣
║  Ad Unit ID    : 2417103                            ║
║  Pubs trouvées : 2                                    ║
║  Rotation      : 30s                                  ║
║  Position      : BOTTOM_LEFT                          ║
╠═══════════════════════════════════════════════════════╣
║  CONTRÔLES DISPONIBLES:                              ║
║  _G.AAdsController:GetStats()                        ║
║  _G.AAdsController:NextAd()                          ║
║  _G.AAdsController:PreviousAd()                      ║
║  _G.AAdsController:ToggleRotation()                  ║
║  _G.AAdsController:SetPosition('TOP_RIGHT')          ║
║  _G.AAdsController:ListAds()                         ║
║  _G.AAdsController:Toggle()                          ║
║  _G.AAdsController:Destroy()                         ║
╚═══════════════════════════════════════════════════════╝

🔄 Pub [2/2] affichée - 970x250    ← Après 30s (rotation auto)
```

---

## 🔧 Personnalisations Courantes

### Rotation Plus Rapide (15 secondes)

```lua
RotateInterval = 15,
```

### Pubs Plus Grandes (70% taille originale)

```lua
PreferredScale = 0.7,
```

### Position Top-Right

```lua
Position = "TOP_RIGHT",
```

### Pas de Bouton Fermeture

```lua
ShowCloseButton = false,
```

---

## 🚀 Intégration SriBlox Modern

Ajouter à la **fin** de `SriBloxModern.lua` :

```lua
spawn(function()
    wait(2) -- Attendre splash screen

    -- Charger publicités
    loadstring(readfile("Addsextention/Integration_Simple_AAds.lua"))()
    
    -- Hotkeys
    local UIS = game:GetService("UserInputService")
    
    -- F7: Toggle pubs
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F7 then
            _G.AAdsController:Toggle()
        end
    end)
    
    -- F8: Pub suivante
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F8 then
            _G.AAdsController:NextAd()
        end
    end)
    
    print("💡 Hotkeys: F7 = Toggle | F8 = Next Ad")
end)
```

---

## 📈 Optimisation Revenue

### 1. Multiple Positions (4 coins)

```lua
spawn(function()
    local positions = {"TOP_LEFT", "TOP_RIGHT", "BOTTOM_LEFT", "BOTTOM_RIGHT"}
    
    for i, pos in ipairs(positions) do
        wait(i * 2) -- Décalage entre chaque
        
        local code = readfile("Addsextention/Integration_Simple_AAds.lua")
        code = code:gsub('BOTTOM_LEFT', pos)
        loadstring(code)()
    end
end)
```

### 2. Tracking Discord

```lua
-- Après ligne 285 de Integration_Simple_AAds.lua
local webhook = "https://discord.com/api/webhooks/VOTRE_WEBHOOK"
spawn(function()
    local http = game:GetService("HttpService")
    pcall(function()
        request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = http:JSONEncode({
                content = string.format("📊 Impression #%d | Revenue: $%.4f", 
                    Stats.Impressions, Stats.Revenue)
            })
        })
    end)
end)
```

---

## 🐛 Troubleshooting

### Problème: Aucune pub trouvée

**Solution** :
```lua
-- Forcer URLs manuellement (lignes 109-115)
adsList = {
    {Image = "https://static.a-ads.com/a-ads-banners/531599/970x250", Width = 970, Height = 250},
    {Image = "https://static.a-ads.com/a-ads-advert-illustrations/442/475x250", Width = 475, Height = 250},
}
```

### Problème: Image ne s'affiche pas

**Cause** : Roblox bloque URLs externes  
**Solution** :
1. Upload image sur Roblox Assets
2. Remplacer URL par `rbxassetid://ID`

### Problème: Rotation ne fonctionne pas

**Solution** :
```lua
-- Remplacer ligne 296
task.spawn(function()
    while rotationEnabled and task.wait(CONFIG.RotateInterval) do
        ...
    end
end)
```

---

## 📚 Documentation Complète

| Guide | Description |
|-------|-------------|
| **QUICKSTART.md** | Installation 5 minutes (système général) |
| **GUIDE_IMAGES_AADS.md** | Formats images A-Ads & personnalisation |
| **GUIDE_AADS_GITHUB.md** | Setup page GitHub proxy (méthode alternative) |
| **RECAP_MULTI_IMAGES.md** | Récapitulatif v2.0 multi-images |
| **SUMMARY.md** | Récapitulatif système général |
| **Example_Usage.lua** | 8 exemples use cases |

---

## 📊 Formats Publicités A-Ads

| Taille | Type | URL Pattern |
|--------|------|-------------|
| 468x60 | Banner | `//static.a-ads.com/a-ads-banners/{ID}/468x60` |
| 728x90 | Leaderboard | `//static.a-ads.com/a-ads-banners/{ID}/728x90` |
| 970x250 | Billboard | `//static.a-ads.com/a-ads-banners/{ID}/970x250` |
| 475x250 | Teaser | `//static.a-ads.com/a-ads-advert-illustrations/{ID}/475x250` |

**Auto-détection** : Système extrait automatiquement toutes les tailles

---

## ✅ Checklist Validation

- [ ] **Test_Extraction_Quick.lua** exécuté → Images trouvées
- [ ] **Integration_Simple_AAds.lua** exécuté → UI visible
- [ ] **Rotation automatique** fonctionne (30s)
- [ ] **Click pub** copie lien clipboard
- [ ] **GetStats()** retourne données correctes
- [ ] **NextAd() / PreviousAd()** fonctionnels
- [ ] **Dimensions** adaptées (pas coupées)

---

## 💡 Astuces Rapides

### Test Rapide Sans A-Ads

```lua
-- Modifier ligne 109-115 (fallback)
adsList = {
    {Image = "rbxassetid://123456789", Width = 200, Height = 100}, -- Votre image test
}
```

### Désactiver Rotation (Pub Fixe)

```lua
RotateInterval = 999999,  -- Jamais
```

### Forcer Taille Fixe

```lua
-- Ligne 174 (remplacer calcul)
local adWidth, adHeight = 300, 100  -- Toujours 300×100
```

---

## 🔗 Ressources

- **Dashboard A-Ads** : https://a-ads.com/campaigns/{VOTRE_ID}
- **API Documentation** : https://a-ads.com/api
- **Support A-Ads** : support@a-ads.com
- **SriBlox Modern** : `../SriBlox-Modern/`

---

## 🎯 Workflow Recommandé

```
1. Créer compte A-Ads (5 min)
2. Créer Ad Unit → Copier ID
3. Test_Extraction_Quick.lua → Vérifier extraction
4. Integration_Simple_AAds.lua → Tester rotation
5. Personnaliser config (scale, position, rotation)
6. Intégrer SriBlox Modern (hotkeys F7/F8)
7. Monitor stats (_G.AAdsController:GetStats())
8. Optimiser revenue (multiple positions, tracking Discord)
```

---

## 📊 Statistiques Exemple

```lua
_G.AAdsController:GetStats()

-- Après 10 minutes utilisation:
{
    Impressions = 20,      -- 20 affichages (rotation 30s)
    Clicks = 3,            -- 3 clicks utilisateur
    Revenue = 0.03,        -- $0.03 (CPM $1.50)
    CTR = 15.0,            -- 15% taux de click (excellent!)
    CurrentAd = "1/2",     -- Pub 1 sur 2 affichée
    TotalAds = 2           -- 2 pubs chargées
}
```

**Revenue Mensuel Estimé** :
- 100 joueurs/jour × 10 min × 20 impressions = **20,000 impressions**
- 20,000 × ($1.50 CPM / 1000) = **$30/mois**

---

## 🏆 Pourquoi A-Ads ?

✅ **Anonyme** : Pas de KYC, parfait exploits  
✅ **Bitcoin** : Paiement crypto ($1 minimum)  
✅ **Adaptive** : Multiples formats auto  
✅ **API Simple** : Iframe embed facile  
✅ **Revenue OK** : $0.50-$2 CPM  
✅ **Fast Setup** : 5 minutes total

---

**Version** : 2.0 - Multi-Images Dynamiques  
**Ad Unit ID Exemple** : 2417103  
**Auteur** : Système Addsextention  
**Date** : Novembre 2025  
**Lignes Code** : ~1,860 (système complet)  
**Fichiers** : 15 (code + doc)
