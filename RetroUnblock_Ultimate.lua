-- 🚀 RETROUNBLOCK INTERFACE - VERSION ULTIME
-- Reproduction PARFAITE de l'image sci-fi/rétro fournie
-- Interface complète avec HtmlOnLua

print("🌟 Lancement RetroUnblock Interface - Version Ultime")
print("🎨 Reproduction exacte de l'image sci-fi/rétro avec tous les détails")

-- Chargement de HtmlOnLua depuis Pastebin (méthode confirmée fonctionnelle)
print("📡 Chargement de HtmlOnLua depuis Pastebin...")
local HtmlOnLua = nil
local engine = nil

-- Utilisation de la méthode confirmée par l'utilisateur
print("🔗 Utilisation du lien Pastebin confirmé fonctionnel")
local loadSuccess, loadResult = pcall(function()
    return loadstring(game:HttpGet("https://pastebin.com/raw/nScauqfC", true))()
end)

if loadSuccess and loadResult then
    HtmlOnLua = loadResult
    print("✅ HtmlOnLua chargé avec succès depuis Pastebin")
    print("📦 Type du module:", type(HtmlOnLua))
    
    -- Diagnostic avancé du module
    if type(HtmlOnLua) == "table" then
        local methods = {}
        for key, value in pairs(HtmlOnLua) do
            if type(value) == "function" then
                table.insert(methods, key)
            end
        end
        print("🛠️ Méthodes disponibles:", table.concat(methods, ", "))
    end
    
    -- Création du moteur de rendu avec diagnostic
    if HtmlOnLua.new then
        print("🔧 Méthode 'new' détectée, création d'instance...")
        local engineSuccess, engineResult = pcall(function()
            return HtmlOnLua.new()
        end)
        
        if engineSuccess and engineResult then
            engine = engineResult
            print("✅ Moteur HtmlOnLua prêt pour le rendu !")
            print("🎯 Type de l'instance:", type(engine))
            
            -- Vérifier la méthode render
            if engine.render then
                print("✅ Méthode render confirmée sur l'instance")
            else
                print("❌ Méthode render manquante sur l'instance")
                engine = nil
            end
        else
            print("❌ Erreur de création du moteur:", engineResult)
            print("🔧 Tentative avec méthode alternative...")
            
            -- Tentative avec méthode directe si disponible
            if HtmlOnLua.renderDirect then
                print("🔄 Utilisation de la méthode renderDirect")
                engine = { render = HtmlOnLua.renderDirect }
            else
                print("🔧 Passage en mode interface native")
            end
        end
    else
        print("❌ Méthode 'new' non disponible dans le module")
        print("🔧 Tentative avec méthode directe...")
        
        -- Tentative avec méthode directe
        if HtmlOnLua.renderDirect then
            print("🔄 Utilisation de la méthode renderDirect")
            engine = { render = HtmlOnLua.renderDirect }
        elseif HtmlOnLua.render then
            print("🔄 Utilisation de la méthode render directe")
            engine = { render = HtmlOnLua.render }
        else
            print("🔧 Aucune méthode de rendu disponible - Passage en mode natif")
        end
    end
else
    print("❌ Erreur de chargement:", loadResult)
    print("🔧 Possible causes:")
    print("   • Connexion internet requise")
    print("   • Lien Pastebin temporairement inaccessible")
    print("🎮 Passage en mode interface native équivalente")
end

-- 🎨 HTML COMPLET - Interface exacte de l'image
local perfectHTML = [[
<div class="retro-universe">
    <!-- En-tête avec logo et navigation -->
    <div class="universe-header">
        <div class="retro-logo">RetroUnblock</div>
        <div class="navigation-panel">
            <div class="nav-button">Процент ↗</div>
            <div class="nav-button">Отзывы ↗</div>
            <div class="nav-button">Faq ↗</div>
            <div class="nav-button">Связь ↗</div>
        </div>
    </div>
    
    <!-- Message de bienvenue principal -->
    <div class="welcome-zone">
        <h1 class="commander-title">ДОБРО ПОЖАЛОВАТЬ,<br>КОМАНДИР!</h1>
    </div>
    
    <!-- Zone de contenu principal en 3 colonnes -->
    <div class="main-universe">
        <!-- Panneau gauche - Informations de sécurité -->
        <div class="security-panel">
            <div class="security-alert">
                <div class="alert-icon">○</div>
                <div class="alert-message">
                    <p>ТВОЙ АККАУНТ ПОД АТАКОЙ?</p>
                    <p>ХОЧЕШЬ ЗАБЛОКИРОВАТЬ ВЗЛОМЩИКОВ?</p>
                    <p>ЗАХОДИ СКОРЕЙ В...</p>
                </div>
            </div>
        </div>
        
        <!-- Panneau central - Vaisseau et titre -->
        <div class="command-center">
            <!-- Zone du vaisseau spatial -->
            <div class="spacecraft-zone">
                <div class="spacecraft">🚀</div>
                <div class="engine-trail"></div>
            </div>
            
            <!-- Titre principal du jeu -->
            <div class="game-branding">
                <h2 class="retro-game-title">Retro<br>Unblock!</h2>
            </div>
            
            <!-- Section de lancement -->
            <div class="launch-control">
                <button class="launch-button">Play ►</button>
                <p class="launch-message">"PRESS START TO UNBLOCK"</p>
            </div>
        </div>
        
        <!-- Panneau droit - Mission 2022 -->
        <div class="mission-panel">
            <div class="mission-brief">
                <div class="mission-icon">⊞</div>
                <div class="mission-text">
                    <p>Запускайся в 2022-м,</p>
                    <p>чтобы побороть</p>
                    <p>остатки преступности!</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Champ d'étoiles pour l'atmosphère -->
    <div class="star-universe">
        <div class="cosmic-star star-alpha">✦</div>
        <div class="cosmic-star star-beta">✧</div>
        <div class="cosmic-star star-gamma">✦</div>
        <div class="cosmic-star star-delta">✧</div>
        <div class="cosmic-star star-epsilon">✦</div>
        <div class="cosmic-star star-zeta">✧</div>
        <div class="cosmic-star star-eta">✦</div>
        <div class="cosmic-star star-theta">✧</div>
        <div class="cosmic-star star-iota">✦</div>
        <div class="cosmic-star star-kappa">✧</div>
    </div>
    
    <!-- Effets de particules et lumière -->
    <div class="particle-system">
        <div class="light-particle particle-1"></div>
        <div class="light-particle particle-2"></div>
        <div class="light-particle particle-3"></div>
    </div>
</div>
]]

-- 🎨 CSS COMPLET - Styles sci-fi/rétro parfaits
local perfectCSS = [[
/* 🌌 CONTENEUR UNIVERS RETRO */
.retro-universe {
    background: radial-gradient(ellipse at center, #0f0f23 0%, #0a0a0a 70%, #000000 100%);
    width: 1450px;
    height: 950px;
    border-radius: 30px;
    border: 4px solid #2a2a44;
    color: #f0f0f0;
    font-family: 'Courier New', monospace;
    position: relative;
    overflow: hidden;
    box-shadow: 
        0 0 60px rgba(0, 100, 200, 0.3),
        inset 0 0 100px rgba(0, 50, 100, 0.1);
}

/* 🔝 EN-TÊTE UNIVERS */
.universe-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30px 50px;
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.08) 0%, rgba(255, 255, 255, 0.03) 100%);
    border-bottom: 3px solid #333355;
    backdrop-filter: blur(15px);
}

.retro-logo {
    font-size: 32px;
    font-weight: bold;
    color: #ffffff;
    text-shadow: 
        0 0 20px rgba(255, 255, 255, 0.6),
        2px 2px 4px rgba(0, 0, 0, 0.8);
    letter-spacing: 3px;
    font-family: 'Impact', 'Arial Black', sans-serif;
}

.navigation-panel {
    display: flex;
    gap: 40px;
}

.nav-button {
    color: #ccccdd;
    font-size: 17px;
    font-weight: bold;
    padding: 12px 20px;
    border: 2px solid #444466;
    border-radius: 25px;
    background: linear-gradient(145deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
    cursor: pointer;
    transition: all 0.4s ease;
    letter-spacing: 1px;
}

.nav-button:hover {
    background: linear-gradient(145deg, rgba(100, 150, 255, 0.2), rgba(100, 150, 255, 0.1));
    border-color: #6699ff;
    box-shadow: 0 0 20px rgba(102, 153, 255, 0.5);
    transform: translateY(-2px);
}

/* 🎯 ZONE DE BIENVENUE */
.welcome-zone {
    text-align: center;
    padding: 50px 0;
}

.commander-title {
    font-size: 42px;
    font-weight: bold;
    color: #ffdd33;
    text-shadow: 
        3px 3px 0px #cc9900,
        6px 6px 15px rgba(255, 221, 51, 0.5);
    letter-spacing: 4px;
    line-height: 1.2;
    font-family: 'Courier New', monospace;
    text-transform: uppercase;
    margin: 0;
}

/* 🏗️ UNIVERS PRINCIPAL */
.main-universe {
    display: grid;
    grid-template-columns: 1fr 2.5fr 1fr;
    gap: 50px;
    padding: 0 50px;
    height: calc(100% - 300px);
    align-items: center;
}

/* 📋 PANNEAUX LATÉRAUX */
.security-panel, .mission-panel {
    background: linear-gradient(145deg, rgba(255, 255, 255, 0.12), rgba(255, 255, 255, 0.06));
    border: 3px solid #444466;
    border-radius: 20px;
    padding: 40px 25px;
    backdrop-filter: blur(8px);
    box-shadow: 
        0 8px 20px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

.security-alert, .mission-brief {
    text-align: center;
}

.alert-icon, .mission-icon {
    font-size: 56px;
    color: #88bbff;
    margin-bottom: 25px;
    text-shadow: 0 0 25px rgba(136, 187, 255, 0.7);
    display: block;
}

.alert-message, .mission-text {
    font-size: 15px;
    line-height: 1.7;
    color: #dddddd;
    letter-spacing: 1px;
    font-weight: 500;
}

.alert-message p, .mission-text p {
    margin: 8px 0;
}

/* 🚀 CENTRE DE COMMANDE */
.command-center {
    text-align: center;
    position: relative;
}

.spacecraft-zone {
    position: relative;
    margin-bottom: 40px;
}

.spacecraft {
    font-size: 140px;
    margin-bottom: 20px;
    filter: drop-shadow(0 0 30px rgba(255, 255, 255, 0.8));
    animation: spacecraft-float 4s ease-in-out infinite;
    display: block;
}

.engine-trail {
    position: absolute;
    bottom: -20px;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 100px;
    background: linear-gradient(to bottom, 
        rgba(255, 100, 0, 0.6) 0%,
        rgba(255, 150, 0, 0.4) 50%,
        transparent 100%);
    border-radius: 50%;
    filter: blur(8px);
    animation: engine-pulse 2s ease-in-out infinite alternate;
}

.game-branding {
    margin: 30px 0 50px 0;
}

.retro-game-title {
    font-size: 84px;
    font-weight: bold;
    color: #ffffff;
    text-shadow: 
        4px 4px 0px #666666,
        8px 8px 15px rgba(255, 255, 255, 0.4);
    letter-spacing: 5px;
    line-height: 0.85;
    font-family: 'Impact', 'Arial Black', sans-serif;
    margin: 0;
}

/* 🎮 CONTRÔLES DE LANCEMENT */
.launch-control {
    margin-top: 50px;
}

.launch-button {
    background: linear-gradient(145deg, #2a2a2a, #1a1a1a);
    border: 4px solid #666666;
    border-radius: 18px;
    color: #ffffff;
    font-size: 36px;
    font-weight: bold;
    padding: 25px 70px;
    cursor: pointer;
    box-shadow: 
        0 10px 20px rgba(0, 0, 0, 0.5),
        inset 0 2px 0 rgba(255, 255, 255, 0.15);
    transition: all 0.4s ease;
    font-family: 'Arial', sans-serif;
    letter-spacing: 3px;
}

.launch-button:hover {
    background: linear-gradient(145deg, #3a3a3a, #2a2a2a);
    border-color: #88bbff;
    box-shadow: 
        0 0 30px rgba(136, 187, 255, 0.6),
        0 10px 20px rgba(0, 0, 0, 0.5);
    transform: translateY(-3px);
}

.launch-message {
    margin-top: 30px;
    font-size: 18px;
    color: #aaaaaa;
    letter-spacing: 3px;
    font-weight: bold;
}

/* ✨ UNIVERS D'ÉTOILES */
.star-universe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 1;
}

.cosmic-star {
    position: absolute;
    color: #ffffff;
    font-size: 18px;
    opacity: 0.8;
    animation: stellar-twinkle 3s ease-in-out infinite alternate;
}

.star-alpha { top: 12%; left: 8%; animation-delay: 0s; }
.star-beta { top: 20%; left: 88%; animation-delay: 0.6s; }
.star-gamma { top: 40%; left: 3%; animation-delay: 1.2s; }
.star-delta { top: 60%; left: 92%; animation-delay: 1.8s; }
.star-epsilon { top: 75%; left: 12%; animation-delay: 0.4s; }
.star-zeta { top: 35%; left: 78%; animation-delay: 1s; }
.star-eta { top: 55%; left: 22%; animation-delay: 1.6s; }
.star-theta { top: 85%; left: 85%; animation-delay: 0.8s; }
.star-iota { top: 25%; left: 45%; animation-delay: 1.4s; }
.star-kappa { top: 70%; left: 55%; animation-delay: 0.2s; }

/* 🌟 SYSTÈME DE PARTICULES */
.particle-system {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 0;
}

.light-particle {
    position: absolute;
    width: 4px;
    height: 4px;
    background: rgba(255, 255, 255, 0.6);
    border-radius: 50%;
    animation: particle-drift 8s linear infinite;
}

.particle-1 {
    top: 20%;
    left: 10%;
    animation-delay: 0s;
}

.particle-2 {
    top: 60%;
    left: 80%;
    animation-delay: 2s;
}

.particle-3 {
    top: 80%;
    left: 30%;
    animation-delay: 4s;
}

/* 🎬 ANIMATIONS */
@keyframes spacecraft-float {
    0%, 100% { 
        transform: translateY(0px) rotate(0deg); 
        filter: drop-shadow(0 0 30px rgba(255, 255, 255, 0.8));
    }
    50% { 
        transform: translateY(-20px) rotate(3deg); 
        filter: drop-shadow(0 0 40px rgba(255, 255, 255, 1));
    }
}

@keyframes engine-pulse {
    0% { 
        opacity: 0.6; 
        transform: translateX(-50%) scale(1);
    }
    100% { 
        opacity: 1; 
        transform: translateX(-50%) scale(1.2);
    }
}

@keyframes stellar-twinkle {
    0% { 
        opacity: 0.4; 
        transform: scale(0.8);
    }
    100% { 
        opacity: 1; 
        transform: scale(1.3);
    }
}

@keyframes particle-drift {
    0% { 
        transform: translateY(0px);
        opacity: 0;
    }
    10% { 
        opacity: 1;
    }
    90% { 
        opacity: 1;
    }
    100% { 
        transform: translateY(-100px);
        opacity: 0;
    }
}

/* 🌟 EFFETS DE PROFONDEUR */
.retro-universe::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: 
        radial-gradient(circle at 25% 25%, rgba(0, 100, 255, 0.15) 0%, transparent 60%),
        radial-gradient(circle at 75% 75%, rgba(255, 0, 150, 0.15) 0%, transparent 60%);
    pointer-events: none;
    z-index: 0;
}

/* Éléments au-dessus du fond */
.universe-header, .welcome-zone, .main-universe {
    position: relative;
    z-index: 2;
}
]]

-- 🚀 RENDU DE L'INTERFACE ULTIME
print("🎨 Rendu de l'interface RetroUnblock Ultimate...")

if engine then
    local success, error = pcall(function()
        engine:render(perfectHTML, perfectCSS)
    end)

    if success then
        print("✅ SUCCÈS ! Interface RetroUnblock Ultimate créée !")
        print("🌟 Reproduction PARFAITE de l'image sci-fi/rétro")
        print("")
        print("🎮 CARACTÉRISTIQUES DE L'INTERFACE :")
        print("   ✦ Logo RetroUnblock avec navigation complète")
        print("   ✦ Titre cyrillique 'ДОБРО ПОЖАЛОВАТЬ, КОМАНДИР!' en doré")
        print("   ✦ Layout 3 colonnes exactement comme l'image")
        print("   ✦ Vaisseau spatial 🚀 avec animation flottante")
        print("   ✦ Titre 'Retro Unblock!' en police Impact")
        print("   ✦ Bouton 'Play ►' avec effets hover interactifs")
        print("   ✦ Messages en cyrillique authentiques")
        print("   ✦ Champ d'étoiles scintillantes animées")
        print("   ✦ Effets de particules et lumière d'ambiance")
        print("   ✦ Dégradés spatiaux et effets de profondeur")
        print("")
        print("🌌 THÈME SPATIAL COMPLET :")
        print("   • Fond noir spatial avec dégradé radial")
        print("   • Couleurs : Noir, bleu, jaune doré, blanc")
        print("   • Effets : Blur, ombres, animations CSS")
        print("   • Style : Sci-fi/Rétro authentique")
        print("")
        print("🎯 Interface prête pour l'exploration spatiale !")
    else
        warn("❌ Erreur de rendu HtmlOnLua:", error)
        print("🔧 Passage en mode démonstration alternative...")
        
        -- Création d'une interface Roblox native simple
        local function createNativeDemo()
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "RetroUnblockDemo"
            ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            
            local MainFrame = Instance.new("Frame")
            MainFrame.Size = UDim2.new(0, 800, 0, 600)
            MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
            MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 35)
            MainFrame.BorderSizePixel = 0
            MainFrame.Parent = ScreenGui
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 20)
            UICorner.Parent = MainFrame
            
            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, 0, 0, 80)
            Title.Position = UDim2.new(0, 0, 0, 20)
            Title.BackgroundTransparency = 1
            Title.Text = "🚀 RetroUnblock"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextScaled = true
            Title.Font = Enum.Font.SourceSansBold
            Title.Parent = MainFrame
            
            local WelcomeText = Instance.new("TextLabel")
            WelcomeText.Size = UDim2.new(1, 0, 0, 100)
            WelcomeText.Position = UDim2.new(0, 0, 0, 120)
            WelcomeText.BackgroundTransparency = 1
            WelcomeText.Text = "ДОБРО ПОЖАЛОВАТЬ, КОМАНДИР!"
            WelcomeText.TextColor3 = Color3.fromRGB(255, 221, 51)
            WelcomeText.TextScaled = true
            WelcomeText.Font = Enum.Font.SourceSansBold
            WelcomeText.Parent = MainFrame
            
            local GameTitle = Instance.new("TextLabel")
            GameTitle.Size = UDim2.new(1, 0, 0, 120)
            GameTitle.Position = UDim2.new(0, 0, 0, 280)
            GameTitle.BackgroundTransparency = 1
            GameTitle.Text = "Retro Unblock!"
            GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            GameTitle.TextScaled = true
            GameTitle.Font = Enum.Font.SourceSansBold
            GameTitle.Parent = MainFrame
            
            local PlayButton = Instance.new("TextButton")
            PlayButton.Size = UDim2.new(0, 250, 0, 80)
            PlayButton.Position = UDim2.new(0.5, -125, 0, 450)
            PlayButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            PlayButton.Text = "Play ►"
            PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayButton.TextScaled = true
            PlayButton.Font = Enum.Font.SourceSansBold
            PlayButton.Parent = MainFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 15)
            ButtonCorner.Parent = PlayButton
            
            PlayButton.MouseButton1Click:Connect(function()
                print("🎮 RetroUnblock lancé !")
            end)
            
            print("✅ Interface de démonstration native créée !")
        end
        
        local nativeSuccess, nativeError = pcall(createNativeDemo)
        if not nativeSuccess then
            warn("❌ Erreur interface native:", nativeError)
        end
    end
else
    warn("❌ HtmlOnLua non disponible")
    print("🔧 Création d'une interface de démonstration Roblox native...")
    
    -- Interface de démonstration complète en Roblox natif
    local function createFullNativeInterface()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "RetroUnblockNative"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        -- Conteneur principal
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 1200, 0, 800)
        MainFrame.Position = UDim2.new(0.5, -600, 0.5, -400)
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
        MainFrame.BorderSizePixel = 0
        MainFrame.Parent = ScreenGui
        
        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 25)
        MainCorner.Parent = MainFrame
        
        -- En-tête
        local Header = Instance.new("Frame")
        Header.Size = UDim2.new(1, 0, 0, 80)
        Header.Position = UDim2.new(0, 0, 0, 0)
        Header.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
        Header.BorderSizePixel = 0
        Header.Parent = MainFrame
        
        local HeaderCorner = Instance.new("UICorner")
        HeaderCorner.CornerRadius = UDim.new(0, 25)
        HeaderCorner.Parent = Header
        
        local Logo = Instance.new("TextLabel")
        Logo.Size = UDim2.new(0, 300, 1, 0)
        Logo.Position = UDim2.new(0, 20, 0, 0)
        Logo.BackgroundTransparency = 1
        Logo.Text = "RetroUnblock"
        Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
        Logo.TextScaled = true
        Logo.Font = Enum.Font.SourceSansBold
        Logo.Parent = Header
        
        -- Titre de bienvenue
        local WelcomeTitle = Instance.new("TextLabel")
        WelcomeTitle.Size = UDim2.new(1, 0, 0, 100)
        WelcomeTitle.Position = UDim2.new(0, 0, 0, 100)
        WelcomeTitle.BackgroundTransparency = 1
        WelcomeTitle.Text = "ДОБРО ПОЖАЛОВАТЬ, КОМАНДИР!"
        WelcomeTitle.TextColor3 = Color3.fromRGB(255, 221, 51)
        WelcomeTitle.TextScaled = true
        WelcomeTitle.Font = Enum.Font.SourceSansBold
        WelcomeTitle.Parent = MainFrame
        
        -- Titre du jeu
        local GameTitle = Instance.new("TextLabel")
        GameTitle.Size = UDim2.new(0, 600, 0, 200)
        GameTitle.Position = UDim2.new(0.5, -300, 0, 350)
        GameTitle.BackgroundTransparency = 1
        GameTitle.Text = "Retro\nUnblock!"
        GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        GameTitle.TextScaled = true
        GameTitle.Font = Enum.Font.SourceSansBold
        GameTitle.Parent = MainFrame
        
        -- Bouton Play
        local PlayButton = Instance.new("TextButton")
        PlayButton.Size = UDim2.new(0, 300, 0, 80)
        PlayButton.Position = UDim2.new(0.5, -150, 0, 600)
        PlayButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
        PlayButton.Text = "Play ►"
        PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.TextScaled = true
        PlayButton.Font = Enum.Font.SourceSansBold
        PlayButton.Parent = MainFrame
        
        local PlayCorner = Instance.new("UICorner")
        PlayCorner.CornerRadius = UDim.new(0, 15)
        PlayCorner.Parent = PlayButton
        
        -- Sous-titre
        local Subtitle = Instance.new("TextLabel")
        Subtitle.Size = UDim2.new(1, 0, 0, 40)
        Subtitle.Position = UDim2.new(0, 0, 0, 720)
        Subtitle.BackgroundTransparency = 1
        Subtitle.Text = '"PRESS START TO UNBLOCK"'
        Subtitle.TextColor3 = Color3.fromRGB(170, 170, 170)
        Subtitle.TextScaled = true
        Subtitle.Font = Enum.Font.SourceSans
        Subtitle.Parent = MainFrame
        
        -- Interaction
        PlayButton.MouseButton1Click:Connect(function()
            print("🎮 RetroUnblock - Jeu lancé !")
            PlayButton.Text = "Launching..."
            wait(1)
            PlayButton.Text = "Play ►"
        end)
        
        print("✅ Interface native RetroUnblock créée avec succès !")
        print("🎮 Cliquez sur 'Play ►' pour tester l'interaction")
    end
    
    local success, error = pcall(createFullNativeInterface)
    if success then
        print("✅ Interface de démonstration affichée")
    else
        warn("❌ Erreur complète:", error)
        print("⚠️ Vérifiez que vous êtes dans un environnement Roblox valide")
    end
end

print("\n🚀 RetroUnblock Interface - Mission accomplie !")
print("📡 Basé sur l'analyse détaillée de votre image de référence")
print("🎮 Compatible avec tous les exploits Roblox")
print("🌟 Prêt pour l'aventure spatiale !")
