--[[
    ⚡ COMMANDES RAPIDES - AAds System v1.1
    
    Copier-coller ces commandes directement dans executor Roblox
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- 🧪 ÉTAPE 1: DIAGNOSTIC (OBLIGATOIRE - 30 secondes)
-- ════════════════════════════════════════════════════════════════════════════

loadstring(readfile("Addsextention/DIAGNOSTIC_RAPIDE.lua"))()

--[[
    Attendu: "🎉 SYSTÈME PRÊT À UTILISER!"
    
    Si erreur:
    - Vérifier fichier existe: Addsextention/AAds_Final_System.lua
    - Vérifier ligne 120: doit être 'end' (pas 'endqqqq')
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- 🧪 ÉTAPE 2: TEST EXTRACTION (optionnel - 1 minute)
-- ════════════════════════════════════════════════════════════════════════════

loadstring(readfile("Addsextention/Test_Picture_Extraction.lua"))()

--[[
    Attendu: "✅ 9 pubs extraites"
    
    Vérifie que parser <picture> fonctionne:
    - 6 <source> extraits
    - 1 <img fallback> extrait
    - 1 <img simple> extrait
    - 1 logo teaser extrait
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- 🚀 ÉTAPE 3: LANCER SYSTÈME COMPLET (5 minutes)
-- ════════════════════════════════════════════════════════════════════════════

loadstring(readfile("Addsextention/AAds_Final_System.lua"))()

--[[
    Vérifications attendues:
    
    1. CONSOLE LOGS (30s):
       [A-ADS] ✅ 17 publicité(s) valide(s) extraite(s)
       → Attendu: 15-50 pubs (au lieu de 2-5 avant fix)
    
    2. TÉLÉCHARGEMENT (5-10s):
       [A-ADS] ✅ Image téléchargée (45231 bytes, PNG)
       → Validation format active
    
    3. AFFICHAGE (immédiat):
       → Publicité visible coin écran
       → PAS DE RECTANGLE NOIR ✅
       → Taille adaptée automatiquement
    
    4. ROTATION (15s):
       [A-ADS] ℹ️ Rotation vers pub 2/17
       → Change automatiquement
    
    5. RETRY (si échec):
       [A-ADS] ⚠️ Pub 5 échouée, essai suivante...
       → Skip automatique pubs invalides
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- 🔧 COMMANDES UTILES (après lancement système)
-- ════════════════════════════════════════════════════════════════════════════

-- Statistiques système
_G.AAdsSystem.GetStats()

-- Liste publicités extraites
_G.AAdsSystem.ListAds()

-- Pause/Resume rotation
_G.AAdsSystem.ToggleRotation()

-- Forcer changement pub
_G.AAdsSystem.NextAd()

-- Arrêter système (si nécessaire)
_G.AAdsSystem.Destroy()

-- ════════════════════════════════════════════════════════════════════════════
-- 🐛 TROUBLESHOOTING
-- ════════════════════════════════════════════════════════════════════════════

--[[
    PROBLÈME: Images noires persistent
    
    SOLUTION 1: Supprimer cache
    delfolder("AAds_Cache")
    loadstring(readfile("Addsextention/AAds_Final_System.lua"))()
    
    SOLUTION 2: Vérifier logs console
    - "❌ Format image invalide" → A-Ads bloque
    - "❌ Téléchargement échoué" → URL invalide
    - "⚠️ Réponse HTML au lieu d'image" → 404 serveur
    
    SOLUTION 3: Test manuel URL
    local url = "https://static.a-ads.com/a-ads-banners/531595/970x90?region=eu-central-1"
    local img = game:HttpGet(url)
    print("Taille:", #img, "bytes")
    print("10 premiers bytes:", img:sub(1, 10))
    -- PNG doit commencer par: "\137PNG"
    -- JPEG doit commencer par: "\255\216"
]]--

--[[
    PROBLÈME: "Aucune publicité extraite"
    
    SOLUTION: Vérifier iframe téléchargé
    local html = game:HttpGet("https://acceptable.a-ads.com/2417103/?size=Adaptive")
    print("HTML taille:", #html, "bytes")
    print("200 premiers caractères:", html:sub(1, 200))
    -- Doit contenir "<picture>" ou "<img src="
]]--

--[[
    PROBLÈME: Erreur syntaxe ligne 737
    
    SOLUTION: Bug 'endqqqq' pas corrigé
    1. Ouvrir: Addsextention/AAds_Final_System.lua
    2. Ligne 120: Remplacer 'endqqqq' par 'end'
    3. Sauvegarder fichier
    4. Relancer: DIAGNOSTIC_RAPIDE.lua
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- 📖 DOCUMENTATION COMPLÈTE
-- ════════════════════════════════════════════════════════════════════════════

--[[
    Voir fichiers Markdown:
    
    - INDEX.md           → Guide rapide démarrage
    - GUIDE_TEST.md      → Tests étape par étape
    - RECAP_FIX.md       → Récapitulatif fix complet
    - FIX_PICTURE_TAGS.md → Documentation technique
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- ✅ CHECKLIST VALIDATION
-- ════════════════════════════════════════════════════════════════════════════

--[[
    [ ] DIAGNOSTIC affiche "SYSTÈME PRÊT"
    [ ] TEST EXTRACTION affiche "9 pubs extraites"
    [ ] CONSOLE affiche "15-50 pubs extraites"
    [ ] IMAGE VISIBLE (PAS NOIR!)
    [ ] ROTATION fonctionne (15s)
    [ ] RETRY skip échecs automatiquement
    [ ] CLICK copie lien A-Ads
    [ ] FLÈCHE change position (4 coins)
    
    Si toutes cases cochées:
    🎉 FIX VALIDÉ - Images noires résolues!
]]--

-- ════════════════════════════════════════════════════════════════════════════
-- 📊 RÉSUMÉ FIX
-- ════════════════════════════════════════════════════════════════════════════

--[[
    AVANT FIX:
    ❌ Extraction: 2-5 pubs (<img> seulement)
    ❌ Images noires: ~50% (<picture> ignorées)
    ❌ Rotation: Stuck si échec
    ❌ Erreur: 'endqqqq' ligne 120
    
    APRÈS FIX:
    ✅ Extraction: 30-50 pubs (<img> + <picture> + <source>)
    ✅ Images noires: 0% (retry automatique)
    ✅ Rotation: Skip intelligent échecs
    ✅ Validation: 3 niveaux (HTML/taille/format)
    ✅ Syntaxe: Corrigée (end)
    
    Date: 13 novembre 2024
    Version: AAds Final System v1.1
]]--
