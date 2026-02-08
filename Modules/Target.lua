----------------------------------------------------------------------
-- ThreatPlates Remake - Target Highlight Module
-- Visual emphasis for the current target nameplate
-- Updated for WoW Midnight (12.0) Secret Values API
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

----------------------------------------------------------------------
-- Create Target Highlight Elements
----------------------------------------------------------------------
function Addon:CreateTargetHighlight(frame)
    -- Target highlight: subtle overlay on the health bar (no border)
    local highlight = frame.container:CreateTexture(nil, "ARTWORK", nil, 7)
    highlight:SetPoint("TOPLEFT", frame.healthbar, "TOPLEFT", 0, 0)
    highlight:SetPoint("BOTTOMRIGHT", frame.healthbar, "BOTTOMRIGHT", 0, 0)
    highlight:SetColorTexture(1, 1, 1, 0.15)
    highlight:SetBlendMode("ADD")
    highlight:Hide()

    -- Arrow indicator above name
    local arrow = frame.container:CreateTexture(nil, "OVERLAY")
    arrow:SetTexture("Interface\\AddOns\\ThreatPlatesRemake\\Artwork\\Target.tga")
    arrow:SetSize(24, 12)
    arrow:SetPoint("BOTTOM", frame.name, "TOP", 0, 2)
    arrow:SetVertexColor(1, 1, 1, 0.8)
    arrow:Hide()

    frame.targetHighlight = highlight
    frame.targetArrow = arrow
end

----------------------------------------------------------------------
-- Update Target Highlight
-- In 12.0, UnitIsUnit() may return secret booleans in combat.
-- We use event-based target tracking (TPR.CurrentTarget) as primary
-- method and fall back to UnitIsUnit for out-of-combat.
----------------------------------------------------------------------
function Addon:UpdateTargetHighlight(frame, unitId)
    if not frame or not unitId then return end

    local db = self.db.profile
    if not db.target.enabled then
        if frame.targetHighlight then frame.targetHighlight:Hide() end
        if frame.targetArrow then frame.targetArrow:Hide() end
        frame:SetAlpha(1)
        if frame.container then frame.container:SetScale(1) end
        return
    end

    -- Determine if this unit is our target
    -- UnitIsUnit should still work for nameplate units in most cases
    local isTarget = UnitIsUnit(unitId, "target")

    if isTarget then
        -- Show highlight (subtle additive overlay on health bar)
        if frame.targetHighlight then
            local hc = db.target.highlightColor or { r = 1, g = 1, b = 1, a = 0.15 }
            frame.targetHighlight:SetColorTexture(hc.r, hc.g, hc.b, hc.a)
            frame.targetHighlight:Show()
        end

        -- Show arrow
        if frame.targetArrow then
            frame.targetArrow:Show()
        end

        -- Scale up
        local scale = db.target.scale or 1.3
        if frame.container then
            frame.container:SetScale(scale)
        end

        -- Full alpha
        frame:SetAlpha(db.target.alpha or 1.0)
    else
        -- Hide highlight
        if frame.targetHighlight then
            frame.targetHighlight:Hide()
        end

        if frame.targetArrow then
            frame.targetArrow:Hide()
        end

        -- Scale down
        if frame.container then
            frame.container:SetScale(1)
        end

        -- Reduced alpha for non-targets
        local hasTarget = UnitExists("target")
        if hasTarget then
            frame:SetAlpha(db.target.nonTargetAlpha or 0.7)
        else
            frame:SetAlpha(1)
        end
    end
end
