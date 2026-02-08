----------------------------------------------------------------------
-- ThreatPlates Remake - Database
-- AceDB-3.0 defaults and profile management
-- Updated for WoW Midnight (12.0)
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

local DEFAULTS = {
    profile = {
        dbVersion = 0,

        -------------------------------------------------
        -- General (Midnight: many CVars removed)
        -------------------------------------------------
        general = {
            nameplateRange = 60,
            friendlyPlates = false,
            showInCombatOnly = false,
            clickThrough = false,
        },

        -------------------------------------------------
        -- Health Bar
        -------------------------------------------------
        healthbar = {
            width = 120,
            height = 12,
            texture = "ThreatPlatesBar",
            backgroundColor = { r = 0.1, g = 0.1, b = 0.1, a = 0.9 },
            missingHealthColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 },
            borderTexture = "Interface\\Tooltips\\UI-Tooltip-Border",
            borderSize = 1,
            borderColor = { r = 0, g = 0, b = 0, a = 1 },
            outerBorderSize = 2,
            outerBorderColor = { r = 1, g = 1, b = 1, a = 1 },

            -- Text
            showText = false,
            font = "Fritz Quadrata",
            fontSize = 9,
            fontFlags = "OUTLINE",
            textFormat = "PERCENT", -- PERCENT, CURRENT, BOTH, DEFICIT, NONE

            -- Coloring
            classColor = true,
            reactionColor = true,
            customFriendly = { r = 0, g = 0.8, b = 0 },
            customNeutral = { r = 1, g = 1, b = 0 },
            customHostile = { r = 1, g = 0, b = 0 },

            -- Level
            showLevel = false,

            -- Name Text (above health bar)
            nameText = {
                font = "Fritz Quadrata",
                fontSize = 10,
                fontFlags = "OUTLINE",
                color = { r = 1, g = 1, b = 1, a = 1 },
                show = true,
                yOffset = 2,
            },

            -- Scaling
            targetScale = 1.3,
            nonTargetAlpha = 0.8,
        },

        -------------------------------------------------
        -- Cast Bar
        -------------------------------------------------
        castbar = {
            enabled = true,
            width = 120,
            height = 10,
            yOffset = -2,
            texture = "ThreatPlatesBar",
            backgroundColor = { r = 0.15, g = 0.15, b = 0.15, a = 0.85 },
            borderSize = 1,

            -- Colors
            normalColor = { r = 1, g = 0.7, b = 0 },
            uninterruptibleColor = { r = 0.7, g = 0.7, b = 0.7 },
            interruptColor = { r = 0, g = 1, b = 0 },

            -- Text
            showSpellName = true,
            showTimer = true,
            font = "Fritz Quadrata",
            fontSize = 8,
            fontFlags = "OUTLINE",

            -- Icon
            showIcon = true,
            iconSize = 14,
        },

        -------------------------------------------------
        -- Auras / Debuffs
        -------------------------------------------------
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

            -- Filtering
            filterMode = "ALL", -- WHITELIST, BLACKLIST, ALL
            whitelist = {},
            blacklist = {},

            -- Cooldown spiral
            showCooldownSpiral = true,

            -- Font
            font = "Fritz Quadrata",
            fontSize = 8,
            fontFlags = "OUTLINE",
            durationFontSize = 8,

            -- Border
            borderSize = 1,
            borderColor = { r = 0, g = 0, b = 0, a = 1 },
            debuffBorderColor = { r = 1, g = 0, b = 0, a = 1 },
            buffBorderColor = { r = 0, g = 0.6, b = 1, a = 1 },
        },

        -------------------------------------------------
        -- Threat
        -------------------------------------------------
        threat = {
            enabled = true,
            useGlow = true,
            useColorChange = true,

            -- DPS/Healer mode (default) - alerts when pulling aggro
            dps = {
                safe = { r = 0, g = 1, b = 0 },       -- Not on threat table / low threat
                medium = { r = 1, g = 1, b = 0 },      -- Gaining threat
                high = { r = 1, g = 0.5, b = 0 },      -- Close to pulling
                danger = { r = 1, g = 0, b = 0 },       -- Have aggro / tanking
            },

            -- Tank mode (inverted)
            tank = {
                safe = { r = 0, g = 1, b = 0 },        -- Solid aggro
                medium = { r = 1, g = 1, b = 0 },       -- Losing aggro
                high = { r = 1, g = 0.5, b = 0 },       -- About to lose
                danger = { r = 1, g = 0, b = 0 },        -- Lost aggro
            },

            -- Glow settings
            glowSize = 8,
            glowAlpha = 0.7,
        },

        -------------------------------------------------
        -- Target Highlight
        -------------------------------------------------
        target = {
            enabled = true,
            highlightTexture = "Interface\\AddOns\\ThreatPlatesRemake\\Artwork\\TP_HealthBar_Highlight.tga",
            highlightColor = { r = 1, g = 1, b = 1, a = 0.3 },
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderSize = 2,
            scale = 1.3,
            alpha = 1.0,
            nonTargetAlpha = 0.7,
        },

        -------------------------------------------------
        -- Minimap Icon
        -------------------------------------------------
        minimap = {
            hide = false,
        },
    },
}

local DB_VERSION = 7 -- Bump this when forced migration is needed

function Addon:SetupDatabase()
    self.db = LibStub("AceDB-3.0"):New("ThreatPlatesRemakeDB", DEFAULTS, true)

    -- Force-migrate stale profile values
    self:MigrateProfile()

    -- Profile change callbacks
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshAllPlates")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshAllPlates")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshAllPlates")

    -- Setup minimap icon via LibDBIcon
    local LDB = LibStub("LibDataBroker-1.1")
    local icon = LDB:NewDataObject(ADDON_NAME, {
        type = "launcher",
        text = "ThreatPlates Remake",
        icon = "Interface\\AddOns\\ThreatPlatesRemake\\Artwork\\Logo.tga",
        OnClick = function(_, button)
            if button == "LeftButton" then
                Addon:SlashCommand("")
            end
        end,
        OnTooltipShow = function(tt)
            tt:AddLine("ThreatPlates Remake")
            tt:AddLine("|cff00ff00Left-Click|r to open config", 1, 1, 1)
        end,
    })

    local LibDBIcon = LibStub("LibDBIcon-1.0", true)
    if LibDBIcon then
        LibDBIcon:Register(ADDON_NAME, icon, self.db.profile.minimap)
    end
end

----------------------------------------------------------------------
-- Profile Migration — forces correct values on stale saved profiles
----------------------------------------------------------------------
function Addon:MigrateProfile()
    local p = self.db.profile
    if (p.dbVersion or 0) >= DB_VERSION then return end

    -- v2+v6: Black inner border + white outer border (ThreatPlates classic style)
    p.healthbar.borderSize = 1
    p.healthbar.borderColor = { r = 0, g = 0, b = 0, a = 1 }
    p.healthbar.outerBorderSize = 2
    p.healthbar.outerBorderColor = { r = 1, g = 1, b = 1, a = 1 }
    p.healthbar.missingHealthColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 }
    p.healthbar.backgroundColor = { r = 0.05, g = 0.05, b = 0.05, a = 1 }
    p.healthbar.showText = false
    p.healthbar.showLevel = false
    p.healthbar.texture = "ThreatPlatesBar"
    p.auras.filterMode = "ALL"
    p.auras.durationFontSize = 8
    p.auras.iconSize = 22
    p.castbar.yOffset = -2
    p.castbar.texture = "ThreatPlatesBar"

    -- v4: Force maxAuras, onlyMine
    p.auras.maxAuras = 5
    p.auras.onlyMine = true
    p.auras.borderSize = 1

    -- v7: Initialize nameText settings if missing
    if not p.healthbar.nameText or type(p.healthbar.nameText) ~= "table" then
        p.healthbar.nameText = {
            font = "Fritz Quadrata",
            fontSize = 10,
            fontFlags = "OUTLINE",
            color = { r = 1, g = 1, b = 1, a = 1 },
            show = true,
            yOffset = 2,
        }
    end

    -- v7: Migrate font paths to LSM key names
    local fontMigrations = {
        ["Fonts\\FRIZQT__.TTF"] = "Fritz Quadrata",
        ["Fonts\\ARIALN.TTF"] = "Arial Narrow",
        ["Fonts\\MORPHEUS.TTF"] = "Morpheus",
        ["Fonts\\SKURRI.TTF"] = "Skurri",
    }
    for oldPath, newKey in pairs(fontMigrations) do
        if p.healthbar.font == oldPath then p.healthbar.font = newKey end
        if p.healthbar.nameText and p.healthbar.nameText.font == oldPath then p.healthbar.nameText.font = newKey end
        if p.castbar.font == oldPath then p.castbar.font = newKey end
        if p.auras.font == oldPath then p.auras.font = newKey end
    end
    -- Also catch nil or empty font values
    if not p.healthbar.font or p.healthbar.font == "" then p.healthbar.font = "Fritz Quadrata" end
    if not p.castbar.font or p.castbar.font == "" then p.castbar.font = "Fritz Quadrata" end
    if not p.auras.font or p.auras.font == "" then p.auras.font = "Fritz Quadrata" end

    p.dbVersion = DB_VERSION
end

function Addon:RefreshAllPlates()
    self:MigrateProfile()
    self:ApplyCVars()
    for plate, frame in pairs(TPR.ActivePlates) do
        if frame.unitId then
            self:ConfigureFrame(frame, frame.unitId)
        end
    end
end
