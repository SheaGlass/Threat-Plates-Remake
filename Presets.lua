----------------------------------------------------------------------
-- ThreatPlates Remake - Presets
-- Built-in style presets that override profile settings
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

----------------------------------------------------------------------
-- Preset Definitions
----------------------------------------------------------------------
TPR.Presets = {
    --------------------------------------------------------------
    -- Classic ThreatPlates: White border, wide bar, traditional look
    --------------------------------------------------------------
    classic = {
        name = "Classic ThreatPlates",
        desc = "Traditional ThreatPlates look: white+black double border, health text with level, yellow target glow.",
        settings = {
            healthbar = {
                width = 130,
                height = 12,
                texture = "ThreatPlatesBar",
                borderSize = 1,
                borderColor = { r = 0, g = 0, b = 0, a = 1 },
                outerBorderSize = 2,
                outerBorderColor = { r = 1, g = 1, b = 1, a = 1 },
                missingHealthColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
                showText = true,
                textFormat = "CURRENT_PERCENT",
                showLevel = true,
                classColor = true,
                reactionColor = true,
                targetScale = 1.3,
                nonTargetAlpha = 0.8,
                fontSize = 9,
            },
            castbar = {
                enabled = true,
                width = 130,
                height = 10,
                yOffset = -2,
                texture = "ThreatPlatesBar",
                normalColor = { r = 1, g = 0.7, b = 0 },
                uninterruptibleColor = { r = 0.7, g = 0.7, b = 0.7 },
                showSpellName = true,
                showTimer = true,
                showIcon = true,
                iconSize = 14,
                fontSize = 8,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 5,
                iconSize = 22,
                iconSpacing = 2,
                yOffset = 14,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = true,
                durationFontSize = 8,
                borderSize = 1,
            },
            threat = {
                enabled = true,
                useGlow = true,
                useColorChange = true,
                glowAlpha = 0.7,
            },
            target = {
                enabled = true,
                scale = 1.3,
                nonTargetAlpha = 0.7,
                borderColor = { r = 1, g = 0.84, b = 0, a = 1 },
            },
        },
    },

    --------------------------------------------------------------
    -- Minimal: Clean, flat, thin bars with no border
    --------------------------------------------------------------
    minimal = {
        name = "Minimal",
        desc = "Clean, compact bars with no border and flat texture. Prioritizes readability.",
        settings = {
            healthbar = {
                width = 100,
                height = 8,
                texture = "TP Flat",
                borderSize = 0,
                borderColor = { r = 0, g = 0, b = 0, a = 0 },
                missingHealthColor = { r = 0.1, g = 0.1, b = 0.1, a = 0.9 },
                showText = false,
                showLevel = false,
                classColor = true,
                reactionColor = true,
                targetScale = 1.2,
                nonTargetAlpha = 0.7,
                fontSize = 8,
            },
            castbar = {
                enabled = true,
                width = 100,
                height = 6,
                yOffset = -1,
                texture = "TP Flat",
                normalColor = { r = 1, g = 0.7, b = 0 },
                uninterruptibleColor = { r = 0.6, g = 0.6, b = 0.6 },
                showSpellName = true,
                showTimer = false,
                showIcon = true,
                iconSize = 10,
                fontSize = 7,
                borderSize = 0,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 4,
                iconSize = 18,
                iconSpacing = 1,
                yOffset = 10,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = false,
                durationFontSize = 7,
                borderSize = 1,
            },
            threat = {
                enabled = true,
                useGlow = false,
                useColorChange = true,
                glowAlpha = 0.5,
            },
            target = {
                enabled = true,
                scale = 1.2,
                nonTargetAlpha = 0.6,
                borderColor = { r = 1, g = 1, b = 1, a = 0.6 },
            },
        },
    },

    --------------------------------------------------------------
    -- Grey Minimal: Cool-toned slate/lavender/grey aesthetic
    --------------------------------------------------------------
    grey_minimal = {
        name = "Grey - Minimal",
        desc = "Sleek, muted look with cool blue-purple and grey tones. Ultra-clean with thin bars and no clutter.",
        settings = {
            healthbar = {
                width = 110,
                height = 8,
                texture = "TP Flat",
                borderSize = 1,
                borderColor = { r = 0.2, g = 0.2, b = 0.25, a = 1 },
                outerBorderSize = 0,
                outerBorderColor = { r = 0, g = 0, b = 0, a = 0 },
                backgroundColor = { r = 0.08, g = 0.08, b = 0.12, a = 0.95 },
                missingHealthColor = { r = 0.08, g = 0.08, b = 0.12, a = 1 },
                showText = false,
                showLevel = false,
                classColor = false,
                reactionColor = false,
                customFriendly = { r = 0.45, g = 0.55, b = 0.7 },   -- Steel blue
                customNeutral  = { r = 0.6, g = 0.55, b = 0.7 },    -- Dusty lavender
                customHostile  = { r = 0.55, g = 0.45, b = 0.65 },   -- Muted purple
                targetScale = 1.2,
                nonTargetAlpha = 0.6,
                fontSize = 8,
                nameText = {
                    font = "Fritz Quadrata",
                    fontSize = 9,
                    fontFlags = "OUTLINE",
                    color = { r = 0.78, g = 0.8, b = 0.85, a = 0.9 },
                    show = true,
                    xOffset = 0,
                    yOffset = 2,
                },
            },
            castbar = {
                enabled = true,
                width = 110,
                height = 6,
                yOffset = -1,
                texture = "TP Flat",
                backgroundColor = { r = 0.06, g = 0.06, b = 0.1, a = 0.9 },
                normalColor = { r = 0.5, g = 0.6, b = 0.75 },          -- Cool blue-grey
                uninterruptibleColor = { r = 0.4, g = 0.35, b = 0.5 }, -- Dark purple-grey
                showSpellName = true,
                showTimer = false,
                showIcon = true,
                iconSize = 10,
                fontSize = 7,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 4,
                iconSize = 18,
                iconSpacing = 1,
                yOffset = 10,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = false,
                durationFontSize = 7,
                borderSize = 1,
                borderColor = { r = 0.2, g = 0.2, b = 0.25, a = 1 },
            },
            threat = {
                enabled = true,
                useGlow = false,
                useColorChange = true,
                glowAlpha = 0.4,
                dps = {
                    safe   = { r = 0.45, g = 0.55, b = 0.65 },  -- Slate blue
                    medium = { r = 0.6, g = 0.55, b = 0.65 },   -- Lavender grey
                    high   = { r = 0.65, g = 0.5, b = 0.6 },    -- Mauve
                    danger = { r = 0.7, g = 0.4, b = 0.5 },     -- Dusty rose
                },
                tank = {
                    safe   = { r = 0.45, g = 0.55, b = 0.65 },
                    medium = { r = 0.6, g = 0.55, b = 0.65 },
                    high   = { r = 0.65, g = 0.5, b = 0.6 },
                    danger = { r = 0.7, g = 0.4, b = 0.5 },
                },
            },
            target = {
                enabled = true,
                scale = 1.2,
                nonTargetAlpha = 0.5,
                borderColor = { r = 0.65, g = 0.7, b = 0.85, a = 0.8 },
            },
        },
    },

    --------------------------------------------------------------
    -- Glossy: Shiny gradient look with thin black border
    --------------------------------------------------------------
    glossy = {
        name = "Glossy",
        desc = "Polished look with a glossy gradient texture and thin black border.",
        settings = {
            healthbar = {
                width = 120,
                height = 12,
                texture = "TP Gloss",
                borderSize = 1,
                borderColor = { r = 0, g = 0, b = 0, a = 1 },
                missingHealthColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
                showText = false,
                showLevel = false,
                classColor = true,
                reactionColor = true,
                targetScale = 1.3,
                nonTargetAlpha = 0.8,
                fontSize = 9,
            },
            castbar = {
                enabled = true,
                width = 120,
                height = 10,
                yOffset = -2,
                texture = "TP Gloss",
                normalColor = { r = 1, g = 0.7, b = 0 },
                uninterruptibleColor = { r = 0.7, g = 0.7, b = 0.7 },
                showSpellName = true,
                showTimer = true,
                showIcon = true,
                iconSize = 14,
                fontSize = 8,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 5,
                iconSize = 22,
                iconSpacing = 2,
                yOffset = 14,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = true,
                durationFontSize = 8,
                borderSize = 1,
            },
            threat = {
                enabled = true,
                useGlow = true,
                useColorChange = true,
                glowAlpha = 0.7,
            },
            target = {
                enabled = true,
                scale = 1.3,
                nonTargetAlpha = 0.7,
                borderColor = { r = 1, g = 1, b = 1, a = 1 },
            },
        },
    },

    --------------------------------------------------------------
    -- Grey: Clean grey bars with threat-reactive coloring
    -- White-grey default, orange warning, red aggro
    -- Bright orange castbar, black box for uninterruptible
    --------------------------------------------------------------
    grey = {
        name = "Grey",
        desc = "Clean grey bars that shift to orange/red based on threat. Black uninterruptible castbar with white text.",
        settings = {
            healthbar = {
                width = 120,
                height = 10,
                texture = "TP Flat",
                borderSize = 1,
                borderColor = { r = 0.15, g = 0.15, b = 0.15, a = 1 },
                outerBorderSize = 0,
                outerBorderColor = { r = 0, g = 0, b = 0, a = 0 },
                backgroundColor = { r = 0.05, g = 0.05, b = 0.05, a = 0.95 },
                missingHealthColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
                showText = false,
                showLevel = false,
                classColor = false,
                reactionColor = false,
                customFriendly = { r = 0.78, g = 0.8, b = 0.82 },   -- Light warm grey
                customNeutral  = { r = 0.85, g = 0.82, b = 0.7 },   -- Warm beige grey
                customHostile  = { r = 0.82, g = 0.82, b = 0.84 },   -- Clean white-grey
                targetScale = 1.25,
                nonTargetAlpha = 0.7,
                fontSize = 9,
                nameText = {
                    font = "Fritz Quadrata",
                    fontSize = 9,
                    fontFlags = "OUTLINE",
                    color = { r = 0.9, g = 0.9, b = 0.9, a = 1 },
                    show = true,
                    xOffset = 0,
                    yOffset = 2,
                },
            },
            castbar = {
                enabled = true,
                width = 120,
                height = 10,
                yOffset = -2,
                texture = "TP Flat",
                backgroundColor = { r = 0.05, g = 0.05, b = 0.05, a = 0.95 },
                normalColor = { r = 1, g = 0.6, b = 0 },              -- Bright orange
                uninterruptibleColor = { r = 0.08, g = 0.08, b = 0.08 }, -- Near black
                showSpellName = true,
                showTimer = true,
                showIcon = true,
                iconSize = 14,
                fontSize = 8,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 5,
                iconSize = 20,
                iconSpacing = 2,
                yOffset = 12,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = true,
                durationFontSize = 8,
                borderSize = 1,
                borderColor = { r = 0.15, g = 0.15, b = 0.15, a = 1 },
            },
            threat = {
                enabled = true,
                useGlow = true,
                useColorChange = true,
                glowAlpha = 0.6,
                dps = {
                    safe   = { r = 0.82, g = 0.82, b = 0.84 },  -- White-grey (no threat)
                    medium = { r = 1, g = 0.85, b = 0.3 },       -- Yellow-orange (gaining)
                    high   = { r = 1, g = 0.5, b = 0 },          -- Orange (close to pulling)
                    danger = { r = 1, g = 0.15, b = 0.1 },       -- Red (have aggro)
                },
                tank = {
                    safe   = { r = 0.82, g = 0.82, b = 0.84 },  -- White-grey (solid aggro)
                    medium = { r = 1, g = 0.85, b = 0.3 },       -- Yellow-orange (losing)
                    high   = { r = 1, g = 0.5, b = 0 },          -- Orange (about to lose)
                    danger = { r = 1, g = 0.15, b = 0.1 },       -- Red (lost aggro)
                },
            },
            target = {
                enabled = true,
                scale = 1.25,
                nonTargetAlpha = 0.65,
                borderColor = { r = 1, g = 1, b = 1, a = 0.9 },
            },
        },
    },

    --------------------------------------------------------------
    -- Neon: Vibrant glowing colors on dark background
    --------------------------------------------------------------
    neon = {
        name = "Neon",
        desc = "Vibrant neon colors on dark backgrounds with strong glow effects.",
        settings = {
            healthbar = {
                width = 115,
                height = 10,
                texture = "TP Flat",
                borderSize = 1,
                borderColor = { r = 0.1, g = 0.1, b = 0.15, a = 1 },
                outerBorderSize = 0,
                outerBorderColor = { r = 0, g = 0, b = 0, a = 0 },
                backgroundColor = { r = 0.03, g = 0.03, b = 0.06, a = 0.95 },
                missingHealthColor = { r = 0.03, g = 0.03, b = 0.06, a = 1 },
                showText = false,
                showLevel = false,
                classColor = false,
                reactionColor = false,
                customFriendly = { r = 0, g = 1, b = 0.6 },       -- Neon green
                customNeutral  = { r = 1, g = 0.9, b = 0 },       -- Neon yellow
                customHostile  = { r = 1, g = 0, b = 0.4 },       -- Neon pink-red
                targetScale = 1.3,
                nonTargetAlpha = 0.6,
                fontSize = 8,
                nameText = {
                    font = "Fritz Quadrata",
                    fontSize = 9,
                    fontFlags = "OUTLINE",
                    color = { r = 0.9, g = 0.95, b = 1, a = 1 },
                    show = true,
                    xOffset = 0,
                    yOffset = 2,
                },
            },
            castbar = {
                enabled = true,
                width = 115,
                height = 8,
                yOffset = -2,
                texture = "TP Flat",
                backgroundColor = { r = 0.03, g = 0.03, b = 0.06, a = 0.95 },
                normalColor = { r = 0, g = 0.85, b = 1 },         -- Neon cyan
                uninterruptibleColor = { r = 0.6, g = 0, b = 0.8 }, -- Neon purple
                showSpellName = true,
                showTimer = true,
                showIcon = true,
                iconSize = 12,
                fontSize = 7,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 5,
                iconSize = 20,
                iconSpacing = 2,
                yOffset = 12,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = true,
                durationFontSize = 7,
                borderSize = 1,
                borderColor = { r = 0.1, g = 0.1, b = 0.15, a = 1 },
            },
            threat = {
                enabled = true,
                useGlow = true,
                useColorChange = true,
                glowAlpha = 0.9,
                dps = {
                    safe   = { r = 0, g = 1, b = 0.6 },
                    medium = { r = 1, g = 1, b = 0 },
                    high   = { r = 1, g = 0.4, b = 0 },
                    danger = { r = 1, g = 0, b = 0.3 },
                },
                tank = {
                    safe   = { r = 0, g = 1, b = 0.6 },
                    medium = { r = 1, g = 1, b = 0 },
                    high   = { r = 1, g = 0.4, b = 0 },
                    danger = { r = 1, g = 0, b = 0.3 },
                },
            },
            target = {
                enabled = true,
                scale = 1.3,
                nonTargetAlpha = 0.5,
                borderColor = { r = 0, g = 0.85, b = 1, a = 1 },
            },
        },
    },

    --------------------------------------------------------------
    -- Dark: Subdued dark theme, low-profile
    --------------------------------------------------------------
    dark = {
        name = "Dark",
        desc = "Low-profile dark bars that stay out of your way. Class colors with muted tones.",
        settings = {
            healthbar = {
                width = 110,
                height = 9,
                texture = "TP Gradient",
                borderSize = 1,
                borderColor = { r = 0, g = 0, b = 0, a = 1 },
                outerBorderSize = 0,
                outerBorderColor = { r = 0, g = 0, b = 0, a = 0 },
                backgroundColor = { r = 0.03, g = 0.03, b = 0.03, a = 0.95 },
                missingHealthColor = { r = 0.03, g = 0.03, b = 0.03, a = 1 },
                showText = false,
                showLevel = false,
                classColor = true,
                reactionColor = true,
                targetScale = 1.2,
                nonTargetAlpha = 0.5,
                fontSize = 8,
                nameText = {
                    font = "Fritz Quadrata",
                    fontSize = 9,
                    fontFlags = "OUTLINE",
                    color = { r = 0.7, g = 0.7, b = 0.7, a = 0.85 },
                    show = true,
                    xOffset = 0,
                    yOffset = 2,
                },
            },
            castbar = {
                enabled = true,
                width = 110,
                height = 7,
                yOffset = -1,
                texture = "TP Gradient",
                backgroundColor = { r = 0.03, g = 0.03, b = 0.03, a = 0.95 },
                normalColor = { r = 0.85, g = 0.55, b = 0 },
                uninterruptibleColor = { r = 0.35, g = 0.35, b = 0.35 },
                showSpellName = true,
                showTimer = false,
                showIcon = true,
                iconSize = 11,
                fontSize = 7,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 4,
                iconSize = 18,
                iconSpacing = 1,
                yOffset = 10,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = false,
                durationFontSize = 7,
                borderSize = 1,
                borderColor = { r = 0, g = 0, b = 0, a = 1 },
            },
            threat = {
                enabled = true,
                useGlow = false,
                useColorChange = true,
                glowAlpha = 0.4,
            },
            target = {
                enabled = true,
                scale = 1.2,
                nonTargetAlpha = 0.4,
                borderColor = { r = 0.8, g = 0.8, b = 0.8, a = 0.5 },
            },
        },
    },

    --------------------------------------------------------------
    -- Healer: Wide bars with health text, friendly plates emphasized
    --------------------------------------------------------------
    healer = {
        name = "Healer",
        desc = "Wide bars with health text and deficit display. Designed for healing with clear health visibility.",
        settings = {
            healthbar = {
                width = 140,
                height = 14,
                texture = "ThreatPlatesBar",
                borderSize = 1,
                borderColor = { r = 0, g = 0, b = 0, a = 1 },
                outerBorderSize = 1,
                outerBorderColor = { r = 0.3, g = 0.3, b = 0.3, a = 1 },
                backgroundColor = { r = 0.1, g = 0.1, b = 0.1, a = 0.95 },
                missingHealthColor = { r = 0.15, g = 0.02, b = 0.02, a = 1 },
                showText = true,
                textFormat = "DEFICIT",
                showLevel = false,
                classColor = true,
                reactionColor = true,
                targetScale = 1.2,
                nonTargetAlpha = 0.85,
                fontSize = 10,
                nameText = {
                    font = "Fritz Quadrata",
                    fontSize = 10,
                    fontFlags = "OUTLINE",
                    color = { r = 1, g = 1, b = 1, a = 1 },
                    show = true,
                    xOffset = 0,
                    yOffset = 2,
                },
            },
            castbar = {
                enabled = true,
                width = 140,
                height = 10,
                yOffset = -2,
                texture = "ThreatPlatesBar",
                normalColor = { r = 1, g = 0.7, b = 0 },
                uninterruptibleColor = { r = 0.7, g = 0.7, b = 0.7 },
                showSpellName = true,
                showTimer = true,
                showIcon = true,
                iconSize = 14,
                fontSize = 9,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = true,
                onlyMine = false,
                maxAuras = 6,
                iconSize = 24,
                iconSpacing = 2,
                yOffset = 16,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = true,
                durationFontSize = 8,
                borderSize = 1,
            },
            threat = {
                enabled = true,
                useGlow = true,
                useColorChange = true,
                glowAlpha = 0.6,
            },
            target = {
                enabled = true,
                scale = 1.2,
                nonTargetAlpha = 0.85,
                borderColor = { r = 0.2, g = 0.8, b = 1, a = 1 },
            },
        },
    },

    --------------------------------------------------------------
    -- Striped: Textured bars with horizontal stripe pattern
    --------------------------------------------------------------
    striped = {
        name = "Striped",
        desc = "Textured bars with subtle horizontal stripes. A distinctive look with class colors.",
        settings = {
            healthbar = {
                width = 125,
                height = 12,
                texture = "TP Striped",
                borderSize = 1,
                borderColor = { r = 0, g = 0, b = 0, a = 1 },
                outerBorderSize = 1,
                outerBorderColor = { r = 0.25, g = 0.25, b = 0.25, a = 1 },
                backgroundColor = { r = 0.06, g = 0.06, b = 0.06, a = 0.95 },
                missingHealthColor = { r = 0.06, g = 0.06, b = 0.06, a = 1 },
                showText = false,
                showLevel = true,
                classColor = true,
                reactionColor = true,
                targetScale = 1.3,
                nonTargetAlpha = 0.75,
                fontSize = 9,
            },
            castbar = {
                enabled = true,
                width = 125,
                height = 10,
                yOffset = -2,
                texture = "TP Striped",
                normalColor = { r = 1, g = 0.65, b = 0 },
                uninterruptibleColor = { r = 0.5, g = 0.5, b = 0.5 },
                showSpellName = true,
                showTimer = true,
                showIcon = true,
                iconSize = 14,
                fontSize = 8,
                borderSize = 1,
            },
            auras = {
                enabled = true,
                showDebuffs = true,
                showBuffs = false,
                onlyMine = true,
                maxAuras = 5,
                iconSize = 22,
                iconSpacing = 2,
                yOffset = 14,
                showDuration = true,
                showStacks = true,
                showCooldownSpiral = true,
                durationFontSize = 8,
                borderSize = 1,
            },
            threat = {
                enabled = true,
                useGlow = true,
                useColorChange = true,
                glowAlpha = 0.7,
            },
            target = {
                enabled = true,
                scale = 1.3,
                nonTargetAlpha = 0.7,
                borderColor = { r = 1, g = 0.84, b = 0, a = 1 },
            },
        },
    },
}

----------------------------------------------------------------------
-- Apply a Preset
----------------------------------------------------------------------
function Addon:ApplyPreset(presetKey)
    local preset = TPR.Presets[presetKey]
    if not preset then
        self:Print("Unknown preset: " .. tostring(presetKey))
        return
    end

    local p = self.db.profile

    -- Deep-copy preset settings into the profile
    for section, values in pairs(preset.settings) do
        if p[section] then
            for key, val in pairs(values) do
                if type(val) == "table" then
                    -- Copy color tables etc.
                    p[section][key] = {}
                    for k, v in pairs(val) do
                        p[section][key][k] = v
                    end
                else
                    p[section][key] = val
                end
            end
        end
    end

    -- Bump version so migration doesn't overwrite
    p.dbVersion = p.dbVersion or 0
    if p.dbVersion < 7 then p.dbVersion = 7 end

    self:Print("Applied preset: " .. preset.name)
    self:RefreshAllPlates()
end

----------------------------------------------------------------------
-- Deep-copy a table (for profile export/import)
----------------------------------------------------------------------
local function DeepCopy(src)
    if type(src) ~= "table" then return src end
    local copy = {}
    for k, v in pairs(src) do
        copy[k] = DeepCopy(v)
    end
    return copy
end

----------------------------------------------------------------------
-- Export Current Profile to String
-- Serialize → Compress → Base64 encode
----------------------------------------------------------------------
function Addon:ExportProfile()
    local LibDeflate = LibStub("LibDeflate", true)
    if not LibDeflate then
        self:Print("LibDeflate not found — cannot export.")
        return nil
    end

    -- Build exportable data (only the settings sections, not internal state)
    local exportData = {
        _format = "TPR1",  -- version tag so we can detect on import
        healthbar = DeepCopy(self.db.profile.healthbar),
        castbar = DeepCopy(self.db.profile.castbar),
        auras = DeepCopy(self.db.profile.auras),
        threat = DeepCopy(self.db.profile.threat),
        target = DeepCopy(self.db.profile.target),
        general = DeepCopy(self.db.profile.general),
    }

    local serialized = self:Serialize(exportData)
    if not serialized then
        self:Print("Serialization failed.")
        return nil
    end

    local compressed = LibDeflate:CompressDeflate(serialized)
    if not compressed then
        self:Print("Compression failed.")
        return nil
    end

    local encoded = LibDeflate:EncodeForPrint(compressed)
    return encoded
end

----------------------------------------------------------------------
-- Import Profile from String
-- Base64 decode → Decompress → Deserialize → Apply
----------------------------------------------------------------------
function Addon:ImportProfile(str)
    if not str or str == "" then
        self:Print("Import string is empty.")
        return false
    end

    local LibDeflate = LibStub("LibDeflate", true)
    if not LibDeflate then
        self:Print("LibDeflate not found — cannot import.")
        return false
    end

    local decoded = LibDeflate:DecodeForPrint(str)
    if not decoded then
        self:Print("Failed to decode import string. Make sure you copied it correctly.")
        return false
    end

    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then
        self:Print("Failed to decompress import data.")
        return false
    end

    local ok, data = self:Deserialize(decompressed)
    if not ok or type(data) ~= "table" then
        self:Print("Failed to deserialize import data.")
        return false
    end

    if data._format ~= "TPR1" then
        self:Print("Unrecognized import format. This doesn't look like a ThreatPlates Remake profile string.")
        return false
    end

    -- Apply imported data to current profile
    local p = self.db.profile
    local sections = { "healthbar", "castbar", "auras", "threat", "target", "general" }
    for _, section in ipairs(sections) do
        if data[section] and type(data[section]) == "table" and p[section] then
            for key, val in pairs(data[section]) do
                if type(val) == "table" then
                    p[section][key] = DeepCopy(val)
                else
                    p[section][key] = val
                end
            end
        end
    end

    -- Ensure dbVersion is current
    p.dbVersion = 7

    self:Print("Profile imported successfully!")
    self:RefreshAllPlates()
    return true
end

----------------------------------------------------------------------
-- Save Current Settings as a Custom Preset (stored in saved variables)
----------------------------------------------------------------------
function Addon:SaveCustomPreset(presetName)
    if not presetName or presetName == "" then
        self:Print("Please enter a name for your custom preset.")
        return
    end

    -- Store custom presets in a global saved variable table
    if not ThreatPlatesRemakeCustomPresets then
        ThreatPlatesRemakeCustomPresets = {}
    end

    local presetData = {
        name = presetName,
        desc = "Custom preset: " .. presetName,
        settings = {
            healthbar = DeepCopy(self.db.profile.healthbar),
            castbar = DeepCopy(self.db.profile.castbar),
            auras = DeepCopy(self.db.profile.auras),
            threat = DeepCopy(self.db.profile.threat),
            target = DeepCopy(self.db.profile.target),
        },
    }

    -- Clean out internal state from saved preset
    presetData.settings.healthbar.dbVersion = nil

    local key = presetName:lower():gsub("%s+", "_")
    ThreatPlatesRemakeCustomPresets[key] = presetData

    self:Print("Saved custom preset: " .. presetName)
end

----------------------------------------------------------------------
-- Delete a Custom Preset
----------------------------------------------------------------------
function Addon:DeleteCustomPreset(key)
    if ThreatPlatesRemakeCustomPresets and ThreatPlatesRemakeCustomPresets[key] then
        local name = ThreatPlatesRemakeCustomPresets[key].name
        ThreatPlatesRemakeCustomPresets[key] = nil
        self:Print("Deleted custom preset: " .. name)
    end
end

----------------------------------------------------------------------
-- Apply a Custom Preset (same logic as built-in presets)
----------------------------------------------------------------------
function Addon:ApplyCustomPreset(key)
    if not ThreatPlatesRemakeCustomPresets or not ThreatPlatesRemakeCustomPresets[key] then
        self:Print("Custom preset not found.")
        return
    end

    local preset = ThreatPlatesRemakeCustomPresets[key]
    local p = self.db.profile

    for section, values in pairs(preset.settings) do
        if p[section] then
            for k, val in pairs(values) do
                if type(val) == "table" then
                    p[section][k] = {}
                    for k2, v2 in pairs(val) do
                        p[section][k][k2] = v2
                    end
                else
                    p[section][k] = val
                end
            end
        end
    end

    p.dbVersion = p.dbVersion or 0
    if p.dbVersion < 7 then p.dbVersion = 7 end

    self:Print("Applied custom preset: " .. preset.name)
    self:RefreshAllPlates()
end
