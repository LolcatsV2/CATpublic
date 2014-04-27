/*=======================
=SAccess module, created=
=======by Lolcats========
=======================*/

concommand.Add("cat_setaccess", function( ply, command, arguments )
	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local togroup = arguments[2]
	
	
	if (!IsValid(ply)) then
		CAT_SetUserGroup(victim, togroup, "Console")
		CAT_LogAction("Console", "Set "..victim:Nick().."'s usergroup to "..togroup..".")
	return end
	
	
	
	
	local plycando = CAT_CanDoAction(ply, "setaccess")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
		
		
	
	CAT_SetUserGroup(victim, togroup, ply)
	
	
	
	CAT_LogAction(ply, "Set "..victim:Nick().."'s usergroup to "..togroup..".")
end)