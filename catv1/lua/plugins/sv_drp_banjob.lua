/*=======================
=Ban Job module, created=
=======by Lolcats========
=======================*/

concommand.Add("cat_banjob", function( ply, command, arguments )

	if (string.lower(engine.ActiveGamemode()) != "darkrp") then return end
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "banjob")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	local ind = tonumber(arguments[2])	
	local time = tonumber(arguments[3])
	
	victim:teamBan(ind, time*60)
		
	CAT_LogAction(ply, "Banned "..victim:Nick().." from being "..team.GetAllTeams()[ind].Name.." for "..time.." minutes.")

	
	
end)