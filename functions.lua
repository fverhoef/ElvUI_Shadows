local E, L, V, P, G = unpack(ElvUI)
local ElvUI_Shadows = E:GetModule("ElvUI_Shadows")
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

function ElvUI_Shadows:Scale(x)
    return 1 * floor(x / 1 + .5)
end

function ElvUI_Shadows:SetInside(obj, anchor, xOffset, yOffset, anchor2)
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

function ElvUI_Shadows:SetOutside(obj, anchor, xOffset, yOffset, anchor2)
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

function ElvUI_Shadows:CreateShadows()
    -- Unit Frames
    ElvUI_Shadows:CreateUnitFrameShadows("player")
    ElvUI_Shadows:CreateUnitFrameShadows("pet")
    ElvUI_Shadows:CreateUnitFrameShadows("target")
    ElvUI_Shadows:CreateUnitFrameShadows("targettarget")
    ElvUI_Shadows:CreateUnitFrameShadows("focus")

    -- Unit Frame Groups
    ElvUI_Shadows:CreateUnitGroupShadows("arena")
    ElvUI_Shadows:CreateUnitGroupShadows("assist")
    ElvUI_Shadows:CreateUnitGroupShadows("boss")
    ElvUI_Shadows:CreateUnitGroupShadows("party")
    ElvUI_Shadows:CreateUnitGroupShadows("raid")
    ElvUI_Shadows:CreateUnitGroupShadows("raid40")
    ElvUI_Shadows:CreateUnitGroupShadows("tank")

    -- Action Bars
    for i = 1, 10 do
        ElvUI_Shadows:CreateShadow(AB.handledBars["bar" .. i])
    end

    -- Addon Manager
    ElvUI_Shadows:CreateShadow(_G.AddonList)

    -- Auras
    if not A.hookedShadows then
        hooksecurefunc(A, "UpdateAura", function(self, button)
            ElvUI_Shadows:CreateShadow(button)
        end)
        hooksecurefunc(A, "UpdateStatusBar", function(self, button)
            ElvUI_Shadows:CreateShadow(button)
        end)
        hooksecurefunc(A, "UpdateTempEnchant", function(self, button)
            ElvUI_Shadows:CreateShadow(button)
        end)
        A.hookedShadows = true
    end

    -- Bags
    ElvUI_Shadows:CreateShadow(B.BagFrame)
    ElvUI_Shadows:CreateShadow(B.BankFrame)

    -- BG Score
    ElvUI_Shadows:CreateShadow(_G.WorldStateScoreFrame.backdrop)

    -- Chat
    ElvUI_Shadows:CreateShadow(_G.LeftChatPanel)
    ElvUI_Shadows:CreateShadow(_G.LeftChatDataPanel)
    ElvUI_Shadows:CreateShadow(_G.LeftChatToggleButton)
    ElvUI_Shadows:CreateShadow(_G.RightChatPanel)
    ElvUI_Shadows:CreateShadow(_G.RightChatDataPanel)
    ElvUI_Shadows:CreateShadow(_G.RightChatToggleButton)

    -- Data Bars
    ElvUI_Shadows:CreateShadow(DB.expBar)
    ElvUI_Shadows:CreateShadow(DB.petExpBar)
    ElvUI_Shadows:CreateShadow(DB.repBar)

    -- ElvUI Options
    if not E.hookedShadows then
        hooksecurefunc(E, "Config_WindowOpened", function()
            local optionsFrame = E:Config_GetWindow()
            if optionsFrame then
                ElvUI_Shadows:CreateShadow(optionsFrame)
            end
        end)

        -- ElvUI Popups
        hooksecurefunc(E, "StaticPopupSpecial_Show", function(self, frame)
            ElvUI_Shadows:CreateShadow(frame)
        end)

        E.hookedShadows = true
    end

    -- Channels
    ElvUI_Shadows:CreateShadow(_G.ChannelFrame)

    -- Chat Config
    ElvUI_Shadows:CreateShadow(_G.ChatConfigFrame)

    -- Character Frame
    ElvUI_Shadows:CreateShadow(_G.CharacterFrame.backdrop)
    if CharacterModelFrame.Background then
        ElvUI_Shadows:CreateShadow(_G.CharacterModelFrame)
    end
    ElvUI_Shadows:CreateShadow(_G.ReputationDetailFrame)
    for i = 1, #CHARACTERFRAME_SUBFRAMES do
        local tab = _G["CharacterFrameTab" .. i]
        if tab and false then
            ElvUI_Shadows:CreateShadow(tab.backdrop)
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
            ElvUI_Shadows:CreateShadow(button)
        end
    end

    -- DressUp
    ElvUI_Shadows:CreateShadow(_G.DressUpFrame.backdrop)

    -- Friends Frame
    ElvUI_Shadows:CreateShadow(_G.FriendsFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.AddFriendFrame)
    ElvUI_Shadows:CreateShadow(_G.GuildInfoFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.GuildMemberDetailFrame)
    ElvUI_Shadows:CreateShadow(_G.GuildControlPopupFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.RaidInfoFrame)
    for i = 1, #_G.FRIENDSFRAME_SUBFRAMES do
        local tab = _G["FriendsFrameTab" .. i]
        if tab and false then
            ElvUI_Shadows:CreateShadow(tab.backdrop)
            -- tab.backdrop:SetFrameLevel(_G.FriendsFrame:GetFrameLevel() - 1)
        end
    end

    -- Game Menu
    ElvUI_Shadows:CreateShadow(_G.GameMenuFrame)

    -- Gossip
    ElvUI_Shadows:CreateShadow(_G.GossipFrame.backdrop)

    -- Guild Registrar
    ElvUI_Shadows:CreateShadow(_G.GuildRegistrarFrame.backdrop)

    -- Help
    ElvUI_Shadows:CreateShadow(_G.HelpFrame)
    ElvUI_Shadows:CreateShadow(_G.HelpFrameHeader.backdrop)

    -- Interface Options
    ElvUI_Shadows:CreateShadow(_G.InterfaceOptionsFrame)

    -- Loot History
    ElvUI_Shadows:CreateShadow(_G.LootFrame)
    ElvUI_Shadows:CreateShadow(_G.LootHistoryFrame)
    ElvUI_Shadows:CreateShadow(_G.MasterLooterFrame)

    -- Mail Frame
    ElvUI_Shadows:CreateShadow(_G.MailFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.OpenMailFrame.backdrop)

    -- Merchant Frame
    ElvUI_Shadows:CreateShadow(_G.MerchantFrame.backdrop)

    -- Minimap
    ElvUI_Shadows:CreateShadow(_G.MMHolder)

    -- Mirror Timers
    for i = 1, 3 do
        ElvUI_Shadows:CreateShadow(_G["MirrorTimer" .. i .. "StatusBar"])
    end

    -- NamePlates
    if not NP.hookedShadows then
        hooksecurefunc(NP, "UpdatePlate", function(self, nameplate)
            if not nameplate.Health.shadow then
                ElvUI_Shadows:CreateShadow(nameplate.Health)
                ElvUI_Shadows:CreateShadow(nameplate.Power)
                ElvUI_Shadows:CreateShadow(nameplate.Castbar)
                hooksecurefunc(nameplate.Buffs, "PostUpdateIcon", function(self, unit, button)
                    ElvUI_Shadows:CreateShadow(button)
                end)
                hooksecurefunc(nameplate.Debuffs, "PostUpdateIcon", function(self, unit, button)
                    ElvUI_Shadows:CreateShadow(button)
                end)
            end
        end)
        NP.hookedShadows = true
    end

    -- Panels
    ElvUI_Shadows:CreateShadow(LO.BottomPanel)
    ElvUI_Shadows:CreateShadow(LO.TopPanel)

    -- Pet Stable Frame
    ElvUI_Shadows:CreateShadow(_G.PetStableFrame.backdrop)

    -- Petition Frame
    ElvUI_Shadows:CreateShadow(_G.PetitionFrame.backdrop)

    -- Popups    
    for i = 1, 4 do
        local popup = _G["StaticPopup" .. i]
        ElvUI_Shadows:CreateShadow(popup)
    end
    for i = 1, 4 do
        local popup = _G["ElvUI_StaticPopup" .. i]
        ElvUI_Shadows:CreateShadow(popup)
    end
    ElvUI_Shadows:CreateShadow(_G.StackSplitFrame)

    -- Quest Frame
    ElvUI_Shadows:CreateShadow(_G.QuestFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.QuestLogFrame.backdrop)

    -- Raid Utility Panel
    ElvUI_Shadows:CreateShadow(RaidUtilityPanel)
    ElvUI_Shadows:CreateShadow(_G.RaidControlButton)

    -- Ready Check
    ElvUI_Shadows:CreateShadow(_G.ReadyCheckFrame)

    -- Script Errors
    ElvUI_Shadows:CreateShadow(_G.ScriptErrorsFrame)

    -- Spellbook Frame
    ElvUI_Shadows:CreateShadow(_G.SpellBookFrame.backdrop)
    for i = 1, _G.MAX_SKILLLINE_TABS do
        local tab = _G["SpellBookSkillLineTab" .. i]
        ElvUI_Shadows:CreateShadow(tab)
        -- tab:SetFrameLevel(_G.SpellBookFrame:GetFrameLevel() - 1)
    end

    -- Tabard
    ElvUI_Shadows:CreateShadow(_G.TabardFrame.backdrop)

    -- Taxi
    ElvUI_Shadows:CreateShadow(_G.TaxiFrame.backdrop)

    -- Tooltips	
    ElvUI_Shadows:CreateShadow(_G.GameTooltip)
    ElvUI_Shadows:CreateShadow(_G.GameTooltipStatusBar)
    ElvUI_Shadows:CreateShadow(_G.ItemRefTooltip)
    ElvUI_Shadows:CreateShadow(_G.ItemRefShoppingTooltip1)
    ElvUI_Shadows:CreateShadow(_G.ItemRefShoppingTooltip2)
    ElvUI_Shadows:CreateShadow(_G.AutoCompleteBox)
    ElvUI_Shadows:CreateShadow(_G.FriendsTooltip)
    ElvUI_Shadows:CreateShadow(_G.ShoppingTooltip1)
    ElvUI_Shadows:CreateShadow(_G.ShoppingTooltip2)
    ElvUI_Shadows:CreateShadow(_G.EmbeddedItemTooltip)
    ElvUI_Shadows:CreateShadow(DT.tooltip)
    -- TODO: Options dialog tooltips

    -- Trade
    ElvUI_Shadows:CreateShadow(_G.TradeFrame.backdrop)

    -- Tutorial
    ElvUI_Shadows:CreateShadow(_G.TutorialFrame)

    -- Video Options (System)
    ElvUI_Shadows:CreateShadow(_G.VideoOptionsFrame)

    -- World Map
    ElvUI_Shadows:CreateShadow(_G.WorldMapFrame)
end

function ElvUI_Shadows:CreateUnitFrameShadows(frame)
    local unitFrame = UF[frame]
    if unitFrame and (not frame.shadow) then
        ElvUI_Shadows:CreateShadow(unitFrame)
        if unitFrame.Castbar then
            ElvUI_Shadows:CreateShadow(unitFrame.Castbar.Holder)
        end
        hooksecurefunc(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
            ElvUI_Shadows:CreateShadow(button)
        end)
        hooksecurefunc(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
            ElvUI_Shadows:CreateShadow(button)
        end)
    end
end

function ElvUI_Shadows:CreateUnitGroupShadows(group)
    local header = UF[group]
    if header then
        if header.groups then
            for i, group in next, header.groups do
                for j, obj in next, group do
                    if type(obj) == "table" then
                        if obj.unit then
                            ElvUI_Shadows:CreateShadow(obj)
                            if obj.Castbar then
                                ElvUI_Shadows:CreateShadow(obj.Castbar.Holder)
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
                        ElvUI_Shadows:CreateShadow(obj)
                        if obj.Castbar then
                            ElvUI_Shadows:CreateShadow(obj.Castbar.Holder)
                        end
                    end
                end
            end
        end
    end
end

function ElvUI_Shadows:CreateShadow(frame, config)
    if frame and (not frame.shadow) then
        frame.shadow = CreateFrame("Frame", nil, frame)
        if (not config) then
            config = E.db.ElvUI_Shadows.general
        end
        frame.shadow.config = config
        ElvUI_Shadows:RegisterShadow(frame.shadow)
        ElvUI_Shadows:UpdateShadow(frame.shadow)
    end
end

function ElvUI_Shadows:RegisterShadow(shadow)
    if not shadow then
        return
    end
    if shadow.isRegistered then
        return
    end
    ElvUI_Shadows.shadows[shadow] = true
    shadow.isRegistered = true
end

function ElvUI_Shadows:UpdateShadows()
    if UnitAffectingCombat("player") then
        return
    end

    ElvUI_Shadows:CreateShadows()
    for frame, _ in pairs(self.shadows) do
        ElvUI_Shadows:UpdateShadow(frame)
    end
end

function ElvUI_Shadows:UpdateShadow(shadow)
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

function ElvUI_Shadows:GROUP_ROSTER_UPDATE()
    ElvUI_Shadows:UpdateShadows()
end

function ElvUI_Shadows:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        ElvUI_Shadows:ScheduleTimer("LoadAuctionFrame", 0.01)
    elseif addonName == "Blizzard_BindingUI" then
        ElvUI_Shadows:ScheduleTimer("LoadBindingsFrame", 0.01)
    elseif addonName == "Blizzard_Communities" then
        ElvUI_Shadows:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    elseif addonName == "Blizzard_CraftUI" then
        ElvUI_Shadows:ScheduleTimer("LoadCraftFrame", 0.01)
    elseif addonName == "Blizzard_GMChatUI" then
        ElvUI_Shadows:ScheduleTimer("LoadGMChatFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        ElvUI_Shadows:ScheduleTimer("LoadInspectFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        ElvUI_Shadows:ScheduleTimer("LoadMacroFrame", 0.01)
    elseif addonName == "Blizzard_RaidUI" then
        ElvUI_Shadows:ScheduleTimer("LoadRaidFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        ElvUI_Shadows:ScheduleTimer("LoadTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        ElvUI_Shadows:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        ElvUI_Shadows:ScheduleTimer("LoadTrainerFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadAuctionFrame()
    if _G.AuctionFrame then
        ElvUI_Shadows:CreateShadow(_G.AuctionFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadAuctionFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadBindingsFrame()
    if _G.KeyBindingFrame then
        ElvUI_Shadows:CreateShadow(_G.KeyBindingFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadBindingsFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadCommunitiesFrame()
    if _G.CommunitiesFrame then
        ElvUI_Shadows:CreateShadow(_G.CommunitiesFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadCraftFrame()
    if _G.CraftFrame then
        ElvUI_Shadows:CreateShadow(_G.CraftFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadCraftFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadGMChatFrame()
    if _G.GMChatFrame then
        ElvUI_Shadows:CreateShadow(_G.GMChatFrame)
    else
        ElvUI_Shadows:ScheduleTimer("LoadGMChatFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadInspectFrame()
    if _G.InspectFrame then
        ElvUI_Shadows:CreateShadow(_G.InspectFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadInspectFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadMacroFrame()
    if _G.MacroFrame then
        ElvUI_Shadows:CreateShadow(_G.MacroFrame.backdrop)
        ElvUI_Shadows:CreateShadow(_G.MacroPopupFrame)
    else
        ElvUI_Shadows:ScheduleTimer("LoadMacroFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadRaidFrame()
    if _G["RaidPullout1"] then
        local rp
        for i = 1, _G.NUM_RAID_PULLOUT_FRAMES do
            rp = _G["RaidPullout" .. i]
            ElvUI_Shadows:CreateShadow(rp.backdrop)
        end
    else
        ElvUI_Shadows:ScheduleTimer("LoadRaidFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadTalentFrame()
    if _G.TalentFrame then
        ElvUI_Shadows:CreateShadow(_G.TalentFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadTalentFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadTradeSkillFrame()
    if _G.TradeSkillFrame then
        ElvUI_Shadows:CreateShadow(_G.TradeSkillFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    end
end

function ElvUI_Shadows:LoadTrainerFrame()
    if _G.ClassTrainerFrame then
        ElvUI_Shadows:CreateShadow(_G.ClassTrainerFrame.backdrop)
    else
        ElvUI_Shadows:ScheduleTimer("LoadTrainerFrame", 0.01)
    end
end
