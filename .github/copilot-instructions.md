# Roblox Exploit Development Workspace

## Project Overview
This is a **Roblox exploit script development workspace** containing:
- **UI Libraries collection** (`UI-Libraries/`): 80+ Roblox UI libraries for script interfaces
- **Custom UI system** (`HtmlOnLua.lua`): HTML/CSS renderer for Roblox written in pure Lua
- **Exploit scripts**: Game-specific and utility scripts (FE scripts, hubs, diagnostics)
- **Python utilities**: Pastebin scraper and Lua code formatter

## Core Technologies
- **Lua**: Primary language for Roblox scripts
- **Python**: Utilities for scraping and code formatting
- **Roblox API**: Game services (CoreGui, TweenService, UserInputService, etc.)
- **Executor APIs**: Synapse/KRNL-style functions (`loadstring`, `readfile`, `game:HttpGet`)

## Critical Architecture: HtmlOnLua System

`HtmlOnLua.lua` is a complete HTML/CSS rendering engine in pure Lua (672 lines):

**Architecture** (4-stage pipeline):
1. **HTML Parser** → Tokenizes HTML into DOM tree
2. **CSS Parser** → Extracts style rules (classes, IDs, inline styles)
3. **Style Engine** → Applies CSS to DOM with specificity resolution
4. **Roblox Renderer** → Converts DOM to native Roblox UI (ScreenGui/Frame/TextLabel)

**Usage pattern**:
```lua
local HtmlOnLua = loadstring(readfile("HtmlOnLua.lua"))()
local engine = HtmlOnLua.new()
engine:render(htmlString, cssString)
```

**Supported HTML**: `<div>`, `<p>`, `<h1-h6>`, `<button>`, `<img>`, `<span>`
**Supported CSS**: Colors, dimensions, fonts, borders, layout (flexbox-like)

## UI Libraries Conventions

### Standard Import Pattern
All UI libraries follow the loadstring pattern:
```lua
local library = loadstring(game:HttpGet("URL"))()
local window = library:CreateWindow("Title", "Version")
local tab = window:CreateTab("Tab Name")
local section = tab:CreateSection("Section")
```

### Common Element Types
- **Toggle**: `section:CreateToggle({Name, Callback})`
- **Button**: `section:CreateButton({Name, Callback})`
- **Slider**: `section:CreateSlider({Min, Max, Callback})`
- **Dropdown**: `section:CreateDropdown({List, Callback})`
- **TextBox**: `section:CreateTextBox({Placeholder, Callback})`

### Key Libraries (by popularity in workspace)
- **Orion** / **Rayfield**: Modern, most full-featured
- **Linoria**: Advanced with theme/config managers
- **Void** / **Mercury**: Drawing-based (custom rendering)
- **ImGui (Iris)**: Immediate-mode pattern

## Roblox Service Patterns

### Service Access
Always use `game:GetService()` for reliability:
```lua
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
```

### GUI Protection Pattern
Exploits commonly protect GUIs from detection:
```lua
if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end
screenGui.Parent = game:GetService("CoreGui")
```

### Async Loading Pattern
Scripts wait for game to load before executing:
```lua
repeat wait() until game:IsLoaded()
-- or
if not game:IsLoaded() then game.Loaded:Wait() end
```

## Python Utilities

### `pastebin_db.py`
Scrapes Pastebin for Roblox scripts using Google Search API:
- **Search**: `search_pastebin(keyword)` → paste IDs
- **Download**: `download_paste(paste_id)` → script content
- **Preview mode**: Shows first 10 lines before downloading

### `arrange_orca.py`
Lua code formatter that:
1. Adds newlines after `;`, `end`, `function`, control structures
2. Auto-indents based on `function`/`do`/`then` → `end` blocks
3. Cleans up minified/obfuscated Lua scripts

## File Organization

```
MyExploit/
├── UI-Libraries/          # 80+ UI library implementations
│   ├── Orion/, Rayfield/  # Popular libraries
│   ├── LinoriaLib/        # Advanced library with themes
│   └── ImGui/            # Immediate-mode libraries
├── HtmlOnLua.lua         # HTML/CSS rendering system (core)
├── Demo_Immediate_HtmlOnLua.lua  # HtmlOnLua instant demo
├── SolarisHub/           # Custom hub with UI designer
│   └── solaris_ui_designer.py   # Visual UI builder
├── pastebin_db.py        # Script scraper utility
└── arrange_orca.py       # Lua formatter utility
```

## Development Workflows

### Testing HtmlOnLua Changes
1. Modify `HtmlOnLua.lua`
2. Run `Demo_Immediate_HtmlOnLua.lua` in Roblox executor
3. Check console output for parser errors
4. Verify visual rendering in CoreGui

### Adding New UI Library
1. Create folder in `UI-Libraries/`
2. Add `source.lua` (main implementation)
3. Add `Example.lua` (usage demonstration)
4. Optional: Add `ReadMe.md` with loadstring and preview

### Formatting Obfuscated Scripts
```bash
python arrange_orca.py
# Reads: OrcaV2.lua
# Outputs: OrcaV2_arranged.lua (formatted)
```

## Common Gotchas

### Executor Compatibility
- **Synapse-specific**: `syn.protect_gui()`, `syn.request()`
- **KRNL/Universal**: Use `game:HttpGet()`, check `identifyexecutor()`
- **File operations**: `readfile()`, `writefile()`, `isfolder()`, `makefolder()`

### HtmlOnLua Limitations
- Max ~50 HTML elements for performance
- No JavaScript event handlers (only static onclick)
- Limited CSS (no pseudo-classes, animations partial)
- DOM depth limit ~10 levels

### UI Library Element Limits
Most libraries work best with:
- <50 UI elements per tab
- Simple callbacks (avoid heavy computations)
- Parent elements before adding children

## Key Design Patterns

### Configuration Saving Pattern
```lua
local config = {}
for flag, value in pairs(library.flags) do
    config[flag] = value
end
writefile(folder.."/config.json", game:GetService("HttpService"):JSONEncode(config))
```

### Tween-based Animations
```lua
TweenService:Create(element, TweenInfo.new(0.3), {
    BackgroundTransparency = 0,
    Size = UDim2.new(1, 0, 1, 0)
}):Play()
```

### Remote Script Loading
```lua
-- Pattern used by 90% of libraries
loadstring(game:HttpGet("https://raw.githubusercontent.com/.../source.lua"))()
```

## Documentation References
- `README_HtmlOnLua.md`: Complete HtmlOnLua architecture and API
- `GUIDE_UTILISATION.md`: Quick start guide (French)
- UI library `ReadMe.md` files: Library-specific documentation
- `Docs.md` files: API reference for specific libraries
