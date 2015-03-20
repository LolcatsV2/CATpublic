/*=======================
==Freeze module,created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "unfreeze"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!unfreeze"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!unfreeze target"

concommand.Add("cat_unfreeze", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "unfreeze")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")
		return
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	if (!victim:IsFrozen()) then return end
	
	victim:Freeze(false)
	
	CAT_LogAction(ply, "Unfroze "..victim:Nick()..".")
	
end)