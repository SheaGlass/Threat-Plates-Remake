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
-- Checks multiple sources to detect quest mobs:
-- 1. UnitIsQuestBoss() API (quest boss mobs)
-- 2. Blizzard nameplate's built-in quest icon visibility
----------------------------------------------------------------------
function Addon:UpdateQuestIcon(frame, unitId)
    if not frame or not frame.questIcon or not unitId then return end

    local db = self.db.profile
    if not db.questIcon or not db.questIcon.enabled then
        frame.questIcon:Hide()
        return
    end

    local isQuestMob = false

    -- Method 1: UnitIsQuestBoss (may return secret in combat, use pcall)
    local ok, result = pcall(function()
        if UnitIsQuestBoss(unitId) then return true end
        return false
    end)
    if ok and result then
        isQuestMob = true
    end

    -- Method 2: Check Blizzard nameplate's quest icon widget
    if not isQuestMob then
        local plate = frame:GetParent()
        if plate and plate.UnitFrame then
            local uf = plate.UnitFrame
            if uf.questIcon and uf.questIcon.IsShown and uf.questIcon:IsShown() then
                isQuestMob = true
            elseif uf.SoftTargetFrame and uf.SoftTargetFrame.IsShown and uf.SoftTargetFrame:IsShown() then
                isQuestMob = true
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
