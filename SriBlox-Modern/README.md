# SriBlox Modern

Une interface ultra-moderne pour rechercher et exécuter des scripts Roblox depuis ScriptBlox, développée en TypeScript avec Roact + Rodux + Flipper.

## 🎨 Fonctionnalités

- **Interface moderne** : Design inspiré Windows 11 avec effets Acrylic blur
- **Animations fluides** : Transitions Flipper (Spring) sur tous les composants
- **4 thèmes** : Dark, Light, Colorful, Cyberpunk avec gradients
- **Recherche avancée** : API ScriptBlox avec pagination
- **Cards animées** : Hover effects, glow, scale animations
- **État global** : Rodux store pour state management
- **TypeScript** : Code typé et sécurisé avec roblox-ts

## 🚀 Technologies

- **roblox-ts** 2.3.0 - Compilateur TypeScript → Lua
- **@rbxts/roact** 1.4.4 - Bibliothèque UI déclarative (style React)
- **@rbxts/rodux** 3.0.0 - State management (style Redux)
- **@rbxts/flipper** 3.0.0 - Moteur d'animations physiques
- **@rbxts/roact-hooked** 0.4.0 - Hooks React-like pour Roact

## 📦 Installation

```bash
# Installer les dépendances
npm install

# Compiler TypeScript → Lua
npm run build

# Mode watch (recompilation auto)
npm run watch
```

## 🏗️ Structure du projet

```
SriBlox-Modern/
├── src/
│   ├── components/         # Composants Roact
│   │   ├── Acrylic.tsx    # Effet blur Windows 11
│   │   ├── SearchBar.tsx  # Barre de recherche animée
│   │   └── ScriptCard.tsx # Card de script avec hover
│   ├── services/
│   │   └── scriptblox.service.ts  # API wrapper ScriptBlox
│   ├── store/             # State management Rodux
│   │   ├── actions.ts     # Actions Redux
│   │   ├── reducer.ts     # Reducers
│   │   └── store.ts       # Store configuré
│   ├── themes/
│   │   └── themes.ts      # 4 thèmes avec gradients
│   ├── types.ts           # Interfaces TypeScript
│   ├── App.tsx            # Composant principal
│   └── main.client.tsx    # Point d'entrée
├── package.json
├── tsconfig.json
├── default.project.json   # Config Rojo
└── README.md
```

## 🎮 Utilisation

1. **Lancer l'interface** : Appuyez sur `F6` dans le jeu
2. **Rechercher un script** : Tapez dans la barre de recherche et appuyez sur Entrée
3. **Exécuter un script** : Cliquez sur le bouton `▶` Run
4. **Copier le lien** : Cliquez sur `🔗` pour copier l'URL
5. **Fermer** : Cliquez sur `✕` ou appuyez à nouveau sur `F6`

## 🎨 Thèmes disponibles

- **Dark** (défaut) : Fond noir avec accents bleus/violets
- **Light** : Fond blanc avec accents doux
- **Colorful** : Gradients vibrants rose/orange/violet
- **Cyberpunk** : Néon cyan/magenta style futuriste

## 🛠️ Développement

### Compiler le projet

```bash
# Build production
npm run build

# Watch mode (dev)
npm run watch
```

### Tester dans Roblox

1. Compilez avec `npm run build`
2. Le code Lua sera dans `out/`
3. Utilisez Rojo pour syncer : `rojo serve`
4. Connectez Roblox Studio au serveur Rojo
5. Testez le jeu

### Pour executors (Synapse, KRNL, etc.)

Le fichier compilé `out/main.client.lua` peut être exécuté directement :

```lua
loadstring(readfile("SriBlox-Modern/out/main.client.lua"))()
```

## 📝 API ScriptBlox

Le service `ScriptBloxService` expose :

- `searchScripts(query, page, max)` - Recherche de scripts
- `getScriptCode(slug)` - Récupère le code d'un script
- `executeScript(slug)` - Exécute un script
- `copyScriptUrl(slug)` - Copie l'URL dans le presse-papier
- `formatNumber(num)` - Formate les nombres (1200 → 1.2K)
- `formatDate(dateString)` - Formate les dates

## 🎯 Composants clés

### Acrylic

Effet blur moderne Windows 11-style :

```tsx
<Acrylic transparency={0.6} blurSize={24} tintColor={color}>
  {children}
</Acrylic>
```

### SearchBar

Barre de recherche avec animations Flipper :

```tsx
<SearchBar
  theme={theme}
  placeholder="Search..."
  onSearch={(query) => handleSearch(query)}
  onSettingsClick={() => openSettings()}
/>
```

### ScriptCard

Card de script avec hover effects :

```tsx
<ScriptCard script={script} theme={theme} index={0} />
```

## 🐛 Erreurs TypeScript

Les erreurs `Cannot find module '@rbxts/roact'` avant `npm install` sont normales. Elles disparaissent après installation des packages.

## 📄 Licence

Ce projet est open source. Utilisez-le librement pour vos scripts Roblox.

## 🙏 Crédits

- **ScriptBlox API** : https://scriptblox.com
- **roblox-ts** : https://roblox-ts.com
- **Roact** : Bibliothèque UI de Roblox
- **Flipper** : Moteur d'animations de Roblox

---

**Version** : 2.0.0 TypeScript
**Auteur** : SriBlox Team
**Date** : 2024
