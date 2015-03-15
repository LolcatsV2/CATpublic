/*=======================
===Slay module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "slay"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!slay"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!slay target"


concommand.Add("cat_slay", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "slay")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	
	victim:Kill()
	
	CAT_LogAction(ply, "Made "..victim:Nick().." go to sleep for a long time.")
	
end)
	
	
	
	
	
	