/*=======================
==Strip module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "strip"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!strip"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!strip target"

concommand.Add("cat_strip", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "strip")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end


		victim:StripWeapons()
		CAT_LogAction(ply, "Stripped "..victim:Nick().." of their weapons.")

end)