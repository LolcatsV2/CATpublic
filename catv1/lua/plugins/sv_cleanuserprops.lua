/*=======================
==Clean module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "cprops"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!cprops"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!cprops target"



concommand.Add("cat_cprops", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "cprops")
		if plycando == false then
	return end	
		
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local victimID = victim:SteamID()
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	CAT_LogAction(ply, "Cleaned up "..victim:Nick().."'s props.")
	
	cleanup.CC_Cleanup(victim, "", {})
	
	
end)