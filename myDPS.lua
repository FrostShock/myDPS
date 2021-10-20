-- This addon is inspired from  https://github.com/vetu104/lockinfo  and it was developed with (Discord) help from Vetu

local myDPSFrame = CreateFrame("Frame", "myDPSFrame", UIParent)

myDPSFrame:SetWidth(100)
myDPSFrame:SetHeight(100)
myDPSFrame:SetPoint("CENTER", UIParent)
myDPSFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
myDPSFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

myDPSFrame:SetScript("OnEvent", function()
--  DEFAULT_CHAT_FRAME:AddMessage(event.." - "..type(event))
--  DEFAULT_CHAT_FRAME:AddMessage(arg1)
  if event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
    if string.find(arg1, "Your ") then
      _,_,sdmg = string.find(arg1, "(%d+)")
      dmg = tonumber(sdmg)
      mydps = mydps + dmg
      if not (smydps == "") then smydps = smydps.." + " end
      smydps = smydps..sdmg
--      DEFAULT_CHAT_FRAME:AddMessage(mydps)
    end
  elseif event == "PLAYER_REGEN_ENABLED" then
    if dpsdetails then
      DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Total damage to last mob: "..smydps.." = "..mydps)
    else
      DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Total damage to last mob: "..mydps)
    end
    mydps = 0
    smydps = ""
  end
end)

mydps=0
smydps=""

--  if you want less details then comment the next line
dpsdetails=1
