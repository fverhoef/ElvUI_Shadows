local E, L, V, P, G = unpack(ElvUI)
local ElvUI_Shadows = E:GetModule("ElvUI_Shadows")
local LSM = LibStub("LibSharedMedia-3.0")
local AB = E:GetModule("ActionBars")
local B = E:GetModule("Bags")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local LO = E:GetModule("Layout")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function ElvUI_Shadows:Scale(x)
    return 1 * floor(x / 1 + .5)
end

function ElvUI_Shadows:SetTemplate(frame)
    if ElvUI_Shadows.AddOnSkins then
        AddOnSkins[1]:SetTemplate(frame)
    elseif frame.SetTemplate then
        frame:SetTemplate("Transparent", true)
    else
        frame:SetBackdrop({
            bgFile = ElvUI_Shadows.SolidBackground,
            edgeFile = ElvUI_Shadows.SolidBackground,
            tile = false,
            tileSize = 0,
            edgeSize = 1,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        })
        frame:SetBackdropColor(.08, .08, .08, .8)
        frame:SetBackdropBorderColor(0, 0, 0)
    end
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
    if ElvUI_Shadows.IsRetail then
        ElvUI_Shadows:CreateUnitFrameShadows("assist")
    end
    ElvUI_Shadows:CreateUnitFrameShadows("boss")
    ElvUI_Shadows:CreateUnitFrameShadows("party1")
    ElvUI_Shadows:CreateUnitFrameShadows("party2")
    ElvUI_Shadows:CreateUnitFrameShadows("party3")
    ElvUI_Shadows:CreateUnitFrameShadows("party4")

    -- Action Bars
    for i = 1, 10 do
        ElvUI_Shadows:CreateShadow(AB.handledBars["bar" .. i])
    end

    -- Addon Manager
    ElvUI_Shadows:CreateShadow(_G.AddonList)

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
    hooksecurefunc(E, "Config_WindowOpened", function()
        local optionsFrame = E:Config_GetWindow()
        if optionsFrame then
            ElvUI_Shadows:CreateShadow(optionsFrame)
        end
    end)

    -- Channels
    ElvUI_Shadows:CreateShadow(_G.ChannelFrame)

    -- Chat Config
    ElvUI_Shadows:CreateShadow(_G.ChatConfigFrame)

    -- Character Frame
    ElvUI_Shadows:CreateShadow(_G.CharacterFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.ReputationDetailFrame)
    for i = 1, #CHARACTERFRAME_SUBFRAMES do
        local tab = _G["CharacterFrameTab" .. i]
        if tab and false then
            ElvUI_Shadows:CreateShadow(tab.backdrop)
            -- tab.backdrop:SetFrameLevel(_G.CharacterFrame:GetFrameLevel() - 1)
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
    ElvUI_Shadows:CreateShadow(_G.LootHistoryFrame)

    -- Mail Frame
    ElvUI_Shadows:CreateShadow(_G.MailFrame.backdrop)

    -- Merchant Frame
    ElvUI_Shadows:CreateShadow(_G.MerchantFrame.backdrop)

    -- Minimap
    ElvUI_Shadows:CreateShadow(_G.MMHolder)

    -- Mirror Timers
    for i = 1, 3 do
        ElvUI_Shadows:CreateShadow(_G["MirrorTimer" .. i .. "StatusBar"])
    end

    -- Panels
    ElvUI_Shadows:CreateShadow(LO.BottomPanel)
    ElvUI_Shadows:CreateShadow(LO.TopPanel)

    -- Pet Stable Frame
    ElvUI_Shadows:CreateShadow(_G.PetStableFrame.backdrop)

    -- Petition Frame
    ElvUI_Shadows:CreateShadow(_G.PetitionFrame.backdrop)

    -- Quest Frame
    ElvUI_Shadows:CreateShadow(_G.QuestFrame.backdrop)
    ElvUI_Shadows:CreateShadow(_G.QuestLogFrame.backdrop)

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

    -- Trade
    ElvUI_Shadows:CreateShadow(_G.TradeFrame)

    -- Video Options (System)
    ElvUI_Shadows:CreateShadow(_G.VideoOptionsFrame)

    -- World Map
    ElvUI_Shadows:CreateShadow(_G.WorldMapFrame)
end

function ElvUI_Shadows:CreateUnitFrameShadows(frame)
    if UF[frame] then
        ElvUI_Shadows:CreateShadow(UF[frame])
        if UF[frame].Castbar then
            ElvUI_Shadows:CreateShadow(UF[frame].Castbar.Holder)
        end
    end
end

function ElvUI_Shadows:CreateShadow(frame, config)
    if frame and (not frame.Shadow) then
        if ElvUI_Shadows.AddOnSkins then
            AddOnSkins[1]:CreateShadow(frame)
            if (not config) then
                config = ElvUI_Shadows.ShadowConfig
            end
            frame.Shadow.Config = config
            ElvUI_Shadows:RegisterShadow(frame.Shadow)
            ElvUI_Shadows:UpdateShadow(frame.Shadow)
        elseif frame.CreateShadow then
            frame:CreateShadow()
        end
    end
end

function ElvUI_Shadows:RegisterShadow(shadow)
    if not shadow then
        return
    end
    if shadow.isRegistered then
        return
    end
    ElvUI_Shadows.RegisteredShadows[shadow] = true
    shadow.isRegistered = true
end

function ElvUI_Shadows:UpdateShadows()
    if UnitAffectingCombat("player") then
        return
    end

    ElvUI_Shadows:CreateShadows()
    for frame, _ in pairs(self.RegisteredShadows) do
        ElvUI_Shadows:UpdateShadow(frame)
    end
end

function ElvUI_Shadows:UpdateShadow(shadow)
    local r, g, b, a = unpack(shadow.Config.Color)

    local backdrop = shadow:GetBackdrop()

    local size = shadow.Config.Size
    shadow:SetOutside(shadow:GetParent(), size, size)

    backdrop.edgeSize = ElvUI_Shadows:Scale(size > 3 and size or 3)

    shadow:SetBackdrop(backdrop)
    shadow:SetBackdropColor(r, g, b, 0)
    shadow:SetBackdropBorderColor(r, g, b, a)
end

function ElvUI_Shadows:AddonLoaded(addonName)
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
