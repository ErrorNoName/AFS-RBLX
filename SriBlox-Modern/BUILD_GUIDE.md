# 🚀 Guide de Build - SriBlox Modern

Ce guide explique comment compiler et utiliser SriBlox Modern.

## ⚙️ Prérequis

1. **Node.js** (v16 ou supérieur) : https://nodejs.org
2. **npm** (inclus avec Node.js)
3. **Éditeur de code** : VS Code recommandé

## 📦 Installation initiale

```bash
# Se placer dans le dossier du projet
cd SriBlox-Modern

# Installer toutes les dépendances
npm install
```

Cela va installer :
- `roblox-ts` : Compilateur TypeScript → Lua
- `@rbxts/roact` : Bibliothèque UI
- `@rbxts/rodux` : State management
- `@rbxts/flipper` : Animations
- `@rbxts/roact-hooked` : Hooks React-like
- `@rbxts/roact-rodux` : Intégration Roact + Rodux

## 🔨 Compilation

### Build standard (production)

```bash
npm run build
```

Résultat : Fichiers Lua compilés dans `out/`

### Watch mode (développement)

```bash
npm run watch
```

Mode watch : recompile automatiquement à chaque modification TypeScript.

## 📁 Structure après build

```
SriBlox-Modern/
├── src/                    # Code source TypeScript
├── out/                    # Code compilé Lua ✅
│   ├── main.client.lua
│   ├── App.lua
│   ├── components/
│   ├── services/
│   ├── store/
│   └── themes/
├── node_modules/           # Dépendances npm
└── package.json
```

## 🎮 Méthodes d'utilisation

### Méthode 1 : Executor (Synapse, KRNL, etc.)

**Étape 1 : Compiler**
```bash
npm run build
```

**Étape 2 : Copier le code**

Le fichier principal est `out/main.client.lua`. Cependant, comme il utilise des modules (`require`), vous devez :

1. Utiliser un bundler (voir section suivante)
2. OU copier manuellement tous les fichiers `out/` dans votre executor
3. OU utiliser `loadstring` avec tous les modules chargés

**Étape 3 : Exécuter**
```lua
-- Dans votre executor
loadstring(readfile("SriBlox-Modern/out/main.client.lua"))()
```

### Méthode 2 : Roblox Studio (avec Rojo)

**Étape 1 : Installer Rojo**
```bash
# Windows (avec Chocolatey)
choco install rojo

# OU télécharger depuis https://github.com/rojo-rbx/rojo/releases
```

**Étape 2 : Compiler TypeScript**
```bash
npm run build
```

**Étape 3 : Serveur Rojo**
```bash
rojo serve
```

**Étape 4 : Connecter Roblox Studio**
1. Ouvrir Roblox Studio
2. Installer le plugin Rojo : https://www.roblox.com/library/13916111004
3. Cliquer sur "Connect" dans le plugin
4. Entrer `localhost:34872`

Le projet sera synchronisé dans Studio.

**Étape 5 : Tester**
1. Appuyez sur F5 dans Studio
2. Appuyez sur F6 dans le jeu pour ouvrir SriBlox

### Méthode 3 : Bundle unique (recommandé pour executors)

**Créer un bundler simple :**

Créez `bundle.js` dans le dossier racine :

```javascript
const fs = require('fs');
const path = require('path');

// Fonction récursive pour bundler
function bundleDirectory(dir, prefix = '') {
    let output = '';
    const files = fs.readdirSync(dir);
    
    files.forEach(file => {
        const filePath = path.join(dir, file);
        const stat = fs.statSync(filePath);
        
        if (stat.isDirectory()) {
            output += bundleDirectory(filePath, prefix + file + '/');
        } else if (file.endsWith('.lua')) {
            const moduleName = prefix + file.replace('.lua', '');
            const content = fs.readFileSync(filePath, 'utf8');
            output += `-- Module: ${moduleName}\n`;
            output += `local ${moduleName.replace(/[\/\-\.]/g, '_')} = (function()\n`;
            output += content;
            output += `\nend)()\n\n`;
        }
    });
    
    return output;
}

// Bundle
const bundled = bundleDirectory('./out');
fs.writeFileSync('./SriBloxModern_Bundle.lua', bundled);
console.log('✅ Bundle créé : SriBloxModern_Bundle.lua');
```

**Utiliser le bundler :**

```bash
# Compiler TypeScript
npm run build

# Créer le bundle
node bundle.js
```

Résultat : **Un seul fichier** `SriBloxModern_Bundle.lua` à exécuter.

## 🐛 Résolution de problèmes

### Erreur : `Cannot find module '@rbxts/roact'`

**Solution :** Exécuter `npm install`

### Erreur : `rbxtsc: command not found`

**Solution :** 
```bash
npm install -g roblox-ts
# OU
npx rbxtsc
```

### Erreur : Les animations ne fonctionnent pas

**Cause :** Flipper nécessite un Heartbeat loop actif.

**Solution :** Vérifier que le code s'exécute bien dans un environnement Roblox.

### Erreur : `loadstring` not found

**Cause :** Script exécuté dans Roblox Studio (loadstring désactivé).

**Solution :** Utiliser Rojo ou un executor.

## 📊 Optimisation

### Minification Lua

Pour réduire la taille du code compilé :

```bash
# Installer luamin
npm install -g luamin

# Minifier un fichier
luamin -f out/main.client.lua > out/main.client.min.lua
```

### Tree shaking

roblox-ts fait du tree shaking automatique. Pour optimiser :

1. Évitez les imports inutilisés
2. Utilisez des imports nommés plutôt que `import *`
3. Compilez en mode production

## 🔄 Workflow de développement recommandé

1. **Modifier le code TypeScript** dans `src/`
2. **Watch mode actif** : `npm run watch`
3. **Tester dans Roblox** :
   - Studio : Utiliser Rojo
   - Executor : Copier `out/main.client.lua`
4. **Commiter les changements** (Git)

## 📝 Scripts npm disponibles

| Commande | Description |
|----------|-------------|
| `npm run build` | Compile TypeScript → Lua (production) |
| `npm run watch` | Compile en mode watch (dev) |
| `npm install` | Installe les dépendances |

## 🎯 Commandes utiles

```bash
# Installer une nouvelle dépendance
npm install @rbxts/exemple-package

# Mettre à jour les dépendances
npm update

# Vérifier les types TypeScript
npx tsc --noEmit

# Linter le code
npx eslint src/
```

## 🚀 Déploiement

### Pour utilisateurs finaux (executor)

1. Compilez : `npm run build`
2. Créez le bundle : `node bundle.js`
3. Distribuez : `SriBloxModern_Bundle.lua`

### Pour développeurs (GitHub)

1. Pushez le code source (sans `node_modules/` et `out/`)
2. Autres développeurs clonent et font `npm install`
3. Compilation automatique avec `npm run build`

## 📞 Support

- **Erreurs TypeScript** : Vérifier `tsconfig.json`
- **Erreurs Lua** : Vérifier les logs Roblox
- **Erreurs npm** : Supprimer `node_modules/` et refaire `npm install`

---

**Bonne compilation !** 🎉
