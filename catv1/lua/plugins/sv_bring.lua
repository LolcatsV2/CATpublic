/*=======================
==Bring module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "bring"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!bring"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!bring target"

concommand.Add("cat_bring", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		MsgC(Color(255, 0, 0), "You're the console, you can't bring people! \n")
	return end	
	
	local plycando = CAT_CanDoAction(ply, "bring")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end

	CAT_LogAction(ply, "Brought "..victim:Nick().." to themself.")
	
	
	
	local newpos = CAT_playerSend( victim, ply, victim:GetMoveType() == MOVETYPE_NOCLIP )
	
	if (newpos == false) then
		CAT_PlayerMsg(ply, "Can't bring that person to you. You're probably in a wall.")
		return
	end
	
	local newang = (ply:GetPos() - newpos):Angle()
	
	victim:SetPos( newpos )
	victim:SetEyeAngles( newang )
	victim:SetLocalVelocity( Vector( 0, 0, 0 ) )
	
	
end)