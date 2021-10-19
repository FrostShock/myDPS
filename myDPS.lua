local exampleFrame = CreateFrame("Frame", "lockinfoexampleFrame", UIParent)

exampleFrame:SetWidth(100)
exampleFrame:SetHeight(100)
exampleFrame:SetPoint("CENTER", UIParent)
exampleFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")

exampleFrame:SetScript("OnEvent", function()
  if string.find(arg1, "Fireball") then
    _,_,exampleDamage = string.find(arg1, "(%d+)")
    dmg = tonumber(exampleDamage)
    mydps = mydps + dmg
--    DEFAULT_CHAT_FRAME:AddMessage(exampleDamage)
    DEFAULT_CHAT_FRAME:AddMessage(mydps)
  end
end)

mydps=0
