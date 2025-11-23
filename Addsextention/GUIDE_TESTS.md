# 🧪 GUIDE COMPLET - TESTS AFFICHAGE A-ADS

## 📋 Vue d'ensemble

Suite de 3 scripts de test pour afficher publicités A-Ads externes (images/GIFs/vidéos) dans Roblox.

**URL Test**: `//acceptable.a-ads.com/2417103/?size=Adaptive`

---

## 🎯 Scripts disponibles

### 1️⃣ **Test_All_Methods.lua** (PRINCIPAL)
**Test complet 4 méthodes affichage**

**Méthodes testées**:
- ✅ **EditableImage** (2024) - MODERNE, officiel Roblox
- ✅ **Drawing API** - Executor library (Synapse/KRNL)
- ✅ **ViewportFrame** - Hybrid technique
- ✅ **getcustomasset()** - Legacy fallback

**Utilisation**:
```lua
loadstring(readfile("Addsextention/Test_All_Methods.lua"))()
```

**Logs détaillés**:
- ℹ️ INFO - Progression étapes
- ✅ SUCCESS - Opérations réussies
- ❌ ERROR - Échecs avec raison
- ⚠️ WARNING - Avertissements
- 🔍 DEBUG - Détails techniques

**Résultats visuels**:
- 🟢 **Bordure verte** = EditableImage
- 🔵 **Bordure bleue** = Drawing API
- 🟠 **Bordure orange** = ViewportFrame
- 🟣 **Bordure magenta** = getcustomasset

**Commandes console**:
```lua
_G.AAdsTestController.Reload() -- Relancer tests
_G.AAdsTestController.Results -- Voir résultats
_G.AAdsTestController.CurrentMedia -- Liste médias détectés
```

---

### 2️⃣ **Test_GIF_Animation.lua**
**Test spécialisé GIFs animés**

**Méthodes**:
- Frame-by-frame rotation (théorique)
- Drawing API première frame statique

**Utilisation**:
```lua
loadstring(readfile("Addsextention/Test_GIF_Animation.lua"))()
```

**Limitations**:
⚠️ Roblox ne supporte **PAS** nativement animation GIFs!

**Solutions**:
1. Extraire frames GIF → Rotation manuelle (complexe)
2. Afficher première frame statique (simple)
3. Utiliser image PNG/JPEG alternative A-Ads

**Commandes**:
```lua
_G.GIFTestController.Reload()
_G.GIFTestController.GIFData -- Infos GIF détecté
```

---

### 3️⃣ **Test_Video_Support.lua**
**Test support vidéos**

**Détection**:
- `<video poster="">` - Thumbnail vidéo
- `<source src="">` - URL vidéo directe (.mp4/.webm)

**Utilisation**:
```lua
loadstring(readfile("Addsextention/Test_Video_Support.lua"))()
```

**Limitations**:
⚠️ Roblox ne supporte **PAS** lecture vidéos!

**Solutions**:
- Afficher thumbnail/poster image
- Fallback texte "VIDEO" si pas d'image
- A-Ads utilise rarement vidéos (95% images)

**Commandes**:
```lua
_G.VideoTestController.Reload()
_G.VideoTestController.VideoData -- Infos vidéo
```

---

## 📊 Résultats attendus

### ✅ EditableImage (RECOMMANDÉ)

**Avantages**:
- ✅ Officiel Roblox 2024
- ✅ Supporte URLs externes via API Cloudflare
- ✅ Performance optimale
- ✅ Pas de dépendance executor

**Prérequis**:
- Roblox version 2024+
- Mesh/Image API activé (Studio settings)
- Connexion internet (API Cloudflare Worker)

**API utilisée**: `https://image-parser.tyrannizerdev.workers.dev`

**Process**:
1. Télécharger image externe
2. Convertir en pixel matrix (API)
3. CreateEditableImage()
4. WritePixelsBuffer() avec RGBA data
5. ImageLabel.ImageContent = Content.fromObject()

---

### ✅ Drawing API

**Avantages**:
- ✅ Bypass GUI Roblox complètement
- ✅ Charge URLs externes nativement
- ✅ Compatible Synapse/KRNL/Fluxus

**Limitations**:
- ⚠️ Pas tous executors supportent `Drawing.new("Image")`
- ⚠️ Pas d'intégration UI Roblox native
- ⚠️ Fallback texte "AD" si non supporté

**Process**:
1. game:HttpGet(imageUrl) → Download data
2. Drawing.new("Image")
3. img.Data = imageData
4. img.Visible = true

---

### ⚠️ ViewportFrame

**Statut**: **Expérimental** (peut être bloqué)

**Architecture**:
```
ViewportFrame (UI 2D)
  └─ Camera → Part 3D
      └─ SurfaceGui (texture Part)
          └─ ImageLabel.Image = URL externe
```

**Hypothèse**: SurfaceGui.ImageLabel contourne blocage Roblox

**Test requis**: Vérifier affichage visuel!

---

### ✅ getcustomasset() Legacy

**Avantages**:
- ✅ Fonctionne sur anciens executors
- ✅ Méthode éprouvée

**Limitations**:
- ⚠️ Nécessite téléchargement local (writefile)
- ⚠️ Chemin absolu requis: `workspace/AAds_Cache/`
- ⚠️ Moins performant que EditableImage

**Process**:
1. game:HttpGet(imageUrl) → Download
2. writefile("workspace/AAds_Cache/ad.png", data)
3. getcustomasset("workspace/AAds_Cache/ad.png")
4. ImageLabel.Image = rbxasset://

---

## 🐛 Troubleshooting

### ❌ "CreateEditableImage non supporté"

**Cause**: Roblox version trop ancienne

**Solution**:
- Mettre à jour Roblox client
- OU utiliser Drawing API
- OU utiliser getcustomasset()

---

### ❌ "Drawing library non supportée"

**Cause**: Executor ne supporte pas Drawing

**Solution**:
- Utiliser EditableImage
- OU utiliser getcustomasset()
- OU changer executor (Synapse/KRNL)

---

### ❌ "API Cloudflare Worker échec"

**Cause**: Connexion internet ou CORS

**Solutions**:
1. Vérifier connexion internet
2. Attendre quelques secondes, réessayer
3. Utiliser pubs par défaut (fallback automatique)

---

### ⚠️ "ViewportFrame créé mais fond gris"

**Cause**: SurfaceGui bloque aussi URLs externes

**Solution**:
- Utiliser EditableImage (priorité)
- OU Drawing API
- ⚠️ ViewportFrame non fiable pour URLs externes

---

### ❌ "getcustomasset crash 'attempt to index nil'"

**Cause**: Chemin relatif au lieu d'absolu

**Solution**:
```lua
-- ❌ MAUVAIS
writefile("cache/ad.png", data)
getcustomasset("cache/ad.png")

-- ✅ BON
writefile("workspace/AAds_Cache/ad.png", data)
getcustomasset("workspace/AAds_Cache/ad.png")
```

---

## 📖 Workflow complet

### Étape 1: Télécharger iframe A-Ads
```lua
local html = game:HttpGet("https://acceptable.a-ads.com/2417103/?size=Adaptive")
```

### Étape 2: Parser contenu
```lua
-- Images
for src in html:gmatch('<img[^>]+src=["\']([^"\']+)["\']') do
    local url = src:gsub("^//", "https://")
    table.insert(images, url)
end

-- GIFs (détection extension)
if url:lower():match("%.gif") then
    -- Traiter comme image statique (première frame)
end

-- Vidéos
for poster in html:gmatch('<video[^>]+poster=["\']([^"\']+)["\']') do
    -- Afficher thumbnail
end
```

### Étape 3: Afficher avec méthode compatible

**Ordre priorité**:
1. **EditableImage** (si Roblox 2024+)
2. **Drawing API** (si executor supporte)
3. **getcustomasset()** (fallback legacy)
4. **ViewportFrame** (expérimental, dernier recours)

---

## 📚 Ressources techniques

### API EditableImage
- **Roblox DevForum**: [Image Parser API](https://devforum.roblox.com/t/image-parser-api-render-external-images-to-roblox/3586131)
- **GitHub**: [LuauImageParser](https://github.com/Metatable-Games/LuauImageParser)
- **API Endpoint**: `https://image-parser.tyrannizerdev.workers.dev`

### Drawing API
- **Synapse Documentation**: Drawing library reference
- **KRNL**: Supporte Drawing.new("Image")
- **Fluxus**: Support partiel

### A-Ads URLs
- **Format iframe**: `//acceptable.a-ads.com/{AD_UNIT_ID}/?size=Adaptive`
- **Images statiques**: `https://static.a-ads.com/a-ads-banners/{ID}/{WIDTH}x{HEIGHT}_{HASH}.png`
- **Types**: PNG, JPEG (95%), GIF (4%), Vidéo (1%)

---

## 🎓 Exemples d'utilisation

### Test rapide une méthode
```lua
-- Tester seulement EditableImage
loadstring(readfile("Addsextention/Test_All_Methods.lua"))()
-- Regarder bordure VERTE = EditableImage fonctionne
```

### Test tous formats
```lua
-- Test 1: Images + GIFs + Vidéos
loadstring(readfile("Addsextention/Test_All_Methods.lua"))()

-- Test 2: GIFs spécifiquement
loadstring(readfile("Addsextention/Test_GIF_Animation.lua"))()

-- Test 3: Vidéos spécifiquement
loadstring(readfile("Addsextention/Test_Video_Support.lua"))()
```

### Relancer tests
```lua
-- Sans recharger script
_G.AAdsTestController.Reload()
_G.GIFTestController.Reload()
_G.VideoTestController.Reload()
```

---

## ✅ Checklist validation

**Après exécution Test_All_Methods.lua**:

- [ ] Console affiche logs détaillés (INFO/SUCCESS/ERROR)
- [ ] 4 GUI créés dans CoreGui (EditableImage/Drawing/ViewportFrame/getcustomasset)
- [ ] Au moins 1 bordure colorée visible à l'écran
- [ ] Résultats finaux affichés avec temps ms
- [ ] Recommandation donnée (méthode préférée)
- [ ] Image A-Ads visible (vérifier visuellement!)

**Si aucune image visible**:
1. Vérifier console logs pour erreurs
2. Tester executor différent (Synapse recommandé)
3. Vérifier connexion internet
4. Utiliser pubs par défaut (fallback automatique)

---

## 📞 Support

**Problèmes courants**:
- Fond gris = Blocage Roblox URLs externes
- Aucune GUI = Erreur script (vérifier console)
- Crash = Executor incompatible

**Solutions**:
1. Lire console logs complets
2. Tester autre executor
3. Vérifier version Roblox (2024+ pour EditableImage)
4. Désactiver antivirus (peut bloquer Drawing API)

---

**Dernière mise à jour**: 2024
**Auteur**: MyExploit Team
**Compatibilité**: Roblox 2024+, Synapse X, KRNL, Fluxus, Script-Ware
