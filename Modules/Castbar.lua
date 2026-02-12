----------------------------------------------------------------------
-- ThreatPlates Remake - Cast Bar Module
-- Custom cast bar on nameplates with interrupt indicators
-- Updated for WoW Midnight (12.0) using Plater-proven patterns:
--   SetTimerDuration() + UnitCastingDuration/UnitChannelDuration
--   SetAlphaFromBoolean() + EvaluateColorValueFromBoolean() for secrets
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

local FALLBACK_TEXTURE = "Interface\\TargetingFrame\\UI-StatusBar"
local LSM = LibStub("LibSharedMedia-3.0", true)
local IS_MIDNIGHT = (Enum and Enum.StatusBarInterpolation) and true or false

local function ResolveTexture(key)
    if not key or key == "" then return FALLBACK_TEXTURE end
    if LSM then
        local path = LSM:Fetch("statusbar", key, true)
        if path then return path end
    end
    if key:find("\\") or key:find("/") then return key end
    return FALLBACK_TEXTURE
end

-- Wrapper matching Plater's CastInfo pattern
local CastInfo = {}
CastInfo.UnitCastingInfo = function(unit)
    if UnitCastingInfo then
        return UnitCastingInfo(unit)
    end
    return nil
end
CastInfo.UnitChannelInfo = function(unit)
    if UnitChannelInfo then
        return UnitChannelInfo(unit)
    end
    return nil
end

----------------------------------------------------------------------
-- Secret-safe color helper (Plater/Details-Framework pattern)
-- Uses C_CurveUtil.EvaluateColorValueFromBoolean to pick between
-- two color values based on a potentially-secret boolean.
-- When the boolean is plain, falls back to simple Lua branching.
----------------------------------------------------------------------
local function SetBarColorFromInterruptState(bar, notInterruptible, normalColor, uninterruptibleColor)
    if IS_MIDNIGHT and C_CurveUtil and C_CurveUtil.EvaluateColorValueFromBoolean then
        local r = C_CurveUtil.EvaluateColorValueFromBoolean(notInterruptible, uninterruptibleColor.r, normalColor.r)
        local g = C_CurveUtil.EvaluateColorValueFromBoolean(notInterruptible, uninterruptibleColor.g, normalColor.g)
        local b = C_CurveUtil.EvaluateColorValueFromBoolean(notInterruptible, uninterruptibleColor.b, normalColor.b)
        bar:SetStatusBarColor(r, g, b, 1)
    else
        -- Pre-12.0 fallback: notInterruptible is a plain boolean
        local color = notInterruptible and uninterruptibleColor or normalColor
        bar:SetStatusBarColor(color.r, color.g, color.b, 1)
    end
end

----------------------------------------------------------------------
-- Create Cast Bar Elements
----------------------------------------------------------------------
function Addon:CreateCastBar(frame)
    local db = self.db.profile

    local width = db.castbar.width or 120
    local height = db.castbar.height or 10
    local yOffset = db.castbar.yOffset or -14

    -- Background / border (no BackdropTemplate — Midnight safe)
    local bg = CreateFrame("Frame", nil, frame.container)
    bg:SetSize(width + 2, height + 2)
    -- Initial position set by LayoutElements() in Core.lua
    bg:SetFrameLevel(frame.container:GetFrameLevel() + 3)

    -- Border texture (1px black outline using a background texture)
    local borderTex = bg:CreateTexture(nil, "BACKGROUND")
    borderTex:SetAllPoints(bg)
    borderTex:SetColorTexture(0, 0, 0, 1)
    bg.borderTex = borderTex

    -- Cast bar StatusBar
    local bar = CreateFrame("StatusBar", nil, bg)
    bar:SetSize(width, height)
    bar:SetPoint("CENTER", bg, "CENTER", 0, 0)
    bar:SetFrameLevel(bg:GetFrameLevel() + 1)

    -- Background texture (dark area behind the fill, like Plater)
    local barBg = bar:CreateTexture(nil, "BACKGROUND")
    barBg:SetDrawLayer("BACKGROUND", -6)
    barBg:SetAllPoints(bar)
    local bgc = db.castbar.backgroundColor or { r = 0.15, g = 0.15, b = 0.15, a = 0.85 }
    barBg:SetColorTexture(bgc.r, bgc.g, bgc.b, bgc.a)
    bar.barBg = barBg

    -- Fill texture (resolve LSM key to path)
    bar:SetStatusBarTexture(ResolveTexture(db.castbar.texture))
    bar.barTexture = bar:GetStatusBarTexture()

    if IS_MIDNIGHT then
        bar:SetMinMaxValues(0, 1, Enum.StatusBarInterpolation.Immediate)
        bar:SetValue(0, Enum.StatusBarInterpolation.Immediate)
    else
        bar:SetMinMaxValues(0, 1)
        bar:SetValue(0)
    end

    -- Spark
    local spark = bar:CreateTexture(nil, "OVERLAY")
    spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    spark:SetSize(12, height * 2.5)
    spark:SetBlendMode("ADD")
    spark:SetPoint("CENTER", bar.barTexture, "RIGHT", 0, 0)
    bar.spark = spark

    -- Spell name text
    local spellName = bar:CreateFontString(nil, "OVERLAY")
    spellName:SetFont(TPR.ResolveFont(db.castbar.font), db.castbar.fontSize or 8, db.castbar.fontFlags or "OUTLINE")
    spellName:SetPoint("LEFT", bar, "LEFT", 2, 0)
    spellName:SetJustifyH("LEFT")
    spellName:SetTextColor(1, 1, 1, 1)
    bar.spellName = spellName

    -- Timer text
    local timer = bar:CreateFontString(nil, "OVERLAY")
    timer:SetFont(TPR.ResolveFont(db.castbar.font), db.castbar.fontSize or 8, db.castbar.fontFlags or "OUTLINE")
    timer:SetPoint("RIGHT", bar, "RIGHT", -2, 0)
    timer:SetJustifyH("RIGHT")
    timer:SetTextColor(1, 1, 1, 1)
    bar.timer = timer

    -- Spell icon (RIGHT side, classic ThreatPlates style)
    local icon = bg:CreateTexture(nil, "ARTWORK")
    local iconSize = db.castbar.iconSize or 14
    icon:SetSize(iconSize, iconSize)
    icon:SetPoint("LEFT", bg, "RIGHT", 2, 0)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    bar.icon = icon

    -- Icon border (thin black outline using background texture)
    local iconBorderTex = bg:CreateTexture(nil, "ARTWORK", nil, 0)
    iconBorderTex:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
    iconBorderTex:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
    iconBorderTex:SetColorTexture(0, 0, 0, 1)
    bar.iconBorderTex = iconBorderTex

    -- Shield icon for uninterruptible
    local shield = bg:CreateTexture(nil, "OVERLAY")
    shield:SetTexture("Interface\\CastingBar\\UI-CastingBar-Arena-Shield")
    shield:SetSize(iconSize + 6, iconSize + 6)
    shield:SetPoint("CENTER", icon, "CENTER", 0, 0)
    shield:Hide()
    bar.shield = shield

    -- Flash overlay for interrupt feedback
    local flash = bar:CreateTexture(nil, "OVERLAY", nil, 7)
    flash:SetAllPoints(bar)
    flash:SetColorTexture(1, 1, 1, 1)
    flash:SetAlpha(0)
    flash:SetBlendMode("ADD")
    flash:Hide()
    bar.flash = flash

    -- State tracking
    bar.casting = false
    bar.channeling = false
    bar.notInterruptible = false
    bar.durationObject = nil
    bar.lazyUpdateCooldown = 0

    -- OnUpdate handler for timer text (Plater lazy tick pattern)
    bar:SetScript("OnUpdate", function(self, deltaTime)
        if not self.casting and not self.channeling then return end

        self.lazyUpdateCooldown = (self.lazyUpdateCooldown or 0) - deltaTime
        if self.lazyUpdateCooldown > 0 then return end
        self.lazyUpdateCooldown = 0.1 -- Update every 100ms

        -- Update timer text from duration object
        if self.durationObject and self.durationObject.GetRemainingDuration then
            self.timer:SetText(string.format("%.1f", self.durationObject:GetRemainingDuration()))
        end
    end)

    bg:Hide()
    frame.castbar = bar
    frame.castbarBg = bg
end

----------------------------------------------------------------------
-- Cast Event Handlers
----------------------------------------------------------------------
function Addon:OnCastStart(_, unitId)
    self:UpdateCastingInfo(unitId)
end

function Addon:OnCastStop(_, unitId)
    self:StopCast(unitId)
end

function Addon:OnChannelStart(_, unitId)
    self:UpdateChannelInfo(unitId)
end

function Addon:OnChannelStop(_, unitId)
    self:StopCast(unitId)
end

function Addon:OnCastInterruptible(_, unitId)
    self:UpdateCastInterruptState(unitId, false)
end

function Addon:OnCastNotInterruptible(_, unitId)
    self:UpdateCastInterruptState(unitId, true)
end

----------------------------------------------------------------------
-- Update Casting Info (Plater/oUF pattern for Midnight 12.0)
-- notInterruptible from UnitCastingInfo is a SECRET boolean in 12.0.
-- We pass it directly to secret-aware APIs:
--   SetAlphaFromBoolean() for shield visibility
--   C_CurveUtil.EvaluateColorValueFromBoolean() for bar color
-- UNIT_SPELLCAST_NOT_INTERRUPTIBLE events update with plain booleans.
----------------------------------------------------------------------
function Addon:UpdateCastingInfo(unitId)
    local plate = TPR.NameplatesByUnit[unitId]
    if not plate then return end
    local frame = TPR.ActivePlates[plate]
    if not frame or not frame.castbar then return end

    local db = self.db.profile
    if not db.castbar.enabled then return end

    local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = CastInfo.UnitCastingInfo(unitId)
    if not name then return end

    local bar = frame.castbar

    -- Store the (possibly secret) notInterruptible value directly.
    -- Do NOT use "or false" — that performs a boolean test on the secret.
    bar.notInterruptible = notInterruptible

    -- Set state
    bar.casting = true
    bar.channeling = false
    bar.lazyUpdateCooldown = 0

    -- Get duration object for Midnight
    if IS_MIDNIGHT and UnitCastingDuration then
        bar.durationObject = UnitCastingDuration(unitId)
    else
        bar.durationObject = nil
    end

    -- Apply fill using SetTimerDuration (Midnight) or manual (fallback)
    if IS_MIDNIGHT and bar.durationObject and bar.SetTimerDuration then
        bar:SetTimerDuration(bar.durationObject, Enum.StatusBarInterpolation.Immediate, Enum.StatusBarTimerDirection.ElapsedTime)
    elseif startTime and endTime then
        -- Pre-12.0 fallback
        local ok, startSec = pcall(function() return startTime / 1000 end)
        local ok2, endSec = pcall(function() return endTime / 1000 end)
        if ok and ok2 then
            bar.startTime = startSec
            bar.endTime = endSec
            bar:SetMinMaxValues(0, endSec - startSec)
            bar:SetValue(GetTime() - startSec)
        end
    end

    -- Apply appearance using secret-safe APIs
    self:ApplyCastBarAppearance(bar, db, name, texture, notInterruptible)

    frame.castbarBg:Show()
    self:LayoutElements(frame)
end

----------------------------------------------------------------------
-- Update Channel Info (Plater/oUF pattern for Midnight 12.0)
----------------------------------------------------------------------
function Addon:UpdateChannelInfo(unitId)
    local plate = TPR.NameplatesByUnit[unitId]
    if not plate then return end
    local frame = TPR.ActivePlates[plate]
    if not frame or not frame.castbar then return end

    local db = self.db.profile
    if not db.castbar.enabled then return end

    local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = CastInfo.UnitChannelInfo(unitId)
    if not name then return end

    local bar = frame.castbar

    -- Store the (possibly secret) notInterruptible value directly.
    bar.notInterruptible = notInterruptible

    -- Set state
    bar.casting = false
    bar.channeling = true
    bar.lazyUpdateCooldown = 0

    -- Get duration object for Midnight
    if IS_MIDNIGHT and UnitChannelDuration then
        bar.durationObject = UnitChannelDuration(unitId)
    else
        bar.durationObject = nil
    end

    -- Apply fill using SetTimerDuration (Midnight) or manual (fallback)
    if IS_MIDNIGHT and bar.durationObject and bar.SetTimerDuration then
        bar:SetTimerDuration(bar.durationObject, Enum.StatusBarInterpolation.Immediate, Enum.StatusBarTimerDirection.RemainingTime)
    elseif startTime and endTime then
        local ok, startSec = pcall(function() return startTime / 1000 end)
        local ok2, endSec = pcall(function() return endTime / 1000 end)
        if ok and ok2 then
            bar.startTime = startSec
            bar.endTime = endSec
            bar:SetMinMaxValues(0, endSec - startSec)
            bar:SetValue(endSec - GetTime())
        end
    end

    -- Apply appearance using secret-safe APIs
    self:ApplyCastBarAppearance(bar, db, name, texture, notInterruptible)

    frame.castbarBg:Show()
    self:LayoutElements(frame)
end

----------------------------------------------------------------------
-- Apply Cast Bar Appearance (shared between cast and channel)
-- notInterruptible can be a SECRET boolean (from UnitCastingInfo) or
-- a plain boolean (from UNIT_SPELLCAST_NOT_INTERRUPTIBLE event).
-- Uses Blizzard's secret-aware APIs to handle both cases:
--   SetAlphaFromBoolean() for shield visibility
--   C_CurveUtil.EvaluateColorValueFromBoolean() for bar color
----------------------------------------------------------------------
function Addon:ApplyCastBarAppearance(bar, db, name, texture, notInterruptible)
    -- Bar color: use secret-safe helper to pick between normal/uninterruptible
    SetBarColorFromInterruptState(bar, notInterruptible, db.castbar.normalColor, db.castbar.uninterruptibleColor)

    -- Spell name (SetText accepts secret strings)
    if db.castbar.showSpellName then
        bar.spellName:SetText(name)
        bar.spellName:Show()
    else
        bar.spellName:Hide()
    end

    -- Timer text
    if db.castbar.showTimer then
        bar.timer:Show()
    else
        bar.timer:Hide()
    end

    -- Spell icon (SetTexture accepts secret textures)
    if db.castbar.showIcon and texture then
        bar.icon:SetTexture(texture)
        bar.icon:Show()
        if bar.iconBorderTex then bar.iconBorderTex:Show() end
    else
        bar.icon:Hide()
        if bar.iconBorderTex then bar.iconBorderTex:Hide() end
    end

    -- Shield for uninterruptible (secret-safe)
    if IS_MIDNIGHT and bar.shield.SetAlphaFromBoolean then
        bar.shield:Show()
        bar.shield:SetAlphaFromBoolean(notInterruptible, 1, 0)
    else
        -- Pre-12.0 fallback: notInterruptible is a plain boolean
        if notInterruptible then
            bar.shield:Show()
        else
            bar.shield:Hide()
        end
    end

    bar.spark:Show()
end

----------------------------------------------------------------------
-- Stop Cast
----------------------------------------------------------------------
function Addon:StopCast(unitId)
    local plate = TPR.NameplatesByUnit[unitId]
    if not plate then return end
    local frame = TPR.ActivePlates[plate]
    if frame then
        self:StopCastForFrame(frame)
    end
end

function Addon:StopCastForFrame(frame)
    if not frame or not frame.castbar then return end
    local bar = frame.castbar

    bar.casting = false
    bar.channeling = false
    bar.durationObject = nil

    bar.timer:SetText("")
    bar.spellName:SetText("")
    bar.icon:SetTexture(nil)
    bar.icon:Hide()
    if bar.iconBorderTex then bar.iconBorderTex:Hide() end
    bar.shield:Hide()
    bar.spark:Hide()

    if frame.castbarBg then
        frame.castbarBg:Hide()
    end
    self:LayoutElements(frame)
end

----------------------------------------------------------------------
-- Update Interruptible State Mid-Cast (from events, plain booleans)
-- Called by UNIT_SPELLCAST_INTERRUPTIBLE / NOT_INTERRUPTIBLE events.
-- These events pass plain boolean state (not secrets).
----------------------------------------------------------------------
function Addon:UpdateCastInterruptState(unitId, isNotInterruptible)
    local plate = TPR.NameplatesByUnit[unitId]
    if not plate then return end
    local frame = TPR.ActivePlates[plate]
    if not frame or not frame.castbar then return end

    local db = self.db.profile
    local bar = frame.castbar
    bar.notInterruptible = isNotInterruptible

    local color
    if isNotInterruptible then
        color = db.castbar.uninterruptibleColor
        bar.shield:SetAlpha(1)
        bar.shield:Show()
    else
        color = db.castbar.normalColor
        bar.shield:Hide()
    end
    bar:SetStatusBarColor(color.r, color.g, color.b, 1)
end
