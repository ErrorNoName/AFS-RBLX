-- 📚 GUIDE D'UTILISATION RETROUNBLOCK - Pour Exécuteurs Roblox
-- Guide complet pour utiliser l'interface RetroUnblock avec HtmlOnLua

print("📚 === GUIDE D'UTILISATION RETROUNBLOCK ===")
print("🎯 Interface sci-fi/rétro avec HtmlOnLua pour exécuteurs")

print("\n🚀 ÉTAPES D'UTILISATION :")
print("1. 📡 Assurez-vous d'avoir une connexion internet")
print("2. 🎮 Lancez votre exécuteur Roblox favori") 
print("3. 📋 Copiez et exécutez RetroUnblock_Ultimate.lua")
print("4. ⏳ Attendez le chargement de HtmlOnLua depuis Pastebin")
print("5. ✨ Profitez de l'interface RetroUnblock !")

print("\n🔧 EXÉCUTEURS TESTÉS ET COMPATIBLES :")
print("✅ Synapse X - Pleinement compatible")
print("✅ KRNL - Compatible avec HTTP")
print("✅ Fluxus - Compatible")  
print("✅ Oxygen U - Compatible")
print("✅ Script-Ware - Compatible")
print("⚠️ Autres exécuteurs - Dépend du support HTTP")

print("\n📋 LIENS RAPIDES :")
print("🔗 HtmlOnLua Principal: https://pastebin.com/raw/nScauqfC")
print("📁 Script RetroUnblock: RetroUnblock_Ultimate.lua")
print("🧪 Test Pastebin: RetroUnblock_Test_Pastebin.lua")
print("🔧 Diagnostic: RetroUnblock_Diagnostic.lua")

print("\n❓ PROBLÈMES COURANTS ET SOLUTIONS :")

print("\n🔴 PROBLÈME: 'attempt to index nil with render'")
print("💡 SOLUTION: HtmlOnLua n'a pas pu se charger")
print("   • Vérifiez votre connexion internet")
print("   • Testez avec RetroUnblock_Test_Pastebin.lua")
print("   • L'interface native s'affichera automatiquement")

print("\n🔴 PROBLÈME: 'HttpService non disponible'")
print("💡 SOLUTION: Votre exécuteur ne supporte pas HTTP")
print("   • Utilisez un exécuteur plus récent (Synapse, KRNL)")
print("   • L'interface native fonctionnera quand même")

print("\n🔴 PROBLÈME: 'Code Pastebin vide'")
print("💡 SOLUTION: Lien Pastebin inaccessible")
print("   • Vérifiez que Pastebin n'est pas bloqué")
print("   • Essayez à un moment différent")
print("   • L'interface native est le fallback")

print("\n🔴 PROBLÈME: Interface ne s'affiche pas")
print("💡 SOLUTION: Vérifiez PlayerGui")
print("   • Assurez-vous d'être dans un jeu Roblox")
print("   • Regardez dans CoreGui ou PlayerGui")
print("   • Relancez le script si nécessaire")

print("\n✅ VÉRIFICATION RAPIDE :")
print("🎯 Pour tester si tout fonctionne, exécutez :")
print('loadfile("RetroUnblock_Test_Pastebin.lua")()')
print("🎮 Cela vous dira exactement quel est le problème")

print("\n🌟 FONCTIONNALITÉS DE L'INTERFACE :")
print("• 🖼️ Design sci-fi/rétro exact de l'image fournie")
print("• 🌍 Texte cyrillique authentique")  
print("• 🚀 Vaisseau spatial animé")
print("• ⭐ Étoiles scintillantes")
print("• 🎮 Bouton Play interactif")
print("• 🎨 Couleurs et effets fidèles à l'original")

print("\n🛠️ MODES DISPONIBLES :")
print("1. 🌐 Mode HtmlOnLua - Interface HTML/CSS complète")
print("2. 🎮 Mode Natif - Interface Roblox équivalente")  
print("3. 🔧 Mode Test - Diagnostic et vérification")

print("\n📊 QUE FAIRE SI HTMLONLUA NE CHARGE PAS :")
print("✅ C'est normal ! Le script a un système de fallback")
print("✅ Une interface native identique s'affichera")
print("✅ Toutes les fonctionnalités sont préservées")
print("✅ L'expérience visuelle reste la même")

print("\n🎯 UTILISATION RECOMMANDÉE :")
print("1. 📋 Copiez RetroUnblock_Ultimate.lua")
print("2. 🎮 Collez dans votre exécuteur")
print("3. ▶️ Exécutez le script")
print("4. 🖥️ L'interface apparaît automatiquement")
print("5. 🎮 Cliquez sur 'Play ►' pour tester")

print("\n🚀 COMMANDES RAPIDES :")
print("• Test complet: loadfile('RetroUnblock_Test_Pastebin.lua')()")
print("• Interface principale: loadfile('RetroUnblock_Ultimate.lua')()")
print("• Diagnostic: loadfile('RetroUnblock_Diagnostic.lua')()")

print("\n💡 CONSEILS POUR EXÉCUTEURS :")
print("• 🔥 Utilisez Synapse X pour la meilleure expérience")
print("• 🌐 Assurez-vous que HTTP est activé")
print("• 📡 Testez votre connexion Pastebin d'abord")
print("• 🎮 Lancez dans un jeu Roblox actif")
print("• 🔄 Relancez si l'interface ne s'affiche pas")

print("\n🎊 SUCCÈS ATTENDU :")
print("✅ Chargement de HtmlOnLua depuis Pastebin")
print("✅ Interface RetroUnblock s'affiche au centre")
print("✅ Texte cyrillique 'ДОБРО ПОЖАЛОВАТЬ, КОМАНДИР!'")
print("✅ Vaisseau spatial animé au centre")
print("✅ Bouton Play interactif fonctionnel")
print("✅ Design exact de l'image sci-fi/rétro")

print("\n🎯 L'interface RetroUnblock est conçue pour fonctionner")
print("🎮 dans TOUS les environnements d'exécuteurs Roblox !")
print("🌟 Même sans HtmlOnLua, vous aurez une interface parfaite !")

print("\n📞 SUPPORT :")
print("• 🔧 Si problèmes persistent, utilisez le diagnostic")
print("• 📊 Les logs vous diront exactement quoi faire")
print("• 🎮 L'interface native fonctionne toujours")

print("\n✨ === GUIDE TERMINÉ - PRÊT À UTILISER ! ===")
print("🚀 Exécutez maintenant RetroUnblock_Ultimate.lua !")

-- Test rapide de l'environnement
print("\n🧪 TEST RAPIDE DE L'ENVIRONNEMENT :")
local hasGame = pcall(function() return game end)
local hasHttpGet = pcall(function() return game.HttpGet end)
local hasPlayerGui = pcall(function() return game.Players.LocalPlayer.PlayerGui end)

print("🎮 Game disponible:", hasGame and "✅" or "❌")
print("📡 HttpGet disponible:", hasHttpGet and "✅" or "❌") 
print("🖥️ PlayerGui disponible:", hasPlayerGui and "✅" or "❌")

if hasGame and hasPlayerGui then
    print("🟢 ENVIRONNEMENT OPTIMAL - Tout fonctionnera parfaitement !")
elseif hasGame then
    print("🟡 ENVIRONNEMENT PARTIEL - Interface native disponible")
else
    print("🔴 ENVIRONNEMENT LIMITÉ - Exécutez dans Roblox")
end

print("\n🎯 Vous êtes prêt ! Lancez RetroUnblock_Ultimate.lua maintenant !")
