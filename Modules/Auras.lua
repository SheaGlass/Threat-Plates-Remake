----------------------------------------------------------------------
-- ThreatPlates Remake - Auras Module
-- Debuff & buff tracking on nameplates
-- Updated for WoW Midnight (12.0) Secret Values API
----------------------------------------------------------------------
local ADDON_NAME, TPR = ...
local Addon = TPR.Addon

local MAX_AURA_ICONS = 10 -- hard cap for icon pool

----------------------------------------------------------------------
-- Create Aura Container
----------------------------------------------------------------------
function Addon:CreateAuraFrame(frame)
    local db = self.db.profile

    local auraFrame = CreateFrame("Frame", nil, frame.container)
    auraFrame:SetSize(db.healthbar.width or 120, db.auras.iconSize or 20)
    auraFrame:SetPoint("BOTTOM", frame.healthbarBg, "TOP", 0, db.auras.yOffset or 16)
    auraFrame:SetFrameLevel(frame.container:GetFrameLevel() + 5)

    -- Pre-create icon pool
    auraFrame.icons = {}
    for i = 1, MAX_AURA_ICONS do
        auraFrame.icons[i] = self:CreateAuraIcon(auraFrame, i)
    end

    frame.auraFrame = auraFrame
end

----------------------------------------------------------------------
-- Create Individual Aura Icon
----------------------------------------------------------------------
function Addon:CreateAuraIcon(parent, index)
    local db = self.db.profile
    local size = db.auras.iconSize or 20

    local icon = CreateFrame("Frame", nil, parent)
    icon:SetSize(size, size)

    -- Border texture (1px behind the icon art)
    icon.border = icon:CreateTexture(nil, "BACKGROUND")
    icon.border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
    icon.border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
    icon.border:SetColorTexture(0, 0, 0, 1)

    -- Texture (inset slightly so border shows)
    icon.texture = icon:CreateTexture(nil, "ARTWORK")
    icon.texture:SetAllPoints(icon)
    icon.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    -- Cooldown spiral (hidden — clean look, just show duration number)
    icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
    icon.cooldown:SetAllPoints(icon)
    icon.cooldown:SetDrawEdge(false)
    icon.cooldown:SetDrawSwipe(false)
    icon.cooldown:SetHideCountdownNumbers(true)

    -- Duration text — small number at top-right of icon
    icon.duration = icon:CreateFontString(nil, "OVERLAY")
    local dfs = db.auras.durationFontSize or 8
    icon.duration:SetFont(TPR.ResolveFont(db.auras.font), dfs, "OUTLINE")
    icon.duration:SetPoint("TOPRIGHT", icon, "TOPRIGHT", 2, 2)
    icon.duration:SetTextColor(1, 1, 1, 1)
    icon.duration:Hide()

    -- Stack count
    icon.stacks = icon:CreateFontString(nil, "OVERLAY")
    icon.stacks:SetFont(TPR.ResolveFont(db.auras.font), db.auras.fontSize or 8, "OUTLINE")
    icon.stacks:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
    icon.stacks:SetTextColor(1, 1, 1, 1)

    icon:Hide()
    return icon
end

----------------------------------------------------------------------
-- Update Auras for a Unit (Midnight 12.0 compatible)
-- In 12.0, aura data fields may be secret values. We use
-- GetUnitAuraInstanceIDs() for enumeration and pass secret
-- values directly to widget APIs.
----------------------------------------------------------------------
function Addon:UpdateAuras(frame, unitId)
    if not frame or not frame.auraFrame or not unitId then return end

    local db = self.db.profile
    if not db.auras.enabled then
        for i = 1, MAX_AURA_ICONS do
            frame.auraFrame.icons[i]:Hide()
        end
        return
    end

    local auras = {}

    -- Build filter strings. In 12.0, use the "|PLAYER" flag at the API level
    -- to only get player-applied auras (bypasses secret value filtering issues).
    local playerSuffix = db.auras.onlyMine and "|PLAYER" or ""

    if db.auras.showDebuffs then
        self:CollectAuras(unitId, "HARMFUL" .. playerSuffix, auras, db)
    end

    if db.auras.showBuffs then
        self:CollectAuras(unitId, "HELPFUL" .. playerSuffix, auras, db)
    end

    -- In 12.0, expirationTime may be secret so we can't sort by it.
    -- Display auras in the order received instead.

    -- Display
    local maxShow = math.min(db.auras.maxAuras or 5, MAX_AURA_ICONS, #auras)
    local iconSize = db.auras.iconSize or 20
    local spacing = db.auras.iconSpacing or 2
    local totalWidth = (maxShow * iconSize) + ((maxShow - 1) * spacing)
    local startX = -totalWidth / 2

    for i = 1, MAX_AURA_ICONS do
        local iconFrame = frame.auraFrame.icons[i]
        if i <= maxShow then
            local aura = auras[i]
            self:SetAuraIcon(iconFrame, aura, db, unitId)

            iconFrame:SetSize(iconSize, iconSize)
            iconFrame:ClearAllPoints()
            iconFrame:SetPoint("LEFT", frame.auraFrame, "CENTER", startX + (i - 1) * (iconSize + spacing), 0)
            iconFrame:Show()
        else
            iconFrame:Hide()
            iconFrame:SetScript("OnUpdate", nil)
            if iconFrame.duration then iconFrame.duration:Hide() end
        end
    end
end

----------------------------------------------------------------------
-- Collect Auras (Midnight 12.0 compatible)
-- Uses GetUnitAuraInstanceIDs() if available, falls back to
-- GetAuraDataBySlot or ForEachAura.
----------------------------------------------------------------------
function Addon:CollectAuras(unitId, filter, auras, db)
    local function ProcessAura(aura)
        if not aura then return end

        -- In 12.0, "only mine" filtering is handled by the "|PLAYER" flag
        -- in the API filter string, so we don't need to check sourceUnit here.

        local isSecret = issecretvalue or function() return false end

        -- Whitelist/blacklist filtering (skipped when spell IDs are secret)
        if db.auras.filterMode == "WHITELIST" and next(db.auras.whitelist) ~= nil then
            local spellId = aura.spellId
            if spellId and not isSecret(spellId) then
                if not db.auras.whitelist[spellId] then
                    return
                end
            end
        elseif db.auras.filterMode == "BLACKLIST" then
            local spellId = aura.spellId
            if spellId and not isSecret(spellId) then
                if db.auras.blacklist[spellId] then
                    return
                end
            end
        end

        -- Use filter string to determine harmful since isHarmful may be secret
        -- filter may be "HARMFUL|PLAYER" so check with string.find
        table.insert(auras, {
            name = aura.name,
            icon = aura.icon,
            stacks = aura.applications,
            duration = aura.duration,
            expirationTime = aura.expirationTime,
            spellId = aura.spellId,
            isHarmful = (string.find(filter, "HARMFUL") ~= nil),
            dispelType = aura.dispelName,
            auraInstanceID = aura.auraInstanceID,
        })
    end

    -- Method 1: GetUnitAuraInstanceIDs (new in 12.0, preferred)
    if C_UnitAuras and C_UnitAuras.GetUnitAuraInstanceIDs then
        local instanceIDs = C_UnitAuras.GetUnitAuraInstanceIDs(unitId, filter)
        if instanceIDs then
            for _, instanceID in ipairs(instanceIDs) do
                local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unitId, instanceID)
                if aura then
                    ProcessAura(aura)
                end
            end
            return
        end
    end

    -- Method 2: GetAuraDataBySlot (TWW+)
    if C_UnitAuras and C_UnitAuras.GetAuraDataBySlot then
        local slot = 1
        local found = false
        while slot <= 80 do
            local aura = C_UnitAuras.GetAuraDataBySlot(unitId, slot)
            if not aura then break end
            found = true

            local isHarmful = aura.isHarmful
            local wantHarmful = (string.find(filter, "HARMFUL") ~= nil)
            if (wantHarmful and isHarmful) or (not wantHarmful and not isHarmful) then
                ProcessAura(aura)
            end
            slot = slot + 1
        end
        if found then return end
    end

    -- Method 3: ForEachAura fallback
    if AuraUtil and AuraUtil.ForEachAura then
        AuraUtil.ForEachAura(unitId, filter, nil, function(aura)
            ProcessAura(aura)
        end, true)
    end
end

----------------------------------------------------------------------
-- Apply Aura Data to Icon Frame (Midnight 12.0 compatible)
-- Secret values are passed directly to widget APIs (SetTexture,
-- SetText, SetCooldown) which accept them.
----------------------------------------------------------------------
function Addon:SetAuraIcon(iconFrame, aura, db, unitId)
    if not aura then
        iconFrame:Hide()
        return
    end

    -- Texture (SetTexture accepts secret texture paths)
    iconFrame.texture:SetTexture(aura.icon)

    -- Border color (keep thin black border — clean look)
    if iconFrame.border then
        iconFrame.border:SetColorTexture(0, 0, 0, 1)
    end

    -- Stack count — only show if stacks > 1
    -- In 12.0, applications may be secret, so use pcall for the > 1 check
    if db.auras.showStacks and aura.stacks then
        local showStacks = false
        local ok, result = pcall(function() return aura.stacks > 1 end)
        if ok then showStacks = result end
        if showStacks then
            iconFrame.stacks:SetText(string.format("%d", aura.stacks))
            iconFrame.stacks:Show()
        else
            iconFrame.stacks:Hide()
        end
    else
        iconFrame.stacks:Hide()
    end

    -- In Midnight (12.0), aura duration/expirationTime are secret values.
    -- Use C_UnitAuras.GetAuraDuration() which returns a DurationObject,
    -- then use SetCooldownFromDurationObject() and GetRemainingDuration().
    local durationObj
    if C_UnitAuras and C_UnitAuras.GetAuraDuration and unitId and aura.auraInstanceID then
        durationObj = C_UnitAuras.GetAuraDuration(unitId, aura.auraInstanceID)
    end

    -- Cooldown spiral
    if db.auras.showCooldownSpiral then
        if durationObj and iconFrame.cooldown.SetCooldownFromDurationObject then
            -- Midnight path: use DurationObject directly
            iconFrame.cooldown:SetCooldownFromDurationObject(durationObj)
            iconFrame.cooldown:Show()
        elseif aura.duration and aura.expirationTime then
            -- Fallback: try arithmetic (may fail with secrets)
            pcall(function()
                iconFrame.cooldown:SetCooldown(aura.expirationTime - aura.duration, aura.duration)
            end)
            iconFrame.cooldown:Show()
        else
            iconFrame.cooldown:Hide()
        end
    else
        iconFrame.cooldown:Hide()
    end

    -- Custom duration text on icon
    if db.auras.showDuration and iconFrame.duration then
        iconFrame.durationObject = durationObj
        iconFrame.expirationTime = aura.expirationTime
        if durationObj or aura.expirationTime then
            iconFrame.duration:Show()
            -- Set up OnUpdate to tick the duration text
            iconFrame:SetScript("OnUpdate", function(self, elapsed)
                self._elapsed = (self._elapsed or 0) + elapsed
                if self._elapsed < 0.1 then return end
                self._elapsed = 0
                if self.durationObject and self.durationObject.GetRemainingDuration then
                    -- GetRemainingDuration returns a secret — pass directly to format
                    self.duration:SetText(string.format("%.0f", self.durationObject:GetRemainingDuration()))
                else
                    self.duration:SetText("")
                end
            end)
        else
            iconFrame.duration:Hide()
            iconFrame:SetScript("OnUpdate", nil)
        end
    elseif iconFrame.duration then
        iconFrame.duration:Hide()
        iconFrame:SetScript("OnUpdate", nil)
    end
end

----------------------------------------------------------------------
-- Format Duration (e.g. 5.1, 1:23, 5m)
----------------------------------------------------------------------
function Addon:FormatDuration(seconds)
    if seconds < 10 then
        return string.format("%.1f", seconds)
    elseif seconds < 60 then
        return string.format("%d", math.floor(seconds))
    elseif seconds < 3600 then
        return string.format("%dm", math.floor(seconds / 60))
    else
        return string.format("%dh", math.floor(seconds / 3600))
    end
end
