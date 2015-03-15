/*=======================
==Freeze module,created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "freeze"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!freeze"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!freeze target length"

concommand.Add("cat_freeze", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "freeze")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local freezetime = tonumber(arguments[2])
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	if (victim:IsFrozen()) then return end
	
	victim:Freeze(true)
	
	if freezetime == 0 then
		CAT_LogAction(ply, "Froze "..victim:Nick().." indefinitely.")
	else
		CAT_LogAction(ply, "Froze "..victim:Nick().." for "..tostring(freezetime).." seconds.")
		timer.Simple(freezetime, function()
			victim:Freeze(false)
		end)
	end
end)