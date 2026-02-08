----------------------------------------------------------------------
-- ThreatPlates Remake - Combo Points / Class Power Module
-- Displays combo points, holy power, chi, arcane charges, soul shards,
-- and essence on the target's nameplate.
-- Updated for WoW Midnight (12.0) Secret Values API
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

local MAX_POINTS = 7 -- covers all class max values

----------------------------------------------------------------------
-- Player class & power type detection (cached once)
----------------------------------------------------------------------
local playerClass = nil
local playerPowerType = nil

-- Class-specific default colors for filled points
local CLASS_POWER_COLORS = {
    ROGUE       = { r = 1.0, g = 0.9, b = 0.2 },  -- Yellow
    DRUID       = { r = 1.0, g = 0.5, b = 0.0 },  -- Orange
    PALADIN     = { r = 0.9, g = 0.7, b = 0.0 },  -- Gold
    MONK        = { r = 0.0, g = 0.9, b = 0.6 },  -- Jade
    MAGE        = { r = 0.4, g = 0.5, b = 1.0 },  -- Arcane blue
    WARLOCK     = { r = 0.6, g = 0.3, b = 0.9 },  -- Purple
    EVOKER      = { r = 0.2, g = 0.8, b = 0.9 },  -- Cyan
    DEATHKNIGHT = { r = 0.8, g = 0.1, b = 0.2 },  -- Red (runes)
}

-- Power type numeric fallbacks in case Enum.PowerType keys are missing
local POWER_COMBO     = (Enum and Enum.PowerType and Enum.PowerType.ComboPoints) or 4
local POWER_HOLYPOWER = (Enum and Enum.PowerType and Enum.PowerType.HolyPower) or 9
local POWER_CHI       = (Enum and Enum.PowerType and Enum.PowerType.Chi) or 12
local POWER_ARCANE    = (Enum and Enum.PowerType and Enum.PowerType.ArcaneCharges) or 16
local POWER_SHARDS    = (Enum and Enum.PowerType and Enum.PowerType.SoulShards) or 7
local POWER_ESSENCE   = (Enum and Enum.PowerType and Enum.PowerType.Essence) or 19
local POWER_RUNES     = (Enum and Enum.PowerType and Enum.PowerType.Runes) or 5

local function DetectPowerType()
    local _, class = UnitClass("player")
    playerClass = class

    if class == "ROGUE" then
        playerPowerType = POWER_COMBO
    elseif class == "DRUID" then
        local spec = GetSpecialization and GetSpecialization() or nil
        if spec == 2 then -- Feral
            playerPowerType = POWER_COMBO
        else
            playerPowerType = nil
        end
    elseif class == "PALADIN" then
        playerPowerType = POWER_HOLYPOWER
    elseif class == "MONK" then
        local spec = GetSpecialization and GetSpecialization() or nil
        if spec == 3 then -- Windwalker
            playerPowerType = POWER_CHI
        else
            playerPowerType = nil
        end
    elseif class == "MAGE" then
        local spec = GetSpecialization and GetSpecialization() or nil
        if spec == 1 then -- Arcane
            playerPowerType = POWER_ARCANE
        else
            playerPowerType = nil
        end
    elseif class == "WARLOCK" then
        playerPowerType = POWER_SHARDS
    elseif class == "EVOKER" then
        playerPowerType = POWER_ESSENCE
    elseif class == "DEATHKNIGHT" then
        playerPowerType = POWER_RUNES
    else
        playerPowerType = nil
    end
end

----------------------------------------------------------------------
-- Create Combo Point Icons
----------------------------------------------------------------------
function Addon:CreateComboPoints(frame)
    local db = self.db.profile

    local container = CreateFrame("Frame", nil, frame.container)
    container:SetSize(200, 20)
    container:SetFrameLevel(frame.container:GetFrameLevel() + 6)

    -- Create point icons
    container.icons = {}
    for i = 1, MAX_POINTS do
        local size = db.comboPoints.iconSize or 8

        local icon = CreateFrame("Frame", nil, container)
        icon:SetSize(size, size)

        -- Border (1px black behind)
        icon.border = icon:CreateTexture(nil, "BACKGROUND")
        icon.border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
        icon.border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
        icon.border:SetColorTexture(0, 0, 0, 1)

        -- Fill texture
        icon.fill = icon:CreateTexture(nil, "ARTWORK")
        icon.fill:SetAllPoints(icon)
        icon.fill:SetColorTexture(1, 1, 1, 1)

        icon:Hide()
        container.icons[i] = icon
    end

    container:Hide()
    frame.comboPoints = container
end

-- Positioning handled by LayoutElements() in Core.lua

----------------------------------------------------------------------
-- Update Combo Points Display
----------------------------------------------------------------------
function Addon:UpdateComboPoints(frame, unitId)
    if not frame or not frame.comboPoints then return end

    local db = self.db.profile

    -- Hide if disabled or no power type for this class
    if not db.comboPoints.enabled then
        frame.comboPoints:Hide()
        return
    end

    -- Detect power type if not yet cached
    if not playerClass then
        DetectPowerType()
    end

    if not playerPowerType then
        frame.comboPoints:Hide()
        return
    end

    -- Only show on current target
    if db.comboPoints.showOnTargetOnly then
        local isTarget = false
        local ok, val = pcall(UnitIsUnit, unitId, "target")
        if ok then isTarget = val end

        if not isTarget then
            frame.comboPoints:Hide()
            return
        end
    end

    -- Get power values
    local current, maxPower
    if playerPowerType == POWER_RUNES then
        -- Runes work differently — count ready runes
        current = 0
        maxPower = 6
        for i = 1, 6 do
            local start, duration, ready = GetRuneCooldown(i)
            if ready then
                current = current + 1
            end
        end
    else
        current = UnitPower("player", playerPowerType)
        maxPower = UnitPowerMax("player", playerPowerType)
    end

    -- In 12.0, UnitPower may return secrets — safely extract numeric value
    local currentNum, maxNum
    local ok1, val1 = pcall(function() return current + 0 end)
    local ok2, val2 = pcall(function() return maxPower + 0 end)

    if ok1 and ok2 then
        currentNum = val1
        maxNum = val2
    else
        -- Secrets — can't compare, hide the display
        frame.comboPoints:Hide()
        return
    end

    if maxNum <= 0 then
        frame.comboPoints:Hide()
        return
    end

    -- Determine colors
    local activeColor, inactiveColor
    if db.comboPoints.useClassColors and playerClass and CLASS_POWER_COLORS[playerClass] then
        local cc = CLASS_POWER_COLORS[playerClass]
        activeColor = { r = cc.r, g = cc.g, b = cc.b, a = 1 }
    else
        activeColor = db.comboPoints.activeColor
    end
    inactiveColor = db.comboPoints.inactiveColor

    -- Layout and show icons
    local iconSize = db.comboPoints.iconSize or 8
    local spacing = db.comboPoints.iconSpacing or 2
    local totalWidth = (maxNum * iconSize) + ((maxNum - 1) * spacing)
    local startX = -totalWidth / 2

    for i = 1, MAX_POINTS do
        local icon = frame.comboPoints.icons[i]
        if i <= maxNum then
            icon:SetSize(iconSize, iconSize)
            icon:ClearAllPoints()
            icon:SetPoint("LEFT", frame.comboPoints, "CENTER", startX + (i - 1) * (iconSize + spacing), 0)

            if i <= currentNum then
                icon.fill:SetColorTexture(activeColor.r, activeColor.g, activeColor.b, activeColor.a or 1)
            else
                icon.fill:SetColorTexture(inactiveColor.r, inactiveColor.g, inactiveColor.b, inactiveColor.a or 0.5)
            end

            icon.border:ClearAllPoints()
            icon.border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
            icon.border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)

            icon:Show()
        else
            icon:Hide()
        end
    end

    -- Show container (positioning handled by LayoutElements in Core.lua)
    frame.comboPoints:Show()
end

----------------------------------------------------------------------
-- Update All Plates (called on power change events)
----------------------------------------------------------------------
function Addon:UpdateAllComboPoints()
    for plate, frame in pairs(TPR.ActivePlates) do
        if frame.unitId then
            self:UpdateComboPoints(frame, frame.unitId)
        end
    end
end

----------------------------------------------------------------------
-- Re-detect power type (called on spec change)
----------------------------------------------------------------------
function Addon:RefreshPowerType()
    DetectPowerType()
    self:UpdateAllComboPoints()
end
