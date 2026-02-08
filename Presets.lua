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
