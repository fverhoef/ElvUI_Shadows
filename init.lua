local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local ElvUI_Shadows = E:NewModule("ElvUI_Shadows", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
ElvUI_Shadows.RegisteredShadows = {}
ElvUI_Shadows.ShadowConfig = {["Enable"] = true, ["Color"] = {0, 0, 0, 0.5}, ["ColorByClass"] = false, ["Size"] = 5}
ElvUI_Shadows.SolidBackground = LSM:Fetch("background", "Solid")

_G.ElvUI_Shadows = ElvUI_Shadows

function ElvUI_Shadows:InsertOptions()
    E.Options.args.ElvUI_Shadows = {order = 100, type = "group", name = "|cFF6FFF10Shadows|r", args = {}}
end

function ElvUI_Shadows:Initialize()
    ElvUI_Shadows:CreateShadows()
    ElvUI_Shadows:ScheduleTimer("UpdateShadows", 1)
    ElvUI_Shadows:RegisterEvent("ADDON_LOADED", ElvUI_Shadows.AddonLoaded)

    EP:RegisterPlugin(addonName, ElvUI_Shadows.InsertOptions)
end

E:RegisterModule(ElvUI_Shadows:GetName())
