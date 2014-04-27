--Chat Tags cause we can.

net.Receive("cattagsstatus", function(len)

cattagstatus = net.ReadString()
end)

function chattags(ply, strText, bTeamOnly, bPlayerIsDead)

if cattagstatus == "false" then return end

	local green = Color(0, 209, 49)
	local red = Color(209, 0, 0)
	local blue = Color(0, 80, 209)
	local pink = Color(255, 0, 251)
	local white = Color(255, 255, 255)
	local yellow = Color(242, 255, 0)
	local orange = Color(255, 100, 0)
	local teal = Color(0, 255, 255)
	local dgreen = Color(0, 90, 21)
	
	
	local usertitle = ""
	local usercolor = ""
	
	if ply:GetNWString("CAT_Usergroup") == "owner" then
		usertitle = "[Owner] "
		usercolor = red
	elseif ply:GetNWString("CAT_Usergroup") == "superadmin" then
		usertitle = "[Superadmin] "
		usercolor = teal
	elseif ply:GetNWString("CAT_Usergroup") == "admin" then
		usertitle = "[Admin] "
		usercolor = orange
	elseif ply:GetNWString("CAT_Usergroup") == "moderator" then
		usertitle = "[Moderator] "
		usercolor = blue
	elseif ply:GetNWString("CAT_Usergroup") == "vip" then
		usertitle = "[V.I.P.] "
		usercolor = green
	elseif ply:GetNWString("CAT_Usergroup") == "user" then
		usertitle = "[User] "
		usercolor = dgreen
	end
	
	
	if not IsValid(ply) then
		chat.AddText(blue, "Console: ", white, strText)
		return true
	else
		chat.AddText(usercolor, usertitle, yellow, ply:Nick(), white, ": ", strText)
		return true
	end
end
hook.Add("OnPlayerChat", "chattthing", chattags)













