-- modules/PopupCompat.lua (tidy shim)
local SalesTools
local ok, AceAddon = pcall(LibStub, "AceAddon-3.0")
if ok and AceAddon then SalesTools = AceAddon:GetAddon("SalesTools", true) end
if not SalesTools then SalesTools = _G["SalesTools"] end
if not SalesTools then return end

-- Ensure dialog exists at load
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

-- Back-compat aliases to unified helper
if not SalesTools.Copy then
    function SalesTools:Copy(v, title)
        local d = StaticPopup_Show("SalesToolsPopup", nil, nil, { text = tostring(v or "") })
        if d and title and d.Text and d.Text.SetText then d.Text:SetText(tostring(title)) end
        local eb = d and (d.EditBox or d.editBox)
        if eb then eb:SetText(tostring(v or "")); eb:HighlightText(0,-1); eb:SetFocus(); eb:SetCursorPosition(0) end
    end
end
if not SalesTools.ShowPopup then
    function SalesTools:ShowPopup(v, title) self:Copy(v, title or "Copy") end
end
if not SalesTools.ShowCopyPopup then
    function SalesTools:ShowCopyPopup(v, title) self:Copy(v, title or "Copy") end
end