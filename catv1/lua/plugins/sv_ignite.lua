/*=======================
==Ignite module,created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "ignite"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!ignite"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!ignite target length"

concommand.Add("cat_ignite", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "ignite")
		if plycando == false then
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:Ignite(arguments[2])
	
	CAT_LogAction(ply, "Lit "..victim:Nick().." on fire.")
	
end)