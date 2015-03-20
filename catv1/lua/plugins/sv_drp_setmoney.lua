/*=======================
=SetMoney module,created=
=======by Lolcats========
=======================*/

concommand.Add("cat_setmoney", function( ply, command, arguments )

	if (string.lower(engine.ActiveGamemode()) != "darkrp") then return end

	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )

	local plycando = CAT_CanDoAction(ply, "setmoney")
		if plycando == false then
			CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
			return 
		end		
		
	if (victim:IsBetterOrSame(ply)) then
			
		CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
		return
	end

	if (tonumber(arguments[2]) == nil) then 
		CAT_PlayerMsg(ply, "You didn't specify a real number. Try again")
		return
	end

	victim:setDarkRPVar("money", tonumber(arguments[2]))

	CAT_LogActionServer(ply, " set "..victim:Nick().."'s money to ".. arguments[2]..".")

end)