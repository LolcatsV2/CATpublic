/*=======================
==SClean module,created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "cleanserver"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!cleanserver"
CAT_Commands[PLUGINNAME].args = 0
CAT_Commands[PLUGINNAME].help = "!cleanserver"

concommand.Add("cat_serverclean", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "cleanserver")
		if plycando == false then
	return end
	
	game.CleanUpMap(true, {})

	CAT_LogAction(ply, "Cleaned up the server.")
	
end)