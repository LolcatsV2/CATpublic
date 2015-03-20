/*=======================
=Set Name module, created=
=======by Lolcats========
=======================*/

concommand.Add("cat_setname", function( ply, command, arguments )

	if (string.lower(engine.ActiveGamemode()) != "darkrp") then return end
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "setname")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	local toname = arguments[2]
	local oldname = victim:Nick()
	
	victim:setRPName(toname, false)
		
	CAT_LogAction(ply, "Set "..oldname.."'s RP Name to "..toname..".")
	
end)