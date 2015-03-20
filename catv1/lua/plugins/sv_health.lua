/*=======================
==Health module,created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "health"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!health"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!health target amount"

concommand.Add("cat_health", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end		
	
	local plycando = CAT_CanDoAction(ply, "health")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:SetHealth(arguments[2])
		
	CAT_LogAction(ply, "Set "..victim:Nick().."'s health to "..arguments[2]..".")
	
end)