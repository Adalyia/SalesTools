--[[
    Project: SalesTools
    Desc: An addon with several useful Quality of Life features for the advertisement & administration of in-game gold sales
    Repo: https://github.com/Adalyia/SalesTools
    Author(s): 
    - Updated for 11.2 by Osiris the Kiwi / Discord: osirisnz
    - Emily Cohen / Emilýp-Illidan / adalyiawra@gmail.com
    - Honorax-Illidan - https://worldofwarcraft.com/en-us/character/us/illidan/honorax (Original author, this addon is largely based on his idea/work)
    - David Martínez / Volthemar-Dalaran / damaartinezgo@gmail.com
--]]

--[[
    TODO:
    - Possible refactor/rename back to AdTools
    - Localisation for ruRU, zhCN, zhTW, etc.
    - Drop the StdUi dependency (this lib doesn't seem to be actively maintained/developed at the moment)
    - Make the mail event code less janky (pls make this easier blizzard)
    - Separate modules into different addons (e.g. SalesTools_Mail, SalesTools_Log, SalesTools_Config, etc.) (this idea might be scrapped)
    - Add a "SalesTools_Config" module to handle options rather than having it in SalesTools_Main (this idea might be scrapped)
--]]

-- Basic imports(s)/setup
local L = LibStub("AceLocale-3.0"):GetLocale("SalesTools") -- Localization support
SalesTools = LibStub("AceAddon-3.0"):NewAddon("SalesTools", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
local StdUi = LibStub("StdUi")
local LibDBIcon = LibStub("LibDBIcon-1.0")

-- Global for our addon object
_G["SalesTools"] = SalesTools

-- Debugging mode
local DEBUG_MODE = false

-- Addon constants
local ADDON_CHAT_PREFIX = "|cffFFE400[|r|cff3AFF00" .. L["Addon_Name"] .. "|r|cffFFE400]|r"
local ADDON_COMMAND1,ADDON_COMMAND2,ADDON_COMMAND3,ADDON_COMMAND4 = "sales","sale","st","ad"
local ADDON_ICON = [=[Interface\Addons\SalesTools\media\i32.tga]=]
local MINIMAP_DEFAULTS = {
    { text = L["Addon_Name"], notCheckable = true, isTitle = true },
    { text = L["SalesTools_Minimap_HideMinimap"], notCheckable = true, func = function()
        SalesTools.db.global.minimap.hide = true;
        LibDBIcon:Refresh("SalesToolsMinimapButton", SalesTools.db.global.minimap)
    end }
}
local ADDON_OPTION_DEFAULTS = {
    desc = {
        type = "description",
        name = L["Description"],
        fontSize = "medium",
        order = 1
    },
    author = {
        type = "description",
        name = "\n|cffffd100" .. L["Author"] .. ": |r " .. C_AddOns.GetAddOnMetadata("SalesTools", "Author"),
        order = 2
    },
    version = {
        type = "description",
        name = "|cffffd100" .. L["Version"] .. ": |r" .. C_AddOns.GetAddOnMetadata("SalesTools", "Version") .. "\n",
        order = 3
    },
    hide_minimap = {
        name = L["SalesTools_Minimap_Option_Label"],
        desc = "|cffaaaaaa".. L["SalesTools_Minimap_Option_Desc"] .. "|r",
        descStyle = "inline",
        width = "full",
        type = "toggle",
        order = 4,
        set = function(_, val)
            SalesTools.db.global.minimap.hide = not val
            LibDBIcon:Refresh("SalesToolsMinimapButton", SalesTools.db.global.minimap)
        end,
        get = function(_)
            return not SalesTools.db.global.minimap.hide
        end
    },
}
local ADDON_COMMAND_DEFAULTS = {
    version = {
        desc = L["SalesTools_Version_Command_Desc"],
        action = function()
            SalesTools:Print(string.format(L["SalesTools_Version_Command_Msg"], C_AddOns.GetAddOnMetadata("SalesTools", "Version")))
            SalesTools:AddonInfoPanel()
        end,
    },
    minimap = {
        desc = L["SalesTools_Minimap_Command_Desc"],
        action = function()
            SalesTools.db.global.minimap.hide = not SalesTools.db.global.minimap.hide
            LibDBIcon:Refresh("SalesToolsMinimapButton", SalesTools.db.global.minimap)
        end,
    }
}

-- Replacements for the default print function to addon name localization
function SalesTools:Print(...)
    local str = ADDON_CHAT_PREFIX .. "|cff00F7FF "
    local count = select("#", ...)
	for i = 1, count do
		str = str .. tostring(select(i, ...))
		if i < count then
			str = str .. " "
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage(str .. "|r")
end

function SalesTools:Debug(...)
    if DEBUG_MODE then
        local str = ADDON_CHAT_PREFIX .. "|cffFF0000 "
        local count = select("#", ...)
        for i = 1, count do
            str = str .. tostring(select(i, ...))
            if i < count then
                str = str .. " "
            end
        end
        DEFAULT_CHAT_FRAME:AddMessage(str .. "|r")
    end
end

-- Core functions
function SalesTools:OnInitialize()
    -- Called when the addon is loaded
    self:Debug("OnInitialize")

    -- Set a starting Z value for our frames/windows
    self.FRAME_LEVEL = 0

    -- Instanced copy of the addon icon
    self.AddonIcon = ADDON_ICON

    -- Create our local options table / flatfile
    self.db = LibStub("AceDB-3.0"):New("SalesToolsDB", defaults)

    -- Create a list of minimap options from our defaults
    self.MinimapMenu = MINIMAP_DEFAULTS

    -- Create a list of buttons to attach to the mailbox frame, this can be filled/added to by modules
    self.MailboxButtons = {}
    
    -- Create our addon options dictionary, this determines options in the interface menu
    self.AddonOptions = ADDON_OPTION_DEFAULTS

    -- Create a list of addon commands/subcommands, this can be filled/added to by modules
    self.AddonCommands = ADDON_COMMAND_DEFAULTS

    -- Enumerate the modules we want to load
    self.MailLog = SalesTools:GetModule("MailLog")
    self.MailSender = SalesTools:GetModule("MailSender")
    self.MailGrabber = SalesTools:GetModule("MailGrabber")
    self.TradeLog = SalesTools:GetModule("TradeLog")
    self.BalanceList = SalesTools:GetModule("BalanceList")
    self.AutoInvite = SalesTools:GetModule("AutoInvite")
    self.HelperDisplay = SalesTools:GetModule("HelperDisplay")
    self.MassInvite = SalesTools:GetModule("MassInvite")
    self.MassWhisper = SalesTools:GetModule("MassWhisper")
    self.CollectorMenu = SalesTools:GetModule("CollectorMenu")
    self.NameGrabber = SalesTools:GetModule("NameGrabber")

    -- Modules to load at runtime
    for name, module in self:IterateModules() do
        module:SetEnabledState(true)
    end
    
    -- Draw minimap button
    SalesTools:DrawMinimapButton()

    -- Populate our addon options panel
    SalesTools:SetupOptions()
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SalesTools", "SalesTools")

    -- Command handler
    local function OnCommand(msg)
        -- Called when the addon is given a command
        self:Debug("OnCommand", msg)
    
        -- To make our command arguments non case sensitive convert the input string to lower case before comparison
        msg = string.lower(msg)
    
        -- Var that tells us if we executed a command or not
        local found = false
    
        -- Iterate through the registered commands, if we find a match execute the corresponding action
        for key, value in pairs(SalesTools.AddonCommands) do
            if (key == msg) then
                found = true
                value.action()
            end
            
        end
    
        -- If we find no valid commands, output the commands list
        if (not found) then
            self:Print("Commands:")
            for key, value in pairs(SalesTools.AddonCommands) do
                DEFAULT_CHAT_FRAME:AddMessage("   /" .. "|cffd4af37" .. ADDON_COMMAND1 .. "|r" .. " |cff00FF17" .. key .. " |r- |cff00F7FF" .. value.desc)
            end
        
        end
    end

    -- Register commands
    self:RegisterChatCommand(ADDON_COMMAND1, OnCommand)
    self:RegisterChatCommand(ADDON_COMMAND2, OnCommand)
    self:RegisterChatCommand(ADDON_COMMAND3, OnCommand)
    self:RegisterChatCommand(ADDON_COMMAND4, OnCommand)

    -- Print version information
    local _ver=C_AddOns.GetAddOnMetadata("SalesTools","Version"); self:Print(string.format("Version %s updated for patch 11.2 by Osiris the Kiwi", _ver))
end

function SalesTools:OnEnable()
    -- Called when the addon is enabled
    self:Debug("OnEnable")

    -- Disable tutorials KEKW
    SetCVar("showTutorials", 0)

    -- Register our event handlers
    self:RegisterEvent("MAIL_SHOW", "OnEvent")
    self:RegisterEvent("MAIL_CLOSED", "OnEvent")
end

function SalesTools:OnDisable()
    -- Called when the addon is disabled
    self:Debug("OnDisable")

end

-- Setup/basic UI functions

function SalesTools:DrawMinimapButton()
    -- Called to draw/display the minimap button
    self:Debug("DrawMinimapButton")

    if (self.db.global.minimap == nil) then
        self.db.global.minimap = { ["hide"] = false }
    end

    local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("SalesToolsMinimapButton", {
        type = "launcher",
        icon = self.AddonIcon,
        OnClick = function(self)
            if (not self.menuFrame) then
                local MenuFrame = CreateFrame("Frame", "MinimapMenuFrame", UIParent, "UIDropDownMenuTemplate")
                self.MinimapMenuFrame = MenuFrame
            end
            
            EasyMenu(SalesTools.MinimapMenu, self.MinimapMenuFrame, "cursor", 0, 0, "MENU");
            
        end,
    })

    LibDBIcon:Register("SalesToolsMinimapButton", ldb, self.db.global.minimap)
    LibDBIcon:Refresh("SalesToolsMinimapButton", self.db.global.minimap)
end

function SalesTools:SetupOptions()
    -- Called to create a menu for our addon's options in the Blizzard UI
    self:Debug("SetupOptions")

    local options = {
        name = L["Addon_Name"],
        descStyle = "inline",
        type = "group",
        childGroups = "tree",
        args = self.AddonOptions,
    }

    LibStub("AceConfig-3.0"):RegisterOptionsTable("SalesTools", options)
end

-- Event Handlers
function SalesTools:OnEvent(event, ...)
    -- Called when an event is triggered
    self:Debug("OnEvent", event, ...)

    -- Check if the event is one of the registered events
    if (event == "MAIL_SHOW") then
        -- When the mail frame opens draw our buttons
        SalesTools:DrawMailboxButtons()
    elseif (event == "MAIL_CLOSED") then
        -- When the mail frame closes hide any created buttons
        if (self.SendMailButton) then
            self.SendMailButton:Hide()
        end
        if (self.MailLogButton) then
            self.MailLogButton:Hide()
        end
        if (self.MailPickupButton) then
            self.MailPickupButton:Hide()
        end
        if (self.AddonIconFrame) then
            self.AddonIconFrame:Hide()
        end
        if (self.MailPickupButton) then
            self.MailPickupButton:Hide()
        end
	end
end

-- GUI Elements



-- Toggle the version/info panel
function SalesTools:ToggleInfoPanel()

-- Toggle the help/info plate panel
function SalesTools:ToggleHelpPanel()
    if (self.HelpPanel and self.HelpPanel:IsShown()) then
        self.HelpPanel:Hide()
    else
        -- Trigger the /sales help command programmatically
        ChatFrame1EditBox:SetText("/sales help")
        ChatEdit_SendText(ChatFrame1EditBox, 0)
    end
end


    if (self.InfoPanel and self.InfoPanel:IsShown()) then
        self.InfoPanel:Hide()
    else
        self:AddonInfoPanel()
    end
end

function SalesTools:AddonInfoPanel()
    -- Called to draw/display the addon's information panel
    self:Debug("AddonInfoPanel")

    if (self.InfoPanel) then
        self.InfoPanel:Show()
    else
        local window = StdUi:Window(UIParent, 360, 200, L["Addon_Name"])
        window:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
        if window.closeBtn then window.closeBtn:Show() end
        if window.closeBtn then window.closeBtn:Show() end
        window:SetMovable(false);
        window:EnableMouse(true);

        local addonVersion = StdUi:Label(window, '|cffFFE400' .. C_AddOns.GetAddOnMetadata("SalesTools", "Version") .. '|r', 17, nil, 160);
        addonVersion:SetJustifyH('CENTER');
        StdUi:GlueTop(addonVersion, window, 0, -40);

        local authorText = table.concat({
    '|cffffd100Version ' .. C_AddOns.GetAddOnMetadata("SalesTools","Version") .. ' updated for patch 11.2 by Osiris the Kiwi|r',
    '|cff00FF17Discord: osirisnz|r',
    '',
    '|cffffd100Previous authors and contributors|r',
    '|cff00FF17Adalyia-Illidan|r',
    '|cff00FF17Volthemar-Dalaran|r',
    '|cff00FF17Honorax-Illidan|r',
}, string.char(10))

local addonAuthor = StdUi:Label(window, authorText, 13, nil, 300);
addonAuthor:SetJustifyH('CENTER');
StdUi:GlueBelow(addonAuthor, addonVersion, 0, -10);
local addonNotes = StdUi:Label(window, '|cff00F7FF' .. C_AddOns.GetAddOnMetadata("SalesTools", "Notes") .. '|r', 13, nil, 300);
        addonNotes:SetJustifyH('CENTER');
        StdUi:GlueBelow(addonNotes, addonAuthor, 0, -15);

        self.InfoPanel = window

    end
end

-- Draw our mail frame buttons
function SalesTools:DrawMailboxButtons()
    if (self.AddonIconFrame == nil and self.SendMailButton == nil and self.MailLogButton == nil and self.MailSender ~= nil and self.MailLog ~= nil) then
        local AddonIconFrame = StdUi:Frame(MailFrame, 32, 32)
        local icon_texture = StdUi:Texture(AddonIconFrame, 32, 32, SalesTools.AddonIcon)
        StdUi:GlueTop(icon_texture, AddonIconFrame, 0, 0)

        local MailLogButton = StdUi:Button(MailFrame, 150, 22, "Mail Log")
        MailLogButton:SetScript("OnClick", function()
            if (SalesTools.MailLog) then
                SalesTools.MailLog:Toggle()
            end
        end)

        StdUi:GlueBottom(MailLogButton, MailFrame, 20, -22, "RIGHT")
        StdUi:GlueLeft(AddonIconFrame, MailLogButton, 0, -11)

        local SendMailButton = StdUi:Button(MailFrame, 150, 22, "Mail Gold")
        SendMailButton:SetScript("OnClick", function()
            if (SalesTools.MailSender) then
                SalesTools.MailSender:Toggle()
            end
        end)

        StdUi:GlueBottom(SendMailButton, MailLogButton, 0, -22)

        self.SendMailButton = SendMailButton
        self.MailLogButton = MailLogButton
        self.AddonIconFrame = AddonIconFrame
        
        
        if (self.MailPickupButton == nil and self.MailGrabber ~= nil) then
            local MailPickupButton = StdUi:Button(MailFrame, 150, 22, "Mail Pickup")
            MailPickupButton:SetScript("OnClick", function()
                if (SalesTools.MailGrabber) then
                    SalesTools.MailGrabber:Toggle()
                end
            end)

            StdUi:GlueBottom(MailPickupButton, SendMailButton, 0, -22)

            self.MailPickupButton = MailPickupButton
        
        end
    else
        if (self.MailSender ~= nil and self.MailLog ~= nil) then
        self.AddonIconFrame:Show()
        self.SendMailButton:Show()
        self.MailLogButton:Show()
            if (self.MailGrabber ~= nil) then
                self.MailPickupButton:Show()
            end
        end
    end
    
end

-- Reused functions
function SalesTools:HasValue(tab, val)
    -- Check if a table has a value
    self:Debug("HasValue")
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function SalesTools:CommaValue(amount)
    -- Comma delimit an integer
    self:Debug("CommaValue")

    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end


-- I'm Lazy :3
function EasyMenu(menuList, menuFrame, anchor, x, y, displayMode, autoHideDelay )
	if ( displayMode == "MENU" ) then
		menuFrame.displayMode = displayMode;
	end
	UIDropDownMenu_Initialize(menuFrame, EasyMenu_Initialize, displayMode, nil, menuList);
	ToggleDropDownMenu(1, nil, menuFrame, anchor, x, y, menuList, nil, autoHideDelay);
end

function EasyMenu_Initialize( frame, level, menuList )
	for index = 1, #menuList do
		local value = menuList[index]
		if (value.text) then
			value.index = index;
			UIDropDownMenu_AddButton( value, level );
		end
	end
end

function SalesTools:FormatRawCurrency(currency)
    -- Convert a value in copper to a rounded value in gold
    self:Debug("FormatRawCurrency")

    return math.floor(currency / COPPER_PER_GOLD)
end

function SalesTools:GetPlayerFullName()
    -- Get the player's name in Name-Realm format
    self:Debug("GetPlayerFullName")

    local name, realm = UnitFullName("player")

    if realm ~= nil then
        return name .. "-" .. realm
    else
        return name
    end
end

function SalesTools:GetNextFrameLevel()
    -- Get the next frame level
    self:Debug("GetNextFrameLevel")

    SalesTools.FRAME_LEVEL = SalesTools.FRAME_LEVEL + 10
    return math.min(SalesTools.FRAME_LEVEL, 10000)
end

-- === Unified copy helpers ===
function SalesTools:Copy(value, title)
    self:Debug("Copy")
    if not StaticPopupDialogs["SalesToolsPopup"] then
        StaticPopupDialogs["SalesToolsPopup"] = {
            text = "Copy",
            button1 = OKAY,
            timeout = 10,
            whileDead = true,
            hideOnEscape = true,
            exclusive = true,
            enterClicksFirstButton = true,
            preferredIndex = 3,
            hasEditBox = true,
        }
    end
    local dialog = StaticPopup_Show("SalesToolsPopup", nil, nil, { text = tostring(value or "") })
    if not dialog then return end
    if title and dialog.Text and dialog.Text.SetText then dialog.Text:SetText(tostring(title)) end
    local eb = dialog.EditBox or dialog.editBox
    if eb then
        eb:SetText(tostring(value or ""))
        eb:HighlightText(0, -1)
        eb:SetFocus()
        eb:SetCursorPosition(0)
        eb:SetScript("OnEnterPressed", function() dialog:Hide() end)
        eb:SetScript("OnTabPressed", function() dialog:Hide() end)
        eb:SetScript("OnSpacePressed", function() dialog:Hide() end)
    end
end

function SalesTools:ShowPopup(text, title)
    self:Copy(text, title or "Copy")
end
StaticPopupDialogs["SalesToolsPopup"] = {
    text = "Copy",
    button1 = OKAY,
    timeout = 10,
    whileDead = true,
    hideOnEscape = true,
    exclusive = true,
    enterClicksFirstButton = true,
    preferredIndex = 3,
    hasEditBox = true,
}

--[[
Robust startup banner: prints once per load (login or /reload) after chat is ready,
avoiding duplicate prints across PLAYER_LOGIN / PLAYER_ENTERING_WORLD / ADDON_LOADED.
]]
if not SalesToolsStartupFrame then
    local f = CreateFrame("Frame")
    SalesToolsStartupFrame = f
    f.printed = false
    f:RegisterEvent("ADDON_LOADED")
    f:RegisterEvent("PLAYER_LOGIN")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:SetScript("OnEvent", function(self, event, ...)
        if event == "ADDON_LOADED" then
            local name = ...
            if name ~= "SalesTools" then return end
        end
        if self.printed then return end
        self.printed = true

        local ver = "?"
        if C_AddOns and C_AddOns.GetAddOnMetadata then
            ver = C_AddOns.GetAddOnMetadata("SalesTools", "Version") or "?"
        elseif GetAddOnMetadata then
            ver = GetAddOnMetadata("SalesTools", "Version") or "?"
        end

        if C_Timer and C_Timer.After then
            C_Timer.After(0.1, function()
                if SalesTools and SalesTools.Print then
                    SalesTools:Print(string.format("Version %s updated for patch 11.2 by Osiris the Kiwi", ver))
                else
                    print("|cff33ff99[SalesTools]|r Version " .. ver .. " updated for patch 11.2 by Osiris the Kiwi")
                end
            end)
        else
            if SalesTools and SalesTools.Print then
                SalesTools:Print(string.format("Version %s updated for patch 11.2 by Osiris the Kiwi", ver))
            else
                print("|cff33ff99[SalesTools]|r Version " .. ver .. " updated for patch 11.2 by Osiris the Kiwi")
            end
        end
    end)
end

