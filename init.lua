local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local ElvUI_Shadows = E:NewModule("ElvUI_Shadows", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
ElvUI_Shadows.shadows = {}
ElvUI_Shadows.title = "|cff1784d1ElvUI|r |cff76FF03Shadows|r"

_G.ElvUI_Shadows = ElvUI_Shadows

function ElvUI_Shadows:Initialize()
    ElvUI_Shadows:CreateShadows()
    ElvUI_Shadows:ScheduleTimer("UpdateShadows", 1)
    ElvUI_Shadows:RegisterEvent("ADDON_LOADED", ElvUI_Shadows.ADDON_LOADED)
    ElvUI_Shadows:RegisterEvent("GROUP_ROSTER_UPDATE", ElvUI_Shadows.GROUP_ROSTER_UPDATE)

    EP:RegisterPlugin(addonName, ElvUI_Shadows.InsertOptions)
end

E:RegisterModule(ElvUI_Shadows:GetName())
