/*=======================
==SClean module,created==
=======by Lolcats========
=======================*/

concommand.Add("cat_serverclean", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "cleanserver")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	game.CleanUpMap(true, {})

	CAT_LogAction(ply, "Cleaned up the server.")
	
end)