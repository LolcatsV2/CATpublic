/*=======================
==Unban module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "unban"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!unban"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!unban steamid"

concommand.Add("cat_unban", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "unban")
		if plycando == false then
		
		CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	local victim = arguments[1]
	CAT_Unban(victim)
		
		
	CAT_LogAction(ply, "Unbanned SteamID "..victim..".")

end)