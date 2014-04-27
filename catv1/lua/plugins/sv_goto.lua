/*=======================
===Goto module,created===
=======by Lolcats========
=======================*/

concommand.Add("cat_goto", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		MsgC(Color(255,0,0), "You're the console, you can't go to people!")
	return end			
	
	local plycando = CAT_CanDoAction(ply, "goto")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
	if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	CAT_LogAction(ply, "Went to "..victim:Nick().."'s location.")
	
	
	local newpos = CAT_playerSend( ply, victim, ply:GetMoveType() == MOVETYPE_NOCLIP )
	local newang = (victim:GetPos() - newpos):Angle()
	
	
	
	ply:SetPos( newpos )
	ply:SetEyeAngles( newang )
	ply:SetLocalVelocity( Vector( 0, 0, 0 ) )
	
	
end)