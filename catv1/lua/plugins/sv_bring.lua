/*=======================
==Bring module, created==
=======by Lolcats========
=======================*/

concommand.Add("cat_bring", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		MsgC(Color(255, 0, 0), "You're the console, you can't bring people! \n")
	return end	
	
	local plycando = CAT_CanDoAction(ply, "bring")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end

	CAT_LogAction(ply, "Brought "..victim:Nick().." to themself.")
	
	
	
	local newpos = CAT_playerSend( victim, ply, victim:GetMoveType() == MOVETYPE_NOCLIP )
	local newang = (ply:GetPos() - newpos):Angle()
	
	
	
	victim:SetPos( newpos )
	victim:SetEyeAngles( newang )
	victim:SetLocalVelocity( Vector( 0, 0, 0 ) )
	
	
end)