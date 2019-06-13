--///////////////////////////--
--//     (c) 2018-2019     //--
--//       by Lorenzo      //--
--//    Lake-Gaming.com    //--
--///////////////////////////--

local screenX, screenY = guiGetScreenSize()
local standartX, standartY = 1920, 1080
local sx, sy = screenX / standartX, screenY / standartY

local hudTable = {"ammo", "armour", "clock", "health", "money", "weapon", "wanted", "area_name", "vehicle_name", "breath", "clock"}
for i = 1, #hudTable do
	setPlayerHudComponentVisible(hudTable[i], false)
end

function SelfmadeHUD()
	local health=tonumber(getElementHealth(getLocalPlayer()))
	local armor=tonumber(getPedArmor(getLocalPlayer()))
	local oxygen=getPedOxygenLevel(getLocalPlayer())
	local health=235/100*health
	local armor=235/100*armor

	dxDrawRectangle(1600*sx, 20*sy, 300*sx, 50*sy, tocolor(0, 0, 0, 120),false)--HEALTH Bar
	dxDrawRectangle(1660*sx, 24*sy, health*sx, 42*sy, tocolor(200, 0, 0, 200),true)--HEALTH Progress
	dxDrawImage(1605*sx, 22*sy, 47*sx, 47*sy, "images/HEALTH.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	local health = math.floor (getElementHealth (getLocalPlayer()))
	dxDrawText("Health • "..health.." %", 3450*sx, 32*sy, 100*sx, 15*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "top", false, false, true, true, false)
	
	if not isElementInWater(getLocalPlayer()) then
		dxDrawRectangle(1600*sx, 80*sy, 300*sx, 50*sy, tocolor(0, 0, 0, 120),false)--ARMOR Bar
		dxDrawRectangle(1660*sx, 84*sy, armor*sx, 42*sy, tocolor(0, 200, 200, 200),true)--ARMOR Progress
		dxDrawImage(1605*sx, 82*sy, 47*sx, 45*sy, "images/ARMOR.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		local armor=math.floor (getPedArmor(getLocalPlayer()))
		dxDrawText("Armor • "..armor.." %", 3450*sx, 92*sy, 100*sx, 15*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "top", false, false, true, true, false)
	elseif isElementInWater(getLocalPlayer()) then
		dxDrawRectangle(1600*sx, 80*sy, 300*sx, 50*sy, tocolor(0, 0, 0, 120),false)--OXYGEN Bar
		dxDrawRectangle(1660*sx, 84*sy, 572/2430*oxygen, 42*sy, tocolor(0, 200, 200, 200),true)--OXYGEN Progress
		dxDrawImage(1605*sx, 82*sy, 47*sx, 45*sy, "images/OXYGEN.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawText("Oxygen • "..math.floor(oxygen/10).." %", 3450*sx, 92*sy, 100*sx, 15*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "top", false, false, true, true, false)
	end
	
	dxDrawRectangle(1600*sx, 140*sy, 300*sx, 50*sy, tocolor(0, 0, 0, 120),false)--MONEY Bar
	dxDrawRectangle(1660*sx, 144*sy, 235*sx, 42*sy, tocolor(100, 100, 100, 200),true)--MONEY Progress
	dxDrawImage(1605*sx, 144*sy, 47*sx, 43*sy, "images/MONEY.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	local playerMoney=convertMoneyToString(getPlayerMoney(localPlayer));
	dxDrawText("$ "..playerMoney, 3450*sx, 152*sy, 100*sx, 15*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "top", false, false, true, true, false)
	
	local weaponID = getPedWeapon (getLocalPlayer())
	dxDrawImage(1460*sx, 20*sy, 100*sx, 100*sy,"images/WEAPONS/"..tostring(weaponID)..".png",0.0,0.0,0.0,tocolor(255,255,255,200),false)
	if getPedTotalAmmo(getLocalPlayer())>1 then
	dxDrawText(getPedAmmoInClip(getLocalPlayer()).." | "..getPedTotalAmmo(getLocalPlayer())-getPedAmmoInClip(getLocalPlayer()),2920*sx, 120*sy, 100*sx, 15*sy, tocolor(255, 255, 225, 255), 1.30, "default-bold", "center", "top", false, false, true, true, false)
	end

end
addEventHandler("onClientRender",root,SelfmadeHUD)

--Dont edit this
function convertMoneyToString(money)
    local formatted = money
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k==0 then break end
    end
    formatted = tostring(formatted)
    return formatted
end