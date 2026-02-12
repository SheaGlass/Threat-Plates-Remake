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
                    spacer4 = { name = "", type = "description", order = 3.8 },
                    applyGreyMinimal = {
                        name = "Grey - Minimal",
                        desc = TPR.Presets.grey_minimal.desc,
                        type = "execute",
                        order = 4,
                        width = "full",
                        func = function() Addon:ApplyPreset("grey_minimal") end,
                        confirm = true,
                        confirmText = "Apply the Grey - Minimal preset?\nThis will overwrite your current settings.",
                    },
                    greyMinimalDesc = {
                        name = "|cff888888" .. TPR.Presets.grey_minimal.desc .. "|r",
                        type = "description",
                        order = 4.5,
                    },
                    spacer5 = { name = "", type = "description", order = 4.8 },
                    applyGrey = {
                        name = "Grey",
                        desc = TPR.Presets.grey.desc,
                        type = "execute",
                        order = 5,
                        width = "full",
                        func = function() Addon:ApplyPreset("grey") end,
                        confirm = true,
                        confirmText = "Apply the Grey preset?\nThis will overwrite your current settings.",
                    },
                    greyDesc = {
                        name = "|cff888888" .. TPR.Presets.grey.desc .. "|r",
                        type = "description",
                        order = 5.5,
                    },
                    spacer6 = { name = "", type = "description", order = 5.8 },
                    applyNeon = {
                        name = "Neon",
                        desc = TPR.Presets.neon.desc,
                        type = "execute",
                        order = 6,
                        width = "full",
                        func = function() Addon:ApplyPreset("neon") end,
                        confirm = true,
                        confirmText = "Apply the Neon preset?\nThis will overwrite your current settings.",
                    },
                    neonDesc = {
                        name = "|cff888888" .. TPR.Presets.neon.desc .. "|r",
                        type = "description",
                        order = 6.5,
                    },
                    spacer7 = { name = "", type = "description", order = 6.8 },
                    applyDark = {
                        name = "Dark",
                        desc = TPR.Presets.dark.desc,
                        type = "execute",
                        order = 7,
                        width = "full",
                        func = function() Addon:ApplyPreset("dark") end,
                        confirm = true,
                        confirmText = "Apply the Dark preset?\nThis will overwrite your current settings.",
                    },
                    darkDesc = {
                        name = "|cff888888" .. TPR.Presets.dark.desc .. "|r",
                        type = "description",
                        order = 7.5,
                    },
                    spacer8 = { name = "", type = "description", order = 7.8 },
                    applyHealer = {
                        name = "Healer",
                        desc = TPR.Presets.healer.desc,
                        type = "execute",
                        order = 8,
                        width = "full",
                        func = function() Addon:ApplyPreset("healer") end,
                        confirm = true,
                        confirmText = "Apply the Healer preset?\nThis will overwrite your current settings.",
                    },
                    healerDesc = {
                        name = "|cff888888" .. TPR.Presets.healer.desc .. "|r",
                        type = "description",
                        order = 8.5,
                    },
                    spacer9 = { name = "", type = "description", order = 8.8 },
                    applyStriped = {
                        name = "Striped",
                        desc = TPR.Presets.striped.desc,
                        type = "execute",
                        order = 9,
                        width = "full",
                        func = function() Addon:ApplyPreset("striped") end,
                        confirm = true,
                        confirmText = "Apply the Striped preset?\nThis will overwrite your current settings.",
                    },
                    stripedDesc = {
                        name = "|cff888888" .. TPR.Presets.striped.desc .. "|r",
                        type = "description",
                        order = 9.5,
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
                    previewBtn = MakePreviewButton(-1),
                    nameplateRange = {
                        name = "Nameplate Range",
                        desc = "Maximum distance at which nameplates are visible.",
                        type = "range",
                        min = 20, max = 100, step = 0.5,
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
                        min = 50, max = 300, step = 0.5,
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
                        min = 4, max = 40, step = 0.5,
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
                        min = 6, max = 24, step = 0.5,
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
                        min = 6, max = 24, step = 0.5,
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
                        min = 50, max = 300, step = 0.5,
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
                        min = 4, max = 30, step = 0.5,
                        order = 3,
                        get = function() return db.castbar.height end,
                        set = function(_, val)
                            db.castbar.height = val
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
                        min = 6, max = 20, step = 0.5,
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
                        min = 8, max = 30, step = 0.5,
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
                        min = 1, max = 10, step = 1, -- integer only
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
                        min = 10, max = 40, step = 0.5,
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
                        min = 0, max = 10, step = 0.1,
                        order = 12,
                        get = function() return db.auras.iconSpacing end,
                        set = function(_, val) db.auras.iconSpacing = val end,
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
                        min = 6, max = 20, step = 0.5,
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
                        min = 6, max = 16, step = 0.5,
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
                        min = 0, max = 4, step = 0.1,
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
                        min = 2, max = 20, step = 0.5,
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
            -- COMBO POINTS TAB
            --------------------------------------------------------
            comboPoints = {
                name = "Combo Points",
                type = "group",
                order = 7,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    enabled = {
                        name = "Enable Combo Points",
                        desc = "Show combo points, holy power, chi, arcane charges, soul shards, or essence on the target's nameplate.",
                        type = "toggle",
                        order = 0,
                        width = "full",
                        get = function() return db.comboPoints.enabled end,
                        set = function(_, val)
                            db.comboPoints.enabled = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    posHeader = {
                        name = "Position",
                        type = "header",
                        order = 1,
                    },
                    sizeHeader = {
                        name = "Size & Style",
                        type = "header",
                        order = 10,
                    },
                    iconSize = {
                        name = "Point Size",
                        type = "range",
                        min = 4, max = 20, step = 0.5,
                        order = 11,
                        get = function() return db.comboPoints.iconSize end,
                        set = function(_, val)
                            db.comboPoints.iconSize = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    iconSpacing = {
                        name = "Point Spacing",
                        type = "range",
                        min = 0, max = 10, step = 0.1,
                        order = 12,
                        get = function() return db.comboPoints.iconSpacing end,
                        set = function(_, val)
                            db.comboPoints.iconSpacing = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    behaviorHeader = {
                        name = "Behavior",
                        type = "header",
                        order = 15,
                    },
                    showOnTargetOnly = {
                        name = "Show on Target Only",
                        desc = "Only display combo points on your current target's nameplate.",
                        type = "toggle",
                        order = 16,
                        get = function() return db.comboPoints.showOnTargetOnly end,
                        set = function(_, val)
                            db.comboPoints.showOnTargetOnly = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    colorHeader = {
                        name = "Colors",
                        type = "header",
                        order = 20,
                    },
                    useClassColors = {
                        name = "Use Class Colors",
                        desc = "Use class-specific colors for filled points (e.g., yellow for Rogue, gold for Paladin).",
                        type = "toggle",
                        order = 21,
                        get = function() return db.comboPoints.useClassColors end,
                        set = function(_, val)
                            db.comboPoints.useClassColors = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    activeColor = {
                        name = "Active Point Color",
                        desc = "Color for filled/active points (used when class colors are disabled).",
                        type = "color",
                        hasAlpha = true,
                        order = 22,
                        get = function()
                            local c = db.comboPoints.activeColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.comboPoints.activeColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                    inactiveColor = {
                        name = "Inactive Point Color",
                        desc = "Color for empty/inactive points.",
                        type = "color",
                        hasAlpha = true,
                        order = 23,
                        get = function()
                            local c = db.comboPoints.inactiveColor
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.comboPoints.inactiveColor = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                },
            },

            --------------------------------------------------------
            -- QUEST ICON TAB
            --------------------------------------------------------
            questIcon = {
                name = "Quest Icon",
                type = "group",
                order = 8,
                args = {
                    previewBtn = MakePreviewButton(-1),
                    enabled = {
                        name = "Enable Quest Icon",
                        desc = "Show a quest indicator icon on nameplates for quest-related mobs.",
                        type = "toggle",
                        order = 0,
                        width = "full",
                        get = function() return db.questIcon.enabled end,
                        set = function(_, val)
                            db.questIcon.enabled = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    styleHeader = {
                        name = "Style",
                        type = "header",
                        order = 5,
                    },
                    style = {
                        name = "Icon Style",
                        desc = "Choose the visual style of the quest indicator.",
                        type = "select",
                        order = 6,
                        values = (function()
                            local v = {}
                            for _, s in ipairs(TPR.QuestIconStyles) do
                                v[s.key] = s.name
                            end
                            return v
                        end)(),
                        get = function() return db.questIcon.style or "classic" end,
                        set = function(_, val)
                            db.questIcon.style = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    positionHeader = {
                        name = "Position",
                        type = "header",
                        order = 8,
                    },
                    position = {
                        name = "Icon Position",
                        desc = "Where to place the quest icon relative to the health bar.",
                        type = "select",
                        order = 9,
                        values = {
                            LEFT = "Left",
                            RIGHT = "Right",
                            ABOVE = "Above",
                            BELOW = "Below",
                        },
                        get = function() return db.questIcon.position or "LEFT" end,
                        set = function(_, val)
                            db.questIcon.position = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    sizeHeader = {
                        name = "Size",
                        type = "header",
                        order = 10,
                    },
                    size = {
                        name = "Icon Size",
                        desc = "Size of the quest indicator icon in pixels.",
                        type = "range",
                        min = 8, max = 48, step = 1,
                        order = 11,
                        get = function() return db.questIcon.size end,
                        set = function(_, val)
                            db.questIcon.size = val
                            Addon:RefreshAllPlates()
                        end,
                    },
                    colorHeader = {
                        name = "Color",
                        type = "header",
                        order = 15,
                    },
                    useCustomColor = {
                        name = "Use Custom Color Tint",
                        desc = "Apply a custom color tint to the quest icon. When disabled, the icon uses its natural colors.",
                        type = "toggle",
                        order = 16,
                        get = function() return db.questIcon.color ~= nil end,
                        set = function(_, val)
                            if val then
                                db.questIcon.color = { r = 1, g = 1, b = 0, a = 1 }
                            else
                                db.questIcon.color = nil
                            end
                            Addon:RefreshAllPlates()
                        end,
                    },
                    color = {
                        name = "Icon Color",
                        desc = "Custom color tint for the quest icon.",
                        type = "color",
                        hasAlpha = true,
                        order = 17,
                        disabled = function() return db.questIcon.color == nil end,
                        get = function()
                            local c = db.questIcon.color or { r = 1, g = 1, b = 0, a = 1 }
                            return c.r, c.g, c.b, c.a
                        end,
                        set = function(_, r, g, b, a)
                            db.questIcon.color = { r = r, g = g, b = b, a = a }
                            Addon:RefreshAllPlates()
                        end,
                    },
                },
            },

            --------------------------------------------------------
            -- LAYOUT TAB (absolute positioning, dual state)
            --------------------------------------------------------
            layout = {
                name = "Layout",
                type = "group",
                order = 9,
                args = {
                    desc = {
                        name = "Position each element freely. All positions are pixel offsets from the nameplate center.\nTwo layout states: |cff00ff00Default|r (no cast) and |cffffaa00Casting|r (cast bar visible).",
                        type = "description",
                        order = 0,
                        fontSize = "medium",
                    },
                    layoutMode = {
                        name = "  Toggle Layout Mode (Drag & Drop)  ",
                        desc = "Enter layout mode to drag nameplate elements and reposition them visually.",
                        type = "execute",
                        order = 0.3,
                        width = "full",
                        func = function()
                            Addon:ToggleLayoutMode()
                        end,
                    },
                    layoutSpacer = { name = "", type = "description", order = 0.4 },
                    editState = {
                        name = "Editing State",
                        desc = "Choose which layout state to edit. 'Default' is used when the mob is not casting. 'Casting' is used when the cast bar is visible.",
                        type = "select",
                        order = 0.5,
                        width = "normal",
                        values = { default = "Default (No Cast)", casting = "Casting" },
                        get = function() return layoutEditState end,
                        set = function(_, v) layoutEditState = v end,
                    },
                    stateSpacer = { name = "", type = "description", order = 0.6 },
                    copyState = {
                        name = "Copy Default → Casting",
                        desc = "Copy all Default positions into the Casting state.",
                        type = "execute",
                        order = 0.7,
                        width = "normal",
                        func = function()
                            local src = db.layout.default
                            for key, pos in pairs(src) do
                                db.layout.casting[key] = { x = pos.x, y = pos.y }
                            end
                            Addon:RefreshAllPlates()
                        end,
                        confirm = true,
                        confirmText = "Copy all Default positions to Casting? This will overwrite Casting positions.",
                    },
                    -- Health Bar
                    hbHeader = { name = "Health Bar", type = "header", order = 1 },
                    hbX = {
                        name = "X", type = "range", order = 1.1,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].healthbar and db.layout[layoutEditState].healthbar.x) or 0 end,
                        set = function(_, v) db.layout[layoutEditState].healthbar.x = v; Addon:RefreshAllPlates() end,
                    },
                    hbY = {
                        name = "Y", type = "range", order = 1.2,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].healthbar and db.layout[layoutEditState].healthbar.y) or 0 end,
                        set = function(_, v) db.layout[layoutEditState].healthbar.y = v; Addon:RefreshAllPlates() end,
                    },
                    -- Name Text
                    ntHeader = { name = "Name Text", type = "header", order = 2 },
                    ntX = {
                        name = "X", type = "range", order = 2.1,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].nameText and db.layout[layoutEditState].nameText.x) or 0 end,
                        set = function(_, v) db.layout[layoutEditState].nameText.x = v; Addon:RefreshAllPlates() end,
                    },
                    ntY = {
                        name = "Y", type = "range", order = 2.2,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].nameText and db.layout[layoutEditState].nameText.y) or 12 end,
                        set = function(_, v) db.layout[layoutEditState].nameText.y = v; Addon:RefreshAllPlates() end,
                    },
                    -- Auras
                    aHeader = { name = "Auras", type = "header", order = 3 },
                    aX = {
                        name = "X", type = "range", order = 3.1,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].auras and db.layout[layoutEditState].auras.x) or 0 end,
                        set = function(_, v) db.layout[layoutEditState].auras.x = v; Addon:RefreshAllPlates() end,
                    },
                    aY = {
                        name = "Y", type = "range", order = 3.2,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].auras and db.layout[layoutEditState].auras.y) or 26 end,
                        set = function(_, v) db.layout[layoutEditState].auras.y = v; Addon:RefreshAllPlates() end,
                    },
                    -- Cast Bar
                    cbHeader = { name = "Cast Bar", type = "header", order = 4 },
                    cbX = {
                        name = "X", type = "range", order = 4.1,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].castbar and db.layout[layoutEditState].castbar.x) or 0 end,
                        set = function(_, v) db.layout[layoutEditState].castbar.x = v; Addon:RefreshAllPlates() end,
                    },
                    cbY = {
                        name = "Y", type = "range", order = 4.2,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].castbar and db.layout[layoutEditState].castbar.y) or -12 end,
                        set = function(_, v) db.layout[layoutEditState].castbar.y = v; Addon:RefreshAllPlates() end,
                    },
                    -- Combo Points
                    cpHeader = { name = "Combo Points", type = "header", order = 5 },
                    cpX = {
                        name = "X", type = "range", order = 5.1,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].comboPoints and db.layout[layoutEditState].comboPoints.x) or 0 end,
                        set = function(_, v) db.layout[layoutEditState].comboPoints.x = v; Addon:RefreshAllPlates() end,
                    },
                    cpY = {
                        name = "Y", type = "range", order = 5.2,
                        min = -100, max = 100, step = 0.5, width = "normal",
                        get = function() return (db.layout[layoutEditState] and db.layout[layoutEditState].comboPoints and db.layout[layoutEditState].comboPoints.y) or -26 end,
                        set = function(_, v) db.layout[layoutEditState].comboPoints.y = v; Addon:RefreshAllPlates() end,
                    },
                    -- Reset
                    resetHeader = { name = "", type = "header", order = 10 },
                    resetLayout = {
                        name = "Reset Current State Positions",
                        type = "execute",
                        order = 11,
                        width = "full",
                        func = function()
                            local defaults = {
                                healthbar   = { x = 0, y = 0 },
                                nameText    = { x = 0, y = 12 },
                                auras       = { x = 0, y = 26 },
                                castbar     = { x = 0, y = -12 },
                                comboPoints = { x = 0, y = -26 },
                            }
                            db.layout[layoutEditState] = defaults
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
local layoutEditState = "default" -- "default" or "casting" — which layout state is being edited
local layoutHandles = {}
local pendingLayout = nil -- temporary layout positions during drag mode (nil = use db directly)
local layoutSnapSize = 0  -- snap grid size in pixels (0 = off)
local layoutGridLines = {} -- grid line textures drawn on preview

function Addon:TogglePreview()
    if previewFrame and previewFrame:IsShown() then
        previewFrame:Hide()
        return
    end
    if not previewFrame then
        self:CreatePreviewFrame()
    end
    previewFrame:Show()
    self:RefreshPreview()
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

    -- Name text uses its own font settings
    local nt = db.healthbar.nameText or {}
    local nameFontPath = TPR.ResolveFont(nt.font)
    local nameFlags = nt.fontFlags or "OUTLINE"
    previewFrame.name:SetFont(nameFontPath, nt.fontSize or 10, nameFlags)
    local nc = nt.color or { r = 1, g = 1, b = 1, a = 1 }
    previewFrame.name:SetTextColor(nc.r, nc.g, nc.b, nc.a)
    local showName = (nt.show ~= false)
    if showName then previewFrame.name:Show() else previewFrame.name:Hide() end

    -- Cast bar appearance (positioning done below in stacking section)
    local cbBg = previewFrame.castBg
    local cbWidth = db.castbar.width or 120
    local cbHeight = db.castbar.height or 10
    cbBg:SetSize(cbWidth + 2, cbHeight + 2)

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

    local showCastbar = db.castbar.enabled
    if showCastbar then cbBg:Show() else cbBg:Hide() end

    -- Aura appearance (positioning done below in stacking section)
    local auraSize = db.auras.iconSize or 22
    local auraSpacing = db.auras.iconSpacing or 2
    local maxAuras = db.auras.maxAuras or 5
    local showAuras = db.auras.enabled and db.auras.showDebuffs
    local auraFont = TPR.ResolveFont(db.auras.font)
    previewFrame.auraAnchor:SetSize((maxAuras * auraSize) + ((maxAuras - 1) * auraSpacing) + 4, auraSize + 4)
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

    -- Combo points appearance
    local cpDb = db.comboPoints or {}
    local cpSize = cpDb.iconSize or 8
    local cpSpacing = cpDb.iconSpacing or 2
    local cpEnabled = cpDb.enabled
    local sampleMax = 5
    local sampleCurrent = 3
    local activeC = cpDb.activeColor or { r = 1, g = 0.9, b = 0.2, a = 1 }
    local inactiveC = cpDb.inactiveColor or { r = 0.3, g = 0.3, b = 0.3, a = 0.5 }

    if previewFrame.comboIcons then
        local cpTotalW = (sampleMax * cpSize) + ((sampleMax - 1) * cpSpacing)
        local cpStartX = -cpTotalW / 2
        previewFrame.comboAnchor:SetSize(cpTotalW + 4, cpSize + 4)

        for i = 1, 7 do
            local ci = previewFrame.comboIcons[i]
            if cpEnabled and i <= sampleMax then
                ci:SetSize(cpSize, cpSize)
                ci:ClearAllPoints()
                ci:SetPoint("LEFT", previewFrame.comboAnchor, "CENTER", cpStartX + (i - 1) * (cpSize + cpSpacing), 0)
                ci.border:ClearAllPoints()
                ci.border:SetPoint("TOPLEFT", ci, "TOPLEFT", -1, 1)
                ci.border:SetPoint("BOTTOMRIGHT", ci, "BOTTOMRIGHT", 1, -1)
                if i <= sampleCurrent then
                    ci.fill:SetColorTexture(activeC.r, activeC.g, activeC.b, activeC.a or 1)
                else
                    ci.fill:SetColorTexture(inactiveC.r, inactiveC.g, inactiveC.b, inactiveC.a or 0.5)
                end
                ci:Show()
            else
                ci:Hide()
            end
        end
    end

    --------------------------------------------------------------------
    -- Layout — mirrors LayoutElements() from Core.lua
    -- Uses the currently selected editing state (default or casting)
    -- If pendingLayout exists (layout mode), use that instead
    --------------------------------------------------------------------
    local layoutTable = db.layout or {}
    local lay = pendingLayout or (layoutTable[layoutEditState] or layoutTable.default or {})
    local cont = previewFrame.container

    -- Health bar
    local hb_l = lay.healthbar or { x = 0, y = 0 }
    bg:ClearAllPoints()
    bg:SetPoint("CENTER", cont, "CENTER", hb_l.x, hb_l.y)

    -- Name text
    if showName then
        local nt_l = lay.nameText or { x = 0, y = 12 }
        previewFrame.name:ClearAllPoints()
        previewFrame.name:SetPoint("CENTER", cont, "CENTER", nt_l.x, nt_l.y)
    end

    -- Auras
    if showAuras then
        local a_l = lay.auras or { x = 0, y = 26 }
        previewFrame.auraAnchor:ClearAllPoints()
        previewFrame.auraAnchor:SetPoint("CENTER", cont, "CENTER", a_l.x, a_l.y)
    end

    -- Cast bar
    if showCastbar then
        local cb_l = lay.castbar or { x = 0, y = -12 }
        cbBg:ClearAllPoints()
        cbBg:SetPoint("CENTER", cont, "CENTER", cb_l.x, cb_l.y)
    end

    -- Combo points
    if cpEnabled then
        local cp_l = lay.comboPoints or { x = 0, y = -26 }
        previewFrame.comboAnchor:ClearAllPoints()
        previewFrame.comboAnchor:SetPoint("CENTER", cont, "CENTER", cp_l.x, cp_l.y)
    else
        previewFrame.comboAnchor:ClearAllPoints()
        previewFrame.comboAnchor:SetPoint("CENTER", cont, "CENTER", 0, 200) -- park offscreen
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
    f.container = container

    -- Aura anchor (positioned by RefreshPreview stacking logic)
    local auraAnchor = CreateFrame("Frame", nil, container)
    auraAnchor:SetSize(200, 30)
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

    -- Name text (positioned by RefreshPreview stacking logic)
    local name = container:CreateFontString(nil, "OVERLAY")
    name:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    name:SetTextColor(1, 0.2, 0.2, 1)
    name:SetText("Withered Hungerer")
    f.name = name

    -- Health bar outer border bg (fixed center anchor — stacking builds around it)
    local hpBg = CreateFrame("Frame", nil, container)
    hpBg:SetSize(124, 16)
    hpBg:SetPoint("CENTER", container, "CENTER", 0, 0)

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

    -- Cast bar bg (positioned by RefreshPreview stacking logic)
    local cbBg = CreateFrame("Frame", nil, container)
    cbBg:SetSize(122, 12)

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

    -- Combo point preview icons (positioned by RefreshPreview stacking logic)
    local comboAnchor = CreateFrame("Frame", nil, container)
    comboAnchor:SetSize(200, 20)
    f.comboAnchor = comboAnchor

    f.comboIcons = {}
    for i = 1, 7 do
        local ci = CreateFrame("Frame", nil, comboAnchor)
        ci:SetSize(8, 8)

        ci.border = ci:CreateTexture(nil, "BACKGROUND")
        ci.border:SetPoint("TOPLEFT", ci, "TOPLEFT", -1, 1)
        ci.border:SetPoint("BOTTOMRIGHT", ci, "BOTTOMRIGHT", 1, -1)
        ci.border:SetColorTexture(0, 0, 0, 1)

        ci.fill = ci:CreateTexture(nil, "ARTWORK")
        ci.fill:SetAllPoints(ci)
        ci.fill:SetColorTexture(1, 0.9, 0.2, 1)

        ci:Hide()
        f.comboIcons[i] = ci
    end

    -- Auto-refresh ticker: update preview every 0.3s while visible
    -- (paused during layout mode to avoid fighting with drag positions)
    f:SetScript("OnUpdate", function(self, elapsed)
        if self._layoutMode then return end
        self._elapsed = (self._elapsed or 0) + elapsed
        if self._elapsed < 0.3 then return end
        self._elapsed = 0
        Addon:RefreshPreview()
    end)

    previewFrame = f
end

----------------------------------------------------------------------
-- Layout Mode — drag-and-drop element positioning
-- Makes preview elements draggable; saves offsets to DB on drop
----------------------------------------------------------------------
local function CreateDragHandle(container, anchorTo, labelText, width, height)
    -- container = always a Frame (previewFrame); anchorTo = the element to overlay
    local handle = CreateFrame("Frame", nil, container)
    handle:SetSize(width + 10, height + 10)
    handle:SetPoint("CENTER", anchorTo, "CENTER", 0, 0)
    handle:SetFrameLevel(container:GetFrameLevel() + 50)
    handle:SetMovable(true)
    handle:EnableMouse(true)
    handle:RegisterForDrag("LeftButton")

    -- Semi-transparent highlight overlay
    local overlay = handle:CreateTexture(nil, "OVERLAY")
    overlay:SetAllPoints(handle)
    overlay:SetColorTexture(0.2, 0.6, 1.0, 0.25)
    handle.overlay = overlay

    -- Bright border
    local bTop = handle:CreateTexture(nil, "OVERLAY", nil, 2)
    bTop:SetHeight(1)
    bTop:SetPoint("TOPLEFT", handle, "TOPLEFT", 0, 0)
    bTop:SetPoint("TOPRIGHT", handle, "TOPRIGHT", 0, 0)
    bTop:SetColorTexture(0.3, 0.7, 1.0, 0.8)

    local bBot = handle:CreateTexture(nil, "OVERLAY", nil, 2)
    bBot:SetHeight(1)
    bBot:SetPoint("BOTTOMLEFT", handle, "BOTTOMLEFT", 0, 0)
    bBot:SetPoint("BOTTOMRIGHT", handle, "BOTTOMRIGHT", 0, 0)
    bBot:SetColorTexture(0.3, 0.7, 1.0, 0.8)

    local bLeft = handle:CreateTexture(nil, "OVERLAY", nil, 2)
    bLeft:SetWidth(1)
    bLeft:SetPoint("TOPLEFT", handle, "TOPLEFT", 0, 0)
    bLeft:SetPoint("BOTTOMLEFT", handle, "BOTTOMLEFT", 0, 0)
    bLeft:SetColorTexture(0.3, 0.7, 1.0, 0.8)

    local bRight = handle:CreateTexture(nil, "OVERLAY", nil, 2)
    bRight:SetWidth(1)
    bRight:SetPoint("TOPRIGHT", handle, "TOPRIGHT", 0, 0)
    bRight:SetPoint("BOTTOMRIGHT", handle, "BOTTOMRIGHT", 0, 0)
    bRight:SetColorTexture(0.3, 0.7, 1.0, 0.8)

    -- Label
    local label = handle:CreateFontString(nil, "OVERLAY", nil, 3)
    label:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
    label:SetPoint("TOP", handle, "BOTTOM", 0, -1)
    label:SetTextColor(0.3, 0.8, 1.0, 1)
    label:SetText(labelText)

    handle:Hide()
    return handle
end

function Addon:ToggleLayoutMode()
    if not previewFrame then
        self:CreatePreviewFrame()
    end
    if not previewFrame:IsShown() then
        previewFrame:Show()
    end
    -- Always refresh positions before entering/exiting layout mode
    self:RefreshPreview()

    local isLayout = not previewFrame._layoutMode
    previewFrame._layoutMode = isLayout

    if isLayout then
        self:EnterLayoutMode()
    else
        self:ExitLayoutMode()
    end
end

----------------------------------------------------------------------
-- Sidebar Legend — toggle buttons for each element
----------------------------------------------------------------------
local sidebarFrame = nil

local function CreateSidebarToggle(parent, labelText, color, yPos, initialState, onToggle)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(130, 22)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, -yPos)

    -- Background
    local bgTex = btn:CreateTexture(nil, "BACKGROUND")
    bgTex:SetAllPoints(btn)
    btn.bgTex = bgTex

    -- Border
    local bTop = btn:CreateTexture(nil, "BORDER")
    bTop:SetHeight(1); bTop:SetPoint("TOPLEFT"); bTop:SetPoint("TOPRIGHT")
    bTop:SetColorTexture(color.r, color.g, color.b, 0.7)
    local bBot = btn:CreateTexture(nil, "BORDER")
    bBot:SetHeight(1); bBot:SetPoint("BOTTOMLEFT"); bBot:SetPoint("BOTTOMRIGHT")
    bBot:SetColorTexture(color.r, color.g, color.b, 0.7)
    local bLeft = btn:CreateTexture(nil, "BORDER")
    bLeft:SetWidth(1); bLeft:SetPoint("TOPLEFT"); bLeft:SetPoint("BOTTOMLEFT")
    bLeft:SetColorTexture(color.r, color.g, color.b, 0.7)
    local bRight = btn:CreateTexture(nil, "BORDER")
    bRight:SetWidth(1); bRight:SetPoint("TOPRIGHT"); bRight:SetPoint("BOTTOMRIGHT")
    bRight:SetColorTexture(color.r, color.g, color.b, 0.7)

    -- Color swatch
    local swatch = btn:CreateTexture(nil, "ARTWORK")
    swatch:SetSize(12, 12)
    swatch:SetPoint("LEFT", btn, "LEFT", 4, 0)
    swatch:SetColorTexture(color.r, color.g, color.b, 1)

    -- Label
    local text = btn:CreateFontString(nil, "OVERLAY")
    text:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    text:SetPoint("LEFT", swatch, "RIGHT", 4, 0)
    text:SetTextColor(1, 1, 1, 1)

    btn._enabled = initialState

    local function UpdateLabel()
        if btn._enabled then
            text:SetText("|cff00ff00ON|r  " .. labelText)
            bgTex:SetColorTexture(color.r, color.g, color.b, 0.3)
        else
            text:SetText("|cffff4444OFF|r " .. labelText)
            bgTex:SetColorTexture(0.2, 0.2, 0.2, 0.3)
        end
    end
    UpdateLabel()

    btn:SetScript("OnClick", function(self)
        self._enabled = not self._enabled
        UpdateLabel()
        onToggle(self._enabled)
    end)

    btn:SetScript("OnEnter", function(self)
        bgTex:SetColorTexture(color.r, color.g, color.b, 0.5)
    end)
    btn:SetScript("OnLeave", function(self)
        if self._enabled then
            bgTex:SetColorTexture(color.r, color.g, color.b, 0.3)
        else
            bgTex:SetColorTexture(0.2, 0.2, 0.2, 0.3)
        end
    end)

    return btn
end

local function CreateSidebar(parent)
    if sidebarFrame then return sidebarFrame end

    local sf = CreateFrame("Frame", nil, parent)
    sf:SetSize(148, 248)
    sf:SetPoint("TOPLEFT", parent, "TOPRIGHT", 2, 0)
    sf:SetFrameLevel(parent:GetFrameLevel() + 5)

    -- Background
    local bg = sf:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(sf)
    bg:SetColorTexture(0.08, 0.08, 0.08, 0.95)

    -- Border
    local bTop = sf:CreateTexture(nil, "BORDER")
    bTop:SetHeight(1); bTop:SetPoint("TOPLEFT"); bTop:SetPoint("TOPRIGHT")
    bTop:SetColorTexture(0.4, 0.4, 0.4, 1)
    local bBot = sf:CreateTexture(nil, "BORDER")
    bBot:SetHeight(1); bBot:SetPoint("BOTTOMLEFT"); bBot:SetPoint("BOTTOMRIGHT")
    bBot:SetColorTexture(0.4, 0.4, 0.4, 1)
    local bLeft = sf:CreateTexture(nil, "BORDER")
    bLeft:SetWidth(1); bLeft:SetPoint("TOPLEFT"); bLeft:SetPoint("BOTTOMLEFT")
    bLeft:SetColorTexture(0.4, 0.4, 0.4, 1)
    local bRight = sf:CreateTexture(nil, "BORDER")
    bRight:SetWidth(1); bRight:SetPoint("TOPRIGHT"); bRight:SetPoint("BOTTOMRIGHT")
    bRight:SetColorTexture(0.4, 0.4, 0.4, 1)

    -- Title
    local title = sf:CreateFontString(nil, "OVERLAY")
    title:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    title:SetPoint("TOP", sf, "TOP", 0, -8)
    title:SetTextColor(0.3, 0.8, 1.0, 1)
    title:SetText("Elements")

    -- Divider
    local div = sf:CreateTexture(nil, "ARTWORK")
    div:SetHeight(1)
    div:SetPoint("TOPLEFT", sf, "TOPLEFT", 6, -24)
    div:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -6, -24)
    div:SetColorTexture(0.3, 0.3, 0.3, 1)

    sf.toggles = {}
    sidebarFrame = sf
    return sf
end

----------------------------------------------------------------------
-- Enter / Exit Layout Mode
----------------------------------------------------------------------
function Addon:EnterLayoutMode()
    if not previewFrame then return end
    local db = self.db.profile

    -- Destroy old handles
    for _, h in ipairs(layoutHandles) do h:Hide() end
    layoutHandles = {}

    -- Ensure layout table exists with both states
    if not db.layout then db.layout = {} end
    for _, state in ipairs({"default", "casting"}) do
        if not db.layout[state] then db.layout[state] = {} end
        for _, k in ipairs({"healthbar", "nameText", "auras", "castbar", "comboPoints"}) do
            if not db.layout[state][k] then db.layout[state][k] = { x = 0, y = 0 } end
        end
    end

    -- Initialize pending layout as a deep copy of the current editing state
    local function DeepCopyLayout(src)
        local copy = {}
        for k, v in pairs(src) do
            copy[k] = { x = v.x, y = v.y }
        end
        return copy
    end
    pendingLayout = DeepCopyLayout(db.layout[layoutEditState])

    -- Track if changes were made (for unsaved warning)
    local hasUnsavedChanges = false

    -- Element definitions
    local elements = {
        {
            key = "healthbar",
            label = "Health Bar",
            color = { r = 0.8, g = 0.2, b = 0.2 },
            getAnchor = function() return previewFrame.hpBg end,
            getSize = function()
                return previewFrame.hpBg:GetWidth() or 124, previewFrame.hpBg:GetHeight() or 16
            end,
            saveDrag = function(dx, dy)
                local pos = pendingLayout.healthbar
                pos.x = pos.x + dx
                pos.y = pos.y + dy
                if layoutSnapSize > 0 then
                    pos.x = math.floor(pos.x / layoutSnapSize + 0.5) * layoutSnapSize
                    pos.y = math.floor(pos.y / layoutSnapSize + 0.5) * layoutSnapSize
                end
                hasUnsavedChanges = true
            end,
            isEnabled = function() return true end,
            alwaysOn = true,
        },
        {
            key = "name",
            label = "Name Text",
            color = { r = 0.2, g = 0.8, b = 0.2 },
            getAnchor = function() return previewFrame.name end,
            getSize = function()
                local w = previewFrame.name:GetStringWidth()
                local h = previewFrame.name:GetStringHeight()
                return (w and w > 10) and w or 80, (h and h > 5) and h or 14
            end,
            saveDrag = function(dx, dy)
                local pos = pendingLayout.nameText
                pos.x = pos.x + dx
                pos.y = pos.y + dy
                if layoutSnapSize > 0 then
                    pos.x = math.floor(pos.x / layoutSnapSize + 0.5) * layoutSnapSize
                    pos.y = math.floor(pos.y / layoutSnapSize + 0.5) * layoutSnapSize
                end
                hasUnsavedChanges = true
            end,
            setVisible = function(on)
                db.healthbar.nameText.show = on
                previewFrame._layoutMode = false
                Addon:RefreshPreview()
                previewFrame._layoutMode = true
            end,
            isEnabled = function() return db.healthbar.nameText.show ~= false end,
        },
        {
            key = "auras",
            label = "Auras",
            color = { r = 0.8, g = 0.3, b = 0.8 },
            getAnchor = function() return previewFrame.auraAnchor end,
            getSize = function()
                return previewFrame.auraAnchor:GetWidth() or 120, previewFrame.auraAnchor:GetHeight() or 30
            end,
            saveDrag = function(dx, dy)
                local pos = pendingLayout.auras
                pos.x = pos.x + dx
                pos.y = pos.y + dy
                if layoutSnapSize > 0 then
                    pos.x = math.floor(pos.x / layoutSnapSize + 0.5) * layoutSnapSize
                    pos.y = math.floor(pos.y / layoutSnapSize + 0.5) * layoutSnapSize
                end
                hasUnsavedChanges = true
            end,
            setVisible = function(on)
                db.auras.enabled = on
                previewFrame._layoutMode = false
                Addon:RefreshPreview()
                previewFrame._layoutMode = true
            end,
            isEnabled = function() return db.auras.enabled end,
        },
        {
            key = "castbar",
            label = "Cast Bar",
            color = { r = 1.0, g = 0.6, b = 0.0 },
            getAnchor = function() return previewFrame.castBg end,
            getSize = function()
                return previewFrame.castBg:GetWidth() or 122, previewFrame.castBg:GetHeight() or 12
            end,
            saveDrag = function(dx, dy)
                local pos = pendingLayout.castbar
                pos.x = pos.x + dx
                pos.y = pos.y + dy
                if layoutSnapSize > 0 then
                    pos.x = math.floor(pos.x / layoutSnapSize + 0.5) * layoutSnapSize
                    pos.y = math.floor(pos.y / layoutSnapSize + 0.5) * layoutSnapSize
                end
                hasUnsavedChanges = true
            end,
            setVisible = function(on)
                db.castbar.enabled = on
                previewFrame._layoutMode = false
                Addon:RefreshPreview()
                previewFrame._layoutMode = true
            end,
            isEnabled = function() return db.castbar.enabled end,
        },
        {
            key = "combo",
            label = "Combo Pts",
            color = { r = 1.0, g = 0.9, b = 0.2 },
            getAnchor = function() return previewFrame.comboAnchor end,
            getSize = function()
                return previewFrame.comboAnchor:GetWidth() or 80, previewFrame.comboAnchor:GetHeight() or 20
            end,
            saveDrag = function(dx, dy)
                local pos = pendingLayout.comboPoints
                pos.x = pos.x + dx
                pos.y = pos.y + dy
                if layoutSnapSize > 0 then
                    pos.x = math.floor(pos.x / layoutSnapSize + 0.5) * layoutSnapSize
                    pos.y = math.floor(pos.y / layoutSnapSize + 0.5) * layoutSnapSize
                end
                hasUnsavedChanges = true
            end,
            setVisible = function(on)
                db.comboPoints.enabled = on
                previewFrame._layoutMode = false
                Addon:RefreshPreview()
                previewFrame._layoutMode = true
            end,
            isEnabled = function() return db.comboPoints.enabled end,
        },
    }

    -- Delta-based drag helper (free positioning, writes to pendingLayout)
    local function MakeOnDragStop(handle, anchorTo, saveFunc)
        local startX, startY
        handle:SetScript("OnDragStart", function(self)
            startX, startY = self:GetCenter()
            self:StartMoving()
        end)
        handle:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
            local endX, endY = self:GetCenter()
            if startX and startY and endX and endY then
                local deltaX = endX - startX
                local deltaY = endY - startY
                saveFunc(deltaX, deltaY)
                -- Refresh preview to apply new positions (uses pendingLayout)
                previewFrame._layoutMode = false
                Addon:RefreshPreview()
                previewFrame._layoutMode = true
                -- Snap handle back onto element at new position
                self:ClearAllPoints()
                self:SetPoint("CENTER", anchorTo, "CENTER", 0, 0)
                -- NOTE: live nameplates NOT updated until Save is clicked
            end
        end)
    end

    -- Create sidebar
    local sidebar = CreateSidebar(previewFrame)
    -- Clear old toggle buttons
    if sidebar.toggles then
        for _, t in ipairs(sidebar.toggles) do t:Hide() end
    end
    sidebar.toggles = {}

    -- State toggle (Default / Casting) at top of sidebar
    local stateYPos = 30
    if not sidebar.stateLabel then
        sidebar.stateLabel = sidebar:CreateFontString(nil, "OVERLAY")
        sidebar.stateLabel:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
        sidebar.stateLabel:SetPoint("TOPLEFT", sidebar, "TOPLEFT", 10, -stateYPos)
        sidebar.stateLabel:SetTextColor(0.8, 0.8, 0.8, 1)
    end
    sidebar.stateLabel:SetText("State: |cff00ff00" .. (layoutEditState == "default" and "Default" or "Casting") .. "|r")
    sidebar.stateLabel:Show()

    if not sidebar.stateBtn then
        local stateBtn = CreateFrame("Button", nil, sidebar)
        stateBtn:SetSize(130, 18)
        stateBtn:SetPoint("TOPLEFT", sidebar, "TOPLEFT", 8, -(stateYPos + 14))
        local stateBg = stateBtn:CreateTexture(nil, "BACKGROUND")
        stateBg:SetAllPoints(stateBtn)
        stateBg:SetColorTexture(0.2, 0.4, 0.6, 0.4)
        local stateText = stateBtn:CreateFontString(nil, "OVERLAY")
        stateText:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
        stateText:SetPoint("CENTER")
        stateText:SetTextColor(0.5, 0.8, 1.0, 1)
        stateBtn._text = stateText
        stateBtn._bg = stateBg
        stateBtn:SetScript("OnClick", function()
            -- Switch editing state
            if layoutEditState == "default" then
                layoutEditState = "casting"
            else
                layoutEditState = "default"
            end
            -- Re-initialize pending layout from new state
            pendingLayout = DeepCopyLayout(db.layout[layoutEditState])
            hasUnsavedChanges = false
            sidebar.stateLabel:SetText("State: |cff00ff00" .. (layoutEditState == "default" and "Default" or "Casting") .. "|r")
            stateBtn._text:SetText("Switch to " .. (layoutEditState == "default" and "Casting" or "Default"))
            -- Refresh preview and re-anchor handles
            previewFrame._layoutMode = false
            Addon:RefreshPreview()
            previewFrame._layoutMode = true
            for j, handle in ipairs(layoutHandles) do
                local elem = elements[j]
                if elem then
                    handle:ClearAllPoints()
                    handle:SetPoint("CENTER", elem.getAnchor(), "CENTER", 0, 0)
                end
            end
        end)
        stateBtn:SetScript("OnEnter", function() stateBg:SetColorTexture(0.3, 0.5, 0.7, 0.5) end)
        stateBtn:SetScript("OnLeave", function() stateBg:SetColorTexture(0.2, 0.4, 0.6, 0.4) end)
        sidebar.stateBtn = stateBtn
    end
    sidebar.stateBtn._text:SetText("Switch to " .. (layoutEditState == "default" and "Casting" or "Default"))
    sidebar.stateBtn:Show()

    -- Divider after state toggle
    local elemStartY = stateYPos + 40

    -- Build handles and sidebar toggles for each element
    for i, elem in ipairs(elements) do
        local anchor = elem.getAnchor()
        local w, h = elem.getSize()

        -- Create drag handle with element-specific color
        local handle = CreateDragHandle(previewFrame, anchor, elem.label, w, h)
        handle.overlay:SetColorTexture(elem.color.r, elem.color.g, elem.color.b, 0.25)

        if elem.isEnabled() then
            handle:Show()
        end
        MakeOnDragStop(handle, anchor, elem.saveDrag)
        table.insert(layoutHandles, handle)

        -- Create sidebar toggle button (skip for always-on elements like health bar)
        if not elem.alwaysOn then
            local toggle = CreateSidebarToggle(sidebar, elem.label, elem.color,
                elemStartY + (i - 1) * 28, elem.isEnabled(), function(on)
                elem.setVisible(on)
                if on then
                    handle:ClearAllPoints()
                    handle:SetPoint("CENTER", elem.getAnchor(), "CENTER", 0, 0)
                    handle:Show()
                else
                    handle:Hide()
                end
            end)
            table.insert(sidebar.toggles, toggle)
        else
            -- Just show a non-interactive label for always-on elements
            local label = sidebar:CreateFontString(nil, "OVERLAY")
            label:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
            label:SetPoint("TOPLEFT", sidebar, "TOPLEFT", 10, -(elemStartY + (i - 1) * 28))
            label:SetTextColor(elem.color.r, elem.color.g, elem.color.b, 1)
            label:SetText(elem.label)
            table.insert(sidebar.toggles, label)
        end
    end

    -- Snap grid slider
    local snapYPos = elemStartY + #elements * 28 + 8
    if not sidebar.snapLabel then
        sidebar.snapLabel = sidebar:CreateFontString(nil, "OVERLAY")
        sidebar.snapLabel:SetFont("Fonts\\FRIZQT__.TTF", 9, "OUTLINE")
        sidebar.snapLabel:SetTextColor(0.7, 0.7, 0.7, 1)
    end
    sidebar.snapLabel:ClearAllPoints()
    sidebar.snapLabel:SetPoint("TOPLEFT", sidebar, "TOPLEFT", 10, -snapYPos)
    sidebar.snapLabel:SetText("Snap: " .. (layoutSnapSize > 0 and (layoutSnapSize .. "px") or "Off"))
    sidebar.snapLabel:Show()

    if not sidebar.snapMinus then
        local snapMinus = CreateFrame("Button", nil, sidebar)
        snapMinus:SetSize(22, 18)
        local smBg = snapMinus:CreateTexture(nil, "BACKGROUND")
        smBg:SetAllPoints(snapMinus)
        smBg:SetColorTexture(0.3, 0.3, 0.3, 0.5)
        local smText = snapMinus:CreateFontString(nil, "OVERLAY")
        smText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
        smText:SetPoint("CENTER")
        smText:SetText("-")
        snapMinus:SetScript("OnClick", function()
            layoutSnapSize = math.max(0, layoutSnapSize - 1)
            sidebar.snapLabel:SetText("Snap: " .. (layoutSnapSize > 0 and (layoutSnapSize .. "px") or "Off"))
            Addon:UpdateLayoutGrid()
        end)
        sidebar.snapMinus = snapMinus
    end
    sidebar.snapMinus:ClearAllPoints()
    sidebar.snapMinus:SetPoint("TOPLEFT", sidebar, "TOPLEFT", 80, -snapYPos)
    sidebar.snapMinus:Show()

    if not sidebar.snapPlus then
        local snapPlus = CreateFrame("Button", nil, sidebar)
        snapPlus:SetSize(22, 18)
        local spBg = snapPlus:CreateTexture(nil, "BACKGROUND")
        spBg:SetAllPoints(snapPlus)
        spBg:SetColorTexture(0.3, 0.3, 0.3, 0.5)
        local spText = snapPlus:CreateFontString(nil, "OVERLAY")
        spText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
        spText:SetPoint("CENTER")
        spText:SetText("+")
        snapPlus:SetScript("OnClick", function()
            layoutSnapSize = math.min(20, layoutSnapSize + 1)
            sidebar.snapLabel:SetText("Snap: " .. (layoutSnapSize > 0 and (layoutSnapSize .. "px") or "Off"))
            Addon:UpdateLayoutGrid()
        end)
        sidebar.snapPlus = snapPlus
    end
    sidebar.snapPlus:ClearAllPoints()
    sidebar.snapPlus:SetPoint("LEFT", sidebar.snapMinus, "RIGHT", 4, 0)
    sidebar.snapPlus:Show()

    -- Save button (green, prominent)
    local btnYFromBottom = 38
    if not sidebar.saveBtn then
        local saveBtn = CreateFrame("Button", nil, sidebar)
        saveBtn:SetSize(130, 24)

        local saveBg = saveBtn:CreateTexture(nil, "BACKGROUND")
        saveBg:SetAllPoints(saveBtn)
        saveBg:SetColorTexture(0.1, 0.4, 0.1, 0.6)
        saveBtn._bg = saveBg

        local saveBTop = saveBtn:CreateTexture(nil, "BORDER")
        saveBTop:SetHeight(1); saveBTop:SetPoint("TOPLEFT"); saveBTop:SetPoint("TOPRIGHT")
        saveBTop:SetColorTexture(0.2, 0.8, 0.2, 0.8)
        local saveBBot = saveBtn:CreateTexture(nil, "BORDER")
        saveBBot:SetHeight(1); saveBBot:SetPoint("BOTTOMLEFT"); saveBBot:SetPoint("BOTTOMRIGHT")
        saveBBot:SetColorTexture(0.2, 0.8, 0.2, 0.8)
        local saveBLeft = saveBtn:CreateTexture(nil, "BORDER")
        saveBLeft:SetWidth(1); saveBLeft:SetPoint("TOPLEFT"); saveBLeft:SetPoint("BOTTOMLEFT")
        saveBLeft:SetColorTexture(0.2, 0.8, 0.2, 0.8)
        local saveBRight = saveBtn:CreateTexture(nil, "BORDER")
        saveBRight:SetWidth(1); saveBRight:SetPoint("TOPRIGHT"); saveBRight:SetPoint("BOTTOMRIGHT")
        saveBRight:SetColorTexture(0.2, 0.8, 0.2, 0.8)

        local saveText = saveBtn:CreateFontString(nil, "OVERLAY")
        saveText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
        saveText:SetPoint("CENTER")
        saveText:SetTextColor(0.3, 1.0, 0.3, 1)
        saveText:SetText("Save Layout")

        saveBtn:SetScript("OnClick", function()
            -- Copy pendingLayout into db
            if pendingLayout then
                for k, v in pairs(pendingLayout) do
                    db.layout[layoutEditState][k] = { x = v.x, y = v.y }
                end
            end
            hasUnsavedChanges = false
            Addon:RefreshAllPlates()
            Addon:Print("Layout saved for '" .. layoutEditState .. "' state.")
        end)
        saveBtn:SetScript("OnEnter", function() saveBg:SetColorTexture(0.15, 0.5, 0.15, 0.7) end)
        saveBtn:SetScript("OnLeave", function() saveBg:SetColorTexture(0.1, 0.4, 0.1, 0.6) end)
        sidebar.saveBtn = saveBtn
    end
    sidebar.saveBtn:ClearAllPoints()
    sidebar.saveBtn:SetPoint("BOTTOMLEFT", sidebar, "BOTTOMLEFT", 8, btnYFromBottom)
    sidebar.saveBtn:Show()

    -- Reset offset button at bottom
    if not sidebar.resetBtn then
        local resetBtn = CreateFrame("Button", nil, sidebar)
        resetBtn:SetSize(130, 22)

        local resetBg = resetBtn:CreateTexture(nil, "BACKGROUND")
        resetBg:SetAllPoints(resetBtn)
        resetBg:SetColorTexture(0.5, 0.15, 0.15, 0.4)

        local resetBTop = resetBtn:CreateTexture(nil, "BORDER")
        resetBTop:SetHeight(1); resetBTop:SetPoint("TOPLEFT"); resetBTop:SetPoint("TOPRIGHT")
        resetBTop:SetColorTexture(0.8, 0.2, 0.2, 0.7)
        local resetBBot = resetBtn:CreateTexture(nil, "BORDER")
        resetBBot:SetHeight(1); resetBBot:SetPoint("BOTTOMLEFT"); resetBBot:SetPoint("BOTTOMRIGHT")
        resetBBot:SetColorTexture(0.8, 0.2, 0.2, 0.7)
        local resetBLeft = resetBtn:CreateTexture(nil, "BORDER")
        resetBLeft:SetWidth(1); resetBLeft:SetPoint("TOPLEFT"); resetBLeft:SetPoint("BOTTOMLEFT")
        resetBLeft:SetColorTexture(0.8, 0.2, 0.2, 0.7)
        local resetBRight = resetBtn:CreateTexture(nil, "BORDER")
        resetBRight:SetWidth(1); resetBRight:SetPoint("TOPRIGHT"); resetBRight:SetPoint("BOTTOMRIGHT")
        resetBRight:SetColorTexture(0.8, 0.2, 0.2, 0.7)

        local resetText = resetBtn:CreateFontString(nil, "OVERLAY")
        resetText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
        resetText:SetPoint("CENTER")
        resetText:SetTextColor(1, 0.4, 0.4, 1)
        resetText:SetText("Reset Offsets")
        sidebar.resetBtn = resetBtn
    end
    sidebar.resetBtn:SetScript("OnClick", function()
        -- Reset pending layout to defaults
        pendingLayout = {
            healthbar   = { x = 0, y = 0 },
            nameText    = { x = 0, y = 12 },
            auras       = { x = 0, y = 26 },
            castbar     = { x = 0, y = -12 },
            comboPoints = { x = 0, y = -26 },
        }
        hasUnsavedChanges = true
        previewFrame._layoutMode = false
        Addon:RefreshPreview()
        previewFrame._layoutMode = true
        -- Re-anchor all handles
        for j, handle in ipairs(layoutHandles) do
            local elem = elements[j]
            if elem then
                handle:ClearAllPoints()
                handle:SetPoint("CENTER", elem.getAnchor(), "CENTER", 0, 0)
            end
        end
    end)
    sidebar.resetBtn:ClearAllPoints()
    sidebar.resetBtn:SetPoint("BOTTOMLEFT", sidebar, "BOTTOMLEFT", 8, 8)
    sidebar.resetBtn:Show()

    -- Resize sidebar to fit all controls
    local sidebarHeight = elemStartY + #elements * 28 + 30 + 80 -- elements + snap + buttons
    if sidebarHeight < 300 then sidebarHeight = 300 end
    sidebar:SetSize(148, sidebarHeight)

    sidebar:Show()

    -- Draw grid lines if snap is active
    self:UpdateLayoutGrid()

    -- Layout mode hint text
    if not previewFrame._layoutHint then
        local hint = previewFrame:CreateFontString(nil, "OVERLAY")
        hint:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
        hint:SetPoint("BOTTOM", previewFrame, "BOTTOM", 0, 8)
        hint:SetTextColor(0.3, 1.0, 0.5, 1)
        previewFrame._layoutHint = hint
    end
    local stateLabel = layoutEditState == "default" and "|cff00ff00Default|r" or "|cffffaa00Casting|r"
    previewFrame._layoutHint:SetText("LAYOUT MODE (" .. stateLabel .. ")  |  Drag to reposition  |  Click Save when done")
    previewFrame._layoutHint:Show()
end

function Addon:ExitLayoutMode()
    -- Hide all drag handles
    for _, h in ipairs(layoutHandles) do h:Hide() end
    layoutHandles = {}

    -- Hide sidebar
    if sidebarFrame then
        if sidebarFrame.stateLabel then sidebarFrame.stateLabel:Hide() end
        if sidebarFrame.stateBtn then sidebarFrame.stateBtn:Hide() end
        if sidebarFrame.snapLabel then sidebarFrame.snapLabel:Hide() end
        if sidebarFrame.snapMinus then sidebarFrame.snapMinus:Hide() end
        if sidebarFrame.snapPlus then sidebarFrame.snapPlus:Hide() end
        if sidebarFrame.saveBtn then sidebarFrame.saveBtn:Hide() end
        sidebarFrame:Hide()
    end

    -- Hide layout hint
    if previewFrame._layoutHint then
        previewFrame._layoutHint:Hide()
    end

    -- Hide grid lines
    for _, line in ipairs(layoutGridLines) do line:Hide() end

    -- Discard pending layout (unsaved changes lost)
    pendingLayout = nil

    -- Refresh all plates and preview
    self:RefreshAllPlates()
    self:RefreshPreview()
end

----------------------------------------------------------------------
-- Layout Grid — draws snap grid lines on the preview
----------------------------------------------------------------------
function Addon:UpdateLayoutGrid()
    -- Hide existing grid lines
    for _, line in ipairs(layoutGridLines) do line:Hide() end

    if not previewFrame or layoutSnapSize <= 0 then return end

    local cont = previewFrame.container
    if not cont then return end
    local cw, ch = previewFrame:GetWidth(), previewFrame:GetHeight()
    local halfW, halfH = cw / 2, ch / 2

    local lineIndex = 0
    local function GetOrCreateLine()
        lineIndex = lineIndex + 1
        if layoutGridLines[lineIndex] then
            return layoutGridLines[lineIndex]
        end
        local line = previewFrame:CreateTexture(nil, "ARTWORK", nil, -8)
        line:SetColorTexture(0.3, 0.5, 0.7, 0.15)
        layoutGridLines[lineIndex] = line
        return line
    end

    -- Vertical lines from center outward
    for x = 0, halfW, layoutSnapSize do
        for _, sign in ipairs({1, -1}) do
            if x == 0 and sign == -1 then break end -- skip duplicate center
            local line = GetOrCreateLine()
            line:SetSize(1, ch)
            line:ClearAllPoints()
            line:SetPoint("CENTER", previewFrame, "CENTER", x * sign, 0)
            if x == 0 then
                line:SetColorTexture(0.5, 0.7, 1.0, 0.3) -- brighter center line
            else
                line:SetColorTexture(0.3, 0.5, 0.7, 0.15)
            end
            line:Show()
        end
    end

    -- Horizontal lines from center outward
    for y = 0, halfH, layoutSnapSize do
        for _, sign in ipairs({1, -1}) do
            if y == 0 and sign == -1 then break end
            local line = GetOrCreateLine()
            line:SetSize(cw, 1)
            line:ClearAllPoints()
            line:SetPoint("CENTER", previewFrame, "CENTER", 0, y * sign)
            if y == 0 then
                line:SetColorTexture(0.5, 0.7, 1.0, 0.3)
            else
                line:SetColorTexture(0.3, 0.5, 0.7, 0.15)
            end
            line:Show()
        end
    end
end
