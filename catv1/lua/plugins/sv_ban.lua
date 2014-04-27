/*=======================
===Ban module, created===
=======by Lolcats========
=======================*/

concommand.Add("cat_ban", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "ban")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local btime = tonumber(arguments[3])
	local reason = "Banned by: "..ply:Nick().." for reason: "..arguments[2].." for: "..btime.." minutes."
	
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	CAT_LogAction(ply, "Banned "..victim:Nick().." for: "..btime.." for reason: "..arguments[2])
	
	if (!isnumber(btime)) then return end	

	
	CAT_Ban(victim, reason, btime)

	
	
end)