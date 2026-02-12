----------------------------------------------------------------------
-- ThreatPlates Remake - Quest Icon Module
-- Shows a quest indicator on nameplates for quest-related mobs
-- Updated for WoW Midnight (12.0) Secret Values API
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

----------------------------------------------------------------------
-- Style Definitions
----------------------------------------------------------------------
TPR.QuestIconStyles = {
    {
        key = "classic",
        name = "Classic (Yellow !)",
        texture = "Interface\\GossipFrame\\AvailableQuestIcon",
    },
    {
        key = "turn_in",
        name = "Turn-In (Yellow ?)",
        texture = "Interface\\GossipFrame\\ActiveQuestIcon",
    },
    {
        key = "daily",
        name = "Daily (Blue !)",
        texture = "Interface\\GossipFrame\\DailyQuestIcon",
    },
    {
        key = "daily_turn_in",
        name = "Daily Turn-In (Blue ?)",
        texture = "Interface\\GossipFrame\\DailyActiveQuestIcon",
    },
    {
        key = "skull",
        name = "Skull",
        texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
    },
    {
        key = "star",
        name = "Star (Raid Icon)",
        texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_1",
    },
}

-- Build lookup table
TPR.QuestIconStyleMap = {}
for _, style in ipairs(TPR.QuestIconStyles) do
    TPR.QuestIconStyleMap[style.key] = style
end

-- Position presets: offsets relative to the healthbar
TPR.QuestIconPositions = {
    LEFT   = { anchor = "RIGHT",  rel = "LEFT",   x = -4, y = 0 },
    RIGHT  = { anchor = "LEFT",   rel = "RIGHT",  x = 4,  y = 0 },
    ABOVE  = { anchor = "BOTTOM", rel = "TOP",    x = 0,  y = 4 },
    BELOW  = { anchor = "TOP",    rel = "BOTTOM", x = 0,  y = -4 },
}

----------------------------------------------------------------------
-- Tooltip Scanner
-- Creates a hidden tooltip to scan unit tooltips for quest objectives.
-- Looks for quest-colored text (e.g. "0/5" progress lines) which
-- indicates the unit is an objective for a quest in your log.
----------------------------------------------------------------------
local tooltipScanner = CreateFrame("GameTooltip", "TPR_QuestTooltipScanner", UIParent, "GameTooltipTemplate")
tooltipScanner:SetOwner(UIParent, "ANCHOR_NONE")

local function IsCurrentQuestMob(unitId)
    -- Reset the tooltip
    tooltipScanner:ClearLines()
    tooltipScanner:SetUnit(unitId)

    -- Scan tooltip lines for quest objective markers
    local numLines = tooltipScanner:NumLines()
    if numLines < 2 then return false end

    local foundQuestTitle = false
    for i = 2, numLines do
        local textLeft = _G["TPR_QuestTooltipScannerTextLeft" .. i]
        if textLeft then
            local text = textLeft:GetText()
            local r, g, b = textLeft:GetTextColor()

            if text then
                -- Quest title lines are typically in a specific color
                -- Quest progress lines show "X/Y" patterns or percentage
                -- Lines with quest objectives are usually in yellow-ish or
                -- the default quest objective color

                -- Check for quest progress pattern (e.g. "Slay Gnolls: 3/8")
                if text:find("%d+/%d+") then
                    return true
                end

                -- Check for percentage pattern (e.g. "Area Secured: 45%")
                if text:find("%d+%%") then
                    return true
                end

                -- Check for quest objective color (yellow/quest-colored lines)
                -- Quest headers are typically r≈1, g≈0.82, b≈0 (quest yellow)
                -- Quest progress is slightly different but still yellowish
                if r and g and b then
                    -- Quest title: bright yellow (r>0.9, g>0.7, b<0.2)
                    if r > 0.9 and g > 0.7 and b < 0.2 then
                        foundQuestTitle = true
                    end

                    -- Quest progress incomplete: grey-white under a quest title
                    -- (r≈0.8, g≈0.8, b≈0.8 or similar neutral color)
                    if foundQuestTitle and r < 1 and g < 1 and b < 1 and r > 0.5 then
                        -- This line is under a quest title, likely an objective
                        if text:find(":") or text:find("%-") then
                            return true
                        end
                    end
                end
            end
        end
    end

    return false
end

----------------------------------------------------------------------
-- Create Quest Icon Elements
----------------------------------------------------------------------
function Addon:CreateQuestIcon(frame)
    local db = self.db.profile
    local qi = db.questIcon or {}

    local icon = frame.container:CreateTexture(nil, "OVERLAY")
    local styleKey = qi.style or "classic"
    local style = TPR.QuestIconStyleMap[styleKey] or TPR.QuestIconStyles[1]
    icon:SetTexture(style.texture)
    icon:SetSize(qi.size or 24, qi.size or 24)
    icon:Hide()

    frame.questIcon = icon
end

----------------------------------------------------------------------
-- Update Quest Icon
-- Only shows icon for mobs that are objectives of your current quests.
-- Uses tooltip scanning to detect quest progress lines (X/Y patterns).
----------------------------------------------------------------------
function Addon:UpdateQuestIcon(frame, unitId)
    if not frame or not frame.questIcon or not unitId then return end

    local db = self.db.profile
    if not db.questIcon or not db.questIcon.enabled then
        frame.questIcon:Hide()
        return
    end

    -- Only check enemy NPCs (not players, not friendly)
    local isPlayer = UnitIsPlayer(unitId)
    if isPlayer then
        frame.questIcon:Hide()
        return
    end

    local isQuestMob = false

    -- Primary method: Tooltip scan for current quest objectives
    local ok, result = pcall(IsCurrentQuestMob, unitId)
    if ok and result then
        isQuestMob = true
    end

    -- Fallback: Check Blizzard nameplate's quest icon widget
    if not isQuestMob then
        local plate = frame:GetParent()
        if plate and plate.UnitFrame then
            local uf = plate.UnitFrame
            -- Blizzard only shows quest icons for current quest mobs
            if uf.questIcon and uf.questIcon.IsShown then
                local qok, qshown = pcall(uf.questIcon.IsShown, uf.questIcon)
                if qok and qshown then
                    isQuestMob = true
                end
            end
        end
    end

    if isQuestMob then
        local qi = db.questIcon or {}

        -- Apply style
        local styleKey = qi.style or "classic"
        local style = TPR.QuestIconStyleMap[styleKey] or TPR.QuestIconStyles[1]
        frame.questIcon:SetTexture(style.texture)

        -- Apply size
        local size = qi.size or 24
        frame.questIcon:SetSize(size, size)

        -- Apply color tint if set
        local c = qi.color
        if c then
            frame.questIcon:SetVertexColor(c.r, c.g, c.b, c.a or 1)
        else
            frame.questIcon:SetVertexColor(1, 1, 1, 1)
        end

        -- Position relative to healthbar using preset
        local position = qi.position or "LEFT"
        local pos = TPR.QuestIconPositions[position] or TPR.QuestIconPositions.LEFT
        frame.questIcon:ClearAllPoints()
        frame.questIcon:SetPoint(pos.anchor, frame.healthbarBg or frame.healthbar, pos.rel, pos.x, pos.y)

        frame.questIcon:Show()
    else
        frame.questIcon:Hide()
    end
end
