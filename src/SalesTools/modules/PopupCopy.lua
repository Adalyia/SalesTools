-- modules/PopupCopy.lua (forwarder)
local SalesTools = _G["SalesTools"]
if SalesTools then
    function SalesTools:ShowCopyPopup(v, title) self:Copy(v, title or "Copy") end
    SalesTools.ShowCopyPopup = function(v, title) SalesTools:Copy(v, title or "Copy") end
end