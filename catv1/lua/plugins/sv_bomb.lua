/*=======================
===Bomb module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "bomb"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!bomb"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!bomb target"

concommand.Add("cat_bomb", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "bomb")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
	if (victim:IsBetterOrSame(ply)) then
			
		CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
		
		return
	end	
	
	
	
	local bomb = ents.Create( "grenade_helicopter" )
	bomb:SetMoveType(MOVETYPE_NONE)
	bomb:SetAngles( Angle(0,0,0) )
	bomb:SetPos( victim:GetAttachment(1).Pos )
	bomb:Spawn()
	bomb:Activate()
	bomb:SetParent(victim, victim:GetAttachment(1))
	bomb:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	bomb:Fire("ExplodeIn", "3")							-- fix it fix it fix it
	
	victim:EmitSound("npc/strider/charging.wav", 100, 100)
	
	timer.Simple(1.5, function()
	local Position = bomb:GetPos()
	local Effect = EffectData()
	Effect:SetOrigin(Position)
	Effect:SetStart(Position)
	Effect:SetMagnitude(1028)
	Effect:SetScale(512)				
	util.Effect("Explosion", Effect)
	
	bomb:Remove()
	victim:Kill()
	end)
	
	
	CAT_LogAction(ply, "Bombed "..victim:Nick()..".")
	
end)