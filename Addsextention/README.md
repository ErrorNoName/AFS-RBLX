# 📢 Addsextention - Système de Publicités pour Scripts Roblox

## 🎯 Vue d'ensemble

Système complet de monétisation par publicités pour scripts Roblox exploits. Affiche des bannières publicitaires dans les 4 coins de l'écran avec rotation automatique et tracking.

## 💰 Réseaux Publicitaires Recommandés

### **1. A-Ads (Anonymous Ads)** - ⭐ RECOMMANDÉ POUR DÉBUTER
- **Pourquoi ?** : Pas de KYC, parfait pour communauté exploits
- **CPM** : $0.50 - $2.00
- **Paiement** : Bitcoin (minimum $1)
- **Setup** :
  1. Créer compte sur https://a-ads.com
  2. Créer "Ad Unit" (bannière 200x100)
  3. Copier l'ID de l'ad unit (ex: `123456`)
  4. Utiliser : `https://ad.a-ads.com/123456.png`

### **2. PropellerAds** - 💎 MEILLEUR CPM
- **CPM** : $0.50 - $15.00
- **Paiement minimum** : $50 (PayPal, Payoneer)
- **API** : Requiert $1000 dépôt initial
- **Setup** :
  1. S'inscrire : https://publishers.propellerads.com
  2. Créer "Banner Zone" 200x100
  3. Obtenir Zone ID
  4. API Token dans Profile → API Access

### **3. Adsterra** - 🚀 PLUS FLEXIBLE
- **CPM** : $0.30 - $10.00
- **Paiement minimum** : $5 (PayPal, Bitcoin)
- **API** : Gratuite, publique
- **Setup** :
  1. S'inscrire : https://publishers.adsterra.com
  2. Créer "Banner Placement" 200x100
  3. API Token : Dashboard → Profile → API Token
  4. Documentation : https://adsterra.com/api/

## 📁 Structure des fichiers

```
Addsextention/
├── AdManager.lua          # Core - Gestion pool publicités
├── AdPositions.lua        # Configuration positions 4 coins
├── AdDisplay.lua          # Renderer ImageLabel bannières
├── AdController.lua       # Contrôles utilisateur (skip, next, position)
└── README.md              # Ce fichier
```

## 🚀 Installation

### **Méthode 1 : Standalone**
```lua
-- Charger le système complet
local AdSystem = loadstring(game:HttpGet("https://pastebin.com/raw/VOTRE_PASTE"))()

-- Initialiser avec votre API
AdSystem:Init({
    Provider = "A-Ads",  -- ou "PropellerAds", "Adsterra"
    AdUnitID = "123456", -- Votre ID d'ad unit
    Position = "BOTTOM_LEFT",
    AutoRotate = true,
    RotateInterval = 30, -- secondes
})

-- Afficher les pubs
AdSystem:Show()
```

### **Méthode 2 : Intégration SriBlox Modern**
```lua
-- Dans SriBloxModern.lua après l'UI principale
local AdSystem = loadstring(readfile("Addsextention/AdManager.lua"))()
AdSystem:Init({ Provider = "A-Ads", AdUnitID = "123456" })
AdSystem:Show()
```

## 🎮 Contrôles

```lua
-- Changer position
AdSystem:SetPosition("TOP_RIGHT")  -- TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT

-- Passer à la prochaine pub
AdSystem:NextAd()

-- Masquer temporairement
AdSystem:Hide()

-- Afficher à nouveau
AdSystem:Show()

-- Tracking stats
local stats = AdSystem:GetStats()
print(stats.Impressions, stats.Clicks, stats.Revenue)
```

## 💡 Configuration Avancée

### **Pool Publicités Personnalisé**
```lua
AdSystem:Init({
    Provider = "Custom",
    AdsPool = {
        { Image = "rbxassetid://123456", Link = "https://discord.gg/yourserver" },
        { Image = "https://i.imgur.com/abc123.png", Link = "https://youtube.com/@yourchannel" },
        { Image = "rbxassetid://789012", Link = "https://yourwebsite.com" },
    },
    Position = "BOTTOM_RIGHT",
    AutoRotate = true,
    RotateInterval = 20,
})
```

### **Tracking Analytics**
```lua
-- Envoyer stats vers Discord Webhook
AdSystem:Init({
    Provider = "A-Ads",
    AdUnitID = "123456",
    Webhook = "https://discord.com/api/webhooks/YOUR_WEBHOOK",
    TrackClicks = true,
    TrackImpressions = true,
})
```

## 📊 Estimation Revenus

### **Scénario Réaliste** :
- **500 utilisateurs/jour** × **30 secondes de view** = 250 impressions
- **CPM A-Ads** : $1.00
- **Revenue/jour** : $0.25
- **Revenue/mois** : ~$7.50

### **Scénario Optimiste** :
- **5000 utilisateurs/jour** × **2 minutes de view** = 5000 impressions
- **CPM PropellerAds** : $5.00
- **Revenue/jour** : $25
- **Revenue/mois** : ~$750

## ⚙️ Positions Disponibles

```lua
TOP_LEFT      = UDim2.new(0, 10, 0, 10)           -- Haut gauche
TOP_RIGHT     = UDim2.new(1, -210, 0, 10)         -- Haut droite
BOTTOM_LEFT   = UDim2.new(0, 10, 1, -110)         -- Bas gauche
BOTTOM_RIGHT  = UDim2.new(1, -210, 1, -110)       -- Bas droite
```

Bannières : **200×100 pixels** (format standard IAB)

## 🔒 Sécurité & TOS

⚠️ **Important** :
- Les publicités sont affichées dans **votre script**, pas dans Roblox directement
- Utilisez des réseaux **anonymes** (A-Ads) pour éviter KYC
- Ne jamais afficher de contenu **NSFW** ou **illégal**
- Roblox peut détecter HttpService calls → utilisez syn.request si disponible

## 🛠️ Dépannage

**Publicités ne s'affichent pas** :
```lua
-- Vérifier HttpService enabled
pcall(function()
    game:GetService("HttpService"):GetAsync("https://google.com")
end)
```

**Images ne se chargent pas** :
- Vérifier URL publique accessible
- Utiliser `rbxassetid://` pour assets Roblox
- A-Ads : vérifier format PNG/JPEG

**Tracking ne fonctionne pas** :
- Discord Webhook doit être HTTPS
- Utiliser `syn.request` au lieu de `HttpService:PostAsync`

## 📞 Support

- **Discord** : [Votre serveur]
- **GitHub Issues** : [Votre repo]
- **Email** : [Votre email]

## 📜 Licence

MIT License - Libre d'utilisation et modification

---

**Créé par GhostDuckyy** | v1.0.0 | Novembre 2025
