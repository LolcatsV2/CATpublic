/*=======================
==Clean module, created==
=======by Lolcats========
=======================*/

concommand.Add("cat_cleanuserprops", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "cuprops")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end	
		
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local victimID = victim:SteamID()
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	CAT_LogAction(ply, "Cleaned up "..victim:Nick().."'s props.")
	
	cleanup.CC_Cleanup(victim, "", {})

end)