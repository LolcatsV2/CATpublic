/*=======================
==Health module,created==
=======by Lolcats========
=======================*/

concommand.Add("cat_hp", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end		
	
	local plycando = CAT_CanDoAction(ply, "health")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:SetHealth(arguments[2])
		
	CAT_LogAction(ply, "Set "..victim:Nick().."'s health to "..arguments[2]..".")
	
end)