----------------------------------------------------------------------
-- ThreatPlates Remake - Threat Module
-- Threat-based nameplate coloring and glow
-- Uses Plater-proven patterns: UnitDetailedThreatSituation,
-- aggro glow textures, role-based color inversion
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

----------------------------------------------------------------------
-- Create Threat Glow (texture-only, no BackdropTemplate)
----------------------------------------------------------------------
function Addon:CreateThreatGlow(frame)
    -- Upper glow bar (above health bar)
    local glowUpper = frame.container:CreateTexture(nil, "BACKGROUND", nil, -4)
    glowUpper:SetPoint("BOTTOMLEFT", frame.healthbarBg, "TOPLEFT", -4, 0)
    glowUpper:SetPoint("BOTTOMRIGHT", frame.healthbarBg, "TOPRIGHT", 4, 0)
    glowUpper:SetTexture("Interface\\BUTTONS\\UI-Panel-Button-Glow")
    glowUpper:SetTexCoord(0, 95/128, 0, 9/64)
    glowUpper:SetBlendMode("ADD")
    glowUpper:SetHeight(6)
    glowUpper:Hide()
    frame.aggroGlowUpper = glowUpper

    -- Lower glow bar (below health bar)
    local glowLower = frame.container:CreateTexture(nil, "BACKGROUND", nil, -4)
    glowLower:SetPoint("TOPLEFT", frame.healthbarBg, "BOTTOMLEFT", -4, 0)
    glowLower:SetPoint("TOPRIGHT", frame.healthbarBg, "BOTTOMRIGHT", 4, 0)
    glowLower:SetTexture("Interface\\BUTTONS\\UI-Panel-Button-Glow")
    glowLower:SetTexCoord(0, 95/128, 30/64, 38/64)
    glowLower:SetBlendMode("ADD")
    glowLower:SetHeight(6)
    glowLower:Hide()
    frame.aggroGlowLower = glowLower

    -- Left glow bar
    local glowLeft = frame.container:CreateTexture(nil, "BACKGROUND", nil, -4)
    glowLeft:SetPoint("TOPRIGHT", frame.healthbarBg, "TOPLEFT", 0, 4)
    glowLeft:SetPoint("BOTTOMRIGHT", frame.healthbarBg, "BOTTOMLEFT", 0, -4)
    glowLeft:SetTexture("Interface\\BUTTONS\\UI-Panel-Button-Glow")
    glowLeft:SetTexCoord(0, 9/128, 0, 38/64)
    glowLeft:SetBlendMode("ADD")
    glowLeft:SetWidth(6)
    glowLeft:Hide()
    frame.aggroGlowLeft = glowLeft

    -- Right glow bar
    local glowRight = frame.container:CreateTexture(nil, "BACKGROUND", nil, -4)
    glowRight:SetPoint("TOPLEFT", frame.healthbarBg, "TOPRIGHT", 0, 4)
    glowRight:SetPoint("BOTTOMLEFT", frame.healthbarBg, "BOTTOMRIGHT", 0, -4)
    glowRight:SetTexture("Interface\\BUTTONS\\UI-Panel-Button-Glow")
    glowRight:SetTexCoord(86/128, 95/128, 0, 38/64)
    glowRight:SetBlendMode("ADD")
    glowRight:SetWidth(6)
    glowRight:Hide()
    frame.aggroGlowRight = glowRight
end

----------------------------------------------------------------------
-- Update Threat (Plater pattern: UnitDetailedThreatSituation)
----------------------------------------------------------------------
function Addon:UpdateThreat(frame, unitId)
    if not frame or not unitId then return end

    local db = self.db.profile
    if not db.threat.enabled then
        self:HideThreatVisuals(frame)
        return
    end

    -- Use UnitDetailedThreatSituation like Plater
    local isTanking, threatStatus, threatpct, threatrawpct, threatValue = UnitDetailedThreatSituation("player", unitId)

    -- Determine role
    local isTank = self:IsPlayerTank()
    local colorTable = isTank and db.threat.tank or db.threat.dps

    -- Map threat status to color
    local color, showGlow
    if isTank then
        if threatStatus == 3 then
            color = colorTable.safe
            showGlow = false
        elseif threatStatus == 2 then
            color = colorTable.medium
            showGlow = true
        elseif threatStatus == 1 then
            color = colorTable.high
            showGlow = true
        else
            color = colorTable.danger
            showGlow = (threatStatus ~= nil)
        end
    else
        if threatStatus == nil or threatStatus == 0 then
            color = colorTable.safe
            showGlow = false
        elseif threatStatus == 1 then
            color = colorTable.medium
            showGlow = true
        elseif threatStatus == 2 then
            color = colorTable.high
            showGlow = true
        else
            color = colorTable.danger
            showGlow = true
        end
    end

    if not color then
        color = colorTable.safe or { r = 0, g = 1, b = 0 }
    end

    -- Apply health bar color override
    if db.threat.useColorChange and threatStatus and threatStatus >= 1 then
        frame.healthbar:SetStatusBarColor(color.r, color.g, color.b, 1)
    end

    -- Apply glow effects (all texture-based, no BackdropTemplate)
    if db.threat.useGlow and showGlow then
        local glowAlpha = db.threat.glowAlpha or 0.7

        if frame.aggroGlowUpper then
            frame.aggroGlowUpper:SetVertexColor(color.r, color.g, color.b, glowAlpha)
            frame.aggroGlowUpper:Show()
        end
        if frame.aggroGlowLower then
            frame.aggroGlowLower:SetVertexColor(color.r, color.g, color.b, glowAlpha)
            frame.aggroGlowLower:Show()
        end
        if frame.aggroGlowLeft then
            frame.aggroGlowLeft:SetVertexColor(color.r, color.g, color.b, glowAlpha)
            frame.aggroGlowLeft:Show()
        end
        if frame.aggroGlowRight then
            frame.aggroGlowRight:SetVertexColor(color.r, color.g, color.b, glowAlpha)
            frame.aggroGlowRight:Show()
        end
    else
        self:HideThreatVisuals(frame)
    end
end

----------------------------------------------------------------------
-- Hide Threat Visuals
----------------------------------------------------------------------
function Addon:HideThreatVisuals(frame)
    if frame.aggroGlowUpper then frame.aggroGlowUpper:Hide() end
    if frame.aggroGlowLower then frame.aggroGlowLower:Hide() end
    if frame.aggroGlowLeft then frame.aggroGlowLeft:Hide() end
    if frame.aggroGlowRight then frame.aggroGlowRight:Hide() end
end

----------------------------------------------------------------------
-- Role Detection
----------------------------------------------------------------------
function Addon:IsPlayerTank()
    if UnitGroupRolesAssigned then
        return UnitGroupRolesAssigned("player") == "TANK"
    end
    local spec = GetSpecialization and GetSpecialization()
    if spec then
        local role = GetSpecializationRole and GetSpecializationRole(spec)
        return role == "TANK"
    end
    return false
end

function Addon:IsPlayerHealer()
    if UnitGroupRolesAssigned then
        return UnitGroupRolesAssigned("player") == "HEALER"
    end
    local spec = GetSpecialization and GetSpecialization()
    if spec then
        local role = GetSpecializationRole and GetSpecializationRole(spec)
        return role == "HEALER"
    end
    return false
end
