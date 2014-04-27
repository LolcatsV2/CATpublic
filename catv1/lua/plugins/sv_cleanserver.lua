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
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	cleanup.CC_AdminCleanup(ply, "", {} )

	CAT_LogAction(ply, "Cleaned up the server.")
	
end)