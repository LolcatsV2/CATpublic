/*=======================
=Firework module,created=
=======by Lolcats========
=======================*/

local PLUGINNAME = "firework"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!firework"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!firework target"

concommand.Add("cat_firework", function( ply, command, arguments )


	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "firework")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )

	if (victim:IsBetterOrSame(ply)) then	
		CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
		return
	end
		
	victim:EmitSound("misc/taps_03.wav", 100, 100)
	victim:SetMoveType(MOVETYPE_WALK)
	victim:StripWeapons()
	victim:Give("hands")
	victim:SelectWeapon("hands")
	victim:Freeze(true)
	
	for k, v in pairs (ents.FindInSphere(victim:GetPos(), 600)) do
		if (v:IsPlayer() and v != victim) then
			v:ConCommand("say Rest in pepperoni m8.")
			v:SendLua("timer.Simple(0,function() LocalPlayer():ConCommand('act salute') end)")
		end
	end
	
	
	
	timer.Simple(6, function()
	
		victim:Freeze(false)
		victim:SetMoveType(MOVETYPE_WALK)
		victim:SetVelocity(Vector(0, 0, 3072))
		
		timer.Simple(3, function()
		
		victim:Kill()
		
		end)
					
		for i=1, 15 do
			timer.Simple(i/5, function()
				local Position = victim:GetPos()
				local Effect = EffectData()
				Effect:SetOrigin(Position)
				Effect:SetStart(Position)
				Effect:SetMagnitude(1028)
				Effect:SetScale(512)				
				util.Effect("Explosion", Effect)
				
				if i == 15 then
					
					local ED = EffectData()
		
					ED:SetOrigin( victim:GetPos() )
					ED:SetStart( Vector( 0, 213, 255 ) ) // Vector is color.
					ED:SetScale( 2 )
		
					util.Effect( 'firework_explosion', ED )	
					
					CAT_LogAction(ply, "Turned "..victim:Nick().." into a pretty firework.")

				end
			end)
		end
		
		
		
		
		
	end)
	
	
	
	
	
	
	
	
	
	
	


end)



























