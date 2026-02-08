----------------------------------------------------------------------
-- ThreatPlates Remake - Health Bar Module
-- Creates and manages the styled health bar on nameplates
-- Updated for WoW Midnight (12.0) Secret Values API
-- Uses Plater-proven patterns for StatusBar with secret values
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

-- Default fallback texture
local FALLBACK_TEXTURE = "Interface\\TargetingFrame\\UI-StatusBar"
local LSM = LibStub("LibSharedMedia-3.0", true)

-- Resolve an LSM key or raw path to a texture path
local function ResolveTexture(key)
    if not key or key == "" then return FALLBACK_TEXTURE end
    if LSM then
        local path = LSM:Fetch("statusbar", key, true)
        if path then return path end
    end
    -- If it's already a path (contains \ or /), use as-is
    if key:find("\\") or key:find("/") then return key end
    return FALLBACK_TEXTURE
end

-- Detect Midnight
local IS_MIDNIGHT = (Enum and Enum.StatusBarInterpolation) and true or false

----------------------------------------------------------------------
-- Create Health Bar Elements
----------------------------------------------------------------------
function Addon:CreateHealthBar(frame)
    local db = self.db.profile

    local width = db.healthbar.width or 120
    local height = db.healthbar.height or 12

    local borderSize = db.healthbar.borderSize or 2
    local bc = db.healthbar.borderColor or { r = 1, g = 1, b = 1, a = 1 }
    local outerSize = db.healthbar.outerBorderSize or 1
    local obc = db.healthbar.outerBorderColor or { r = 0, g = 0, b = 0, a = 1 }
    local totalBorder = borderSize + outerSize

    -- Outer border frame (black outline around the white border)
    local bg = CreateFrame("Frame", nil, frame.container)
    bg:SetSize(width + totalBorder * 2, height + totalBorder * 2)
    bg:SetPoint("CENTER", frame.container, "CENTER", 0, 0)

    -- Outer border texture (black)
    local outerBorderTex = bg:CreateTexture(nil, "BACKGROUND", nil, -7)
    outerBorderTex:SetAllPoints(bg)
    outerBorderTex:SetColorTexture(obc.r, obc.g, obc.b, obc.a)
    bg.outerBorderTex = outerBorderTex

    -- Inner border texture (white, inset by outer border)
    local borderTex = bg:CreateTexture(nil, "BACKGROUND", nil, -6)
    borderTex:SetPoint("TOPLEFT", bg, "TOPLEFT", outerSize, -outerSize)
    borderTex:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -outerSize, outerSize)
    borderTex:SetColorTexture(bc.r, bc.g, bc.b, bc.a)
    bg.borderTex = borderTex

    frame.healthbarBg = bg

    -- Status bar (the actual health bar, inset by total border)
    local bar = CreateFrame("StatusBar", nil, bg)
    bar:SetPoint("TOPLEFT", bg, "TOPLEFT", totalBorder, -totalBorder)
    bar:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -totalBorder, totalBorder)
    bar:SetFrameLevel(bg:GetFrameLevel() + 1)

    -- Background texture (missing health area - dark behind the fill)
    local background = bar:CreateTexture(nil, "BACKGROUND")
    background:SetDrawLayer("BACKGROUND", -6)
    background:SetAllPoints(bar)
    local mhc = db.healthbar.missingHealthColor or { r = 0.05, g = 0.05, b = 0.05, a = 1 }
    background:SetColorTexture(mhc.r, mhc.g, mhc.b, mhc.a)
    bar.background = background

    -- Status bar fill texture (resolve LSM key to path)
    bar:SetStatusBarTexture(ResolveTexture(db.healthbar.texture))
    bar:SetStatusBarColor(1, 0, 0, 1)

    -- Keep reference to the fill texture for spark anchoring
    bar.barTexture = bar:GetStatusBarTexture()

    -- Initialize with full health
    if IS_MIDNIGHT then
        bar:SetMinMaxValues(0, 1, Enum.StatusBarInterpolation.Immediate)
        bar:SetValue(1, Enum.StatusBarInterpolation.Immediate)
    else
        bar:SetMinMaxValues(0, 1)
        bar:SetValue(1)
    end

    -- Health text
    local text = bar:CreateFontString(nil, "OVERLAY")
    text:SetFont(TPR.ResolveFont(db.healthbar.font), db.healthbar.fontSize or 9, db.healthbar.fontFlags or "OUTLINE")
    text:SetPoint("CENTER", bar, "CENTER", 0, 0)
    text:SetTextColor(1, 1, 1, 1)
    bar.text = text

    -- Absorb overlay (semi-transparent white bar on top of health)
    local absorb = bar:CreateTexture(nil, "OVERLAY")
    absorb:SetTexture("Interface\\Buttons\\WHITE8X8")
    absorb:SetVertexColor(1, 1, 1, 0.3)
    absorb:SetPoint("TOPLEFT", bar.barTexture, "TOPRIGHT", 0, 0)
    absorb:SetHeight(height)
    absorb:SetWidth(0)
    absorb:Hide()
    bar.absorb = absorb

    -- Spark (leading edge glow)
    local spark = bar:CreateTexture(nil, "OVERLAY")
    spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    spark:SetSize(12, height * 2.5)
    spark:SetBlendMode("ADD")
    spark:SetPoint("CENTER", bar.barTexture, "RIGHT", 0, 0)
    bar.spark = spark

    frame.healthbar = bar
end

----------------------------------------------------------------------
-- Update Health Bar Appearance (on config change or unit assignment)
----------------------------------------------------------------------
function Addon:UpdateHealthBarAppearance(frame)
    if not frame or not frame.healthbar then return end
    local db = self.db.profile

    local width = db.healthbar.width or 120
    local height = db.healthbar.height or 12
    local borderSize = db.healthbar.borderSize or 2
    local bc = db.healthbar.borderColor or { r = 1, g = 1, b = 1, a = 1 }
    local outerSize = db.healthbar.outerBorderSize or 1
    local obc = db.healthbar.outerBorderColor or { r = 0, g = 0, b = 0, a = 1 }
    local totalBorder = borderSize + outerSize

    -- Resize bg (includes both borders)
    frame.healthbarBg:SetSize(width + totalBorder * 2, height + totalBorder * 2)

    -- Update outer border color
    if frame.healthbarBg.outerBorderTex then
        frame.healthbarBg.outerBorderTex:SetColorTexture(obc.r, obc.g, obc.b, obc.a)
    end

    -- Update inner border color and position
    if frame.healthbarBg.borderTex then
        frame.healthbarBg.borderTex:ClearAllPoints()
        frame.healthbarBg.borderTex:SetPoint("TOPLEFT", frame.healthbarBg, "TOPLEFT", outerSize, -outerSize)
        frame.healthbarBg.borderTex:SetPoint("BOTTOMRIGHT", frame.healthbarBg, "BOTTOMRIGHT", -outerSize, outerSize)
        frame.healthbarBg.borderTex:SetColorTexture(bc.r, bc.g, bc.b, bc.a)
    end

    -- Resize health bar (inset by total border)
    frame.healthbar:ClearAllPoints()
    frame.healthbar:SetPoint("TOPLEFT", frame.healthbarBg, "TOPLEFT", totalBorder, -totalBorder)
    frame.healthbar:SetPoint("BOTTOMRIGHT", frame.healthbarBg, "BOTTOMRIGHT", -totalBorder, totalBorder)

    -- Fill texture (resolve LSM key, respects config changes)
    frame.healthbar:SetStatusBarTexture(ResolveTexture(db.healthbar.texture))
    frame.healthbar.barTexture = frame.healthbar:GetStatusBarTexture()

    -- Missing health / background color
    if frame.healthbar.background then
        local mhc = db.healthbar.missingHealthColor or { r = 0.2, g = 0, b = 0, a = 0.9 }
        frame.healthbar.background:SetColorTexture(mhc.r, mhc.g, mhc.b, mhc.a)
    end


    -- Font
    frame.healthbar.text:SetFont(
        TPR.ResolveFont(db.healthbar.font),
        db.healthbar.fontSize or 9,
        db.healthbar.fontFlags or "OUTLINE"
    )

    -- Absorb bar height
    frame.healthbar.absorb:SetHeight(height)
end

----------------------------------------------------------------------
-- Update Health Text (Midnight secret-safe)
----------------------------------------------------------------------
function Addon:UpdateHealthText(frame, unitId)
    if not frame or not frame.healthbar then return end
    local db = self.db.profile
    local fmt = db.healthbar.textFormat or "PERCENT"

    if not db.healthbar.showText or fmt == "NONE" then
        frame.healthbar.text:SetText("")
        return
    end

    if fmt == "PERCENT" then
        if UnitHealthPercent then
            local pct = UnitHealthPercent(unitId, true, CurveConstants and CurveConstants.ScaleTo100)
            frame.healthbar.text:SetText(string.format("%.0f%%", pct))
        else
            frame.healthbar.text:SetText("")
        end
    elseif fmt == "CURRENT" then
        if AbbreviateLargeNumbers then
            frame.healthbar.text:SetText(AbbreviateLargeNumbers(UnitHealth(unitId)))
        else
            frame.healthbar.text:SetText(string.format("%s", UnitHealth(unitId)))
        end
    elseif fmt == "CURRENT_PERCENT" then
        -- "738K - 100%" style (classic ThreatPlates)
        if AbbreviateLargeNumbers and UnitHealthPercent then
            local pct = UnitHealthPercent(unitId, true, CurveConstants and CurveConstants.ScaleTo100)
            frame.healthbar.text:SetText(string.format("%s - %.0f%%", AbbreviateLargeNumbers(UnitHealth(unitId)), pct))
        elseif AbbreviateLargeNumbers then
            frame.healthbar.text:SetText(AbbreviateLargeNumbers(UnitHealth(unitId)))
        else
            frame.healthbar.text:SetText(string.format("%s", UnitHealth(unitId)))
        end
    elseif fmt == "BOTH" then
        frame.healthbar.text:SetText(string.format("%s / %s", UnitHealth(unitId), UnitHealthMax(unitId)))
    elseif fmt == "DEFICIT" then
        if UnitHealthMissing then
            frame.healthbar.text:SetText(string.format("-%s", UnitHealthMissing(unitId)))
        else
            frame.healthbar.text:SetText("")
        end
    end
end

----------------------------------------------------------------------
-- Absorb Shield Update (simplified for 12.0 secrets)
----------------------------------------------------------------------
function Addon:UpdateAbsorb(frame, unitId)
    if not frame or not frame.healthbar or not unitId then return end

    local absorb = UnitGetTotalAbsorbs(unitId)

    if absorb and not issecretvalue then
        local maxHealth = UnitHealthMax(unitId) or 1
        if absorb > 0 and maxHealth > 0 then
            local barWidth = frame.healthbar:GetWidth()
            local absorbWidth = (absorb / maxHealth) * barWidth
            absorbWidth = math.min(absorbWidth, barWidth * 0.5)
            frame.healthbar.absorb:SetWidth(absorbWidth)
            frame.healthbar.absorb:Show()
        else
            frame.healthbar.absorb:Hide()
        end
    elseif absorb then
        frame.healthbar.absorb:SetWidth(frame.healthbar:GetWidth() * 0.15)
        frame.healthbar.absorb:Show()
    else
        frame.healthbar.absorb:Hide()
    end
end
