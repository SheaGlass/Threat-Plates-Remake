----------------------------------------------------------------------
-- ThreatPlates Remake - Config
-- AceConfig-3.0 options panel
-- Updated for WoW Midnight (12.0)
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

----------------------------------------------------------------------
-- Shared Media Dropdown Helper
----------------------------------------------------------------------
local LSM = LibStub("LibSharedMedia-3.0", true)

local function GetMediaList(mediaType)
    if LSM then
        return LSM:HashTable(mediaType)
    end
    return {}
end

local function GetMediaKeys(mediaType)
    if LSM then
        return LSM:List(mediaType)
    end
    return {}
end

----------------------------------------------------------------------
-- Options Table
----------------------------------------------------------------------
-- Reusable preview button entry for each tab
local function MakePreviewButton(order)
    return {
        name = "  Toggle Live Preview  ",
        desc = "Show/hide a live preview of your nameplate in the center of the screen.",
        type = "execute",
        order = order or -1,
        width = "full",
        func = function()
            Addon:TogglePreview()
        end,
    }
end

local function GetOptions()
    local db = Addon.db.profile

    local options = {
        name = "ThreatPlates Remake |cff888888- For any issues / bugs contact:|r |cff00aaff https://github.com/SheaGlass/Threat-Plates-Remake|r",
        type = "group",
        childGroups = "tab",
        args = {
            --------------------------------------------------------
            -- PRESETS TAB
            --------------------------------------------------------
            presets = {
                name = "Presets",
                type = "group",
                order = 0,
                args = {
                    desc = {
                        name = "Apply a built-in style preset. This will override your current profile settings for health bar, cast bar, auras, threat, and target modules.",
                        type = "description",
                        order = 0,
                        fontSize = "medium",
                    },
                    spacer1 = { name = "", type = "description", order = 0.5 },
                    applyClassic = {
                        name = "Classic ThreatPlates",
                        desc = TPR.Presets.classic.desc,
                        type = "execute",
                        order = 1,
                        width = "full",
                        func = function() Addon:ApplyPreset("classic") end,
                        confirm = true,
                        confirmText = "Apply the Classic ThreatPlates preset?\nThis will overwrite your current settings.",
                    },
                    classicDesc = {
                        name = "|cff888888" .. TPR.Presets.classic.desc .. "|r",
                        type = "description",
                        order = 1.5,
                    },
                    spacer2 = { name = "", type = "description", order = 1.8 },
                    applyMinimal = {
                        name = "Minimal",
                        desc = TPR.Presets.minimal.desc,
                        type = "execute",
                        order = 2,
                        width = "full",
                        func = function() Addon:ApplyPreset("minimal") end,
                        confirm = true,
                        confirmText = "Apply the Minimal preset?\nThis will overwrite your current settings.",
                    },
                    minimalDesc = {
                        name = "|cff888888" .. TPR.Presets.minimal.desc .. "|r",
                        type = "description",
                        order = 2.5,
                    },
                    spacer3 = { name = "", type = "description", order = 2.8 },
                    applyGlossy = {
                        name = "Glossy",
                        desc = TPR.Presets.glossy.desc,
                        type = "execute",
                        order = 3,
                        width = "full",
                        func = function() Addon:ApplyPreset("glossy") end,
                        confirm = true,
                        confirmText = "Apply the Glossy preset?\nThis will overwrite your current settings.",
                    },
                    glossyDesc = {
                        name = "|cff888888" .. TPR.Presets.glossy.desc .. "|r",
                        type = "description",
                        order = 3.5,
                    },

                    -- Custom Presets
                    customHeader = {
                        name = "Custom Presets",
                        type = "header",
                        order = 10,
                    },
                    customDesc = {
                        name = "|cff888888Save your current settings as a custom preset, or apply/delete saved presets.|r",
                        type = "description",
                        order = 10.1,
                    },
                    customPresetName = {
                        name = "Preset Name",
                        desc = "Enter a name for your custom preset.",
                        type = "input",
                        order = 10.2,
                        width = "double",
                        get = function() return TPR._customPresetName or "" end,
                        set = function(_, val) TPR._customPresetName = val end,
                    },
                    saveCustom = {
                        name = "Save Current as Preset",
                        desc = "Save all current settings as a named custom preset.",
                        type = "execute",
                        order = 10.3,
                        func = function()
                            Addon:SaveCustomPreset(TPR._customPresetName)
                            TPR._customPresetName = ""
                        end,
                    },
                    customPresetList = {
                        name = "Apply Custom Preset",
                        desc = "Select a saved custom preset to apply.",
                        type = "select",
                        order = 10.4,
                        width = "double",
                        values = function()
                            local list = {}
                            if ThreatPlatesRemakeCustomPresets then
                                for key, preset in pairs(ThreatPlatesRemakeCustomPresets) do
                                    list[key] = preset.name
                                end
                            end
                            if not next(list) then
                                list["_none"] = "(No custom presets saved)"
                            end
                            return list
                        end,
                        get = function() return TPR._selectedCustomPreset end,
                        set = function(_, val)
                            TPR._selectedCustomPreset = val
                        end,
                    },
                    applyCustom = {
                        name = "Apply Selected",
                        desc = "Apply the selected custom preset to your current profile.",
                        type = "execute",
                        order = 10.5,
                        func = function()
                            if TPR._selectedCustomPreset and TPR._selectedCustomPreset ~= "_none" then
                                Addon:ApplyCustomPreset(TPR._selectedCustomPreset)
                            end
                        end,
                        confirm = true,
                        confirmText = "Apply this custom preset?\nThis will overwrite your current settings.",
                    },
                    deleteCustom = {
                        name = "Delete Selected",
                        desc = "Permanently delete the selected custom preset.",
                        type = "execute",
                        order = 10.6,
                        func = function()
                            if TPR._selectedCustomPreset and TPR._selectedCustomPreset ~= "_none" then
                                Addon:DeleteCustomPreset(TPR._selectedCustomPreset)
                                TPR._selectedCustomPreset = nil
                            end
                        end,
                        confirm = true,
                        confirmText = "Delete this custom preset? This cannot be undone.",
                    },

                    -- Import / Export
                    shareHeader = {
                        name = "Share Profile",
                        type = "header",
                        order = 20,
                    },
                    shareDesc = {
                        name = "|cff888888Export your settings as a text string to share with others, or paste a string to import someone else's settings.|r",
                        type = "description",
                        order = 20.1,
                    },
                    exportBtn = {
                        name = "Export Profile",
                        desc = "Generate a shareable text string of your current settings. The string will appear in the box below — copy it and share with others.",
                        type = "execute",
                        order = 20.2,
                        func = function()
                            local str = Addon:ExportProfile()
                            if str then
                                TPR._importExportText = str
                                Addon:Print("Profile exported! Copy the string from the text box below.")
                            end
                        end,
                    },
                    importExportBox = {
                        name = "Import / Export String",
                        desc = "After exporting, copy this string. To import, paste a string here.",
                        type = "input",
                        order = 20.3,
                        multiline = 6,
                        width = "full",
                        get = function() return TPR._importExportText or "" end,
                        set = function(_, val) TPR._importExportText = val end,
                    },
                    importBtn = {
                        name = "Import Profile",
                        desc = "Import settings from the text string in the box above. This will overwrite your current settings.",
                        type = "execute",
                        order = 20.4,
                        func = function()
                            if TPR._importExportText and TPR._importExportText ~= "" then
                                Addon:ImportProfile(TPR._importExportText)
                                TPR._importExportText = ""
                            else
                                Addon:Print("Paste a profile string into the text box first.")
                            end
                        end,
                        confirm = true,
                        confirmText = "Import this profile?\nThis will overwrite your current settings.",
                    },
                },
            },

            --------------------------------------------------------
            -- GENERAL TAB
            --------------------------------------------------------
            general = {
                name = "General",
                type = "group",
                order = 1,
                args = {
                    desc = {
                        name = "General nameplate settings and behavior.",
                        type = "description",
                        order = 0,
                    },
                    nameplateRange = {
                        name = "Nameplate Range",
                        desc = "Maximum distance at which nameplates are visible.",
                        type = "range",
                        min = 20, max = 100, step = 1,
                        order = 1,
                        get = function() return db.general.nameplateRange end,
                        set = function(_, val)
                            db.general.nameplateRange = val
                            Addon:ApplyCVars()
                        end,
                    },
                    -- Note: Stacking mode and overlap CVars were removed in Midnight (12.0)
                },
            },

            --------------------------------------------------------
            -- HEALTH BAR TAB
            --------------------------------------------------------
            healthbar = {
                name = "Health Bar",
                type = "group",
                order = 2,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    sizeHeader = {
                        name = "Size & Position",
                        type = "header",
                        order = 0,
                    },
                    width = {
                        name = "Width",
                        type = "range",
                        min = 50, max = 300, step = 1,
                        order = 1,
                        get = function() return db.healthbar.width end,
                        set = function(_, val)
                            db.healthbar.width = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    height = {
                        name = "Height",
                        type = "range",
                        min = 4, max = 40, step = 1,
                        order = 2,
                        get = function() return db.healthbar.height end,
                        set = function(_, val)
                            db.healthbar.height = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    borderHeader = {
                        name = "Border",
                        type = "header",
                        order = 5,
                    },
                    innerBorderDesc = {
                        name = "|cff888888Inner border sits directly around the health bar.|r",
                        type = "description",
                        order = 5.5,
                    },
                    borderSize = {
                        name = "Inner Border Size",
                        desc = "Thickness of the inner border directly around the health bar. Set to 0 to hide.",
                        type = "range",
                        min = 0, max = 4, step = 0.05, isPercent = false,
                        order = 6,
                        get = function() return db.healthbar.borderSize end,
                        set = function(_, val)
                            db.healthbar.borderSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    borderColor = {
                        name = "Inner Border Color",
                        type = "color",
                        hasAlpha = true,
                        order = 7,
                        get = function()
                            local c = db.healthbar.borderColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.healthbar.borderColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    outerBorderDesc = {
                        name = "|cff888888Outer border wraps around the inner border.|r",
                        type = "description",
                        order = 7.5,
                    },
                    outerBorderSize = {
                        name = "Outer Border Size",
                        desc = "Thickness of the outer border wrapping around the inner border. Set to 0 to hide.",
                        type = "range",
                        min = 0, max = 4, step = 0.05, isPercent = false,
                        order = 8,
                        get = function() return db.healthbar.outerBorderSize end,
                        set = function(_, val)
                            db.healthbar.outerBorderSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    outerBorderColor = {
                        name = "Outer Border Color",
                        type = "color",
                        hasAlpha = true,
                        order = 9,
                        get = function()
                            local c = db.healthbar.outerBorderColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.healthbar.outerBorderColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    textureHeader = {
                        name = "Texture & Colors",
                        type = "header",
                        order = 10,
                    },
                    barTexture = {
                        name = "Bar Texture",
                        desc = "The texture used for the health bar fill.",
                        type = "select",
                        order = 10.5,
                        dialogControl = LSM and "LSM30_Statusbar" or nil,
                        values = function() return LSM and LSM:HashTable("statusbar") or {} end,
                        get = function() return db.healthbar.texture end,
                        set = function(_, val)
                            db.healthbar.texture = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    classColor = {
                        name = "Use Class Colors (Players)",
                        desc = "Color health bars by class for player nameplates.",
                        type = "toggle",
                        order = 11,
                        get = function() return db.healthbar.classColor end,
                        set = function(_, val)
                            db.healthbar.classColor = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    missingHealthColor = {
                        name = "Background / Missing Health Color",
                        desc = "Color shown behind the health bar fill where HP has been lost.",
                        type = "color",
                        hasAlpha = true,
                        order = 12,
                        get = function()
                            local c = db.healthbar.missingHealthColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.healthbar.missingHealthColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    customHostile = {
                        name = "Hostile Color",
                        type = "color",
                        order = 13,
                        get = function()
                            local c = db.healthbar.customHostile
                            return c.r, c.g, c.b
                        end,
                        set = function(_, r, g, b)
                            db.healthbar.customHostile = { r = r, g = g, b = b }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    customNeutral = {
                        name = "Neutral Color",
                        type = "color",
                        order = 14,
                        get = function()
                            local c = db.healthbar.customNeutral
                            return c.r, c.g, c.b
                        end,
                        set = function(_, r, g, b)
                            db.healthbar.customNeutral = { r = r, g = g, b = b }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    customFriendly = {
                        name = "Friendly Color",
                        type = "color",
                        order = 15,
                        get = function()
                            local c = db.healthbar.customFriendly
                            return c.r, c.g, c.b
                        end,
                        set = function(_, r, g, b)
                            db.healthbar.customFriendly = { r = r, g = g, b = b }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    textHeader = {
                        name = "Text",
                        type = "header",
                        order = 20,
                    },
                    showText = {
                        name = "Show Health Text",
                        type = "toggle",
                        order = 21,
                        get = function() return db.healthbar.showText end,
                        set = function(_, val)
                            db.healthbar.showText = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    font = {
                        name = "Font",
                        type = "select",
                        order = 21.5,
                        dialogControl = LSM and "LSM30_Font" or nil,
                        values = function() return LSM and LSM:HashTable("font") or {} end,
                        get = function() return db.healthbar.font end,
                        set = function(_, val)
                            db.healthbar.font = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    fontSize = {
                        name = "Font Size",
                        type = "range",
                        min = 6, max = 24, step = 1,
                        order = 22,
                        get = function() return db.healthbar.fontSize end,
                        set = function(_, val)
                            db.healthbar.fontSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    fontFlags = {
                        name = "Font Outline",
                        type = "select",
                        order = 22.5,
                        values = {
                            ["OUTLINE"] = "Outline",
                            ["THICKOUTLINE"] = "Thick Outline",
                            ["MONOCHROME,OUTLINE"] = "Monochrome",
                            [""] = "None",
                        },
                        get = function() return db.healthbar.fontFlags or "OUTLINE" end,
                        set = function(_, val)
                            db.healthbar.fontFlags = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    textFormat = {
                        name = "Text Format",
                        type = "select",
                        values = {
                            PERCENT = "Percentage",
                            CURRENT = "Current HP",
                            CURRENT_PERCENT = "Current - Percent",
                            BOTH = "Current / Max",
                            DEFICIT = "Deficit",
                            NONE = "None",
                        },
                        order = 23,
                        get = function() return db.healthbar.textFormat end,
                        set = function(_, val)
                            db.healthbar.textFormat = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    showLevel = {
                        name = "Show Level",
                        desc = "Display the unit's level on the right side of the health bar.",
                        type = "toggle",
                        order = 24,
                        get = function() return db.healthbar.showLevel end,
                        set = function(_, val)
                            db.healthbar.showLevel = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nameTextHeader = {
                        name = "Name Text (Above Bar)",
                        type = "header",
                        order = 25,
                    },
                    nameTextShow = {
                        name = "Show Name",
                        desc = "Display the unit name above the health bar.",
                        type = "toggle",
                        order = 25.1,
                        get = function() return db.healthbar.nameText.show end,
                        set = function(_, val)
                            db.healthbar.nameText.show = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nameTextFont = {
                        name = "Name Font",
                        type = "select",
                        order = 25.2,
                        dialogControl = LSM and "LSM30_Font" or nil,
                        values = function() return LSM and LSM:HashTable("font") or {} end,
                        get = function() return db.healthbar.nameText.font end,
                        set = function(_, val)
                            db.healthbar.nameText.font = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nameTextFontSize = {
                        name = "Name Font Size",
                        type = "range",
                        min = 6, max = 24, step = 1,
                        order = 25.3,
                        get = function() return db.healthbar.nameText.fontSize end,
                        set = function(_, val)
                            db.healthbar.nameText.fontSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nameTextFontFlags = {
                        name = "Name Font Outline",
                        type = "select",
                        order = 25.4,
                        values = {
                            ["OUTLINE"] = "Outline",
                            ["THICKOUTLINE"] = "Thick Outline",
                            ["MONOCHROME,OUTLINE"] = "Monochrome",
                            [""] = "None",
                        },
                        get = function() return db.healthbar.nameText.fontFlags or "OUTLINE" end,
                        set = function(_, val)
                            db.healthbar.nameText.fontFlags = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nameTextColor = {
                        name = "Name Color",
                        type = "color",
                        hasAlpha = true,
                        order = 25.5,
                        get = function()
                            local c = db.healthbar.nameText.color
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.healthbar.nameText.color = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nameTextYOffset = {
                        name = "Name Y Offset",
                        desc = "Vertical offset of the name text above the health bar.",
                        type = "range",
                        min = -20, max = 30, step = 1,
                        order = 25.6,
                        get = function() return db.healthbar.nameText.yOffset end,
                        set = function(_, val)
                            db.healthbar.nameText.yOffset = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    scaleHeader = {
                        name = "Scaling & Alpha",
                        type = "header",
                        order = 30,
                    },
                    targetScale = {
                        name = "Target Scale",
                        desc = "Scale multiplier for the current target's nameplate.",
                        type = "range",
                        min = 0.5, max = 2.5, step = 0.05,
                        order = 31,
                        get = function() return db.healthbar.targetScale end,
                        set = function(_, val)
                            db.healthbar.targetScale = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nonTargetAlpha = {
                        name = "Non-Target Alpha",
                        desc = "Opacity of nameplates that are NOT your current target.",
                        type = "range",
                        min = 0.1, max = 1.0, step = 0.05,
                        order = 32,
                        get = function() return db.healthbar.nonTargetAlpha end,
                        set = function(_, val)
                            db.healthbar.nonTargetAlpha = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                },
            },

            --------------------------------------------------------
            -- CAST BAR TAB
            --------------------------------------------------------
            castbar = {
                name = "Cast Bar",
                type = "group",
                order = 3,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    enabled = {
                        name = "Enable Cast Bar",
                        type = "toggle",
                        order = 0,
                        get = function() return db.castbar.enabled end,
                        set = function(_, val)
                            db.castbar.enabled = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    sizeHeader = {
                        name = "Size",
                        type = "header",
                        order = 1,
                    },
                    width = {
                        name = "Width",
                        type = "range",
                        min = 50, max = 300, step = 1,
                        order = 2,
                        get = function() return db.castbar.width end,
                        set = function(_, val)
                            db.castbar.width = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    height = {
                        name = "Height",
                        type = "range",
                        min = 4, max = 30, step = 1,
                        order = 3,
                        get = function() return db.castbar.height end,
                        set = function(_, val)
                            db.castbar.height = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    yOffset = {
                        name = "Y Offset",
                        desc = "Vertical offset from the health bar.",
                        type = "range",
                        min = -40, max = 40, step = 1,
                        order = 4,
                        get = function() return db.castbar.yOffset end,
                        set = function(_, val)
                            db.castbar.yOffset = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    castbarTexture = {
                        name = "Bar Texture",
                        desc = "The texture used for the cast bar fill.",
                        type = "select",
                        order = 5,
                        dialogControl = LSM and "LSM30_Statusbar" or nil,
                        values = function() return LSM and LSM:HashTable("statusbar") or {} end,
                        get = function() return db.castbar.texture end,
                        set = function(_, val)
                            db.castbar.texture = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    colorHeader = {
                        name = "Colors",
                        type = "header",
                        order = 10,
                    },
                    normalColor = {
                        name = "Normal Cast Color",
                        type = "color",
                        order = 11,
                        get = function()
                            local c = db.castbar.normalColor
                            return c.r, c.g, c.b
                        end,
                        set = function(_, r, g, b)
                            db.castbar.normalColor = { r = r, g = g, b = b }
                        end,
                    },
                    uninterruptibleColor = {
                        name = "Uninterruptible Color",
                        type = "color",
                        order = 12,
                        get = function()
                            local c = db.castbar.uninterruptibleColor
                            return c.r, c.g, c.b
                        end,
                        set = function(_, r, g, b)
                            db.castbar.uninterruptibleColor = { r = r, g = g, b = b }
                        end,
                    },
                    textHeader = {
                        name = "Text & Icon",
                        type = "header",
                        order = 20,
                    },
                    castFont = {
                        name = "Font",
                        type = "select",
                        order = 20.5,
                        dialogControl = LSM and "LSM30_Font" or nil,
                        values = function() return LSM and LSM:HashTable("font") or {} end,
                        get = function() return db.castbar.font end,
                        set = function(_, val)
                            db.castbar.font = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    castFontSize = {
                        name = "Font Size",
                        type = "range",
                        min = 6, max = 20, step = 1,
                        order = 20.6,
                        get = function() return db.castbar.fontSize end,
                        set = function(_, val)
                            db.castbar.fontSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    showSpellName = {
                        name = "Show Spell Name",
                        type = "toggle",
                        order = 21,
                        get = function() return db.castbar.showSpellName end,
                        set = function(_, val) db.castbar.showSpellName = val end,
                    },
                    showTimer = {
                        name = "Show Timer",
                        type = "toggle",
                        order = 22,
                        get = function() return db.castbar.showTimer end,
                        set = function(_, val) db.castbar.showTimer = val end,
                    },
                    showIcon = {
                        name = "Show Spell Icon",
                        type = "toggle",
                        order = 23,
                        get = function() return db.castbar.showIcon end,
                        set = function(_, val)
                            db.castbar.showIcon = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    iconSize = {
                        name = "Icon Size",
                        type = "range",
                        min = 8, max = 30, step = 1,
                        order = 24,
                        get = function() return db.castbar.iconSize end,
                        set = function(_, val)
                            db.castbar.iconSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                },
            },

            --------------------------------------------------------
            -- AURAS TAB
            --------------------------------------------------------
            auras = {
                name = "Auras / Debuffs",
                type = "group",
                order = 4,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    enabled = {
                        name = "Enable Aura Tracking",
                        type = "toggle",
                        order = 0,
                        get = function() return db.auras.enabled end,
                        set = function(_, val)
                            db.auras.enabled = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    displayHeader = {
                        name = "Display",
                        type = "header",
                        order = 1,
                    },
                    showDebuffs = {
                        name = "Show Debuffs",
                        type = "toggle",
                        order = 2,
                        get = function() return db.auras.showDebuffs end,
                        set = function(_, val) db.auras.showDebuffs = val end,
                    },
                    showBuffs = {
                        name = "Show Buffs",
                        type = "toggle",
                        order = 3,
                        get = function() return db.auras.showBuffs end,
                        set = function(_, val) db.auras.showBuffs = val end,
                    },
                    onlyMine = {
                        name = "Only Show My Auras",
                        desc = "Only display auras that you applied.",
                        type = "toggle",
                        order = 4,
                        get = function() return db.auras.onlyMine end,
                        set = function(_, val) db.auras.onlyMine = val end,
                    },
                    maxAuras = {
                        name = "Max Auras Displayed",
                        type = "range",
                        min = 1, max = 10, step = 1,
                        order = 5,
                        get = function() return db.auras.maxAuras end,
                        set = function(_, val) db.auras.maxAuras = val end,
                    },
                    sizeHeader = {
                        name = "Size",
                        type = "header",
                        order = 10,
                    },
                    iconSize = {
                        name = "Icon Size",
                        type = "range",
                        min = 10, max = 40, step = 1,
                        order = 11,
                        get = function() return db.auras.iconSize end,
                        set = function(_, val)
                            db.auras.iconSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    iconSpacing = {
                        name = "Icon Spacing",
                        type = "range",
                        min = 0, max = 10, step = 1,
                        order = 12,
                        get = function() return db.auras.iconSpacing end,
                        set = function(_, val) db.auras.iconSpacing = val end,
                    },
                    yOffset = {
                        name = "Y Offset",
                        type = "range",
                        min = -40, max = 60, step = 1,
                        order = 13,
                        get = function() return db.auras.yOffset end,
                        set = function(_, val)
                            db.auras.yOffset = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    overlayHeader = {
                        name = "Overlays",
                        type = "header",
                        order = 20,
                    },
                    showDuration = {
                        name = "Show Duration Text",
                        type = "toggle",
                        order = 21,
                        get = function() return db.auras.showDuration end,
                        set = function(_, val) db.auras.showDuration = val end,
                    },
                    showStacks = {
                        name = "Show Stack Count",
                        type = "toggle",
                        order = 22,
                        get = function() return db.auras.showStacks end,
                        set = function(_, val) db.auras.showStacks = val end,
                    },
                    showCooldownSpiral = {
                        name = "Show Cooldown Spiral",
                        type = "toggle",
                        order = 23,
                        get = function() return db.auras.showCooldownSpiral end,
                        set = function(_, val) db.auras.showCooldownSpiral = val end,
                    },
                    appearanceHeader = {
                        name = "Appearance",
                        type = "header",
                        order = 25,
                    },
                    auraFont = {
                        name = "Font",
                        type = "select",
                        order = 25.5,
                        dialogControl = LSM and "LSM30_Font" or nil,
                        values = function() return LSM and LSM:HashTable("font") or {} end,
                        get = function() return db.auras.font end,
                        set = function(_, val)
                            db.auras.font = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    durationFontSize = {
                        name = "Duration Font Size",
                        type = "range",
                        min = 6, max = 20, step = 1,
                        order = 26,
                        get = function() return db.auras.durationFontSize end,
                        set = function(_, val)
                            db.auras.durationFontSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    stackFontSize = {
                        name = "Stack Font Size",
                        type = "range",
                        min = 6, max = 16, step = 1,
                        order = 26.5,
                        get = function() return db.auras.fontSize end,
                        set = function(_, val)
                            db.auras.fontSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    borderSize = {
                        name = "Border Size",
                        type = "range",
                        min = 0, max = 4, step = 1,
                        order = 27,
                        get = function() return db.auras.borderSize end,
                        set = function(_, val)
                            db.auras.borderSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    debuffBorderColor = {
                        name = "Debuff Border Color",
                        type = "color",
                        hasAlpha = true,
                        order = 28,
                        get = function()
                            local c = db.auras.debuffBorderColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.auras.debuffBorderColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    buffBorderColor = {
                        name = "Buff Border Color",
                        type = "color",
                        hasAlpha = true,
                        order = 29,
                        get = function()
                            local c = db.auras.buffBorderColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.auras.buffBorderColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    filterHeader = {
                        name = "Filtering",
                        type = "header",
                        order = 30,
                    },
                    filterNote = {
                        name = "|cffff9900Note:|r In Midnight (12.0), spell data may be restricted by the Secret Values system. Whitelist/Blacklist filtering may not work during combat.",
                        type = "description",
                        order = 30.5,
                    },
                    filterMode = {
                        name = "Filter Mode",
                        type = "select",
                        values = {
                            ALL = "Show All",
                            WHITELIST = "Whitelist Only",
                            BLACKLIST = "Hide Blacklisted",
                        },
                        order = 31,
                        get = function() return db.auras.filterMode end,
                        set = function(_, val) db.auras.filterMode = val end,
                    },
                },
            },

            --------------------------------------------------------
            -- THREAT TAB
            --------------------------------------------------------
            threat = {
                name = "Threat",
                type = "group",
                order = 5,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    enabled = {
                        name = "Enable Threat Coloring",
                        type = "toggle",
                        order = 0,
                        get = function() return db.threat.enabled end,
                        set = function(_, val)
                            db.threat.enabled = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    useGlow = {
                        name = "Show Threat Glow",
                        desc = "Display a colored glow around the nameplate based on threat.",
                        type = "toggle",
                        order = 1,
                        get = function() return db.threat.useGlow end,
                        set = function(_, val) db.threat.useGlow = val end,
                    },
                    useColorChange = {
                        name = "Color Health Bar by Threat",
                        desc = "Override health bar color with threat status color.",
                        type = "toggle",
                        order = 2,
                        get = function() return db.threat.useColorChange end,
                        set = function(_, val) db.threat.useColorChange = val end,
                    },
                    dpsHeader = {
                        name = "DPS / Healer Colors",
                        type = "header",
                        order = 10,
                    },
                    dpsSafe = {
                        name = "Safe (Low Threat)",
                        type = "color",
                        order = 11,
                        get = function() local c = db.threat.dps.safe; return c.r, c.g, c.b end,
                        set = function(_, r, g, b) db.threat.dps.safe = { r = r, g = g, b = b } end,
                    },
                    dpsMedium = {
                        name = "Medium Threat",
                        type = "color",
                        order = 12,
                        get = function() local c = db.threat.dps.medium; return c.r, c.g, c.b end,
                        set = function(_, r, g, b) db.threat.dps.medium = { r = r, g = g, b = b } end,
                    },
                    dpsHigh = {
                        name = "High Threat",
                        type = "color",
                        order = 13,
                        get = function() local c = db.threat.dps.high; return c.r, c.g, c.b end,
                        set = function(_, r, g, b) db.threat.dps.high = { r = r, g = g, b = b } end,
                    },
                    dpsDanger = {
                        name = "Danger (Have Aggro)",
                        type = "color",
                        order = 14,
                        get = function() local c = db.threat.dps.danger; return c.r, c.g, c.b end,
                        set = function(_, r, g, b) db.threat.dps.danger = { r = r, g = g, b = b } end,
                    },
                    glowHeader = {
                        name = "Glow Settings",
                        type = "header",
                        order = 20,
                    },
                    glowSize = {
                        name = "Glow Size",
                        type = "range",
                        min = 2, max = 20, step = 1,
                        order = 21,
                        get = function() return db.threat.glowSize end,
                        set = function(_, val) db.threat.glowSize = val end,
                    },
                    glowAlpha = {
                        name = "Glow Opacity",
                        type = "range",
                        min = 0.1, max = 1.0, step = 0.05,
                        order = 22,
                        get = function() return db.threat.glowAlpha end,
                        set = function(_, val) db.threat.glowAlpha = val end,
                    },
                },
            },

            --------------------------------------------------------
            -- TARGET TAB
            --------------------------------------------------------
            targetOpts = {
                name = "Target Highlight",
                type = "group",
                order = 6,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    enabled = {
                        name = "Enable Target Highlight",
                        type = "toggle",
                        order = 0,
                        get = function() return db.target.enabled end,
                        set = function(_, val)
                            db.target.enabled = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    borderColor = {
                        name = "Target Border Color",
                        type = "color",
                        hasAlpha = true,
                        order = 1,
                        get = function()
                            local c = db.target.borderColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.target.borderColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    scale = {
                        name = "Target Scale",
                        type = "range",
                        min = 0.5, max = 2.5, step = 0.05,
                        order = 2,
                        get = function() return db.target.scale end,
                        set = function(_, val)
                            db.target.scale = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    nonTargetAlpha = {
                        name = "Non-Target Alpha",
                        type = "range",
                        min = 0.1, max = 1.0, step = 0.05,
                        order = 3,
                        get = function() return db.target.nonTargetAlpha end,
                        set = function(_, val)
                            db.target.nonTargetAlpha = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                },
            },

            --------------------------------------------------------
            -- PROFILES TAB (AceDBOptions)
            --------------------------------------------------------
            profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(Addon.db),
        },
    }

    options.args.profiles.order = 99
    return options
end

----------------------------------------------------------------------
-- Register Config
----------------------------------------------------------------------
function Addon:SetupConfig()
    AceConfig:RegisterOptionsTable(ADDON_NAME, GetOptions)
    AceConfigDialog:AddToBlizOptions(ADDON_NAME, "ThreatPlates Remake")
end

----------------------------------------------------------------------
-- Preview Modal — large draggable window with live nameplate preview
-- Auto-refreshes every 0.3s while visible so changes appear instantly
----------------------------------------------------------------------
local previewFrame = nil

function Addon:TogglePreview()
    if previewFrame and previewFrame:IsShown() then
        previewFrame:Hide()
        return
    end
    if not previewFrame then
        self:CreatePreviewFrame()
    end
    self:RefreshPreview()
    previewFrame:Show()
end

function Addon:RefreshPreview()
    if not previewFrame or not previewFrame:IsShown() then return end
    local db = self.db.profile

    -- Health bar geometry
    local width = db.healthbar.width or 120
    local height = db.healthbar.height or 12
    local borderSize = db.healthbar.borderSize or 1
    local outerSize = db.healthbar.outerBorderSize or 2
    local totalBorder = borderSize + outerSize
    local bc = db.healthbar.borderColor or { r = 0, g = 0, b = 0, a = 1 }
    local obc = db.healthbar.outerBorderColor or { r = 1, g = 1, b = 1, a = 1 }

    local bg = previewFrame.hpBg
    bg:SetSize(width + totalBorder * 2, height + totalBorder * 2)
    bg.outerBorderTex:SetColorTexture(obc.r, obc.g, obc.b, obc.a)
    bg.borderTex:ClearAllPoints()
    bg.borderTex:SetPoint("TOPLEFT", bg, "TOPLEFT", outerSize, -outerSize)
    bg.borderTex:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -outerSize, outerSize)
    bg.borderTex:SetColorTexture(bc.r, bc.g, bc.b, bc.a)

    local bar = previewFrame.hp
    bar:ClearAllPoints()
    bar:SetPoint("TOPLEFT", bg, "TOPLEFT", totalBorder, -totalBorder)
    bar:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -totalBorder, totalBorder)
    bar:SetStatusBarTexture(TPR.ResolveTexture(db.healthbar.texture))
    bar:SetStatusBarColor(1, 0, 0, 1)
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(65)

    local mhc = db.healthbar.missingHealthColor or { r = 0.05, g = 0.05, b = 0.05, a = 1 }
    bar.background:SetColorTexture(mhc.r, mhc.g, mhc.b, mhc.a)

    -- Fonts
    local fontPath = TPR.ResolveFont(db.healthbar.font)
    local flags = db.healthbar.fontFlags or "OUTLINE"
    bar.text:SetFont(fontPath, db.healthbar.fontSize or 9, flags)
    if db.healthbar.showText then
        local fmt = db.healthbar.textFormat or "PERCENT"
        if fmt == "PERCENT" then bar.text:SetText("65%")
        elseif fmt == "CURRENT" then bar.text:SetText("650K")
        elseif fmt == "CURRENT_PERCENT" then bar.text:SetText("650K - 65%")
        elseif fmt == "BOTH" then bar.text:SetText("650K / 1M")
        elseif fmt == "DEFICIT" then bar.text:SetText("-350K")
        else bar.text:SetText("") end
    else
        bar.text:SetText("")
    end

    previewFrame.level:SetFont(fontPath, 9, flags)
    if db.healthbar.showLevel then
        previewFrame.level:SetText("80")
        previewFrame.level:Show()
    else
        previewFrame.level:Hide()
    end

    previewFrame.name:SetFont(fontPath, db.healthbar.fontSize or 10, flags)

    -- Cast bar
    local cbBg = previewFrame.castBg
    local cbWidth = db.castbar.width or 120
    local cbHeight = db.castbar.height or 10
    cbBg:ClearAllPoints()
    cbBg:SetSize(cbWidth + 2, cbHeight + 2)
    cbBg:SetPoint("TOP", bg, "BOTTOM", 0, db.castbar.yOffset or -2)

    local cb = previewFrame.castbar
    cb:SetSize(cbWidth, cbHeight)
    cb:SetStatusBarTexture(TPR.ResolveTexture(db.castbar.texture))
    local cc = db.castbar.normalColor or { r = 1, g = 0.7, b = 0 }
    cb:SetStatusBarColor(cc.r, cc.g, cc.b, 1)
    cb:SetMinMaxValues(0, 100)
    cb:SetValue(45)

    local cbFont = TPR.ResolveFont(db.castbar.font)
    local cbFlags = db.castbar.fontFlags or "OUTLINE"
    cb.spellName:SetFont(cbFont, db.castbar.fontSize or 8, cbFlags)
    cb.timer:SetFont(cbFont, db.castbar.fontSize or 8, cbFlags)
    if db.castbar.showSpellName then cb.spellName:SetText("Fireball"); cb.spellName:Show()
    else cb.spellName:Hide() end
    if db.castbar.showTimer then cb.timer:SetText("1.2"); cb.timer:Show()
    else cb.timer:Hide() end

    if db.castbar.enabled then cbBg:Show() else cbBg:Hide() end

    -- Aura preview icons
    local auraSize = db.auras.iconSize or 22
    local auraSpacing = db.auras.iconSpacing or 2
    local maxAuras = db.auras.maxAuras or 5
    local showAuras = db.auras.enabled and db.auras.showDebuffs
    local auraFont = TPR.ResolveFont(db.auras.font)
    for i = 1, 5 do
        local icon = previewFrame.auraIcons[i]
        if showAuras and i <= maxAuras then
            icon:SetSize(auraSize, auraSize)
            icon:ClearAllPoints()
            local totalW = (maxAuras * auraSize) + ((maxAuras - 1) * auraSpacing)
            local startX = -totalW / 2
            icon:SetPoint("LEFT", previewFrame.auraAnchor, "CENTER", startX + (i - 1) * (auraSize + auraSpacing), 0)
            icon.border:ClearAllPoints()
            icon.border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
            icon.border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
            icon.duration:SetFont(auraFont, db.auras.durationFontSize or 8, "OUTLINE")
            if db.auras.showDuration then icon.duration:Show() else icon.duration:Hide() end
            icon.stacks:SetFont(auraFont, db.auras.fontSize or 8, "OUTLINE")
            icon:Show()
        else
            icon:Hide()
        end
    end
end

function Addon:CreatePreviewFrame()
    local f = CreateFrame("Frame", "TPRPreviewWindow", UIParent)
    f:SetSize(500, 300)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
    f:SetFrameStrata("FULLSCREEN_DIALOG")
    f:SetFrameLevel(100)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    -- Dark semi-transparent background
    local backdrop = f:CreateTexture(nil, "BACKGROUND")
    backdrop:SetAllPoints(f)
    backdrop:SetColorTexture(0.08, 0.08, 0.08, 0.95)

    -- Bright border around the modal
    local borderTop = f:CreateTexture(nil, "BORDER")
    borderTop:SetHeight(1)
    borderTop:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
    borderTop:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
    borderTop:SetColorTexture(0.4, 0.4, 0.4, 1)

    local borderBot = f:CreateTexture(nil, "BORDER")
    borderBot:SetHeight(1)
    borderBot:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
    borderBot:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
    borderBot:SetColorTexture(0.4, 0.4, 0.4, 1)

    local borderLeft = f:CreateTexture(nil, "BORDER")
    borderLeft:SetWidth(1)
    borderLeft:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
    borderLeft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
    borderLeft:SetColorTexture(0.4, 0.4, 0.4, 1)

    local borderRight = f:CreateTexture(nil, "BORDER")
    borderRight:SetWidth(1)
    borderRight:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
    borderRight:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
    borderRight:SetColorTexture(0.4, 0.4, 0.4, 1)

    -- Title bar
    local titleBar = f:CreateTexture(nil, "ARTWORK")
    titleBar:SetHeight(28)
    titleBar:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
    titleBar:SetColorTexture(0.15, 0.15, 0.15, 1)

    local title = f:CreateFontString(nil, "OVERLAY")
    title:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE")
    title:SetPoint("LEFT", titleBar, "LEFT", 10, 0)
    title:SetText("|cff00ff00ThreatPlates|r |cffffffffLive Preview|r")

    -- Close X button
    local close = CreateFrame("Button", nil, f)
    close:SetSize(28, 28)
    close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
    close:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    local closeTex = close:CreateFontString(nil, "OVERLAY")
    closeTex:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
    closeTex:SetPoint("CENTER", close, "CENTER", 0, 0)
    closeTex:SetText("|cffff4444X|r")
    close:SetScript("OnClick", function() f:Hide() end)

    -- Hint text at bottom
    local hint = f:CreateFontString(nil, "OVERLAY")
    hint:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
    hint:SetPoint("BOTTOM", f, "BOTTOM", 0, 8)
    hint:SetTextColor(0.5, 0.5, 0.5, 1)
    hint:SetText("Changes update automatically  |  Drag to move")

    -- Container for the fake nameplate (centered)
    local container = CreateFrame("Frame", nil, f)
    container:SetSize(300, 150)
    container:SetPoint("CENTER", f, "CENTER", 0, -10)

    -- Aura anchor (above health bar)
    local auraAnchor = CreateFrame("Frame", nil, container)
    auraAnchor:SetSize(200, 30)
    auraAnchor:SetPoint("BOTTOM", container, "CENTER", 0, 45)
    f.auraAnchor = auraAnchor

    -- Sample aura icons
    local sampleIcons = {
        "Interface\\Icons\\Spell_Fire_FlameBolt",
        "Interface\\Icons\\Spell_Nature_Lightning",
        "Interface\\Icons\\Spell_Shadow_ShadowBolt",
        "Interface\\Icons\\Spell_Holy_MagicSentry",
        "Interface\\Icons\\Spell_Frost_FrostBolt02",
    }
    f.auraIcons = {}
    for i = 1, 5 do
        local icon = CreateFrame("Frame", nil, auraAnchor)
        icon:SetSize(22, 22)

        icon.border = icon:CreateTexture(nil, "BACKGROUND")
        icon.border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
        icon.border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
        icon.border:SetColorTexture(0, 0, 0, 1)

        icon.texture = icon:CreateTexture(nil, "ARTWORK")
        icon.texture:SetAllPoints(icon)
        icon.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        icon.texture:SetTexture(sampleIcons[i])

        icon.duration = icon:CreateFontString(nil, "OVERLAY")
        icon.duration:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
        icon.duration:SetPoint("TOPRIGHT", icon, "TOPRIGHT", 2, 2)
        icon.duration:SetTextColor(1, 1, 1, 1)
        icon.duration:SetText(tostring(math.random(2, 15)))

        icon.stacks = icon:CreateFontString(nil, "OVERLAY")
        icon.stacks:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
        icon.stacks:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
        icon.stacks:SetTextColor(1, 1, 1, 1)
        if i == 1 then icon.stacks:SetText("3") else icon.stacks:SetText("") end

        f.auraIcons[i] = icon
    end

    -- Name text
    local name = container:CreateFontString(nil, "OVERLAY")
    name:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    name:SetPoint("BOTTOM", auraAnchor, "TOP", 0, 2)
    name:SetTextColor(1, 0.2, 0.2, 1)
    name:SetText("Withered Hungerer")
    f.name = name

    -- Health bar outer border bg
    local hpBg = CreateFrame("Frame", nil, container)
    hpBg:SetSize(124, 16)
    hpBg:SetPoint("TOP", auraAnchor, "BOTTOM", 0, -2)

    local outerBorderTex = hpBg:CreateTexture(nil, "BACKGROUND", nil, -7)
    outerBorderTex:SetAllPoints(hpBg)
    outerBorderTex:SetColorTexture(1, 1, 1, 1)
    hpBg.outerBorderTex = outerBorderTex

    local borderTex = hpBg:CreateTexture(nil, "BACKGROUND", nil, -6)
    borderTex:SetPoint("TOPLEFT", hpBg, "TOPLEFT", 2, -2)
    borderTex:SetPoint("BOTTOMRIGHT", hpBg, "BOTTOMRIGHT", -2, 2)
    borderTex:SetColorTexture(0, 0, 0, 1)
    hpBg.borderTex = borderTex
    f.hpBg = hpBg

    -- Health bar
    local hp = CreateFrame("StatusBar", nil, hpBg)
    hp:SetPoint("TOPLEFT", hpBg, "TOPLEFT", 3, -3)
    hp:SetPoint("BOTTOMRIGHT", hpBg, "BOTTOMRIGHT", -3, 3)
    hp:SetFrameLevel(hpBg:GetFrameLevel() + 1)
    hp:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    hp:SetStatusBarColor(1, 0, 0, 1)
    hp:SetMinMaxValues(0, 100)
    hp:SetValue(65)

    local hpBgTex = hp:CreateTexture(nil, "BACKGROUND")
    hpBgTex:SetDrawLayer("BACKGROUND", -6)
    hpBgTex:SetAllPoints(hp)
    hpBgTex:SetColorTexture(0.05, 0.05, 0.05, 1)
    hp.background = hpBgTex

    local hpText = hp:CreateFontString(nil, "OVERLAY")
    hpText:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
    hpText:SetPoint("CENTER", hp, "CENTER", 0, 0)
    hpText:SetTextColor(1, 1, 1, 1)
    hp.text = hpText
    f.hp = hp

    -- Level text
    local level = hp:CreateFontString(nil, "OVERLAY")
    level:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
    level:SetPoint("RIGHT", hp, "RIGHT", -2, 0)
    level:SetTextColor(1, 1, 1, 1)
    f.level = level

    -- Cast bar bg
    local cbBg = CreateFrame("Frame", nil, container)
    cbBg:SetSize(122, 12)
    cbBg:SetPoint("TOP", hpBg, "BOTTOM", 0, -2)

    local cbBorderTex = cbBg:CreateTexture(nil, "BACKGROUND")
    cbBorderTex:SetAllPoints(cbBg)
    cbBorderTex:SetColorTexture(0, 0, 0, 1)
    f.castBg = cbBg

    -- Cast bar
    local cb = CreateFrame("StatusBar", nil, cbBg)
    cb:SetSize(120, 10)
    cb:SetPoint("CENTER", cbBg, "CENTER", 0, 0)
    cb:SetFrameLevel(cbBg:GetFrameLevel() + 1)
    cb:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    cb:SetStatusBarColor(1, 0.7, 0, 1)
    cb:SetMinMaxValues(0, 100)
    cb:SetValue(45)

    local cbBarBg = cb:CreateTexture(nil, "BACKGROUND")
    cbBarBg:SetDrawLayer("BACKGROUND", -6)
    cbBarBg:SetAllPoints(cb)
    cbBarBg:SetColorTexture(0.15, 0.15, 0.15, 0.85)

    local spellName = cb:CreateFontString(nil, "OVERLAY")
    spellName:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
    spellName:SetPoint("LEFT", cb, "LEFT", 2, 0)
    spellName:SetJustifyH("LEFT")
    spellName:SetTextColor(1, 1, 1, 1)
    cb.spellName = spellName

    local timer = cb:CreateFontString(nil, "OVERLAY")
    timer:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
    timer:SetPoint("RIGHT", cb, "RIGHT", -2, 0)
    timer:SetJustifyH("RIGHT")
    timer:SetTextColor(1, 1, 1, 1)
    cb.timer = timer
    f.castbar = cb

    -- Auto-refresh ticker: update preview every 0.3s while visible
    f:SetScript("OnUpdate", function(self, elapsed)
        self._elapsed = (self._elapsed or 0) + elapsed
        if self._elapsed < 0.3 then return end
        self._elapsed = 0
        Addon:RefreshPreview()
    end)

    previewFrame = f
end
