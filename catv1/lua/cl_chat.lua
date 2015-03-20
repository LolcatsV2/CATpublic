--Chat Tags cause we can.

local cattagstatus = cattagstatus

net.Receive("cattagsstatus", function(len)

cattagstatus = net.ReadString()
end)

local function chattags(ply, strText, bTeamOnly, bPlayerIsDead)

	if cattagstatus == "false" then return end

	if (GAMEMODE.Name == "DarkRP") then
		cat_jobcolor = ply:getJobTable()
	end

	local green = Color(0, 209, 49)
	local red = Color(209, 0, 0)
	local blue = Color(0, 80, 209)
	local pink = Color(255, 0, 251)
	local white = Color(255, 255, 255)
	local yellow = Color(242, 255, 0)
	local orange = Color(255, 100, 0)
	local teal = Color(0, 255, 255)
	local dgreen = Color(0, 90, 21)
	local dblue = Color(0, 106, 109)
	
	
	
	
	local usertitle = ""
	local usercolor = ""
	
	if (!IsValid(ply)) then
		usertitle = "[CONSOLE] "
		usercolor = blue
	elseif (ply:GetUserGroup() == "superadmin") then
		usertitle = "[Owner] "
		usercolor = red
	elseif (ply:GetUserGroup() == "admin") then
		usertitle = "[Staff] "
		usercolor = blue
	else
		usertitle = "[User] "
		usercolor = dgreen
	end
	
	if not IsValid(ply) then
		chat.AddText(blue, "CONSOLE: ", white, strText)
		return true
	elseif (GAMEMODE.Name == "DarkRP") then
		chat.AddText(usercolor, usertitle, cat_jobcolor.color, ply:Nick(), white, ": ", strText)
		return true
	else
		chat.AddText(usercolor, usertitle, yellow, ply:Nick(), white, ": ", strText)
		return true
	end
end
hook.Add("OnPlayerChat", "chattthing", chattags)













