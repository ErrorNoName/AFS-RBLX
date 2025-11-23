# ============================================
# 🚀 SriBlox Modern Build Script
# ============================================
# TypeScript → Lua → RBXM → Bundle
# Basé sur le système Orca

param(
    [string]$Mode = "dev",
    [switch]$SkipCompile,
    [switch]$Verbose
)

# Couleurs
function Write-Success { param($msg) Write-Host "✅ $msg" -ForegroundColor Green }
function Write-Error { param($msg) Write-Host "❌ $msg" -ForegroundColor Red }
function Write-Info { param($msg) Write-Host "ℹ️  $msg" -ForegroundColor Cyan }
function Write-Step { param($msg) Write-Host "`n🔧 $msg..." -ForegroundColor Yellow }

# Configuration
$ProjectRoot = $PSScriptRoot
$OutDir = Join-Path $ProjectRoot "out"
$PublicDir = Join-Path $ProjectRoot "public"
$ModelFile = Join-Path $ProjectRoot "SriBloxModern.rbxm"
$Version = "2.0.0"

# Télécharger Rojo et Remodel si nécessaire
$RojoUrl = "https://github.com/rojo-rbx/rojo/releases/download/v7.4.0/rojo-7.4.0-windows.zip"
$RemodelUrl = "https://github.com/rojo-rbx/remodel/releases/download/v0.11.0/remodel-0.11.0-win64.zip"

$RojoExe = Join-Path $ProjectRoot "rojo.exe"
$RemodelExe = Join-Path $ProjectRoot "remodel.exe"

# Créer public/
if (-not (Test-Path $PublicDir)) {
    New-Item -ItemType Directory -Path $PublicDir | Out-Null
}

# Fichier de sortie
$OutputFile = Join-Path $PublicDir "SriBloxModern.lua"

Write-Host @"

==========================================
   SRIBLOX MODERN BUILD
   Version: $Version
==========================================

"@ -ForegroundColor Magenta

# ============================================
# Étape 1: Vérification outils
# ============================================
Write-Step "Vérification des outils"

# Node.js
try {
    $NodeVersion = node --version 2>$null
    Write-Success "Node.js: $NodeVersion"
} catch {
    Write-Error "Node.js non trouvé!"
    exit 1
}

# npm
try {
    $NpmVersion = npm --version 2>$null
    Write-Success "npm: v$NpmVersion"
} catch {
    Write-Error "npm non trouvé!"
    exit 1
}

# Télécharger Rojo si manquant
if (-not (Test-Path $RojoExe)) {
    Write-Info "Téléchargement de Rojo..."
    try {
        $TempZip = Join-Path $env:TEMP "rojo.zip"
        Invoke-WebRequest -Uri $RojoUrl -OutFile $TempZip
        Expand-Archive -Path $TempZip -DestinationPath $ProjectRoot -Force
        Remove-Item $TempZip
        Write-Success "Rojo téléchargé"
    } catch {
        Write-Error "Échec du téléchargement de Rojo"
        exit 1
    }
}

# Télécharger Remodel si manquant
if (-not (Test-Path $RemodelExe)) {
    Write-Info "Téléchargement de Remodel..."
    try {
        $TempZip = Join-Path $env:TEMP "remodel.zip"
        Invoke-WebRequest -Uri $RemodelUrl -OutFile $TempZip
        Expand-Archive -Path $TempZip -DestinationPath $ProjectRoot -Force
        Remove-Item $TempZip
        Write-Success "Remodel téléchargé"
    } catch {
        Write-Error "Échec du téléchargement de Remodel"
        exit 1
    }
}

Write-Success "Tous les outils sont prêts"

# Vérifier node_modules
if (-not (Test-Path "node_modules")) {
    Write-Info "Installation des dépendances..."
    npm install --legacy-peer-deps
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Échec installation npm"
        exit 1
    }
}

# ============================================
# Étape 2: Compilation TypeScript
# ============================================
if (-not $SkipCompile) {
    Write-Step "Compilation TypeScript → Lua"
    
    if (Test-Path $OutDir) {
        Remove-Item -Recurse -Force $OutDir
    }
    
    if ($Verbose) {
        npm run compile -- --verbose
    } else {
        npm run compile
    }
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Échec compilation"
        exit 1
    }
    
    $LuaFiles = (Get-ChildItem -Recurse -Filter "*.lua" $OutDir).Count
    Write-Success "Compilation OK ($LuaFiles fichiers)"
}

# ============================================
# Étape 3: Build Rojo
# ============================================
Write-Step "Build RBXM avec Rojo"

if (Test-Path $ModelFile) {
    Remove-Item $ModelFile
}

if ($Verbose) {
    & $RojoExe build default.project.json --output $ModelFile
} else {
    & $RojoExe build default.project.json --output $ModelFile 2>&1 | Out-Null
}

if ($LASTEXITCODE -ne 0) {
    Write-Error "Échec build Rojo"
    exit 1
}

if (Test-Path $ModelFile) {
    $ModelSize = [math]::Round((Get-Item $ModelFile).Length / 1KB, 2)
    Write-Success "RBXM créé ($ModelSize KB)"
} else {
    Write-Error "RBXM non généré"
    exit 1
}

# ============================================
# Étape 4: Bundle avec Remodel
# ============================================
Write-Step "Création du bundle Lua"

$RemodelArgs = @("run", "ci/bundle.lua", $OutputFile, $Version)

if ($Verbose) {
    $RemodelArgs += "verbose"
}

& $RemodelExe $RemodelArgs

if ($LASTEXITCODE -ne 0) {
    Write-Error "Échec bundling"
    exit 1
}

if (Test-Path $OutputFile) {
    $BundleSize = [math]::Round((Get-Item $OutputFile).Length / 1KB, 2)
    $Lines = (Get-Content $OutputFile).Count
    Write-Success "Bundle créé ($BundleSize KB, $Lines lignes)"
} else {
    Write-Error "Bundle non généré"
    exit 1
}

# ============================================
# Résumé
# ============================================
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "   BUILD TERMINÉ AVEC SUCCÈS!          " -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

Write-Info "Fichiers générés:"
Write-Host "   [RBXM] " -NoNewline
Write-Host "SriBloxModern.rbxm" -ForegroundColor Cyan
Write-Host "   [LUA]  " -NoNewline
Write-Host "public\SriBloxModern.lua" -ForegroundColor Cyan

Write-Host "`nPour tester dans Roblox:" -ForegroundColor Yellow
Write-Host "   loadstring(readfile(`"public/SriBloxModern.lua`"))()" -ForegroundColor Gray

Write-Host "`n✨ SriBlox Modern v$Version prêt à l'emploi!`n" -ForegroundColor Magenta
