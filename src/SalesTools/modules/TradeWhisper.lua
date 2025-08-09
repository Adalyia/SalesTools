-- modules/TradeWhisper.lua
-- Only whisper gold given/received after trade is fully accepted

local f = CreateFrame("Frame")
local tradePartner
local myMoney, theirMoney = 0, 0
local bothAccepted = false

f:RegisterEvent("TRADE_SHOW")
f:RegisterEvent("TRADE_MONEY_CHANGED")
f:RegisterEvent("TRADE_ACCEPT_UPDATE")
f:RegisterEvent("TRADE_CLOSED")

local function formatMoney(copper)
  local g = math.floor(copper / 10000)
  local s = math.floor((copper % 10000) / 100)
  local c = copper % 100
  return string.format("%dg %ds %dc", g, s, c)
end

f:SetScript("OnEvent", function(self, event, ...)
  if event == "TRADE_SHOW" then
    tradePartner = UnitName("NPC") or UnitName("target") or UnitName("trade")
    myMoney, theirMoney = 0, 0
    bothAccepted = false

  elseif event == "TRADE_MONEY_CHANGED" then
    myMoney = GetPlayerTradeMoney()
    theirMoney = GetTargetTradeMoney()

  elseif event == "TRADE_ACCEPT_UPDATE" then
    local playerAccepted, targetAccepted = ...
    if playerAccepted == 1 and targetAccepted == 1 then
      bothAccepted = true
    else
      bothAccepted = false
    end

  elseif event == "TRADE_CLOSED" then
    if bothAccepted and tradePartner then
    end
  end
end)
