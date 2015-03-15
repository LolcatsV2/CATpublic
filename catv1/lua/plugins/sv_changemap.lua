/*=======================
===CMap module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "changemap"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!changemap"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!changemap mapname"


concommand.Add("cat_changemap", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "changemap")
		if plycando == false then
	return end
	
	local tomap = arguments[1]

	if (file.Exists( "maps/" ..tomap.. ".bsp", "GAME" )) then
		
		CAT_LogAction(ply, "Started a changelevel to "..tomap.." in 5 seconds.")
		
		timer.Simple(5, function()
			RunConsoleCommand("changelevel", tomap)
		end)
	else
	CAT_MessagePlayer(ply, "Error! \""..tomap.."\" isn't a valid map!")
	end

end)