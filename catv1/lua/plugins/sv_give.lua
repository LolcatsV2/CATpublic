/*=======================
===Give module,created===
=======by Lolcats========
=======================*/

concommand.Add("cat_give", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "give")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local weapontogive = arguments[2]
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end


		victim:Give(weapontogive)
		CAT_LogAction(ply, "Gave "..victim:Nick().." a "..weapontogive..".")

end)