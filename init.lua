local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local Module = E:NewModule("ElvUI_Shadows", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.shadows = {}
Module.title = "|cff1784d1ElvUI|r |cff76FF03Shadows|r"

_G.ElvUI_Shadows = Module

function Module:Initialize()
    Module:CreateShadows()
    Module:ScheduleTimer("UpdateShadows", 1)
    Module:RegisterEvent("ADDON_LOADED", Module.ADDON_LOADED)
    Module:RegisterEvent("GROUP_ROSTER_UPDATE", Module.GROUP_ROSTER_UPDATE)

    EP:RegisterPlugin(addonName, Module.InsertOptions)
end

E:RegisterModule(Module:GetName())
