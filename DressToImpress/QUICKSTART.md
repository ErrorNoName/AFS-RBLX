# 🎀 Dress To Impress - Guide de Démarrage Rapide

## 🚀 Installation Ultra-Rapide

### Option 1: Loadstring Direct (Plus Simple)
Copiez-collez dans votre exécuteur:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/VOTRE_REPO/DressToImpress/DTI_Hub_Ultimate.lua"))()
```

### Option 2: Fichier Local
1. Téléchargez tout le dossier `DressToImpress/`
2. Placez-le dans votre dossier de scripts
3. Exécutez:
```lua
loadstring(readfile("DressToImpress/LAUNCH.lua"))()
```

## ⚡ Utilisation Rapide

### Commandes Principales

#### Auto Farm Money
```lua
-- Via l'interface: Tab "💰 Auto Farm" > Toggle "Auto Collect Money"
-- OU directement:
local AutoFarm = loadstring(readfile("DressToImpress/scripts/AutoFarmMoney.lua"))()
AutoFarm:Toggle(true)
```

#### Free VIP
```lua
-- Via l'interface: Tab "👑 VIP Features" > Bouton "Activer VIP Gratuit"
-- OU directement:
local VIP = loadstring(readfile("DressToImpress/scripts/FreeVIP.lua"))()
VIP:Activate()
```

#### Player ESP
```lua
-- Via l'interface: Tab "👁️ ESP" > Toggle "Activer Player ESP"
-- OU directement:
local ESP = loadstring(readfile("DressToImpress/scripts/PlayerESP.lua"))()
ESP:Toggle(true)
```

#### Copy Outfit
```lua
-- Via l'interface: Tab "👔 Outfit" > Sélectionner joueur > "Copier Tenue"
-- OU directement:
local CopyOutfit = loadstring(readfile("DressToImpress/scripts/CopyOutfit.lua"))()
CopyOutfit:CopyFromPlayer("NomDuJoueur")
```

## 🎮 Contrôles

- **Right Ctrl**: Ouvrir/Fermer l'interface
- **Clic gauche**: Naviguer dans l'interface
- **Esc**: Fermer l'interface

## 💡 Astuces

### Maximiser le Farm
1. Activez "Auto Farm Money"
2. Réglez la vitesse sur 100%
3. Laissez tourner pendant la partie

### Copier les Meilleures Tenues
1. Activez "Player ESP" pour voir tout le monde
2. Identifiez les joueurs avec de belles tenues
3. Utilisez "Copy Outfit" pour les copier

### Mode Discret
1. Désactivez l'ESP en public
2. Utilisez le VIP seulement en début de partie
3. Ne farmez pas trop vite (réglez à 50%)

## ⚠️ Problèmes Courants

### "Interface ne s'ouvre pas"
```lua
-- Essayez la version alternative:
loadstring(readfile("DressToImpress/DTI_Hub_Orion.lua"))()
```

### "Auto Farm ne marche pas"
- Vérifiez que vous êtes dans une partie active
- Attendez que le jeu soit complètement chargé
- Réactivez le toggle

### "VIP ne se débloque pas"
- Rejoignez d'abord une partie
- Cliquez à nouveau sur le bouton
- Redémarrez le jeu si nécessaire

## 📞 Support

Pour plus d'aide, consultez le README.md complet!

---

**Bon jeu! 🎀**
