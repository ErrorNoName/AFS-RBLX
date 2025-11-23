# 👗 Dress To Impress - Hub Ultimate

> Interface moderne pour Dress To Impress sur Roblox avec toutes les fonctionnalités essentielles

## 📋 Table des Matières
- [Fonctionnalités](#-fonctionnalités)
- [Installation](#-installation)
- [Utilisation](#-utilisation)
- [Scripts Disponibles](#-scripts-disponibles)
- [Screenshots](#-screenshots)
- [FAQ](#-faq)

## ✨ Fonctionnalités

### 💰 Auto Farm
- **Auto Collect Money**: Collecte automatique de toutes les pièces du jeu
- **Vitesse ajustable**: Contrôlez la vitesse de farm (0.01s - 1s)
- **Mode sécurisé**: Évite les détections avec des délais aléatoires

### 👑 VIP Features
- **Free VIP Access**: Débloque les fonctionnalités VIP gratuitement
- **Premium Items**: Accès à tous les items premium
- **Unlock All**: Débloquez tous les vêtements et accessoires

### 👁️ ESP & Vision
- **Player ESP**: Voir tous les joueurs à travers les murs
- **Name Tags**: Affiche les noms des joueurs
- **Couleur personnalisable**: Choisissez la couleur de votre ESP
- **Distance indicator**: Affiche la distance aux joueurs

### 👔 Outfit Tools
- **Copy Outfit**: Copiez la tenue complète de n'importe quel joueur
- **Save Outfits**: Sauvegardez vos tenues préférées
- **Quick Switch**: Changez de tenue instantanément

### ⚙️ Settings
- **Save/Load Config**: Sauvegardez vos paramètres
- **Auto-save**: Sauvegarde automatique de la configuration
- **Multi-profiles**: Créez plusieurs profils de configuration

## 🚀 Installation

### Méthode 1: Loadstring (Recommandé)
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_REPO/DTI_Hub_Ultimate.lua"))()
```

### Méthode 2: Fichier Local
1. Téléchargez `DTI_Hub_Ultimate.lua`
2. Placez-le dans votre dossier d'exploit
3. Exécutez:
```lua
loadstring(readfile("DTI_Hub_Ultimate.lua"))()
```

### Méthode 3: Script Individual
Utilisez les scripts individuels dans le dossier `scripts/`:
```lua
local AutoFarm = loadstring(readfile("scripts/AutoFarmMoney.lua"))()
AutoFarm:Toggle(true)
```

## 📖 Utilisation

### Démarrage Rapide
1. Lancez Dress To Impress sur Roblox
2. Ouvrez votre exécuteur (Synapse, KRNL, etc.)
3. Copiez-collez le code d'installation
4. L'interface s'ouvrira automatiquement!

### Navigation
- **Tab 1 (💰 Auto Farm)**: Fonctionnalités de farming automatique
- **Tab 2 (👑 VIP Features)**: Déblocages VIP et premium
- **Tab 3 (👁️ ESP & Vision)**: Outils de vision et ESP
- **Tab 4 (👔 Outfit Tools)**: Outils de gestion de tenues
- **Tab 5 (⚙️ Settings)**: Paramètres et configuration

### Raccourcis Clavier
- **Right Ctrl**: Ouvrir/Fermer l'interface
- **F9**: Toggle Auto Farm
- **F10**: Toggle ESP

## 📦 Scripts Disponibles

### Structure des Fichiers
```
DressToImpress/
├── DTI_Hub_Ultimate.lua       # Interface principale (Rayfield)
├── DTI_Hub_Orion.lua          # Interface alternative (Orion)
├── README.md                  # Ce fichier
└── scripts/
    ├── AutoFarmMoney.lua      # Module auto farm
    ├── FreeVIP.lua            # Module VIP gratuit
    ├── PlayerESP.lua          # Module ESP
    └── CopyOutfit.lua         # Module copie de tenue
```

### Scripts Individuels

#### AutoFarmMoney.lua
```lua
local AutoFarm = loadstring(readfile("scripts/AutoFarmMoney.lua"))()

-- Activer
AutoFarm:Toggle(true)

-- Désactiver
AutoFarm:Toggle(false)
```

#### FreeVIP.lua
```lua
local VIP = loadstring(readfile("scripts/FreeVIP.lua"))()

-- Activer VIP
VIP:Activate()

-- Désactiver VIP
VIP:Deactivate()
```

#### PlayerESP.lua
```lua
local ESP = loadstring(readfile("scripts/PlayerESP.lua"))()

-- Activer ESP
ESP:Toggle(true)

-- Désactiver ESP
ESP:Toggle(false)
```

#### CopyOutfit.lua
```lua
local CopyOutfit = loadstring(readfile("scripts/CopyOutfit.lua"))()

-- Copier la tenue d'un joueur
CopyOutfit:CopyFromPlayer("PlayerName")

-- Obtenir la liste des joueurs
local players = CopyOutfit:GetPlayerList()
for _, name in ipairs(players) do
    print(name)
end
```

## 🖼️ Screenshots

### Interface Principale
![Main UI](screenshots/main_ui.png)
*Interface moderne avec Rayfield UI Library*

### Auto Farm en Action
![Auto Farm](screenshots/auto_farm.png)
*Collecte automatique de pièces*

### Player ESP
![ESP](screenshots/esp.png)
*Vision ESP avec noms des joueurs*

## 🎨 Personnalisation

### Thèmes
Vous pouvez personnaliser les couleurs de l'interface:

```lua
-- Dans DTI_Hub_Ultimate.lua, modifiez:
local Window = Rayfield:CreateWindow({
    Name = "👗 Votre Nom Ici",
    -- ... autres options
})
```

### Couleurs ESP
```lua
-- Changez la couleur par défaut de l'ESP:
highlight.FillColor = Color3.fromRGB(R, G, B)
```

## ❓ FAQ

### L'interface ne s'affiche pas
**Q**: L'interface ne s'ouvre pas après l'exécution du script.
**R**: Vérifiez que:
- Vous êtes bien dans Dress To Impress
- Votre exécuteur supporte CoreGui
- Le script a fini de charger (regardez la console)

### Auto Farm ne fonctionne pas
**Q**: L'auto farm ne collecte pas les pièces.
**R**: 
- Assurez-vous d'être dans une partie active
- Vérifiez que le toggle est bien activé
- Les pièces peuvent avoir des noms différents selon les updates

### VIP ne se débloque pas
**Q**: Le VIP gratuit ne fonctionne pas.
**R**: 
- Cette fonctionnalité dépend de la structure du jeu
- Rejoignez une partie avant d'activer le VIP
- Certaines protections serveur peuvent bloquer cette fonction

### ESP lag le jeu
**Q**: L'ESP cause des lags.
**R**: 
- Réduisez la transparence
- Désactivez les nametags si non nécessaire
- C'est normal avec beaucoup de joueurs (>20)

### Comment sauvegarder ma config?
**Q**: Mes paramètres ne se sauvegardent pas.
**R**: 
- Utilisez le bouton "💾 Sauvegarder Config" dans Settings
- La config se sauvegarde dans `DTI_Hub/config.json`
- Vérifiez que votre exécuteur supporte `writefile()`

## 🔧 Configuration Avancée

### Modifier la Vitesse de Farm
```lua
-- Dans le code, changez:
SliderFarmSpeed = TabFarm:CreateSlider({
    Range = {0.01, 2},  -- Min, Max
    CurrentValue = 0.1,  -- Valeur par défaut
})
```

### Changer les Touches
```lua
-- Modifiez la touche d'ouverture:
local Input = game:GetService("UserInputService")
Input.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Rayfield:Toggle()
    end
end)
```

## ⚠️ Avertissements

- **Utilisation à vos risques**: L'utilisation de scripts peut entraîner un ban
- **Jeu équitable**: Utilisez ces outils de manière responsable
- **Mises à jour**: Le jeu peut mettre à jour et casser certaines fonctionnalités
- **Support**: Nous ne sommes pas affiliés à Roblox ou Dress To Impress

## 📝 Changelog

### Version 1.0.0 (2025-01-11)
- ✨ Interface initiale avec Rayfield UI
- 💰 Auto Farm Money
- 👑 Free VIP
- 👁️ Player ESP
- 👔 Copy Outfit
- ⚙️ Système de configuration

### Version 1.1.0 (Prévu)
- 🎨 Plus de personnalisation
- 🤖 Auto Win (compétitions)
- 📊 Statistiques détaillées
- 🌐 Support multilingue

## 🤝 Contribution

Les contributions sont les bienvenues! Si vous avez des améliorations:
1. Forkez le projet
2. Créez une branche (`feature/AmazingFeature`)
3. Committez vos changements
4. Ouvrez une Pull Request

## 📜 License

Ce projet est sous licence MIT. Voir `LICENSE` pour plus d'informations.

## 🙏 Crédits

- **UI Libraries**: Rayfield & Orion
- **Communauté**: ScriptBlox, Pastebin
- **Développé par**: MyExploit Team

## 📞 Support

- **Discord**: [Lien Discord]
- **GitHub Issues**: [Lien GitHub]
- **Documentation**: Ce README

---

**🎀 Dress To Impress Hub - L'interface ultime pour DTI! 🎀**

*Dernière mise à jour: 11 Novembre 2025*
