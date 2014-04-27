/*=======================
==CExec module, created==
=======by Lolcats========
=======================*/

concommand.Add("cat_cexec", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "cexec")
		if plycando == false then
	
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
	
		return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local pcommand = arguments[2]
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end


		victim:ConCommand(pcommand)
		CAT_LogAction(ply, "Ran "..pcommand.." on "..victim:Nick()..".")

end)