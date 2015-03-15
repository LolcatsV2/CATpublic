/*=======================
==Spec. module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "isntcheater"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!isntcheater"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!isntcheater target"

concommand.Add("cat_isntcheater", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "isntcheater")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
	if (victim:IsBetterOrSame(ply)) then
			
		CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
		
		return
	end	
	
	if (victim:GetNWBool("CAT_IsCheater")) then
		victim:SetNWBool("CAT_IsCheater", false)
	end

	CAT_BitchList[victim:SteamID()] = nil
	
	CAT_LogActionServer(ply, "Flagged "..victim:Nick().." as a non-cheater.")
	
end)