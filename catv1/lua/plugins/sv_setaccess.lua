/*=======================
=SAccess module, created=
=======by Lolcats========
=======================*/

local PLUGINNAME = "setaccess"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!setaccess"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!setaccess target rank"

concommand.Add("cat_setaccess", function( ply, command, arguments )
		
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local togroup = arguments[2]


	if (!IsValid(ply)) then
		CAT_SetUserGroup(victim, togroup, "Console")
		CAT_LogAction("Console", "Set "..victim:Nick().."'s usergroup to "..togroup..".")
	return end



	local plycando = CAT_CanDoAction(ply, "setaccess")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end

	if (victim:IsBetterOrSame(ply)) then

		CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")

	return end

	CAT_SetUserGroup(victim, togroup, ply)

	CAT_LogAction(ply, "Set "..victim:Nick().."'s usergroup to "..togroup..".")
end)