local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local Module = E:NewModule(addonName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.shadows = {}
Module.name = "Shadows"
Module.title = "|cff76FF03" .. Module.name .. "|r"

addonTable[1] = Module
_G[addonName] = Module

function Module:Initialize()
    Module:CreateShadows()
    Module:ScheduleTimer("UpdateShadows", 1)
    Module:RegisterEvent("ADDON_LOADED", Module.ADDON_LOADED)
    Module:RegisterEvent("GROUP_ROSTER_UPDATE", Module.GROUP_ROSTER_UPDATE)

    EP:RegisterPlugin(Module.name, Module.InsertOptions)
end

E:RegisterModule(Module:GetName())
