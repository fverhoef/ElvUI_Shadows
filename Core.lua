local E, L, V, P, G = unpack(ElvUI)
local Module = E:GetModule("ElvUI_Shadows")
local LSM = LibStub("LibSharedMedia-3.0")
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local B = E:GetModule("Bags")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local LO = E:GetModule("Layout")
local NP = E:GetModule("NamePlates")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function Module:Scale(x)
    return 1 * floor(x / 1 + .5)
end

function Module:SetInside(obj, anchor, xOffset, yOffset, anchor2)
    xOffset = xOffset or 1
    yOffset = yOffset or 1
    anchor = anchor or obj:GetParent()

    assert(anchor)
    if obj:GetPoint() then
        obj:ClearAllPoints()
    end

    obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
    obj:SetPoint("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

function Module:SetOutside(obj, anchor, xOffset, yOffset, anchor2)
    xOffset = xOffset or 1
    yOffset = yOffset or 1
    anchor = anchor or obj:GetParent()

    assert(anchor)
    if obj:GetPoint() then
        obj:ClearAllPoints()
    end

    obj:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
    obj:SetPoint("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

function Module:CreateShadows()
    -- Unit Frames
    Module:CreateUnitFrameShadows("player")
    Module:CreateUnitFrameShadows("pet")
    Module:CreateUnitFrameShadows("target")
    Module:CreateUnitFrameShadows("targettarget")
    Module:CreateUnitFrameShadows("focus")

    -- Unit Frame Groups
    Module:CreateUnitGroupShadows("arena")
    Module:CreateUnitGroupShadows("assist")
    Module:CreateUnitGroupShadows("boss")
    Module:CreateUnitGroupShadows("party")
    Module:CreateUnitGroupShadows("raid")
    Module:CreateUnitGroupShadows("raid40")
    Module:CreateUnitGroupShadows("tank")

    -- Action Bars
    for i = 1, 10 do
        Module:CreateShadow(AB.handledBars["bar" .. i])
    end

    -- Addon Manager
    Module:CreateShadow(_G.AddonList)

    -- Auras
    if not A.hookedShadows then
        hooksecurefunc(A, "UpdateAura", function(self, button)
            Module:CreateShadow(button)
        end)
        hooksecurefunc(A, "UpdateStatusBar", function(self, button)
            Module:CreateShadow(button)
        end)
        hooksecurefunc(A, "UpdateTempEnchant", function(self, button)
            Module:CreateShadow(button)
        end)
        A.hookedShadows = true
    end

    -- Bags
    Module:CreateShadow(B.BagFrame)
    Module:CreateShadow(B.BankFrame)

    -- BG Score
    Module:CreateShadow(_G.WorldStateScoreFrame.backdrop)

    -- Chat
    Module:CreateShadow(_G.LeftChatPanel.backdrop)
    Module:CreateShadow(_G.LeftChatDataPanel)
    Module:CreateShadow(_G.LeftChatToggleButton)
    Module:CreateShadow(_G.RightChatPanel.backdrop)
    Module:CreateShadow(_G.RightChatDataPanel)
    Module:CreateShadow(_G.RightChatToggleButton)

    -- Data Bars
    Module:CreateShadow(DB.expBar)
    Module:CreateShadow(DB.petExpBar)
    Module:CreateShadow(DB.repBar)

    -- ElvUI Options
    if not E.hookedShadows then
        hooksecurefunc(E, "Config_WindowOpened", function()
            local optionsFrame = E:Config_GetWindow()
            if optionsFrame then
                Module:CreateShadow(optionsFrame)
            end
        end)

        -- ElvUI Popups
        hooksecurefunc(E, "StaticPopupSpecial_Show", function(self, frame)
            Module:CreateShadow(frame)
        end)

        E.hookedShadows = true
    end

    -- Channels
    Module:CreateShadow(_G.ChannelFrame)

    -- Chat Config
    Module:CreateShadow(_G.ChatConfigFrame)

    -- Character Frame
    Module:CreateShadow(_G.CharacterFrame.backdrop)
    if CharacterModelFrame.Background then
        Module:CreateShadow(_G.CharacterModelFrame)
    end
    Module:CreateShadow(_G.ReputationDetailFrame)
    for i = 1, #CHARACTERFRAME_SUBFRAMES do
        local tab = _G["CharacterFrameTab" .. i]
        if tab and false then
            Module:CreateShadow(tab.backdrop)
            -- tab.backdrop:SetFrameLevel(_G.CharacterFrame:GetFrameLevel() - 1)
        end
    end
    local slots = {
        "HeadSlot",
        "NeckSlot",
        "ShoulderSlot",
        "BackSlot",
        "ChestSlot",
        "ShirtSlot",
        "TabardSlot",
        "WristSlot",
        "HandsSlot",
        "WaistSlot",
        "LegsSlot",
        "FeetSlot",
        "Finger0Slot",
        "Finger1Slot",
        "Trinket0Slot",
        "Trinket1Slot",
        "MainHandSlot",
        "SecondaryHandSlot",
        "RangedSlot"
    }
    for i, slot in next, slots do
        local button = _G["Character" .. slot]
        if button then
            Module:CreateShadow(button)
        end
    end

    -- DressUp
    Module:CreateShadow(_G.DressUpFrame.backdrop)

    -- Friends Frame
    Module:CreateShadow(_G.FriendsFrame.backdrop)
    Module:CreateShadow(_G.AddFriendFrame)
    Module:CreateShadow(_G.GuildInfoFrame.backdrop)
    Module:CreateShadow(_G.GuildMemberDetailFrame)
    Module:CreateShadow(_G.GuildControlPopupFrame.backdrop)
    Module:CreateShadow(_G.RaidInfoFrame)
    for i = 1, #_G.FRIENDSFRAME_SUBFRAMES do
        local tab = _G["FriendsFrameTab" .. i]
        if tab and false then
            Module:CreateShadow(tab.backdrop)
            -- tab.backdrop:SetFrameLevel(_G.FriendsFrame:GetFrameLevel() - 1)
        end
    end

    -- Game Menu
    Module:CreateShadow(_G.GameMenuFrame)

    -- Gossip
    Module:CreateShadow(_G.GossipFrame.backdrop)

    -- Guild Registrar
    Module:CreateShadow(_G.GuildRegistrarFrame.backdrop)

    -- Help
    Module:CreateShadow(_G.HelpFrame)
    Module:CreateShadow(_G.HelpFrameHeader.backdrop)

    -- Interface Options
    Module:CreateShadow(_G.InterfaceOptionsFrame)

    -- Loot History
    Module:CreateShadow(_G.LootFrame)
    Module:CreateShadow(_G.LootHistoryFrame)
    Module:CreateShadow(_G.MasterLooterFrame)

    -- Mail Frame
    Module:CreateShadow(_G.MailFrame.backdrop)
    Module:CreateShadow(_G.OpenMailFrame.backdrop)

    -- Merchant Frame
    Module:CreateShadow(_G.MerchantFrame.backdrop)

    -- Minimap
    Module:CreateShadow(_G.MMHolder)

    -- Mirror Timers
    for i = 1, 3 do
        Module:CreateShadow(_G["MirrorTimer" .. i .. "StatusBar"])
    end

    -- NamePlates
    if not NP.hookedShadows then
        hooksecurefunc(NP, "UpdatePlate", function(self, nameplate)
            if not nameplate.Health.shadow then
                Module:CreateShadow(nameplate.Health)
                Module:CreateShadow(nameplate.Power)
                Module:CreateShadow(nameplate.Castbar)
                hooksecurefunc(nameplate.Buffs, "PostUpdateIcon", function(self, unit, button)
                    Module:CreateShadow(button)
                end)
                hooksecurefunc(nameplate.Debuffs, "PostUpdateIcon", function(self, unit, button)
                    Module:CreateShadow(button)
                end)
            end
        end)
        NP.hookedShadows = true
    end

    -- Panels
    Module:CreateShadow(LO.BottomPanel)
    Module:CreateShadow(LO.TopPanel)

    -- Pet Stable Frame
    Module:CreateShadow(_G.PetStableFrame.backdrop)

    -- Petition Frame
    Module:CreateShadow(_G.PetitionFrame.backdrop)

    -- Popups    
    for i = 1, 4 do
        local popup = _G["StaticPopup" .. i]
        Module:CreateShadow(popup)
    end
    for i = 1, 4 do
        local popup = _G["ElvUI_StaticPopup" .. i]
        Module:CreateShadow(popup)
    end
    Module:CreateShadow(_G.StackSplitFrame)

    -- Quest Frame
    Module:CreateShadow(_G.QuestFrame.backdrop)
    Module:CreateShadow(_G.QuestLogFrame.backdrop)

    -- Raid Utility Panel
    Module:CreateShadow(RaidUtilityPanel)
    Module:CreateShadow(_G.RaidControlButton)

    -- Ready Check
    Module:CreateShadow(_G.ReadyCheckFrame)

    -- Script Errors
    Module:CreateShadow(_G.ScriptErrorsFrame)

    -- Spellbook Frame
    Module:CreateShadow(_G.SpellBookFrame.backdrop)
    for i = 1, _G.MAX_SKILLLINE_TABS do
        local tab = _G["SpellBookSkillLineTab" .. i]
        Module:CreateShadow(tab)
        -- tab:SetFrameLevel(_G.SpellBookFrame:GetFrameLevel() - 1)
    end

    -- Tabard
    Module:CreateShadow(_G.TabardFrame.backdrop)

    -- Taxi
    Module:CreateShadow(_G.TaxiFrame.backdrop)

    -- Tooltips	
    Module:CreateShadow(_G.GameTooltip)
    Module:CreateShadow(_G.GameTooltipStatusBar)
    Module:CreateShadow(_G.ItemRefTooltip)
    Module:CreateShadow(_G.ItemRefShoppingTooltip1)
    Module:CreateShadow(_G.ItemRefShoppingTooltip2)
    Module:CreateShadow(_G.AutoCompleteBox)
    Module:CreateShadow(_G.FriendsTooltip)
    Module:CreateShadow(_G.ShoppingTooltip1)
    Module:CreateShadow(_G.ShoppingTooltip2)
    Module:CreateShadow(_G.EmbeddedItemTooltip)
    Module:CreateShadow(DT.tooltip)
    -- TODO: Options dialog tooltips

    -- Trade
    Module:CreateShadow(_G.TradeFrame.backdrop)

    -- Tutorial
    Module:CreateShadow(_G.TutorialFrame)

    -- Video Options (System)
    Module:CreateShadow(_G.VideoOptionsFrame)

    -- World Map
    Module:CreateShadow(_G.WorldMapFrame)

    -- Plugins
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Module:CreateShadow(_G[merathilis[1].Title .. "TopPanel"])
        Module:CreateShadow(_G[merathilis[1].Title .. "BottomPanel"])
    end

    local classicClassBars = _G["ClassicClassBars"]
    if classicClassBars then
        Module:CreateShadow(classicClassBars.MageBar)
        Module:CreateShadow(classicClassBars.ShamanBar)
    end
end

function Module:CreateUnitFrameShadows(frame)
    local unitFrame = UF[frame]
    if unitFrame and (not frame.shadow) then
        Module:CreateShadow(unitFrame)
        if unitFrame.Castbar then
            Module:CreateShadow(unitFrame.Castbar.Holder)
        end
        if unitFrame.Power and unitFrame.POWERBAR_DETACHED then
            Module:CreateShadow(unitFrame.Power.Holder)
        end
        if unitFrame.ClassBar then
            Module:CreateShadow(unitFrame.ClassBar.Holder)
        end
        hooksecurefunc(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
            Module:CreateShadow(button)
        end)
        hooksecurefunc(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
            Module:CreateShadow(button)
        end)
    end
end

function Module:CreateUnitGroupShadows(group)
    local header = UF[group]
    if header then
        if header.groups then
            for i, group in next, header.groups do
                for j, obj in next, group do
                    if type(obj) == "table" then
                        if obj.unit then
                            Module:CreateShadow(obj)
                            if obj.Castbar then
                                Module:CreateShadow(obj.Castbar.Holder)
                            end
                        end
                    end
                end
            end
        else
            -- tank, assist
            -- TODO: targets
            for i, obj in next, header do
                if type(obj) == "table" then
                    if obj.unit then
                        Module:CreateShadow(obj)
                        if obj.Castbar then
                            Module:CreateShadow(obj.Castbar.Holder)
                        end
                    end
                end
            end
        end
    end
end

function Module:CreateShadow(frame, config)
    if frame and (not frame.shadow) then
        frame.shadow = CreateFrame("Frame", nil, frame)
        if (not config) then
            config = E.db.ElvUI_Shadows.general
        end
        frame.shadow.config = config
        Module:RegisterShadow(frame.shadow)
        Module:UpdateShadow(frame.shadow)
    end
end

function Module:RegisterShadow(shadow)
    if not shadow then
        return
    end
    if shadow.isRegistered then
        return
    end
    Module.shadows[shadow] = true
    shadow.isRegistered = true
end

function Module:UpdateShadows()
    if UnitAffectingCombat("player") then
        return
    end

    Module:CreateShadows()
    for frame, _ in pairs(self.shadows) do
        Module:UpdateShadow(frame)
    end
end

function Module:UpdateShadow(shadow)
    if not E.db.ElvUI_Shadows.general.enabled then
        shadow:Hide()
    else
        shadow:Show()

        local frame = shadow:GetParent()
        shadow:SetFrameLevel(1)
        shadow:SetFrameStrata(frame:GetFrameStrata())
        shadow:SetOutside(frame, shadow.config.size or 3, shadow.config.size or 3)
        shadow:SetBackdrop({edgeFile = LSM:Fetch("border", "ElvUI GlowBorder"), edgeSize = E:Scale(shadow.config.size > 3 and shadow.config.size or 3)})
        shadow:SetBackdropColor(shadow.config.color.r, shadow.config.color.g, shadow.config.color.b, 0)
        shadow:SetBackdropBorderColor(shadow.config.color.r, shadow.config.color.g, shadow.config.color.b, shadow.config.color.a)
    end
end

function Module:GROUP_ROSTER_UPDATE()
    Module:UpdateShadows()
end

function Module:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        Module:ScheduleTimer("LoadAuctionFrame", 0.01)
    elseif addonName == "Blizzard_BindingUI" then
        Module:ScheduleTimer("LoadBindingsFrame", 0.01)
    elseif addonName == "Blizzard_Communities" then
        Module:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    elseif addonName == "Blizzard_CraftUI" then
        Module:ScheduleTimer("LoadCraftFrame", 0.01)
    elseif addonName == "Blizzard_GMChatUI" then
        Module:ScheduleTimer("LoadGMChatFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        Module:ScheduleTimer("LoadInspectFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        Module:ScheduleTimer("LoadMacroFrame", 0.01)
    elseif addonName == "Blizzard_RaidUI" then
        Module:ScheduleTimer("LoadRaidFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Module:ScheduleTimer("LoadTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Module:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Module:ScheduleTimer("LoadTrainerFrame", 0.01)
    elseif addonName == "ClassicClassBars" then
        Module:ScheduleTimer("LoadClassicClassBars", 0.01)
    end
end

function Module:LoadAuctionFrame()
    if _G.AuctionFrame then
        Module:CreateShadow(_G.AuctionFrame.backdrop)
    else
        Module:ScheduleTimer("LoadAuctionFrame", 0.01)
    end
end

function Module:LoadBindingsFrame()
    if _G.KeyBindingFrame then
        Module:CreateShadow(_G.KeyBindingFrame.backdrop)
    else
        Module:ScheduleTimer("LoadBindingsFrame", 0.01)
    end
end

function Module:LoadCommunitiesFrame()
    if _G.CommunitiesFrame then
        Module:CreateShadow(_G.CommunitiesFrame.backdrop)
    else
        Module:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    end
end

function Module:LoadCraftFrame()
    if _G.CraftFrame then
        Module:CreateShadow(_G.CraftFrame.backdrop)
    else
        Module:ScheduleTimer("LoadCraftFrame", 0.01)
    end
end

function Module:LoadGMChatFrame()
    if _G.GMChatFrame then
        Module:CreateShadow(_G.GMChatFrame)
    else
        Module:ScheduleTimer("LoadGMChatFrame", 0.01)
    end
end

function Module:LoadInspectFrame()
    if _G.InspectFrame then
        Module:CreateShadow(_G.InspectFrame.backdrop)
    else
        Module:ScheduleTimer("LoadInspectFrame", 0.01)
    end
end

function Module:LoadMacroFrame()
    if _G.MacroFrame then
        Module:CreateShadow(_G.MacroFrame.backdrop)
        Module:CreateShadow(_G.MacroPopupFrame)
    else
        Module:ScheduleTimer("LoadMacroFrame", 0.01)
    end
end

function Module:LoadRaidFrame()
    if _G["RaidPullout1"] then
        local rp
        for i = 1, _G.NUM_RAID_PULLOUT_FRAMES do
            rp = _G["RaidPullout" .. i]
            Module:CreateShadow(rp.backdrop)
        end
    else
        Module:ScheduleTimer("LoadRaidFrame", 0.01)
    end
end

function Module:LoadTalentFrame()
    if _G.TalentFrame then
        Module:CreateShadow(_G.TalentFrame.backdrop)
    else
        Module:ScheduleTimer("LoadTalentFrame", 0.01)
    end
end

function Module:LoadTradeSkillFrame()
    if _G.TradeSkillFrame then
        Module:CreateShadow(_G.TradeSkillFrame.backdrop)
    else
        Module:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    end
end

function Module:LoadTrainerFrame()
    if _G.ClassTrainerFrame then
        Module:CreateShadow(_G.ClassTrainerFrame.backdrop)
    else
        Module:ScheduleTimer("LoadTrainerFrame", 0.01)
    end
end

function Module:LoadClassicClassBars()
    if _G.ClassicClassBars then
        Module:CreateShadow(_G.ClassicClassBars.MageBar)
        Module:CreateShadow(_G.ClassicClassBars.ShamanBar)
    else
        Module:ScheduleTimer("LoadClassicClassBars", 0.01)
    end
end
