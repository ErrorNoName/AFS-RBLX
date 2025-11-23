-- Test Local du système HtmlOnLua
-- Ce script peut être exécuté directement dans l'environnement de développement

-- Import du module HtmlOnLua
local HtmlOnLua = require(script.Parent.HtmlOnLua) -- Ajustez le chemin selon votre structure

-- Configuration de test
local DELAY_BETWEEN_TESTS = 3 -- secondes

-- Fonction utilitaire pour attendre
local function delay(seconds)
    local startTime = tick()
    while tick() - startTime < seconds do
        game:GetService("RunService").Heartbeat:Wait()
    end
end

-- Test 1 : Interface de base
local function testBasicInterface()
    print("🔧 Test 1: Interface de base")
    
    local htmlEngine = HtmlOnLua.new()
    
    local html = [[
    <div class="app">
        <h1>✨ HtmlOnLua Demo</h1>
        <p class="subtitle">Rendu HTML/CSS en temps réel dans Roblox</p>
        <div class="buttons">
            <button class="btn-success">✅ Succès</button>
            <button class="btn-warning">⚠️ Attention</button>
            <button class="btn-danger">❌ Erreur</button>
        </div>
        <div class="info">
            <p>Cette interface est générée à partir de code HTML/CSS pur!</p>
        </div>
    </div>
    ]]
    
    local css = [[
    .app {
        background-color: #f8f9fa;
        width: 100%;
        height: 100%;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    h1 {
        color: #2c3e50;
        font-size: 32px;
        text-align: center;
        margin-bottom: 10px;
    }
    
    .subtitle {
        color: #7f8c8d;
        font-size: 18px;
        text-align: center;
        margin-bottom: 30px;
    }
    
    .buttons {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-bottom: 30px;
    }
    
    .btn-success {
        background-color: #27ae60;
        color: white;
        width: 150px;
        height: 45px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
    }
    
    .btn-warning {
        background-color: #f39c12;
        color: white;
        width: 150px;
        height: 45px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
    }
    
    .btn-danger {
        background-color: #e74c3c;
        color: white;
        width: 150px;
        height: 45px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
    }
    
    .info {
        background-color: #ecf0f1;
        padding: 20px;
        border-radius: 8px;
        border-left: 4px solid #3498db;
    }
    
    .info p {
        color: #2c3e50;
        font-size: 16px;
        margin: 0;
    }
    ]]
    
    local success, error = pcall(function()
        htmlEngine:render(html, css)
    end)
    
    if success then
        print("✅ Test 1 réussi - Interface de base affichée")
    else
        warn("❌ Test 1 échoué:", error)
    end
end

-- Test 2 : Dashboard avec statistiques
local function testDashboard()
    print("📊 Test 2: Dashboard avec statistiques")
    
    local htmlEngine = HtmlOnLua.new()
    
    local html = [[
    <div class="dashboard">
        <div class="header">
            <h1>📊 Dashboard Roblox</h1>
            <p>Statistiques en temps réel</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card players">
                <div class="stat-icon">👥</div>
                <div class="stat-info">
                    <h3>Joueurs</h3>
                    <p class="stat-number">1,234</p>
                </div>
            </div>
            
            <div class="stat-card games">
                <div class="stat-icon">🎮</div>
                <div class="stat-info">
                    <h3>Parties</h3>
                    <p class="stat-number">567</p>
                </div>
            </div>
            
            <div class="stat-card coins">
                <div class="stat-icon">🪙</div>
                <div class="stat-info">
                    <h3>Coins</h3>
                    <p class="stat-number">89,012</p>
                </div>
            </div>
        </div>
        
        <div class="actions">
            <button class="action-btn primary">🚀 Lancer Partie</button>
            <button class="action-btn secondary">⚙️ Paramètres</button>
        </div>
    </div>
    ]]
    
    local css = [[
    .dashboard {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        width: 100%;
        height: 100%;
        padding: 25px;
        border-radius: 15px;
        color: white;
    }
    
    .header {
        text-align: center;
        margin-bottom: 30px;
    }
    
    .header h1 {
        font-size: 28px;
        margin-bottom: 5px;
    }
    
    .header p {
        font-size: 16px;
        opacity: 0.8;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background-color: rgba(255, 255, 255, 0.1);
        padding: 20px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        backdrop-filter: blur(10px);
    }
    
    .stat-icon {
        font-size: 24px;
        margin-right: 15px;
    }
    
    .stat-info h3 {
        font-size: 16px;
        margin: 0 0 5px 0;
        opacity: 0.9;
    }
    
    .stat-number {
        font-size: 24px;
        font-weight: bold;
        margin: 0;
    }
    
    .actions {
        display: flex;
        justify-content: center;
        gap: 20px;
    }
    
    .action-btn {
        padding: 15px 30px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .action-btn.primary {
        background-color: #27ae60;
        color: white;
    }
    
    .action-btn.secondary {
        background-color: rgba(255, 255, 255, 0.2);
        color: white;
        backdrop-filter: blur(10px);
    }
    ]]
    
    local success, error = pcall(function()
        htmlEngine:render(html, css)
    end)
    
    if success then
        print("✅ Test 2 réussi - Dashboard affiché")
    else
        warn("❌ Test 2 échoué:", error)
    end
end

-- Test 3 : Interface de jeu complexe
local function testGameUI()
    print("🎮 Test 3: Interface de jeu complexe")
    
    local htmlEngine = HtmlOnLua.new()
    
    local html = [[
    <div class="game-interface">
        <div class="top-bar">
            <div class="player-info">
                <div class="avatar">👤</div>
                <div class="player-details">
                    <h3>Joueur123</h3>
                    <p>Niveau 42</p>
                </div>
            </div>
            
            <div class="resources">
                <div class="resource health">
                    <span class="icon">❤️</span>
                    <span class="value">100/100</span>
                </div>
                <div class="resource mana">
                    <span class="icon">💙</span>
                    <span class="value">75/100</span>
                </div>
                <div class="resource gold">
                    <span class="icon">🪙</span>
                    <span class="value">1,250</span>
                </div>
            </div>
        </div>
        
        <div class="main-content">
            <div class="inventory-panel">
                <h3>🎒 Inventaire</h3>
                <div class="item-slot">⚔️</div>
                <div class="item-slot">🛡️</div>
                <div class="item-slot">🧪</div>
                <div class="item-slot empty">+</div>
            </div>
            
            <div class="action-panel">
                <button class="skill-btn fire">🔥 Boule de Feu</button>
                <button class="skill-btn ice">❄️ Rayon Glacé</button>
                <button class="skill-btn heal">✨ Soin</button>
                <button class="skill-btn ultimate">⚡ Attaque Ultime</button>
            </div>
        </div>
    </div>
    ]]
    
    local css = [[
    .game-interface {
        background: linear-gradient(180deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        width: 100%;
        height: 100%;
        padding: 20px;
        border-radius: 10px;
        color: white;
        border: 2px solid #4a5568;
    }
    
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 15px;
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 8px;
    }
    
    .player-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .avatar {
        width: 50px;
        height: 50px;
        background-color: #4a5568;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    
    .player-details h3 {
        margin: 0;
        font-size: 18px;
    }
    
    .player-details p {
        margin: 5px 0 0 0;
        opacity: 0.7;
    }
    
    .resources {
        display: flex;
        gap: 20px;
    }
    
    .resource {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 12px;
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 6px;
    }
    
    .resource .icon {
        font-size: 18px;
    }
    
    .resource .value {
        font-weight: bold;
    }
    
    .main-content {
        display: flex;
        gap: 30px;
    }
    
    .inventory-panel {
        background-color: rgba(255, 255, 255, 0.1);
        padding: 20px;
        border-radius: 10px;
        min-width: 200px;
    }
    
    .inventory-panel h3 {
        margin-top: 0;
        text-align: center;
    }
    
    .item-slot {
        width: 60px;
        height: 60px;
        background-color: rgba(255, 255, 255, 0.1);
        border: 2px solid #4a5568;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        margin-bottom: 10px;
    }
    
    .item-slot.empty {
        opacity: 0.5;
        border-style: dashed;
    }
    
    .action-panel {
        flex: 1;
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }
    
    .skill-btn {
        padding: 20px;
        border-radius: 10px;
        border: none;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .skill-btn.fire {
        background: linear-gradient(45deg, #ff6b6b, #ee5a24);
        color: white;
    }
    
    .skill-btn.ice {
        background: linear-gradient(45deg, #74b9ff, #0984e3);
        color: white;
    }
    
    .skill-btn.heal {
        background: linear-gradient(45deg, #55efc4, #00b894);
        color: white;
    }
    
    .skill-btn.ultimate {
        background: linear-gradient(45deg, #fd79a8, #e84393);
        color: white;
        grid-column: span 2;
    }
    ]]
    
    local success, error = pcall(function()
        htmlEngine:render(html, css)
    end)
    
    if success then
        print("✅ Test 3 réussi - Interface de jeu affichée")
    else
        warn("❌ Test 3 échoué:", error)
    end
end

-- Fonction principale de test
local function runAllTests()
    print("🧪 === TESTS DU SYSTÈME HTMLONLUA ===")
    print("Version: 1.0")
    print("Environnement: Roblox Studio/Exploits")
    print("=" .. string.rep("=", 50))
    print("")
    
    -- Test 1
    testBasicInterface()
    delay(DELAY_BETWEEN_TESTS)
    
    -- Test 2
    testDashboard()
    delay(DELAY_BETWEEN_TESTS)
    
    -- Test 3
    testGameUI()
    
    print("")
    print("=" .. string.rep("=", 50))
    print("🎉 TOUS LES TESTS TERMINÉS!")
    print("Vérifiez l'écran pour voir les interfaces générées.")
    print("=" .. string.rep("=", 50))
end

-- Exécution automatique
runAllTests()

-- Pour usage manuel :
-- runAllTests()
-- ou individuellement :
-- testBasicInterface()
-- testDashboard()
-- testGameUI()
