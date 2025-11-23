# 🎯 A-ADS SYSTÈME FINAL - DOCUMENTATION

## 📋 Vue d'ensemble

Système complet de publicités A-Ads avec **getcustomasset()** (méthode vérifiée fonctionnelle).

**Fichier**: `AAds_Final_System.lua` (553 lignes)

---

## ✨ Fonctionnalités complètes

### ✅ Rotation automatique pubs
- Changement automatique toutes les **15 secondes** (configurable)
- Support **multiple publicités** depuis iframe A-Ads
- Fallback pubs par défaut si téléchargement échoue

### ✅ Click pour copier lien
- **Click sur pub** → Lien copié dans presse-papier
- Feedback visuel "✅ LIEN COPIÉ!"
- Statistiques clicks trackées

### ✅ Adaptation taille automatique
- Taille container **s'adapte à chaque pub** (728x90, 468x60, 970x250, etc.)
- Position recalculée pour chaque pub
- Toujours visible dans écran

### ✅ Impossible à fermer
- **Pas de bouton X**
- Toujours visible (DisplayOrder max)
- Protected GUI (synapse)

### ✅ Bouton changement position (↔️)
- **4 positions disponibles**:
  - **TopLeft** (Haut gauche)
  - **TopRight** (Haut droite)
  - **BottomLeft** (Bas gauche)
  - **BottomRight** (Bas droite)
- Animation smooth changement position
- Bouton suit la pub (toujours accessible)

### ✅ Toujours dans écran
- **Auto-ajustement** si resize fenêtre Roblox
- Padding 10px des bords écran
- Position recalculée en temps réel

---

## 🚀 Installation

### Prérequis
- ✅ Executor avec `getcustomasset()` ou `getsynasset()`
- ✅ Fonctions filesystem: `writefile`, `readfile`, `isfolder`, `makefolder`
- ✅ `setclipboard()` pour copie lien

### Utilisation

**Méthode 1: Charger depuis fichier**
```lua
loadstring(readfile("Addsextention/AAds_Final_System.lua"))()
```

**Méthode 2: Exécuter directement**
```lua
-- Copier tout le contenu de AAds_Final_System.lua
-- Coller dans executor
-- Execute
```

---

## 🎮 Contrôles utilisateur

### Interface visuelle

**1. Publicité cliquable**
- **Click gauche** sur pub → Copie lien dans presse-papier
- Feedback visuel vert "✅ LIEN COPIÉ!"
- Message: "Collé dans navigateur"

**2. Bouton position (↔️)**
- Bouton jaune à côté de la pub
- **Click** → Change position (cycle 4 coins)
- **Hover** → Tooltip "📍 Changer position"
- Animation smooth déplacement

### Positions disponibles
```
┌─────────────────────────┐
│ TopLeft    TopRight     │
│   [AD]        [AD]      │
│                         │
│                         │
│                         │
│ BottomLeft  BottomRight │
│   [AD]        [AD]      │
└─────────────────────────┘
```

---

## ⚙️ Commandes console

### `_G.AAdsSystem.NextAd()`
Affiche publicité suivante immédiatement
```lua
_G.AAdsSystem.NextAd()
-- Output: "✅ Pub suivante affichée"
```

### `_G.AAdsSystem.ChangePosition()`
Change position coin
```lua
_G.AAdsSystem.ChangePosition()
-- Output: "✅ Position changée: TopLeft"
```

### `_G.AAdsSystem.GetStats()`
Affiche statistiques système
```lua
local stats = _G.AAdsSystem.GetStats()
print(stats)
-- Output:
-- {
--   TotalViews = 42,
--   TotalClicks = 8,
--   CurrentAd = "2/5",
--   Position = "TopRight",
--   Uptime = "320 secondes",
--   RotationEnabled = true
-- }
```

### `_G.AAdsSystem.ListAds()`
Liste toutes publicités chargées
```lua
_G.AAdsSystem.ListAds()
-- Output:
-- 📋 Liste publicités:
--   → 1. 970x250 - https://static.a-ads.com/.../970x250...
--     2. 728x90 - https://static.a-ads.com/.../728x90...
--     3. 468x60 - https://static.a-ads.com/.../468x60...
```

### `_G.AAdsSystem.ToggleRotation()`
Pause/Resume rotation automatique
```lua
_G.AAdsSystem.ToggleRotation()
-- Output: "⏸️ Rotation pausée"

_G.AAdsSystem.ToggleRotation()
-- Output: "✅ Rotation activée"
```

### `_G.AAdsSystem.Destroy()`
⚠️ Arrête système complètement (déconseillé)
```lua
_G.AAdsSystem.Destroy()
-- Output: "❌ Système A-Ads arrêté"
-- GUI disparaît, rotation stop
```

---

## 🔧 Configuration avancée

Modifier variables en haut du script:

```lua
local CONFIG = {
    AdURL = "//acceptable.a-ads.com/2417103/?size=Adaptive", -- Votre URL iframe A-Ads
    RotationInterval = 15, -- Secondes entre changement pubs (15 = recommandé)
    DefaultPosition = "TopRight", -- Position initiale: TopLeft/TopRight/BottomLeft/BottomRight
    Padding = 10, -- Pixels entre bord écran et pub (10 = recommandé)
    
    -- Pubs fallback (si téléchargement iframe échoue)
    DefaultAds = {
        {
            URL = "https://static.a-ads.com/a-ads-banners/531599/970x250_eed0a7ea7e.png",
            Width = 970,
            Height = 250,
            Link = "https://a-ads.com",
        },
        -- Ajouter plus de pubs ici...
    },
}
```

### Exemples configurations

**Rotation rapide (5 secondes)**
```lua
RotationInterval = 5,
```

**Position initiale bas gauche**
```lua
DefaultPosition = "BottomLeft",
```

**Plus de padding (20px)**
```lua
Padding = 20,
```

---

## 📊 Architecture technique

### Workflow complet

```
1. Initialize()
   ├─ DownloadIframe() → Télécharge HTML A-Ads
   ├─ ParseAds(html) → Extrait URLs pubs
   ├─ CreateUI() → Crée ScreenGui + Frame + ImageLabel
   └─ NextAd() → Affiche première pub

2. NextAd() (appelé tous les 15s)
   ├─ DownloadAndCacheImage() → game:HttpGet(imageUrl)
   ├─ writefile() → Sauvegarde workspace/AAds_Cache/ad_X.png
   ├─ getcustomasset() → Convertit en rbxasset://
   └─ DisplayAd() → AdImageLabel.Image = assetUrl

3. DisplayAd()
   ├─ AdContainer.Size = UDim2.new(0, width, 0, height)
   ├─ CalculatePosition() → UDim2 selon coin actuel
   ├─ TweenService → Animation fade-in
   └─ Stats.TotalViews++

4. ChangePosition() (click bouton ↔️)
   ├─ CurrentPosition = "TopLeft" → "TopRight" → "BottomLeft" → "BottomRight" (cycle)
   ├─ CalculatePosition() → Nouvelle UDim2
   ├─ TweenService → Animation déplacement
   └─ UpdatePositionButtonLocation() → Repositionne bouton

5. MonitorScreenResize() (RunService.RenderStepped)
   ├─ Détecte changement ViewportSize
   └─ Recalcule position pour rester dans écran
```

### Calcul positions

```lua
function CalculatePosition(adWidth, adHeight, position)
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local padding = 10
    
    -- TopLeft
    if position == "TopLeft" then
        return UDim2.new(0, padding, 0, padding)
    end
    
    -- TopRight
    if position == "TopRight" then
        return UDim2.new(1, -(adWidth + padding), 0, padding)
    end
    
    -- BottomLeft
    if position == "BottomLeft" then
        return UDim2.new(0, padding, 1, -(adHeight + padding))
    end
    
    -- BottomRight
    if position == "BottomRight" then
        return UDim2.new(1, -(adWidth + padding), 1, -(adHeight + padding))
    end
end
```

**Explication**:
- `UDim2.new(scale, offset, scale, offset)`
- **TopRight**: `X = 1 - (width + padding)` → Colle bord droit
- **BottomLeft**: `Y = 1 - (height + padding)` → Colle bord bas

---

## 🎨 Customisation visuelle

### Changer couleur bouton position

```lua
-- Ligne ~360 dans CreateUI()
PositionButton.BackgroundColor3 = Color3.fromRGB(255, 193, 7) -- Jaune par défaut

-- Exemples:
-- Bleu: Color3.fromRGB(0, 100, 255)
-- Vert: Color3.fromRGB(0, 255, 100)
-- Rouge: Color3.fromRGB(255, 50, 50)
```

### Changer texte bouton

```lua
-- Ligne ~365
PositionButton.Text = "↔️" -- Flèche par défaut

-- Exemples:
-- "📍" (pin)
-- "⬅️➡️" (flèches)
-- "🔄" (reload)
```

### Changer taille bouton

```lua
-- Ligne ~358
PositionButton.Size = UDim2.new(0, 20, 0, 20) -- 20x20 par défaut

-- Plus grand:
PositionButton.Size = UDim2.new(0, 30, 0, 30)
```

### Modifier feedback click

```lua
-- Ligne ~325 dans clickButton.MouseButton1Click
feedback.Text = "✅ LIEN COPIÉ!\nCollé dans navigateur"

-- Exemples:
-- "✅ Copié!"
-- "🔗 URL dans presse-papier"
-- "✅ Ouvrir navigateur et coller (Ctrl+V)"
```

---

## 📈 Statistiques trackées

Le système enregistre automatiquement:

| Stat | Description |
|------|-------------|
| **TotalViews** | Nombre total publicités affichées |
| **TotalClicks** | Nombre clicks sur pubs (liens copiés) |
| **CurrentAd** | Index pub actuelle (ex: "3/5") |
| **Position** | Position actuelle (TopRight/etc) |
| **Uptime** | Secondes depuis démarrage |
| **RotationEnabled** | État rotation (true/false) |

### Accès stats

```lua
local stats = _G.AAdsSystem.GetStats()

print("Vues:", stats.TotalViews)
print("Clicks:", stats.TotalClicks)
print("CTR:", (stats.TotalClicks / stats.TotalViews * 100) .. "%")
```

---

## 🔍 Debugging

### Vérifier système actif

```lua
if _G.AAdsSystem then
    print("✅ Système A-Ads actif")
    print(_G.AAdsSystem.GetStats())
else
    print("❌ Système non chargé")
end
```

### Vérifier cache images

```lua
-- Lister fichiers cache
local files = listfiles("workspace/AAds_Cache")
for _, file in ipairs(files) do
    print(file)
end
-- Output:
-- workspace/AAds_Cache/ad_1.png
-- workspace/AAds_Cache/ad_2.png
-- workspace/AAds_Cache/ad_3.png
```

### Forcer refresh pub

```lua
-- Supprimer cache + recharger
delfolder("workspace/AAds_Cache")
_G.AAdsSystem.Destroy()

-- Recharger script
loadstring(readfile("Addsextention/AAds_Final_System.lua"))()
```

### Logs détaillés

Tous logs console préfixés `[A-ADS]`:

```
[A-ADS] ℹ️ Initialisation système A-Ads...
[A-ADS] ℹ️ Téléchargement iframe A-Ads...
[A-ADS] ✅ Iframe téléchargé (12458 bytes)
[A-ADS] ℹ️ Parsing HTML pour extraction publicités...
[A-ADS] 🔍 Pub détectée: 970x250
[A-ADS] 🔍 Pub détectée: 728x90
[A-ADS] ✅ 5 publicité(s) extraite(s)
[A-ADS] ℹ️ Création interface...
[A-ADS] ✅ Interface créée
[A-ADS] 🔍 Téléchargement image 1...
[A-ADS] ✅ Image téléchargée (58743 bytes)
[A-ADS] 💾 Cache: workspace/AAds_Cache/ad_1.png
[A-ADS] ✅ Asset URL créé
[A-ADS] ℹ️ Affichage pub 970x250
[A-ADS] ✅ Pub affichée (Views: 1)
[A-ADS] ℹ️ Rotation automatique démarrée (15s)
```

---

## ⚠️ Troubleshooting

### Pub ne s'affiche pas

**Cause**: getcustomasset non supporté

**Solution**:
```lua
-- Vérifier support
if getcustomasset or getsynasset then
    print("✅ Supporté")
else
    print("❌ Executor non compatible")
    -- Utiliser autre executor (Synapse/KRNL)
end
```

### Lien pas copié au click

**Cause**: setclipboard non supporté

**Solution**:
```lua
-- Vérifier support
if setclipboard then
    print("✅ setclipboard disponible")
else
    print("❌ setclipboard non supporté")
    -- Afficher lien dans console instead
    print("Lien pub:", adLink)
end
```

### Pub sort de l'écran

**Cause**: Padding trop petit ou résolution extrême

**Solution**:
```lua
-- Augmenter padding
CONFIG.Padding = 20 -- Au lieu de 10

-- OU forcer position spécifique
_G.AAdsSystem.ChangePosition() -- Cycle jusqu'à position visible
```

### Rotation trop rapide/lente

**Solution**:
```lua
-- Modifier CONFIG.RotationInterval
CONFIG.RotationInterval = 30 -- 30 secondes au lieu de 15
```

### Bouton position invisible

**Cause**: Pub trop petite ou position bouton hors écran

**Solution**:
```lua
-- Vérifier position bouton dans UpdatePositionButtonLocation()
-- Ajuster offsets manuellement si besoin
```

---

## 📝 Notes importantes

### ✅ Avantages getcustomasset

- ✅ **Fonctionne** (vérifié par utilisateur)
- ✅ Compatible vieux executors
- ✅ Pas de dépendance API externe
- ✅ Simple et stable

### ⚠️ Limitations

- Cache fichiers local (utilise `workspace/AAds_Cache/`)
- Nécessite filesystem executor
- Pas d'animation GIF (frame statique)
- Pas de vidéos (image statique seulement)

### 🔒 Sécurité

- GUI protégé `syn.protect_gui()` si disponible
- DisplayOrder max (toujours au-dessus)
- Impossible à fermer (pas de bouton X)
- Persistent entre respawns (`ResetOnSpawn = false`)

---

## 🎯 Cas d'usage

### Hub script principal

```lua
-- En haut du hub
loadstring(readfile("Addsextention/AAds_Final_System.lua"))()

-- Votre code hub ici...
```

### Script standalone

```lua
-- Juste charger script seul
loadstring(readfile("Addsextention/AAds_Final_System.lua"))()

-- Système tourne en background
-- Utilisateur peut jouer normalement avec pubs visibles
```

### Integration custom

```lua
-- Charger sans auto-start
local AAdsCode = readfile("Addsextention/AAds_Final_System.lua")

-- Modifier CONFIG avant exec
AAdsCode = AAdsCode:gsub('RotationInterval = 15', 'RotationInterval = 5')

-- Charger
loadstring(AAdsCode)()
```

---

## ✅ Checklist validation

Après chargement script, vérifier:

- [ ] Console affiche "✅ SYSTÈME A-ADS DÉMARRÉ!"
- [ ] Pub visible dans un coin écran
- [ ] Bouton ↔️ jaune visible à côté pub
- [ ] Click pub → Message "✅ LIEN COPIÉ!"
- [ ] Click bouton ↔️ → Pub change position
- [ ] Après 15s → Pub change automatiquement
- [ ] `_G.AAdsSystem` existe et fonctionne
- [ ] Stats accessibles via `GetStats()`

---

## 🚀 Améliorations futures possibles

- [ ] Historique pubs vues
- [ ] Blacklist certaines pubs
- [ ] Export stats JSON
- [ ] Click droit sur pub → Menu options
- [ ] Keybind custom changement position (ex: Ctrl+P)
- [ ] Mode "discret" (pub transparente au hover)

---

**Auteur**: MyExploit Team  
**Date**: 13 novembre 2024  
**Version**: 1.0  
**Status**: ✅ **PRODUCTION READY**

**Fichier**: `AAds_Final_System.lua` (553 lignes)

---

## 📞 Support

**Problème?** Vérifiez logs console `[A-ADS]`

**Commande debug rapide**:
```lua
_G.AAdsSystem.GetStats()
_G.AAdsSystem.ListAds()
```

**Relancer système**:
```lua
_G.AAdsSystem.Destroy()
wait(1)
loadstring(readfile("Addsextention/AAds_Final_System.lua"))()
```
