# 🎯 Guide A-Ads avec Page GitHub

## ✅ Votre Configuration Actuelle

**Ad Unit ID** : `2417103`  
**Type** : Adaptive iframe embed  
**Page HTML** : GitHub Pages avec iframe A-Ads

---

## 📋 Étapes d'Utilisation

### 1️⃣ Publier votre page HTML sur GitHub Pages

**Fichier : `ad.html`**
```html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicité</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: white;
        }

        #frame {
            width: 70%;
            max-width: 800px;
        }

        #frame iframe {
            border: 0;
            padding: 0;
            width: 100%;
            height: auto;
            overflow: hidden;
            display: block;
        }
    </style>
</head>
<body>
    <div id="frame">
        <iframe data-aa="2417103" src="//acceptable.a-ads.com/2417103/?size=Adaptive" title="Publicité"></iframe>
    </div>
</body>
</html>
```

**Activer GitHub Pages** :
1. GitHub → Settings → Pages
2. Source : `main` branch
3. Dossier : `/ (root)` ou `/docs`
4. Save
5. URL : `https://VOTRE_USERNAME.github.io/REPO_NAME/ad.html`

---

### 2️⃣ Tester le système

**Exécuter** : `Test_AAds_GitHub.lua`

```lua
-- Modifier ligne 8:
local GITHUB_PAGE = "https://ghostduckyy.github.io/UI-Libraries/ad.html"  -- VOTRE URL
```

**Le script va** :
- ✅ Charger votre page GitHub
- ✅ Extraire l'iframe A-Ads
- ✅ Récupérer l'image de la pub
- ✅ Afficher dans Roblox
- ✅ Tracking clicks

---

### 3️⃣ Intégration AdManager complet

**Code simple** :
```lua
local AdManager = loadstring(readfile("Addsextention/AdManager.lua"))()

local ads = AdManager.new()

ads:Init({
    Provider = "A-Ads",
    AdUnitID = "2417103",        -- Votre ID
    Position = "BOTTOM_LEFT",
    AutoRotate = false,          -- 1 seule pub
    CPM = 1.50,
    TrackClicks = true,
    TrackImpressions = true,
})

ads:Show()
```

---

## 🔧 Comment ça fonctionne ?

### Architecture :

```
Page GitHub HTML
    ↓
Iframe A-Ads (2417103)
    ↓
Contenu publicitaire HTML
    ↓
Extraction image URL (HttpService)
    ↓
Affichage Roblox (ImageLabel)
```

### Flux de données :

1. **HttpService GET** → Page GitHub
2. **Parse HTML** → Trouve `<iframe src="...">` 
3. **HttpService GET** → Contenu iframe
4. **Regex extraction** → URL image publicitaire
5. **ImageLabel.Image** → Affichage Roblox
6. **Click** → Copie lien dans clipboard

---

## 🎨 Personnalisation

### Changer position
```lua
ads.Controller:SetPosition("TOP_RIGHT")
-- TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT
```

### Activer rotation (si plusieurs pubs)
```lua
ads:Init({
    Provider = "Custom",
    AdsPool = {
        {Image = "url1", Link = "link1"},
        {Image = "url2", Link = "link2"},
    },
    AutoRotate = true,
    RotateInterval = 20,  -- secondes
})
```

### Analytics Discord
```lua
ads:Init({
    Provider = "A-Ads",
    AdUnitID = "2417103",
    Webhook = "https://discord.com/api/webhooks/YOUR_WEBHOOK",
    TrackClicks = true,
    TrackImpressions = true,
})
```

---

## 📊 Monitoring A-Ads

**Dashboard A-Ads** : https://a-ads.com/campaigns/2417103

Vous pouvez voir :
- Impressions réelles
- Clicks
- Revenue généré
- CPM actuel

---

## 🐛 Troubleshooting

### ❌ Image ne charge pas
**Cause** : Roblox bloque HTTP images externes

**Solutions** :
1. Uploader image sur Roblox Assets
2. Utiliser proxy Roblox-friendly
3. Fallback vers `rbxassetid://`

### ❌ HttpService erreur 403
**Cause** : A-Ads bloque requests direct

**Solution** : Utiliser votre page GitHub comme proxy

### ❌ Iframe vide
**Cause** : A-Ads charge pub dynamiquement (JavaScript)

**Solution** : 
- Wait quelques secondes avant extraction
- Utiliser URL directe A-Ads backup

---

## 💡 Méthodes Alternatives

### Méthode 1 : GitHub Proxy (ACTUELLE)
```
Roblox → GitHub Page → Iframe → Image
```
✅ Contourne restrictions  
⚠️ Dépend GitHub Pages uptime

### Méthode 2 : Direct Iframe
```
Roblox → Iframe A-Ads → Image
```
✅ Plus rapide  
❌ Peut être bloqué par A-Ads

### Méthode 3 : URL Directe (Fallback)
```
Roblox → ad.a-ads.com/2417103.png
```
✅ Toujours fonctionne  
❌ Pas de tracking impressions A-Ads

---

## 📈 Optimisation Revenue

### 1. Augmenter impressions
- Afficher publicité dès lancement script
- Position visible (BOTTOM_LEFT recommandé)
- Pas de close button (optionnel)

### 2. Améliorer CTR (Click-Through Rate)
- Publicités pertinentes à votre audience
- Call-to-action clair
- Rotation publicités toutes les 30s

### 3. Maximiser CPM
- Traffic qualité (utilisateurs actifs)
- GEO ciblées (USA/Europe = CPM plus élevé)
- Formats adaptés (200×100 standard)

---

## 🎯 Intégration SriBlox Modern

**Ajouter à la fin de `SriBloxModern.lua`** :

```lua
-- === SYSTÈME PUBLICITÉS A-ADS ===
spawn(function()
    wait(2)  -- Attendre chargement UI principale
    
    local success, AdManager = pcall(function()
        return loadstring(readfile("Addsextention/AdManager.lua"))()
    end)
    
    if success then
        _G.SriBloxAds = AdManager.new()
        
        _G.SriBloxAds:Init({
            Provider = "A-Ads",
            AdUnitID = "2417103",           -- Votre ID
            Position = "BOTTOM_LEFT",
            CPM = 1.50,
            TrackClicks = true,
            TrackImpressions = true,
        })
        
        _G.SriBloxAds:Show()
        
        print("[SriBlox] 📢 Publicités A-Ads activées")
    else
        warn("[SriBlox] ❌ Erreur chargement publicités")
    end
end)

-- (Optionnel) Toggle avec F7
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F7 then
        if _G.SriBloxAds then
            _G.SriBloxAds.Controller:ToggleAds()
        end
    end
end)
```

---

## ✅ Checklist Finale

- [x] Ad Unit créé sur A-Ads (ID: 2417103)
- [x] Page HTML créée avec iframe
- [ ] Page publiée sur GitHub Pages
- [ ] URL GitHub ajoutée dans test script
- [ ] Test exécuté dans Roblox
- [ ] Image publicité affichée
- [ ] Click tracking fonctionne
- [ ] Intégration dans SriBlox Modern
- [ ] Monitoring dashboard A-Ads

---

## 📞 Support A-Ads

- **Dashboard** : https://a-ads.com
- **Documentation** : https://a-ads.com/blog/
- **Support** : support@a-ads.com

---

**Votre setup est prêt ! 🎉**

Revenue estimé : **$0.50 - $2.00 CPM** avec A-Ads  
Paiement : **Bitcoin instantané** (minimum $1)
