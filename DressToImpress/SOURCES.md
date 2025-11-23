# 📚 Sources des Scripts - Dress To Impress

Ce document liste toutes les sources et références utilisées pour créer ce hub.

## 🌐 Sources Principales

### Scripts ScriptBlox
- **Auto Farm Cash + Free VIP**: https://scriptblox.com/script/Dress-To-Impress-DTI-Au-Farm-Cash-FREE-VIP-and-More-30467
- **Zombie Animation**: https://scriptblox.com/script/Dress-To-Impress-zombie-r15-animation-scary-40411
- **OP GUI Xenith**: https://scriptblox.com/script/NEW-CODE!-Dress-To-Impress-Dress-To-Impress-OP-script-free-gui-Xenith-52366
- **Style Showdown**: https://scriptblox.com/script/Dress-To-Impress-STYLE-SHOWDOWN-DTI-Au-Farm-Cash-and-FREE-Vip-30860

### Pastebin
- **Script Principal**: https://pastebin.com/U7iQuTn3
- **Zombie R15**: https://pastebin.com/raw/0GUbHyeH

### GitHub
- **BobFilho Repository**: https://github.com/BobFilho/dress-to-impress-roblox-scriptworks
  - Features: OpenAI/Claude API integration
  - Multilingual support
  - Responsive UI

### Sites de Scripts
- **RedzHub Scripts**: https://redzhubscripts.com/dress-to-impress-script/
- **RedzHub Blox Fruits**: https://redzhubbloxfruits.com/the-dress-to-impress-script/
- **King Exploits**: https://www.kingexploits.com/post/roblox-dress-to-impress-script-hack

## 🎨 UI Libraries Utilisées

### Rayfield UI
- **Source**: https://sirius.menu/rayfield
- **GitHub**: https://github.com/shlexware/Rayfield (unofficial)
- **Utilisé pour**: Interface moderne principale (DTI_Hub_Ultimate.lua)

### Orion Library
- **Source**: https://raw.githubusercontent.com/shlexware/Orion/main/source
- **GitHub**: https://github.com/shlexware/Orion
- **Utilisé pour**: Interface alternative (DTI_Hub_Orion.lua)

## 🔧 Fonctionnalités et Leurs Sources

### 💰 Auto Farm Money
**Sources d'inspiration**:
- ScriptBlox "Auto Farm Cash" scripts
- Pastebin community scripts
- Custom implementation basée sur workspace object detection

**Code de base**:
```lua
-- Pattern commun trouvé dans plusieurs scripts
for _, coin in pairs(workspace:GetDescendants()) do
    if coin.Name:find("coin") or coin.Name:find("money") then
        -- Téléportation vers la pièce
    end
end
```

### 👑 Free VIP
**Sources d'inspiration**:
- ScriptBlox "FREE Vip" scripts
- BobFilho GitHub repository
- Bypass patterns from Pastebin

**Techniques utilisées**:
1. Modification de BoolValues
2. Interception de RemoteEvents
3. Metatable hooking

### 👁️ Player ESP
**Sources d'inspiration**:
- Scripts ESP universels de la communauté
- Drawing libraries ESP implementations
- Custom Highlight-based approach

**Composants**:
- `Instance.new("Highlight")` pour le contour
- `BillboardGui` pour les nametags
- Color customization system

### 👔 Copy Outfit
**Sources d'inspiration**:
- "Copy Outfit" scripts de ScriptBlox
- Roblox avatar system documentation
- Character manipulation scripts

**Éléments copiés**:
- Accessories (hats, hair, etc.)
- Shirts & Pants
- Body colors
- Face accessories

## 📖 Documentation Consultée

### Roblox Developer Documentation
- **Services**: Players, Workspace, CoreGui
- **Classes**: Accessory, Shirt, Pants, BodyColors
- **Methods**: HttpGet, GetDescendants, FindFirstChild

### Community Resources
- **V3rmillion Forums**: Thread discussions sur DTI scripts
- **YouTube Tutorials**: DTI scripting guides
- **Discord Communities**: Exploit development servers

## 🛠️ Outils Utilisés

### Development
- **VS Code**: Éditeur principal
- **Roblox Studio**: Testing environment
- **Various Executors**: Synapse X, KRNL, Delta

### Libraries & Frameworks
- **Lua 5.1**: Base language
- **Roblox Luau**: Extended Lua version
- **UI Libraries**: Rayfield, Orion

## 🔗 Liens Utiles

### Learning Resources
- **Roblox Scripting Basics**: https://developer.roblox.com/
- **Lua Documentation**: https://www.lua.org/manual/5.1/
- **Exploit Development**: V3rmillion, UnknownCheats

### Community
- **ScriptBlox**: https://scriptblox.com/ (largest script database)
- **Pastebin**: https://pastebin.com/ (script sharing)
- **GitHub**: Various repositories for UI libraries

## ⚠️ Avertissement

Tous les scripts ont été:
- ✅ Analysés pour la sécurité
- ✅ Testés en environnement contrôlé
- ✅ Documentés avec leurs sources
- ✅ Adaptés pour ce hub

**Note**: Ces scripts sont à usage éducatif. L'utilisation dans Roblox peut entraîner des sanctions.

## 📝 Crédits

### Développeurs Originaux
- **BobFilho**: AI integration concepts
- **shlexware**: Orion UI Library
- **Sirius**: Rayfield UI Library
- **Community Contributors**: Various script snippets

### Ce Projet
- **Organisation**: MyExploit Team
- **Compilation**: Scripts DTI Hub
- **Documentation**: README, QUICKSTART, SOURCES

## 🔄 Mise à Jour

**Dernière vérification des sources**: 11 Novembre 2025

Les liens et scripts peuvent changer. Consultez régulièrement ce document pour les mises à jour.

---

**📚 Dress To Impress Hub - Toutes les sources documentées**
