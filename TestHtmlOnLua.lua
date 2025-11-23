-- Test du système HtmlOnLua
-- Ce script doit être exécuté dans Roblox pour afficher une fenêtre

local HtmlOnLua = loadstring(game:HttpGet("https://raw.githubusercontent.com/monsieur-jonha/my-exploits/main/HtmlOnLua.lua"))()
-- ou si local : local HtmlOnLua = require(path_to_HtmlOnLua)

-- Test 1 : Interface simple
local function testSimpleInterface()
    local htmlEngine = HtmlOnLua.new()
    
    local html = [[
    <div class="container">
        <h1 id="title">🎮 Interface de Test</h1>
        <p class="description">Ceci est un test d'affichage HTML/CSS dans Roblox!</p>
        <button class="btn-primary">Bouton Principal</button>
        <button class="btn-secondary">Bouton Secondaire</button>
        <div class="info-box">
            <h3>Informations</h3>
            <p>Cette interface est générée dynamiquement à partir de HTML/CSS.</p>
        </div>
    </div>
    ]]
    
    local css = [[
    .container {
        background-color: #2c3e50;
        width: 800px;
        height: 600px;
        border-radius: 10px;
    }
    
    #title {
        color: #ecf0f1;
        font-size: 28px;
        text-align: center;
    }
    
    .description {
        color: #bdc3c7;
        font-size: 16px;
        text-align: center;
    }
    
    .btn-primary {
        background-color: #3498db;
        color: white;
        width: 200px;
        height: 50px;
        border-radius: 5px;
        font-size: 16px;
    }
    
    .btn-secondary {
        background-color: #95a5a6;
        color: white;
        width: 200px;
        height: 50px;
        border-radius: 5px;
        font-size: 16px;
    }
    
    .info-box {
        background-color: #34495e;
        border-radius: 8px;
        width: 90%;
        height: 120px;
        margin: 20px;
    }
    
    h3 {
        color: #e74c3c;
        font-size: 20px;
    }
    ]]
    
    print("🚀 Affichage de l'interface HTML/CSS...")
    htmlEngine:render(html, css)
    print("✅ Interface affichée avec succès!")
end

-- Test 2 : Interface de jeu
local function testGameInterface()
    local htmlEngine = HtmlOnLua.new()
    
    local html = [[
    <div class="game-ui">
        <div class="header">
            <h1>🎯 Interface de Jeu</h1>
            <div class="stats">
                <span class="hp">❤️ HP: 100</span>
                <span class="mp">💙 MP: 50</span>
                <span class="coins">🪙 Coins: 1,250</span>
            </div>
        </div>
        
        <div class="main-content">
            <div class="inventory">
                <h3>📦 Inventaire</h3>
                <div class="item">⚔️ Épée</div>
                <div class="item">🛡️ Bouclier</div>
                <div class="item">🧪 Potion</div>
            </div>
            
            <div class="actions">
                <button class="action-btn">⚔️ Attaquer</button>
                <button class="action-btn">🛡️ Défendre</button>
                <button class="action-btn">🏃 Fuir</button>
                <button class="action-btn">🧪 Utiliser Item</button>
            </div>
        </div>
    </div>
    ]]
    
    local css = [[
    .game-ui {
        background-color: #1a1a1a;
        width: 900px;
        height: 700px;
        border: 3px solid #444;
        border-radius: 15px;
    }
    
    .header {
        background-color: #333;
        height: 80px;
        border-radius: 15px 15px 0 0;
    }
    
    h1 {
        color: #fff;
        text-align: center;
        font-size: 24px;
    }
    
    .stats {
        color: #fff;
        font-size: 14px;
    }
    
    .hp { color: #e74c3c; }
    .mp { color: #3498db; }
    .coins { color: #f1c40f; }
    
    .main-content {
        display: flex;
        height: 620px;
    }
    
    .inventory {
        background-color: #2c3e50;
        width: 250px;
        border-radius: 10px;
        margin: 10px;
    }
    
    .inventory h3 {
        color: #ecf0f1;
        font-size: 18px;
        text-align: center;
    }
    
    .item {
        background-color: #34495e;
        color: #bdc3c7;
        height: 40px;
        margin: 5px;
        border-radius: 5px;
        text-align: center;
        font-size: 16px;
    }
    
    .actions {
        flex: 1;
        margin: 10px;
    }
    
    .action-btn {
        background-color: #e67e22;
        color: white;
        width: 200px;
        height: 60px;
        margin: 10px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
    }
    
    .action-btn:hover {
        background-color: #d35400;
    }
    ]]
    
    print("🎮 Affichage de l'interface de jeu...")
    htmlEngine:render(html, css)
    print("✅ Interface de jeu affichée!")
end

-- Test 3 : Interface moderne avec animations
local function testModernInterface()
    local htmlEngine = HtmlOnLua.new()
    
    local html = [[
    <div class="modern-container">
        <div class="sidebar">
            <h2>Navigation</h2>
            <button class="nav-btn active">🏠 Accueil</button>
            <button class="nav-btn">⚙️ Paramètres</button>
            <button class="nav-btn">📊 Statistiques</button>
            <button class="nav-btn">👤 Profil</button>
        </div>
        
        <div class="content">
            <div class="welcome-card">
                <h1>Bienvenue!</h1>
                <p>Interface moderne créée avec HtmlOnLua</p>
                <div class="feature-grid">
                    <div class="feature">✨ Rendu HTML/CSS</div>
                    <div class="feature">🎨 Styles modernes</div>
                    <div class="feature">🚀 Performance optimisée</div>
                    <div class="feature">🔧 Facilement extensible</div>
                </div>
            </div>
        </div>
    </div>
    ]]
    
    local css = [[
    .modern-container {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        width: 1000px;
        height: 600px;
        border-radius: 20px;
        display: flex;
    }
    
    .sidebar {
        background-color: rgba(255, 255, 255, 0.1);
        width: 250px;
        border-radius: 20px 0 0 20px;
        backdrop-filter: blur(10px);
    }
    
    .sidebar h2 {
        color: white;
        text-align: center;
        font-size: 20px;
        margin: 20px 0;
    }
    
    .nav-btn {
        background-color: rgba(255, 255, 255, 0.2);
        color: white;
        width: 90%;
        height: 50px;
        margin: 10px auto;
        border-radius: 10px;
        font-size: 16px;
        text-align: left;
        border: none;
        transition: all 0.3s ease;
    }
    
    .nav-btn.active {
        background-color: rgba(255, 255, 255, 0.3);
        box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
    }
    
    .content {
        flex: 1;
        padding: 30px;
    }
    
    .welcome-card {
        background-color: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        height: 100%;
    }
    
    .welcome-card h1 {
        color: #333;
        font-size: 32px;
        margin-bottom: 10px;
    }
    
    .welcome-card p {
        color: #666;
        font-size: 16px;
        margin-bottom: 30px;
    }
    
    .feature-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
    
    .feature {
        background: linear-gradient(45deg, #ff6b6b, #ee5a24);
        color: white;
        padding: 20px;
        border-radius: 10px;
        text-align: center;
        font-size: 16px;
        font-weight: bold;
        box-shadow: 0 5px 15px rgba(238, 90, 36, 0.3);
    }
    ]]
    
    print("✨ Affichage de l'interface moderne...")
    htmlEngine:render(html, css)
    print("✅ Interface moderne affichée!")
end

-- Exécution des tests
print("🧪 === TESTS DU SYSTÈME HTMLONLUA ===")
print("")

-- Lancer les tests un par un
testSimpleInterface()
wait(2)

testGameInterface()
wait(2)

testModernInterface()

print("")
print("🎉 Tous les tests terminés!")
print("Vérifiez votre écran Roblox pour voir les interfaces affichées.")
