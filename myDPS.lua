local myDPSFrame = CreateFrame("Frame", "lockinfomyDPSFrame", UIParent)

myDPSFrame:SetWidth(100)
myDPSFrame:SetHeight(100)
myDPSFrame:SetPoint("CENTER", UIParent)
myDPSFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")

myDPSFrame:SetScript("OnEvent", function()
  if string.find(arg1, "Fireball") then
    _,_,sdmg = string.find(arg1, "(%d+)")
    dmg = tonumber(sdmg)
    mydps = mydps + dmg
--    DEFAULT_CHAT_FRAME:AddMessage(sdmg)
    DEFAULT_CHAT_FRAME:AddMessage(mydps)
  end
end)

mydps=0
