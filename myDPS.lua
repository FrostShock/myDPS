-- This addon is inspired from  https://github.com/vetu104/lockinfo  and it was developed with (Discord) help from Vetu

local myDPSFrame = CreateFrame("Frame", "myDPSFrame", UIParent)

myDPSFrame:SetWidth(300)
myDPSFrame:SetHeight(300)
myDPSFrame:SetPoint("CENTER", UIParent)
myDPSFrame:SetBackdropColor(0.7, 0.7, 0.7, 0.7)
myDPSFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
myDPSFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
myDPSFrame:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
myDPSFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

myDPSFrame:SetScript("OnEvent", function()
--  DEFAULT_CHAT_FRAME:AddMessage(event.." - "..type(event))
--  DEFAULT_CHAT_FRAME:AddMessage(arg1)
--  if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") or (event == "CHAT_MSG_COMBAT_SELF_HITS") then
  if not (event == "PLAYER_REGEN_ENABLED") then
    if (string.find(arg1, "Your ") and string.find(arg1, " hits ")) or string.find(arg1, "You hit ") or (string.find(arg1, " suffers ") and string.find(arg1, " from your ")) then
      _,_,sdmg = string.find(arg1, "(%d+)")
      dmg = tonumber(sdmg)
      mydps = mydps + dmg
      if not (smydps == "") then smydps = smydps.." + " end
      smydps = smydps..sdmg
      DEFAULT_CHAT_FRAME:AddMessage(dmg)
    end
  elseif event == "PLAYER_REGEN_ENABLED" then
    dpsMessage = "|cffff0000Total damage in the last fight: "
    if dpsdetails then dpsMessage = dpsMessage..smydps.." = " end
    dpsMessage = dpsMessage..tostring(mydps)
    DEFAULT_CHAT_FRAME:AddMessage(dpsMessage)
    mydps = 0
    smydps = ""
  end
end)

mydps=0
smydps=""

--  if you want more details then uncomment the next line
-- dpsdetails=1
