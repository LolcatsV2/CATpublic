/*=======================
==Speed module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "setspeed"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!setspeed"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!setspeed target number"

concommand.Add("cat_setspeed", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "setspeed")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local tospeed = tonumber(arguments[2])
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end

	victim:SetRunSpeed(tospeed*2)
	victim:SetWalkSpeed(tospeed)
	
	CAT_LogAction(ply, "set "..victim:Nick().."'s speed to "..tostring(tospeed)..".")

end)