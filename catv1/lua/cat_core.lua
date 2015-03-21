/*
Mainly used for core functions
*/	

if (!file.Exists("catusergroups", "DATA")) then 
	MsgN("[[CAT]] Creating usergroups for the first time... [[CAT]]")
	file.CreateDir("catusergroups")
	file.CreateDir("cat")
	file.CreateDir("cat/bans")	
end
	
for k, v in pairs (CAT_Config.UserGroups) do
	if (!file.Exists("catusergroups/"..v, "DATA")) then 
		file.CreateDir("catusergroups/"..v)
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

function CAT_TellAll( CALLER, ACTION )	
	
	if (CAT_Config.TellAdmins) then
		for _, pl in pairs(player.GetAll()) do
		if (CAT_CanDoAction(pl, "isadmin")) then
			if CALLER == "Console" then
			CAT_PlayerMsg(pl, Color(0, 80, 209), "CONSOLE", Color(255, 255, 255), " -> "..ACTION)
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
			CAT_PlayerMsg(pl, Color(0, 80, 209), "SOMEONE", Color(255, 255, 255), " -> "..ACTION)
		elseif CALLER == "Console" then
			CAT_PlayerMsg(pl, Color(0, 80, 209), "CONSOLE", Color(255, 255, 255), " -> "..ACTION)
		else
			CAT_PlayerMsg(pl, Color(242, 255, 0), CALLER:Nick(), Color(255, 255, 255), " -> "..ACTION)
		end
	end
	
end

function CAT_LogActionServer( CALLER, ACTION )	

	Msg( CALLER:Nick().." -> " .. ACTION .. "\n")
	
	CAT_WriteToLog("[CAT] "..CALLER:Nick().." -> "..ACTION)		
	
end

function CAT_LogAction( CALLER, ACTION )	

	if CALLER == "Console" then
		MsgC(Color(0, 200, 200), "Console -> "..ACTION.."\n")
		CAT_TellAll(CALLER, ACTION)
		
		CAT_WriteToLog("[CAT] "..CALLER.." -> "..ACTION)	
		return
	end
	
	Msg( CALLER:Nick().." -> "..ACTION.."\n")

	CAT_TellAll(CALLER, ACTION)
	
	CAT_WriteToLog("[CAT] "..CALLER:Nick().." -> "..ACTION)
	
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

	if (!table.HasValue(CAT_Config.UserGroups, togroup)) then MsgN(caller:Nick().." tried to move "..victim:Nick().." to an invalid usergroup?") return end
	
	if caller == "Console" then
		for k, v in pairs (CAT_Config.UserGroups) do
			if (file.Exists("catusergroups/"..v.."/"..victim:UniqueID()..".txt", "DATA")) then
				file.Delete("catusergroups/"..v.."/"..victim:UniqueID()..".txt")
			end
		end
	
		if (togroup != "user") then
			file.Write("catusergroups/"..togroup.."/"..victim:UniqueID()..".txt", victim:Nick())
		end
			
		
		if (togroup == "owner") then
			victim:SetUserGroup("superadmin")
		elseif (togroup == "staff") then
			victim:SetUserGroup("admin")
		elseif (togroup == "mod") then
			victim:SetUserGroup("mod")
		elseif (togroup == "user") then
			victim:SetUserGroup("user")
		end
	return end
	
	for k, v in pairs (CAT_Config.UserGroups) do
		if file.Exists("catusergroups/"..v.."/"..victim:UniqueID()..".txt", "DATA") then
			file.Delete("catusergroups/"..v.."/"..victim:UniqueID()..".txt")
		end
	
		if (togroup != "user") then
			file.Write("catusergroups/"..togroup.."/"..victim:UniqueID()..".txt", victim:Nick())
		end
		
		if (togroup == "owner") then
			victim:SetUserGroup("superadmin")
		elseif (togroup == "staff") then
			victim:SetUserGroup("admin")
		elseif (togroup == "mod") then
			victim:SetUserGroup("mod")
		elseif (togroup == "user") then
			victim:SetUserGroup("user")
		end
		
		
	end
end
	
function CAT_GetUserGroup(victim)
	
	local usergroup = "user"
	
	for k, v in pairs (CAT_Config.UserGroups) do
		if (file.Exists("catusergroups/"..v.."/"..victim:UniqueID()..".txt", "DATA")) then
			usergroup = v
		end
	end	
		
	return usergroup
	
end

hook.Add("PlayerInitialSpawn", "catsendinitinfo", function(ply)
		
	timer.Simple(0, function()	
		local usergroup = CAT_GetUserGroup(ply)

		if (usergroup == "owner") then
			ply:SetUserGroup("superadmin")
		elseif (usergroup == "staff") then
			ply:SetUserGroup("admin")
		elseif (usergroup == "mod") then
			ply:SetUserGroup("mod")
		end	
	end)
end)


function CAT_CanDoAction(ply, action)
	
	local cando = false
	
	if ply == "Console" then
		cando = true
	return cando end
		
	local usergroup = CAT_GetUserGroup(ply)
		
	if usergroup == "user" then					
		for k, v in pairs (CAT_Config.UserCan) do
			if v == action then
				 cando = true
				break
			end
		end
	end
	if usergroup == "mod" then
		for k, v in pairs (CAT_Config.ModCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end	
	if usergroup == "staff" then
		for k, v in pairs (CAT_Config.StaffCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end
	if usergroup == "owner" then
		for k, v in pairs (CAT_Config.OwnerCan) do
			if v == action then
				 cando = true 
				break
			end
		end
	end


	return cando
	
end

CAT_Bans = CAT_Bans or {}
util.AddNetworkString("cat_removeban")
util.AddNetworkString("cat_sendbans")

function CAT_Ban(ply, vic, reason, time, vicname)

	if (isstring(vicname)) then -- Contingency for redoing a ban

		local fixedid = string.sub(vic, 11)
		local unbanneddate = os.time() + time*60
		local sid = vic
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
	else 	-- Do a normal ban

		local fixedid = string.sub(vic:SteamID(), 11)
		local unbanneddate = os.time() + time*60
		local sid = vic:SteamID() 
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

		if (toberead[3] != "never") then
		
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

--Really this is just a backup. I don't even know if I should keep it here, but oh well.
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
CAT_ModRank = 25
CAT_StaffRank = 50
CAT_OwnerRank = 100

	if CAT_GetUserGroup(self) == "user" then
		return CAT_UserRank
	end

	if CAT_GetUserGroup(self) == "mod" then
		return CAT_ModRank
	end	
	
	if CAT_GetUserGroup(self) == "staff" then
		return CAT_StaffRank
	end
	
	if CAT_GetUserGroup(self) == "owner" then
		return CAT_OwnerRank
	end
end

function PLAYER:IsBetterOrSame( caller )

	local cannotdo

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

MsgC(Color(46, 255, 137), "[[CAT]] CAT Core Functions loaded! \n")
