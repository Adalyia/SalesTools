local L = LibStub("AceLocale-3.0"):NewLocale("SalesTools", "enUS", true);
L = L or {}
--@non-debug@
L["Addon_Name"] = "SalesTools"
L["Version"] = "Version"
L["Author"] = "Author"
L["Minimap"] = "Minimap"
L["Addon"] = "Addon"
L["Version_Message"] = "Version %s by %s Enabled"
L["Description"] = "Package of several tools & QoL features for Advertising & Gold Collecting in World of Warcraft"

L["SalesTools_Minimap_HideMinimap"] = "Hide Minimap Icon"
L["SalesTools_Minimap_Option_Label"] = "Show minimap icon"
L["SalesTools_Minimap_Option_Desc"] = "Whether or not to show the minimap icon."
L["SalesTools_Version_Command_Desc"] = "Check/display the current addon version"
L["SalesTools_Version_Command_Msg"] = "Current version: %s"
L["SalesTools_Minimap_Command_Desc"] = "Toggle visiblity of minimap button"
L["SalesTools_Minimap_Command_Msg"] = nil

L["MailSender_Command_Desc"] = "Opens the bulk mail sender"
L["MailSender_Mail_Sent"] = "Sent %s gold to %s"
L["MailSender_Mail_Failed"] = "Failed to send %s gold to %s, the character may not exist or might be on a different faction?"
L["MailSender_Not_Enough_Gold"] = "Not enough gold to continue"
L["MailSender_Not_Enough_GoldPlayer"] = "Current player: %s, gold: %s"
L["MailSender_Done"] = "Done!"
L["MailSender_Window_Title"] = "Bulk Mail Sender"

L["MailLog_Minimap_Desc"] = "Toggle Mail Log"
L["MailLog_Command_Desc"] = "Opens a log of all mail sent and received"
L["MailLog_Window_Title"] = "Mail Log Viewer"
L["MailLog_Clear_Warning"] = "Select log to clear. These actions CANNOT BE REVERSED. Both sent and received mail will be deleted."
L["MailLog_AllChars_Option"] = "Show all mail received by any character on this account."
L["MailLog_AllChars_Option_Label"] = "All characters"
L["MailLog_TodayFilter_Option_Label"] = "Only show today"
L["MailLog_TodayFilter_Option"] = "Only show mail that was received or sent today."
L["MailLog_NoResults"] = "No results found."
L["MailLog_CurrentResults"] = "Current Results: %s"
L["MailLog_Clear_Button"] = "Clear Log"
L["MailLog_Search_Button"] = "Search"
L["MailLog_Viewer_DateSent"] = "Date Sent"
L["MailLog_Viewer_Sender"] = "Sender"
L["MailLog_Viewer_Recipient"] = "Recipient"
L["MailLog_Viewer_Gold"] = "Gold"
L["MailLog_Viewer_Subject"] = "Subject"
L["MailLog_Viewer_DateLooted"] = "Date Looted"
L["MailLog_Viewer_Body"] = "Body"


L["MailGrabber_Skip_GoldCap"] = "Skipped code %s, attached gold would cause us to exceed gold cap"
L["MailGrabber_Skip_Mismatch"] = "Skipped code %s, attached gold didn't match the expected total"
L["MailGrabber_Collected_Mail"] = "Collected code %s with %s gold attached"
L["MailGrabber_Import_Window_Title"] = "Import"
L["MailGrabber_Export_Window_Title"] = "Export"

L["TradeLog"] = "Trade Log"
L["TradeLog_Toggle"] = "Toggle Trade Log"
L["TradeLog_WhisperOptionName"] = "Whisper after trade"
L["TradeLog_WhisperOptionDesc"] = "Whisper the target about gold received/given after a trade."
L["TradeLog_WhisperSuffixName"] = "Trade whisper suffix"
L["TradeLog_WhisperSuffixDesc"] = "Custom trade whisper suffix"
L["TradeLog_Command_Desc"] = "Opens a log of all trades"
L["TradeLog_Trade_Cancelled"] = "Trade with %s was cancelled: %s"
L["TradeLog_Trade_Completed"] = "Trade with %s was successful"
L["TradeLog_Trade_Gave"] = "Gave %sg to %s in a trade. %s"
L["TradeLog_Trade_Received"] = "Received %sg from %s in a trade. %s"
L["TradeLog_Clear_Button"] = "Clear Log"
L["TradeLog_Search_Button"] = "Search"
L["TradeLog_Clear_Warning"] = "Select log to clear. These actions CANNOT BE REVERSED. All trades will be deleted."
L["TradeLog_AllChars_Option_Label"] = "All characters"
L["TradeLog_AllChars_Option"] = "Show all trades by any character on this account."
L["TradeLog_TodayFilter_Option_Label"] = "Only show today"
L["TradeLog_TodayFilter_Option"] = "Only show trades from today."
L["TradeLog_NoResults"] = "No results found."
L["TradeLog_CurrentResults"] = "Current Results: %s"
L["TradeLog_Viewer_Date"] = "Date"
L["TradeLog_Viewer_You"] = "Player"
L["TradeLog_Viewer_Your_Gold"] = "Your Offer (Gold)"
L["TradeLog_Viewer_Your_Items"] = "Your Offer (Items)"
L["TradeLog_Viewer_Target"] = "Target"
L["TradeLog_Viewer_Their_Gold"] = "Target Offer (Gold)"
L["TradeLog_Viewer_Their_Items"] = "Target Offer (Items)"

L["BalanceList"] = "Balance List"
L["BalanceList_Toggle"] = "Toggle Balance List"
L["BalanceList_Command_Desc"] = "Opens a list of all character balances"
L["BalanceList_Window_Title"] = "Balance List"
L["BalanceList_NoResults"] = "No results found."
L["BalanceList_AuditButton"] = "GSheet Report"
L["BalanceList_Audit_Window_Title"] = "Gold Audit"
L["BalanceList_Audit_Window_Close_Button"] = "Close"
L["BalanceList_Search_Button"] = "Search"
L["BalanceList_AccountBalance"] = "Account Balance: %s %s"
L["BalanceList_Viewer_Character"] = "Character"
L["BalanceList_Viewer_Realm"] = "Realm"
L["BalanceList_Viewer_Balance"] = "Balance"
L["BalanceList_Viewer_Guild"] = "Guild"
L["BalanceList_Viewer_Guild_Balance"] = "Guild Balance"
L["BalanceList_CurrentResults"] = "Current Results: %s"

L["AutoInv"] = "Auto Invites"
L["AutoInv_Enabled_Option_Name"] = "Auto Invites"
L["AutoInv_Enabled_Option_Desc"] = "Automatically invite when whispered one of the below keywords"
L["AutoInv_Keywords_Option_Name"] = "Auto Invite Keywords"
L["AutoInv_Keywords_Option_Desc"] = "Keywords by which someone can request an auto invite in bnet/ingame whispers (List is comma delimitted; ex: inv,invite,invv)"
L["AutoInv_Auto_Accept_Option_Name"] = "Auto Accept Group Invites"
L["AutoInv_Auto_Accept_Option_Desc"] = "Automatically accept group invites"
L["AutoInv_Auto_Accept_Collector_Option_Name"] = "Only Auto-Accept From Collector Char"
L["AutoInv_Auto_Accept_Collector_Option_Desc"] = "Only auto-accept invites from the primary GC character defined above"
L["AutoInv_Options_No_Empty"] = "Field cannot be empty"
L["AutoInv_Accepted_Invite"] = "Accepted invite from %s"
L["AutoInv_Attempt_Invite"] = "Attempting to invite %s"

L["HelpDisplay_Toggle_Command_Desc"] = "Toggle the help display"
L["HelpDisplay_Toggle_NameDisplay_Command_Desc"] = "Toggle the name display"
L["HelpDisplay_Toggle_RealmDisplay_Command_Desc"] = "Toggle the realm display"
L["HelpDisplay_Toggle_GoldDisplay_Command_Desc"] = "Toggle the gold display"
L["HelpDisplay_GoldDisplay_Gold"] = "Gold"

L["CollectorMenu"] = "Collector Menu"
L["CollectorMenu_Primary_Char_Option_Name"] = "Primary Collector Character"
L["CollectorMenu_Primary_Char_Option_Desc"] = "The primary character to use for gold collection"
L["CollectorMenu_Invite_Request_Option_Name"] = "'Request Inv' Button Message"
L["CollectorMenu_Invite_Request_Option_Desc"] = "Message whispered to the primary character when hitting 'Request Inv' in the GC Menu"
L["CollectorMenu_Options_No_Empty"] = "Field cannot be empty"
L["CollectorMenu_Toggle_Command_Desc"] = "Toggle the collector menu"
L["CollectorMenu_Invite_Target_Button"] = "Invite Target"
L["CollectorMenu_Trade_Target_Button"] = "Trade Target"
L["CollectorMenu_Invite_Request_Button"] = "Request Inv"
L["CollectorMenu_Invite_Request_No_Primary"] = "No primary character defined"
L["CollectorMenu_MailLog_Button"] = "Mail Log"
L["CollectorMenu_TradeLog_Button"] = "Trade Log"
L["CollectorMenu_BalanceList_Button"] = "Balance List"
L["CollectorMenu_MassWhisper_Button"] = "Mass Whisper"
L["CollectorMenu_MassInvite_Button"] = "Mass Invite"

L["MassInvite_Window_Title"] = "Invite Players"
L["MassInvite_Pending"] = "Waiting..."
L["MassInvite_Declined"] = "Declined"
L["MassInvite_In_Raid"] = "In Raid"
L["MassInvite_Offline"] = "Offline/Incorrect"
L["MassInvite_Busy"] = "Busy"
L["MassInvite_Toggle"] = "Toggle Mass Invite Panel"
L["MassInvite_Command_Desc"] = "Opens the mass invite panel"
L["MassInvite_Invite_Button"] = "Invite"
L["MassInvite_Progress_Window_Title"] = "Invite Progress"
L["MassInvite_Viewer_Name"] = "Name"
L["MassInvite_Viewer_Status"] = "Status"
L["MassInvite_Viewer_Time"] = "Time"

L["MassWhisper"] = "Mass Whisper"
L["MassWhisper_Window_Title"] = "Whisper Players"
L["MassWhisper_Toggle"] = "Toggle Mass Whisper Panel"
L["MassWhisper_Command_Desc"] = "Opens the mass whisper panel"
L["MassWhisper_Message_Option_Name"] = "Mass Whisper Message Format"
L["MassWhisper_Message_Option_Desc"] = "Message format for messages sent with mass whisper"
L["MassWhisper_Options_No_Empty"] = "Field cannot be empty"


L["test"] = [=[multi
line]=]


--@end-non-debug@
--[===[@debug@
L = L or {}


--@end-debug@]===]
