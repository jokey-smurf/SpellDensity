local addonName, ns = ...

-- 1 - minimum, 2 - reduced, 3 - performance, 4 - full
local DEFAULT_spellVisualDensityFilterSetting = 1

-- Addon name
local function AddonName(color)
    local color = color or "00FF00"
    return string.format("|cff%s%s|r", color, addonName)
end

-- print() with addon name
local function Msg(msg, ...)
    print(AddonName() .. ": " .. msg, ...)
end

local function IsLockedDown()
    return InCombatLockdown() or C_ChallengeMode.IsChallengeModeActive()
end

local SVDF_CVAR_NAME = "spellVisualDensityFilterSetting"
local MIN_SVDF = 1
local MAX_SVDF = 4

local function SetSpellDensity(display)
    local original = C_CVar.GetCVar(SVDF_CVAR_NAME)
    local svdf = math.min(math.max(MIN_SVDF, DEFAULT_spellVisualDensityFilterSetting), MAX_SVDF)
    C_CVar.SetCVar(SVDF_CVAR_NAME, svdf)
    svdf = C_CVar.GetCVar('spellVisualDensityFilterSetting')

    if not display then
        display = original ~= svdf
    end
    if display then
        Msg("Old value was", original, "- New value is", svdf)
    end
end

local spellDensityFrame = CreateFrame("Frame", "SpellDensityFrame")
spellDensityFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
spellDensityFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local _firstTime = true
spellDensityFrame:SetScript("OnEvent", function(self, event)
    if IsLockedDown() then
        return
    end
    SetSpellDensity(_firstTime)
    _firstTime = false
end)

SLASH_SPELLDENSITY1 = "/spelldensity"
SlashCmdList["SPELLDENSITY"] = function(msg)
    SetSpellDensity(true)
end
