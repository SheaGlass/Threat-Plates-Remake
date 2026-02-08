----------------------------------------------------------------------
-- ThreatPlates Remake - Media
-- Register textures, fonts, and borders with LibSharedMedia
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...

local Media = LibStub("LibSharedMedia-3.0")

-- Addon art path shortcut
TPR.Art = "Interface\\AddOns\\ThreatPlatesRemake\\Artwork\\"

---------------------------------------------------------------------------------------------------
-- Status Bar Textures
---------------------------------------------------------------------------------------------------
Media:Register("statusbar", "ThreatPlatesBar", [[Interface\AddOns\ThreatPlatesRemake\Artwork\TP_BarTexture.tga]])
Media:Register("statusbar", "ThreatPlatesEmpty", [[Interface\AddOns\ThreatPlatesRemake\Artwork\Empty.tga]])
Media:Register("statusbar", "Aluminium", [[Interface\AddOns\ThreatPlatesRemake\Artwork\Aluminium.tga]])
Media:Register("statusbar", "Smooth", [[Interface\AddOns\ThreatPlatesRemake\Artwork\Smooth.tga]])
Media:Register("statusbar", "TP Flat", [[Interface\AddOns\ThreatPlatesRemake\Artwork\TP_Flat.tga]])
Media:Register("statusbar", "TP Gradient", [[Interface\AddOns\ThreatPlatesRemake\Artwork\TP_Gradient.tga]])
Media:Register("statusbar", "TP Gloss", [[Interface\AddOns\ThreatPlatesRemake\Artwork\TP_Gloss.tga]])
Media:Register("statusbar", "TP Striped", [[Interface\AddOns\ThreatPlatesRemake\Artwork\TP_Striped.tga]])

---------------------------------------------------------------------------------------------------
-- Fonts
---------------------------------------------------------------------------------------------------
-- Bundled fonts
Media:Register("font", "Accidental Presidency", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Accidental Presidency.ttf]])
Media:Register("font", "Cabin", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Cabin.ttf]])
Media:Register("font", "Forced Square", [[Interface\AddOns\ThreatPlatesRemake\Fonts\FORCED SQUARE.ttf]])
Media:Register("font", "Nueva Std Cond", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Nueva Std Cond.ttf]])
Media:Register("font", "Oswald", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Oswald-Regular.ttf]])
Media:Register("font", "Carlito", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Carlito-Regular.ttf]])
Media:Register("font", "PT Sans Narrow Bold", [[Interface\AddOns\ThreatPlatesRemake\Fonts\PTSansNarrow-Bold.ttf]])
Media:Register("font", "Fira Sans Condensed", [[Interface\AddOns\ThreatPlatesRemake\Fonts\FiraSansCondensed-Medium.ttf]])

Media:Register("font", "The Bold Font", [[Interface\AddOns\ThreatPlatesRemake\Fonts\THEBOLDFONT-FREEVERSION.ttf]])
Media:Register("font", "Tropical Handmade", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Tropical Handmade.ttf]])
Media:Register("font", "Pinky Burst", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Pinky Burst.ttf]])
Media:Register("font", "Hoshiko Satsuki", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Hoshiko Satsuki.ttf]])
Media:Register("font", "Tenada", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Tenada.ttf]])
Media:Register("font", "Storm Gust", [[Interface\AddOns\ThreatPlatesRemake\Fonts\Storm Gust.ttf]])
Media:Register("font", "Caviar Dreams Bold", [[Interface\AddOns\ThreatPlatesRemake\Fonts\CaviarDreams_Bold.ttf]])

-- Built-in WoW fonts
Media:Register("font", "Fritz Quadrata", [[Fonts\FRIZQT__.TTF]])
Media:Register("font", "Arial Narrow", [[Fonts\ARIALN.TTF]])
Media:Register("font", "Morpheus", [[Fonts\MORPHEUS.TTF]])
Media:Register("font", "Skurri", [[Fonts\SKURRI.TTF]])

---------------------------------------------------------------------------------------------------
-- Borders
---------------------------------------------------------------------------------------------------
Media:Register("border", "ThreatPlatesBorder", [[Interface\AddOns\ThreatPlatesRemake\Artwork\TP_WhiteSquare.tga]])

---------------------------------------------------------------------------------------------------
-- Shared Resolve Helpers (used by all modules via TPR.ResolveFont / TPR.ResolveTexture)
---------------------------------------------------------------------------------------------------
function TPR.ResolveFont(key)
    if not key or key == "" then return [[Fonts\FRIZQT__.TTF]] end
    local path = Media:Fetch("font", key, true)
    if path then return path end
    if key:find("\\") or key:find("/") then return key end
    return [[Fonts\FRIZQT__.TTF]]
end

function TPR.ResolveTexture(key)
    if not key or key == "" then return [[Interface\TargetingFrame\UI-StatusBar]] end
    local path = Media:Fetch("statusbar", key, true)
    if path then return path end
    if key:find("\\") or key:find("/") then return key end
    return [[Interface\TargetingFrame\UI-StatusBar]]
end
