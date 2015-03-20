/*=======================
==Ungod module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "ungod"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!ungod"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!ungod target"

concommand.Add("cat_ungod", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "ungod")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")
		return
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:GodDisable()
	
	CAT_LogAction(ply, "Ungodded "..victim:Nick()..".")
	
end)