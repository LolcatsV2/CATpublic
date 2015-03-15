/*=======================
==Rocket module,created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "rocket"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!rocket"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!rocket target"

concommand.Add("cat_rocket", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "rocket")
		if plycando == false then
	return end
	
	
	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )

	
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
				victim:SetMoveType(MOVETYPE_WALK)
				victim:SetVelocity(Vector(0, 0, 2048))
				
				timer.Simple(2, function()
					local Position = victim:GetPos()
					
					local Effect = EffectData()
					Effect:SetOrigin(Position)
					Effect:SetStart(Position)
					Effect:SetMagnitude(512)
					Effect:SetScale(128)
			
			
					util.Effect("Explosion", Effect)
					timer.Simple(0.1, function() victim:Kill() end)
				end)
			
			CAT_LogAction(ply, " rocketed "..victim:Nick()..".")
	
end)