--[[
    TEST EXTRACTION BALISES <picture> A-ADS
    
    Ce script teste l'extraction des publicités depuis HTML A-Ads
    avec support complet des balises <picture> responsive
]]--

-- HTML exemple fourni par user (problème images noires)
local testHTML = [[
<picture class="main">
  <source srcset="//static.a-ads.com/a-ads-banners/531595/970x90?region=eu-central-1" media="(min-aspect-ratio: 9.43333333)">
  <source srcset="//static.a-ads.com/a-ads-banners/531598/728x90?region=eu-central-1" media="(min-aspect-ratio: 7.94444444) and (max-width: 1456px)">
  <source srcset="//static.a-ads.com/a-ads-banners/531590/468x60?region=eu-central-1" media="(min-aspect-ratio: 7.1) and (max-width: 936px)">
  <source srcset="//static.a-ads.com/a-ads-banners/531596/320x50?region=eu-central-1" media="(min-aspect-ratio: 5.7) and (max-width: 624px)">
  <source srcset="//static.a-ads.com/a-ads-banners/531594/300x100?region=eu-central-1" media="(min-aspect-ratio: 2.56) and (max-width: 512px)">
  <source srcset="//static.a-ads.com/a-ads-banners/531592/300x250?region=eu-central-1" media="(max-width: 512px)">
  <img class="image-item" src="//static.a-ads.com/a-ads-banners/531599/970x250?region=eu-central-1">
</picture>

<img class="teaser-advert-logo" src="//static.a-ads.com/a-ads-advert-logos/203/128x128?region=eu-central-1" hidden="" style="display:none">

<img src="//static.a-ads.com/a-ads-banners/999999/468x60?region=eu-central-1">
]]

-- Fonction ParseAds améliorée (copie depuis AAds_Final_System.lua)
local function ParseAds(html)
    local ads = {}
    local processedUrls = {} -- Éviter doublons
    
    print("\n🔍 === EXTRACTION PUBLICITÉS A-ADS ===\n")
    
    -- Pattern 1: <picture> avec <source> (RESPONSIVE - PRIORITÉ)
    print("📋 Étape 1: Recherche balises <picture>...")
    local pictureCount = 0
    
    for pictureBlock in html:gmatch('<picture[^>]*>(.-)</picture>') do
        pictureCount = pictureCount + 1
        print("  📦 <picture> trouvé #" .. pictureCount)
        
        -- Extraire tous <source srcset="">
        local sourceCount = 0
        for srcset in pictureBlock:gmatch('srcset=["\']([^"\']+)["\']') do
            sourceCount = sourceCount + 1
            local url = srcset:gsub("^//", "https://")
            
            -- Extraire dimensions depuis URL (ex: /970x90?)
            local width, height = url:match('/(%d+)x(%d+)%?')
            
            if width and height and not processedUrls[url] then
                processedUrls[url] = true
                
                local ad = {
                    URL = url,
                    Width = tonumber(width),
                    Height = tonumber(height),
                    Source = "picture-source",
                }
                
                table.insert(ads, ad)
                print(string.format("    ✅ <source> %dx%d → %s", ad.Width, ad.Height, ad.URL))
            end
        end
        
        -- Extraire <img> fallback dans <picture>
        for src in pictureBlock:gmatch('<img[^>]+src=["\']([^"\']+)["\']') do
            local url = src:gsub("^//", "https://")
            local width, height = url:match('/(%d+)x(%d+)%?')
            
            if width and height and not processedUrls[url] then
                processedUrls[url] = true
                
                local ad = {
                    URL = url,
                    Width = tonumber(width),
                    Height = tonumber(height),
                    Source = "picture-img-fallback",
                }
                
                table.insert(ads, ad)
                print(string.format("    ✅ <img fallback> %dx%d → %s", ad.Width, ad.Height, ad.URL))
            end
        end
        
        print(string.format("  ✅ %d élément(s) extrait(s) de <picture> #%d", sourceCount + 1, pictureCount))
    end
    
    -- Pattern 2: <img> simples (HORS <picture>)
    print("\n📋 Étape 2: Recherche <img> simples...")
    local imgCount = 0
    
    for src in html:gmatch('<img[^>]+src=["\']([^"\']+)["\']') do
        -- Ignorer logos teaser cachés
        if not src:match('teaser%-advert%-logo') then
            local url = src:gsub("^//", "https://")
            local width, height = url:match('/(%d+)x(%d+)%?')
            
            if width and height and not processedUrls[url] then
                processedUrls[url] = true
                imgCount = imgCount + 1
                
                local ad = {
                    URL = url,
                    Width = tonumber(width),
                    Height = tonumber(height),
                    Source = "img-simple",
                }
                
                table.insert(ads, ad)
                print(string.format("  ✅ <img> %dx%d → %s", ad.Width, ad.Height, ad.URL))
            end
        end
    end
    
    print(string.format("  ✅ %d <img> simple(s) extrait(s)", imgCount))
    
    -- Pattern 3: Logos teaser (FALLBACK)
    print("\n📋 Étape 3: Recherche logos teaser...")
    local logoCount = 0
    
    for src in html:gmatch('<img[^>]+class="teaser%-advert%-logo"[^>]+src=["\']([^"\']+)["\']') do
        local url = src:gsub("^//", "https://")
        
        if not processedUrls[url] then
            processedUrls[url] = true
            logoCount = logoCount + 1
            
            local ad = {
                URL = url,
                Width = 128,
                Height = 128,
                Source = "teaser-logo",
            }
            
            table.insert(ads, ad)
            print(string.format("  ✅ Logo 128x128 → %s", ad.URL))
        end
    end
    
    print(string.format("  ✅ %d logo(s) teaser extrait(s)", logoCount))
    
    -- Résumé
    print("\n" .. string.rep("=", 60))
    print(string.format("📊 TOTAL: %d publicité(s) unique(s) extraite(s)", #ads))
    print(string.rep("=", 60))
    
    if #ads == 0 then
        print("⚠️ AVERTISSEMENT: Aucune publicité trouvée!")
        print("Vérifiez le HTML fourni.")
    end
    
    return ads
end

-- Exécution test
print("\n🚀 TEST EXTRACTION BALISES <picture>")
print(string.rep("=", 60))

local extractedAds = ParseAds(testHTML)

-- Affichage détaillé résultats
print("\n📋 LISTE COMPLÈTE DES PUBLICITÉS:\n")

for i, ad in ipairs(extractedAds) do
    print(string.format("%d. [%s] %dx%d", i, ad.Source, ad.Width, ad.Height))
    print("   URL: " .. ad.URL)
    print("")
end

-- Statistiques par source
print("\n📊 STATISTIQUES PAR SOURCE:\n")

local stats = {
    ["picture-source"] = 0,
    ["picture-img-fallback"] = 0,
    ["img-simple"] = 0,
    ["teaser-logo"] = 0,
}

for _, ad in ipairs(extractedAds) do
    stats[ad.Source] = stats[ad.Source] + 1
end

print(string.format("  <picture> <source>: %d", stats["picture-source"]))
print(string.format("  <picture> <img fallback>: %d", stats["picture-img-fallback"]))
print(string.format("  <img> simple: %d", stats["img-simple"]))
print(string.format("  Logo teaser: %d", stats["teaser-logo"]))

-- Validation résultat attendu
print("\n✅ VALIDATION:\n")

local expectedCount = 9 -- 6 <source> + 1 <img picture> + 1 <img simple> + 1 logo
if #extractedAds >= expectedCount then
    print("✅ SUCCESS: " .. #extractedAds .. " pubs extraites (attendu: " .. expectedCount .. ")")
    print("✅ Parser <picture> fonctionne correctement!")
else
    print("❌ ÉCHEC: Seulement " .. #extractedAds .. " pubs extraites (attendu: " .. expectedCount .. ")")
    print("❌ Parser <picture> incomplet!")
end

print("\n" .. string.rep("=", 60))
print("🏁 FIN TEST")
print(string.rep("=", 60))
