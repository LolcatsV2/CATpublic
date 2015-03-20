/*=======================
=UBan Job module,created=
=======by Lolcats========
=======================*/

concommand.Add("cat_unbanjob", function( ply, command, arguments )

	if (string.lower(engine.ActiveGamemode()) != "darkrp") then return end
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "unbanjob")
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
	
	victim:teamUnBan(ind)
		
	CAT_LogAction(ply, "Unbanned "..victim:Nick().." from being "..team.GetAllTeams()[ind].Name..".")

	
	
end)