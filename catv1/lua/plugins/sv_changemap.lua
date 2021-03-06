/*=======================
===CMap module,created===
=======by Lolcats========
=======================*/

concommand.Add("cat_changemap", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "changemap")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local tomap = arguments[1]

	if (file.Exists( "maps/" ..tomap.. ".bsp", "GAME" )) then
		
		CAT_LogAction(ply, "Started a changelevel to "..tomap.." in 5 seconds.")
		
		timer.Simple(5, function()
			RunConsoleCommand("changelevel", tomap)
		end)
	else
		CAT_PlayerMsg(ply, "Error! \""..tomap.."\" isn't a valid map!")
	end

end)