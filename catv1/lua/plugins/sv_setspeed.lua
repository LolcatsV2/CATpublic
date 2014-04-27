/*=======================
==Speed module, created==
=======by Lolcats========
=======================*/

concommand.Add("cat_sspeed", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "setspeed")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local tospeed = tonumber(arguments[2])
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end

	victim:SetRunSpeed(tospeed*2)
	victim:SetWalkSpeed(tospeed)
	
	CAT_LogAction(ply, "set "..victim:Nick().."'s speed to "..tostring(tospeed)..".")

end)