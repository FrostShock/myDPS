-- This addon is inspired from  https://github.com/vetu104/lockinfo  and it was developed with (Discord) help from Vetu and from freem1nd

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

-- myDPSFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 0, right = 0, top = 0, bottom = 0 }});

local tex = myDPSFrame:CreateTexture(nil, "BACKGROUND")
tex:SetAllPoints()
tex:SetTexture(1, 1, 1, 0.3)

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
textFrame:RegisterEvent("PLAYER_REGEN_DISABLED")

-----------------------------------------------------

local textFrameText = textFrame:CreateFontString()
textFrameText:SetPoint("CENTER", textFrame)
-- https://wowwiki-archive.fandom.com/wiki/API_FontInstance_SetFont   -   Flags   -   "OUTLINE"   -   "THICKOUTLINE"   -   "MONOCHROME"   -   "OUTLINE, MONOCHROME"
-- https://classic.wowhead.com/guides/changing-wow-text-font   -   skurri.ttf   -   ARIALN.ttf   -   MORPHEUS.ttf   -   FRIZQT__.ttf
-- textFrameText:SetFont("Interface\\AddOns\\myDPS\\Fonts\\Ubuntu-R.ttf", 14, "OUTLINE")
--textFrameText:SetTextColor(0.1490, 0.5451, 0.8235)
textFrameText:SetFont("Fonts\\FRIZQT__.ttf", 17)
textFrameText:SetTextColor(0, 0, 0.4)

-----------------------------------------------------

textFrame:SetScript("OnEvent", function()
--  DEFAULT_CHAT_FRAME:AddMessage(event.." - "..type(event))
--  DEFAULT_CHAT_FRAME:AddMessage(arg1)
--  if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") or (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") or (event == "CHAT_MSG_COMBAT_SELF_HITS") then
  if event == "PLAYER_REGEN_ENABLED" then
    TimeLeaveCombat=GetTime()
    TimeInCombat = TimeLeaveCombat - TimeEnterCombat
    mydps = mydamage / TimeInCombat
    mydps = tonumber(string.format("%.1f", mydps))
-- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    TimeInCombat = tonumber(string.format("%.1f", TimeInCombat))
    dpsMessage = "|cffff0000Total damage in the last fight: "
    if dpsdetails then dpsMessage = dpsMessage..smydamage.." = " end
--    dpsMessage = dpsMessage..tostring(mydamage)
    dpsMessage = dpsMessage..tostring(mydamage).." in "..TimeInCombat.." seconds = "..mydps.." dps"
    if mydamage > 0 then DEFAULT_CHAT_FRAME:AddMessage(dpsMessage) end
    textFrameText:SetText("Damage: "..dmg.."\nTotal: "..mydamage)
    mydamage = 0
    smydamage = ""
  elseif event == "PLAYER_REGEN_DISABLED" then
    TimeEnterCombat=GetTime();
  elseif not (event == "PLAYER_ENTERING_WORLD") then
    if (string.find(arg1, "Your ") and (string.find(arg1, " hits ") or string.find(arg1, " crits "))) or string.find(arg1, "You hit ") or string.find(arg1, "You crit ") or (string.find(arg1, " suffers ") and string.find(arg1, " from your ")) then
      _,_,sdmg = string.find(arg1, "(%d+)")
      dmg = tonumber(sdmg)
      mydamage = mydamage + dmg
      if not (smydamage == "") then smydamage = smydamage.." + " end
      smydamage = smydamage..sdmg
      textFrameText:SetText("Damage: "..dmg.."\nTotal: "..mydamage)
--      DEFAULT_CHAT_FRAME:AddMessage(dmg)
    end
  end
end)

dmg=0
mydamage=0
smydamage=""
TimeEnterCombat=GetTime();
TimeLeaveCombat=GetTime();

--  if you want more details then uncomment the next line
-- dpsdetails=1
