/*=======================
===God module, created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "god"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!god"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!god target"

concommand.Add("cat_god", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "god")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:GodEnable()
	
	CAT_LogAction(ply, "Godded "..victim:Nick()..".")
	
end)