/*=======================
=Unignite module,created=
=======by Lolcats========
=======================*/

local PLUGINNAME = "extinguish"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!extinguish"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!extinguish target"

concommand.Add("cat_extinguish", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end		
	
	local plycando = CAT_CanDoAction(ply, "extinguish")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	
	victim:Ignite(0)
	
	CAT_LogAction(ply, "Extinguished "..victim:Nick()..".")
end)