local addonName, ns = ...

local DEFAULT_spellVisualDensityFilterSetting = 1

-- Addon name
local function AddonName(color)
    local color = color or "00FF00"
    return string.format("|cff%s%s|r", color, addonName)
end

-- print() with addon name
local function Msg(msg, value)
    value = value or ""
    print(AddonName() .. ": " .. msg .. " " .. value)
end

local function IsLockedDown()
    return InCombatLockdown() or C_ChallengeMode.IsChallengeModeActive()
end

-- login message
local _version = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""
Msg("Version", version)

local function SetSpellDensity(display)
    C_CVar.SetCVar('spellVisualDensityFilterSetting', DEFAULT_spellVisualDensityFilterSetting)

    if display then
        local svdfs = C_CVar.GetCVar('spellVisualDensityFilterSetting')
        Msg(AddonName(), "Spell Density " .. svdfs)
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
