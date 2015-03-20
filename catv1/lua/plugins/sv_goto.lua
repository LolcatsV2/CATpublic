/*=======================
===Goto module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "goto"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!goto"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!goto target"

concommand.Add("cat_goto", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		MsgC(Color(255,0,0), "You're the console, you can't go to people!")
	return end			
	
	local plycando = CAT_CanDoAction(ply, "goto")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
	
	CAT_LogAction(ply, "Went to "..victim:Nick().."'s location.")
	
	
	local newpos = CAT_playerSend( ply, victim, ply:GetMoveType() == MOVETYPE_NOCLIP )
	
	if (newpos == false) then
		CAT_PlayerMsg(ply, "Can't bring that person to you. You're probably in a wall.")
		return
	end
	
	local newang = (victim:GetPos() - newpos):Angle()
	
	
	
	ply:SetPos( newpos )
	ply:SetEyeAngles( newang )
	ply:SetLocalVelocity( Vector( 0, 0, 0 ) )
	
	
end)