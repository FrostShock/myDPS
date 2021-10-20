-- This addon is inspired from  https://github.com/vetu104/lockinfo  and it was developed with (Discord) help from Vetu

local myDPSFrame = CreateFrame("Frame", "myDPSFrame", UIParent)

myDPSFrame:SetWidth(160)
myDPSFrame:SetHeight(50)
myDPSFrame:SetPoint("CENTER", UIParent)
myDPSFrame:EnableMouse(true)
myDPSFrame:SetMovable(true)

myDPSFrame:SetScript("OnMouseDown", function()
  if arg1 == "LeftButton" then
    this:StartMoving()
  end
end)

myDPSFrame:SetScript("OnMouseUp", function()
  if arg1 == "LeftButton" then
    this:StopMovingOrSizing()
  end
end)

local tex = myDPSFrame:CreateTexture(nil, "BACKGROUND")
tex:SetAllPoints()
tex:SetTexture(1, 1, 1, 0.1)

-----------------------------------------------------

local textFrame = CreateFrame("Frame", nil, UIParent)
textFrame:SetWidth(1)
textFrame:SetHeight(1)
textFrame:SetPoint("CENTER", myDPSFrame)
textFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
textFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
textFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
textFrame:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
textFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

-----------------------------------------------------

local textFrameText = textFrame:CreateFontString()
textFrameText:SetPoint("CENTER", textFrame)
textFrameText:SetFont("Interface\\AddOns\\myDPS\\Fonts\\Ubuntu-R.ttf", 14, "OUTLINE")
textFrameText:SetTextColor(0.1490, 0.5451, 0.8235)

-----------------------------------------------------

textFrame:SetScript("OnEvent", function()
--  DEFAULT_CHAT_FRAME:AddMessage(event.." - "..type(event))
--  DEFAULT_CHAT_FRAME:AddMessage(arg1)
--  if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") or (event == "CHAT_MSG_COMBAT_SELF_HITS") then
  if event == "PLAYER_REGEN_ENABLED" then
    dpsMessage = "|cffff0000Total damage in the last fight: "
    if dpsdetails then dpsMessage = dpsMessage..smydps.." = " end
    dpsMessage = dpsMessage..tostring(mydps)
    DEFAULT_CHAT_FRAME:AddMessage(dpsMessage)
    textFrameText:SetText("Damage: "..dmg.."\nTotal: "..mydps)
    mydps = 0
    smydps = ""
  elseif not (event == "PLAYER_ENTERING_WORLD") then
    if (string.find(arg1, "Your ") and (string.find(arg1, " hits ") or string.find(arg1, " crits "))) or string.find(arg1, "You hit ") or string.find(arg1, "You crit ") or (string.find(arg1, " suffers ") and string.find(arg1, " from your ")) then
      _,_,sdmg = string.find(arg1, "(%d+)")
      dmg = tonumber(sdmg)
      mydps = mydps + dmg
      if not (smydps == "") then smydps = smydps.." + " end
      smydps = smydps..sdmg
      textFrameText:SetText("Damage: "..dmg.."\nTotal: "..mydps)
--      DEFAULT_CHAT_FRAME:AddMessage(dmg)
    end
  end
end)

dmg=0
mydps=0
smydps=""

--  if you want more details then uncomment the next line
-- dpsdetails=1
