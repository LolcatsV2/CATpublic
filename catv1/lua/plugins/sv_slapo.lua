/*=======================
==Slapo module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "slap"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!slap"
CAT_Commands[PLUGINNAME].args = 3
CAT_Commands[PLUGINNAME].help = "!slap target times damage"

concommand.Add("cat_slap", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "slap")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local times = tonumber(arguments[2])
	local damage = tonumber(arguments[3])
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end

		local fixdamaged = math.abs(damage)
		
		if (times != 0) then
		CAT_LogAction(ply, "Slapped "..victim:Nick().." "..times.." times for "..damage.." damage.")
		
		timer.Create("gethit", 1, times, function()
			victim:SetHealth( victim:Health() - fixdamaged )
			victim:ViewPunch( Angle( -10, 0, 0 ) )
			if ( victim:Health() < 1 ) then 
				victim:Kill() 
				timer.Destroy("gethit")
			return end
		end)
		end
		
end)