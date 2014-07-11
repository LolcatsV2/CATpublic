/*
Mainly used for core functions
*/
	
MsgN("[[CAT]] CAT Core Functions loaded! [[CAT]]")
	


if (!file.Exists("catusergroups", "DATA")) then 
	MsgN("[[CAT]] Creating usergroups for the first time... [[CAT]]")
	file.CreateDir("catusergroups")
end
	
for k, v in pairs (CAT_Config.UserGroups) do
	if (!file.Exists("catusergroups/"..v, "DATA")) then 
		file.CreateDir("catusergroups/"..v)
		file.CreateDir("cat")
		file.CreateDir("cat/bans")
	end
end

	
	
function CAT_FindPlayerUserID( userID )

	local UID = tonumber(userID)
	if (UID) then
		for _, pl in pairs(player.GetAll()) do
	
			if (pl:UserID() == UID) then
		
				return pl
		
			end
	
		end
	end
end

function CAT_MessagePlayer( PLAYER, MESSAGE )	
	PLAYER:PrintMessage(HUD_PRINTCONSOLE, MESSAGE)
	PLAYER:ChatPrint(MESSAGE)
end

function CAT_TellAll( CALLER, ACTION )	
	
	if (CAT_Config.TellAdmins) then
		for _, pl in pairs(player.GetAll()) do
		if (CAT_CanDoAction(pl, "isadmin")) then
			if CALLER == "Console" then
			CAT_PlayerMsg(pl, Color(0, 80, 209), "CONSOLE -> ", Color(242, 255, 0), ACTION)
			else
			CAT_PlayerMsg(pl, Color(242, 255, 0), CALLER:Nick(), Color(255, 255, 255), " -> "..ACTION)
			end
		end
	end
end
	
	if (!CAT_Config.TellAll) then return end
	
	for _, pl in pairs(player.GetAll()) do
		if (CAT_CanDoAction(pl, "isadmin")) and (CAT_Config.TellAdmins) then return end
		
		if (CAT_Config.TellAnonymous) then
			CAT_PlayerMsg(pl, Color(0, 80, 209), "SOMEONE -> ", Color(242, 255, 0), ACTION)
		elseif CALLER == "Console" then
			CAT_PlayerMsg(pl, Color(0, 80, 209), "CONSOLE -> ", Color(242, 255, 0), ACTION)
		else
			CAT_PlayerMsg(pl, Color(242, 255, 0), CALLER:Nick(), Color(255, 255, 255), " -> "..ACTION)
		end
	end
	
end

function CAT_LogActionServer( CALLER, ACTION )	

	Msg( CALLER:Nick().." -> " .. ACTION .. "\n")
	
end



function CAT_LogAction( CALLER, ACTION )	

if CALLER == "Console" then
	MsgC(Color(0, 200, 200), "Console -> "..ACTION.."\n")
	CAT_TellAll(CALLER, ACTION)
return end
	
	Msg( CALLER:Nick().." -> "..ACTION.."\n")

	CAT_TellAll(CALLER, ACTION)
	
end

function CAT_FindPlayer( uniqueID )

	if (!uniqueID) then return nil end

	local pl = player.GetByUniqueID(uniqueID)
	
	return pl

end

-- Code from ASSMod, which got this code from Megiddo from ULX. Thanks <3
function CAT_playerSend( from, to, force )
		if not to:IsInWorld() and not force then return false end 

		local yawForward = to:EyeAngles().yaw
		local directions = { -- Directions to try
			math.NormalizeAngle( yawForward - 180 ), -- Behind first
			math.NormalizeAngle( yawForward + 180 ), -- Front
			math.NormalizeAngle( yawForward + 90 ), -- Right
			math.NormalizeAngle( yawForward - 90 ), -- Left
			yawForward,
		}

		local t = {}
		t.start = to:GetPos() + Vector( 0, 0, 15 ) -- Move them up a bit so they can travel across the ground
		t.filter = { to, from }

		local i = 1
		t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
		local tr = util.TraceEntity( t, from )
	    while tr.Hit do -- While it's hitting something, check other angles
	    	i = i + 1
	    	if i > #directions then  -- No place found
				if force then
					return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
				else
					return false
				end
			end

			t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47

			tr = util.TraceEntity( t, from )
	    end

		return tr.HitPos
	end

function CAT_SetUserGroup(victim, togroup, caller)
	

	
	
	
	if (!table.HasValue(CAT_Config.UserGroups, togroup)) then return end
	
	if caller == "Console" then
		file.Write("catusergroups/"..togroup.."/"..victim:UniqueID()..".txt", victim:Nick())
		victim:SetNWString("CAT_Usergroup", togroup)
	return end
/*========================================
This is redundant since we check for their
ability to do "setaccess" in the config,
but I'll keep it here just in case.
===========================================

	CAT_canpromote = true 
	
	if CAT_GetUserGroup(caller) == "user" then
		CAT_canpromote = false
	elseif CAT_GetUserGroup(caller) == "vip" then
		if togroup == "admin" then
			CAT_canpromote = false
		elseif togroup == "superadmin" then
			CAT_canpromote = false
		elseif togroup == "moderator" then
			CAT_canpromote = false
		elseif togroup == "owner" then
			CAT_canpromote = false
		end
	elseif CAT_GetUserGroup(caller) == "admin" then
		if togroup == "superadmin" then 
			CAT_canpromote = false
		elseif togroup == "owner" then
			CAT_canpromote = false
		end
	elseif CAT_GetUserGroup(caller) == "superadmin" then
		if togroup == "owner" then
				CAT_canpromote = false
			end
	elseif CAT_GetUserGroup(caller) == "owner" then
		CAT_canpromote = true
	end
	
	if (!CAT_canpromote) then
		CAT_MessagePlayer(caller, "You can't make promote to something higher than you!")
	return end
	*/

	
	
	for k, v in pairs (CAT_Config.UserGroups) do
		if file.Exists("catusergroups/"..v.."/"..victim:UniqueID()..".txt", "DATA") then
		file.Delete("catusergroups/"..v.."/"..victim:UniqueID()..".txt")
	end
	

		file.Write("catusergroups/"..togroup.."/"..victim:UniqueID()..".txt", victim:Nick())
		victim:SetNWString("CAT_Usergroup", togroup)

	end
end
	
function CAT_GetUserGroup(victim)
	
	for k, v in pairs (CAT_Config.UserGroups) do
		if file.Exists("catusergroups/"..v.."/"..victim:UniqueID()..".txt", "DATA") then
			usergroup = v
		end
	end
	if usergroup then	
		return usergroup
	else
	return "user"
end
end

hook.Add("PlayerInitialSpawn", "catsendinitinfo", function(ply)
	
	file.Write("catusergroups/user/"..ply:UniqueID()..".txt", ply:Nick())
	
	usergroup = CAT_GetUserGroup(ply)
	
	if usergroup != "user" then
		file.Write("catusergroups/"..usergroup.."/"..ply:UniqueID()..".txt", ply:Nick())
	end
	ply:SetNWString("CAT_Usergroup", usergroup)
	
	if (!usergroup) then 
		file.Write("catusergroups/user/"..ply:UniqueID()..".txt", ply:Nick())
		ply:SetNWString("CAT_Usergroup", "user")
	end

	
end)

hook.Add("PlayerDisconnected", "catremoveuser", function(ply)
	
	if (file.Exists("catusergroups/user/"..ply:UniqueID()..".txt", "DATA")) then
		file.Delete("catusergroups/user/"..ply:UniqueID()..".txt")
	end

	
end)

function CAT_CanDoAction(ply, action)
	
	cando = false
	
	if ply == "Console" then
		cando = true
	return cando end
	
	plyrank = ply:GetNWString("CAT_Usergroup")
	checkforreal = CAT_GetUserGroup(ply)
	
	
	
	if checkforreal != plyrank then
		print(ply:Nick().." TRIED TO CHANGE THEIR USERGROUP. !!NOT GOOD!!")
	cando = false return cando end
	
	if plyrank == "user" then					
		for k, v in pairs (CAT_Config.userCan) do
			if v == action then
				 cando = true
				break
			end
		end
	end
	if plyrank == "vip" then
		for k, v in pairs (CAT_Config.vipCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end
	if plyrank == "moderator" then
		for k, v in pairs (CAT_Config.moderatorCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end
	if plyrank == "admin" then
		for k, v in pairs (CAT_Config.adminCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end
	if plyrank == "superadmin" then
		for k, v in pairs (CAT_Config.superadminCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end
		if plyrank == "owner" then
		for k, v in pairs (CAT_Config.ownerCan) do
			if v == action then
				cando = true
				break
			end
		end
	end

	if (cando == true or false) then
	return cando
	else
	cando = false
	return cando
	end
end

CAT_Bans = CAT_Bans or {}
util.AddNetworkString("cat_removeban")
util.AddNetworkString("cat_sendbans")

function CAT_Ban(ply, vic, reason, time, vicname)

if (isstring(vicname)) then -- Contingency for redoing a ban
	
	local fixedid = string.sub(vic, 11)
	local unbanneddate = os.time() + time*60
	local sid = vic -- For the sake of neatness.
	local brname = ply
	local fixreason = string.gsub(reason, " ", "_")
	local fixname = string.gsub(vicname, " ", "_")
	local fixbrname = string.gsub(brname, " ", "_")

	if (time == 0) then

	net.Start("cat_sendbans")
			net.WriteString(fixname)
			net.WriteString(sid)
			net.WriteString("never")
			net.WriteString(fixreason)
			net.WriteString(fixbrname)
		net.Broadcast()


		file.Write("cat/bans/"..fixedid..".txt", fixname.." "..sid.." never".." "..fixreason.." "..brname)
		game.ConsoleCommand("banid "..time.." "..vic.." \n")		
		
		else
		
		local time = tonumber(time)
		
		net.Start("cat_sendbans")
			net.WriteString(fixname)
			net.WriteString(sid)
			net.WriteString(tostring(time))
			net.WriteString(fixreason)
			net.WriteString(brname)
		net.Broadcast()
		
		file.Write("cat/bans/"..fixedid..".txt", fixname.." "..sid.." "..tostring(unbanneddate).." "..fixreason.." "..brname )
		game.ConsoleCommand("banid "..time.." "..vic.." \n")
		
	end
else -- Do a normal ban

local fixedid = string.sub(vic:SteamID(), 11)
local unbanneddate = os.time() + time*60
local sid = vic:SteamID() -- For the sake of neatness.
local brname = ply:Nick()
local fixreason = string.gsub(reason, " ", "_")
local fixname = string.gsub(vic:Nick(), " ", "_")
local fixbrname = string.gsub(brname, " ", "_")

if (time == 0) then

	net.Start("cat_sendbans")
		net.WriteString(fixname)
		net.WriteString(sid)
		net.WriteString("never")
		net.WriteString(fixreason)
		net.WriteString(fixbrname)
	net.Broadcast()

	file.Write("cat/bans/"..fixedid..".txt", fixname.." "..sid.." never".." "..fixreason.." "..fixbrname)
	game.ConsoleCommand("banid "..time.." "..vic:UserID().." \n")
		
	else
	
	net.Start("cat_sendbans")
		net.WriteString(fixname)
		net.WriteString(sid)
		net.WriteString(tostring(time))
		net.WriteString(fixreason)
		net.WriteString(fixbrname)
	net.Broadcast()
	
	
	file.Write("cat/bans/"..fixedid..".txt", fixname.." "..sid.." "..tostring(unbanneddate).." "..fixreason.." "..fixbrname )
	game.ConsoleCommand("banid "..time.." "..vic:UserID().." \n")
	
		end
	end
end
function CAT_Unban(vicid)

	local fixedid = string.sub(vicid, 11)
	local files, direcs = file.Find("cat/bans/"..fixedid..".txt", "DATA")

	net.Start("cat_removeban")
		net.WriteString(vicid)
	net.Broadcast()
	
	for k, v in pairs (files) do
		
		local toberead = string.Explode(" ", file.Read("cat/bans/"..v, "DATA"))
		
		game.ConsoleCommand("removeid "..toberead[2].." \n")
		file.Delete("cat/bans/"..v)
	end
end

timer.Create("CAT_checkforunban", 5, 0, function()

	local files, direcs = file.Find("cat/bans/*.txt", "DATA")
	
	
	for k, v in pairs (files) do
	
		local toberead = string.Explode(" ", file.Read("cat/bans/"..v, "DATA"))

		if toberead[3] != "never" then
		
			if (tonumber(toberead[3]) <= os.time()) then
				CAT_Unban(toberead[2])		
			end
		end
	end
end)
timer.Create("CAT_DoBans", 5, 1, function()

	local files, direcs = file.Find("cat/bans/*.txt", "DATA")

	for k, v in pairs (files) do
		
		local toberead = string.Explode(" ", file.Read("cat/bans/"..v, "DATA"))
		
		if (toberead[3] == "never") then
			game.ConsoleCommand("banid 0 "..toberead[2].." \n")
			
		else
			
			local timeleft = math.floor((toberead[3] - os.time())/60)

			game.ConsoleCommand("banid "..timeleft.." "..toberead[2].." \n")
		end
	end
end)

hook.Add("PlayerAuthed", "CAT_Gatekeeper", function(ply, stid, unid)

	local files, direcs = file.Find("cat/bans/*.txt", "DATA")

	for k, v in pairs (files) do
			
		local toberead = string.Explode(" ", file.Read("cat/bans/"..v, "DATA"))
		if (toberead[2] == stid) then
			ply:Kick("You are banned! D:")
		end
	end
end)

hook.Add("PlayerInitialSpawn", "CAT_sendbantbl", function(ply)

local files, direcs = file.Find("cat/bans/*.txt", "DATA")

for k, v in pairs (files) do
	
	local toberead = string.Explode(" ", file.Read("cat/bans/"..v, "DATA"))
	
if (toberead[3] == "never") then

	net.Start("cat_sendbans")
		net.WriteString(toberead[1])
		net.WriteString(toberead[2])
		net.WriteString(toberead[3])
		net.WriteString(toberead[4])
		net.WriteString(toberead[5])
	net.Send(ply)
else

local fixtime = tonumber(toberead[3])
local realbtime = math.floor((fixtime - os.time())/60)

	net.Start("cat_sendbans")
		net.WriteString(toberead[1])
		net.WriteString(toberead[2])
		net.WriteString(tostring(realbtime))
		net.WriteString(toberead[4])
		net.WriteString(toberead[5])
	net.Send(ply)
	end
end
end)

concommand.Add("cat_refreshbans", function(ply, cmd, arguments)

	local files, direcs = file.Find("cat/bans/*.txt", "DATA")

	for k, v in pairs (files) do
		
		local toberead = string.Explode(" ", file.Read("cat/bans/"..v, "DATA"))
		
	if (toberead[3] == "never") then

		net.Start("cat_sendbans")
			net.WriteString(toberead[1])
			net.WriteString(toberead[2])
			net.WriteString(toberead[3])
			net.WriteString(toberead[4])
			net.WriteString(toberead[5])
		net.Send(ply)
	else


	local fixtime = tonumber(toberead[3])
	local realbtime = math.floor((fixtime - os.time())/60)

		net.Start("cat_sendbans")
			net.WriteString(toberead[1])
			net.WriteString(toberead[2])
			net.WriteString(tostring(realbtime))
			net.WriteString(toberead[4])
			net.WriteString(toberead[5])
		net.Send(ply)
		end
end
end)

local PLAYER = FindMetaTable("Player")
function PLAYER:ReturnGroupNumber()

CAT_UserRank = 0
CAT_VipRank = 5
CAT_ModRank = 10
CAT_AdminRank = 20
CAT_SuperadminRank = 40
CAT_OwnerRank = 100

	if CAT_GetUserGroup(self) == "user" then
		return CAT_UserRank
	end

	if CAT_GetUserGroup(self) == "vip" then
		return CAT_VipRank
	end
	if CAT_GetUserGroup(self) == "moderator" then
		return CAT_ModRank
	end
	if CAT_GetUserGroup(self) == "admin" then
		return CAT_AdminRank
	end

	if CAT_GetUserGroup(self) == "superadmin" then
		return CAT_SuperadminRank
	end
	
	if CAT_GetUserGroup(self) == "owner" then
		return CAT_OwnerRank
	end
end

function PLAYER:IsBetterOrSame( caller )

	if caller == "Console" then
		cannotdo = false
	return cannotdo end

	callerid = caller:SteamID()
	selfid = self:SteamID()

	if self:ReturnGroupNumber() > caller:ReturnGroupNumber() then
		cannotdo = true
		
	end
	
	if self:ReturnGroupNumber() < caller:ReturnGroupNumber() then
		cannotdo = false

	end
	
	if self:ReturnGroupNumber() == caller:ReturnGroupNumber() then
		cannotdo = true
	end
	
	if callerid == selfid then cannotdo = false end


return cannotdo

end


if (!catrcmd) then
	catrcmd = {}
	catrcmd.ConsoleCommand = game.ConsoleCommand
end

