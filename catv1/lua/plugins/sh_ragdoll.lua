/*=======================
=Ragdoll module, created=
=======by Lolcats========
=======================*/


if (SERVER) then

	local PLUGINNAME = "ragdoll"
	CAT_Commands[PLUGINNAME] = {}
	CAT_Commands[PLUGINNAME].command = "!ragdoll"
	CAT_Commands[PLUGINNAME].args = 1
	CAT_Commands[PLUGINNAME].help = "!ragdoll target"



	concommand.Add("cat_ragdoll", function( ply, command, arguments )
			
		if (!IsValid(ply)) then
			ply = "Console"
		end		
			
		local plycando = CAT_CanDoAction(ply, "ragdoll")
			if plycando == false then
		return end	
			
		local victim = CAT_FindPlayerUserID( arguments[1] )
		
			if (victim:IsBetterOrSame(ply)) then
				
				CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
				
				return
			end
		
		
		if (victim:GetNWBool("cat_isragdoll")) then
		
		if not victim:GetNWBool("cat_isragdoll") then
			if victim:InVehicle() then
				victim:ExitVehicle()
				victim:GetParent():Remove()
			end
			
			if victim:GetMoveType() == MOVETYPE_NOCLIP then
				victim:SetMoveType( MOVETYPE_WALK )
			end
			
			
			victim:SetNWBool( "cat_isragdoll", true )
			victim:StripWeapons()
			victim:DrawViewModel( false )
			victim:DrawWorldModel( false )
			victim:SetColor( 255, 255, 255, 0 )

			cat_ragdoll = ents.Create( "prop_ragdoll" )
			cat_ragdoll:SetPos( victim:GetPos() )
			cat_ragdoll:SetModel( victim:GetModel() )
			cat_ragdoll:SetAngles( victim:GetAngles() )
			cat_ragdoll:Spawn()
			cat_ragdoll:Activate()
						
			victim:Spectate( OBS_MODE_ROAMING )
			victim:Freeze( true )
			victim:SetNWEntity( "plyragdoll", cat_ragdoll )
			
			CAT_LogAction(ply, "Ragdolled "..victim:Nick()..".")
			
		else
		
			if cat_ragdoll:IsValid() then

				cat_ragdoll:Remove()
				victim:SetPos( cat_ragdoll:GetPos() + Vector( 0, 0, 50 ) )
				victim:Spawn()			
				victim:SetModel( cat_ragdoll:GetModel() )

			else
				if victim:GetNWBool( "cat_isragdoll" ) then
					victim:Kill()
				end
			end
			
			victim:SetNWBool( "cat_isragdoll", false )
			victim:DrawViewModel( true )
			victim:DrawWorldModel( true )
			victim:SetColor( 255, 255, 255, 255 )
			victim:Freeze( false )
			
			for k, v in pairs (CAT_Config.GiveRagWeps) do
				victim:Give(v)
			end
		
			CAT_LogAction(ply, "Unragdolled "..victim:Nick()..".")
		
		
		end

		else 
		
			if victim:InVehicle() then
				victim:ExitVehicle()
				victim:GetParent():Remove()
			end
			
			if victim:GetMoveType() == MOVETYPE_NOCLIP then
				victim:SetMoveType( MOVETYPE_WALK )
			end
			
			victim:SetNWBool( "cat_isragdoll", true )
			victim:StripWeapons()
			victim:DrawViewModel( false )
			victim:DrawWorldModel( false )
			victim:SetColor( 255, 255, 255, 0 )

			cat_ragdoll = ents.Create( "prop_ragdoll" )
			cat_ragdoll:SetPos( victim:GetPos() )
			cat_ragdoll:SetModel( victim:GetModel() )
			cat_ragdoll:SetAngles( victim:GetAngles() )
			cat_ragdoll:Spawn()
			cat_ragdoll:Activate()
						
			victim:Spectate( OBS_MODE_ROAMING )
			victim:Freeze( true )
			victim:SetNWEntity( "plyragdoll", cat_ragdoll )
			
			CAT_LogAction(ply, "Ragdolled "..victim:Nick()..".")
		end
	end)

	
	function RemoveRagdollOnDisconnect( ply )
		local ent = ply:GetNWEntity( "plyragdoll" )
		if ent:IsValid() then
			ent:Remove()
		end
	end
	hook.Add( "PlayerDisconnected", "RemoveRagdollOnDisconnect", RemoveRagdollOnDisconnect )

	hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawnRag", function( PLAYER ) PLAYER:SetNWBool( "cat_isragdoll", false ) end )

	hook.Add( "CanPlayerEnterVehicle", "CanPlayerEnterVehicleRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "CanPlayerSuicide", "CanPlayerSuicideRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerCanPickupWeapon", "PlayerCanPickupWeaponRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerGiveSWEP", "PlayerGiveSWEPRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerNoClip", "PlayerNoClipRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnEffect", "PlayerSpawnEffectRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnNPC", "PlayerSpawnNPCRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnObject", "PlayerSpawnObjectRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnSENT", "PlayerSpawnSENTRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnSWEP", "PlayerSpawnSWEPRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnProp", "PlayerSpawnPropRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnRagdoll", "PlayerSpawnRagdollRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerSpawnVehicle", "PlayerSpawnVehicleRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
	hook.Add( "PlayerUse", "PlayerUseRag", function( PLAYER ) if PLAYER:GetNWBool( "cat_isragdoll" ) then return false end end )
end

if (CLIENT) then
		
		function catcalcview( pl, origin, angles, fov )

		if pl:GetNWBool( "cat_isragdoll" ) then

			local ragdoll = pl:GetNWEntity( "plyragdoll" )
			if not ragdoll or ragdoll == NULL or not ragdoll:IsValid() then return end
			local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment( "eyes" ) )
			local view = {
				origin = eyes.Pos,
				angles = eyes.Ang,
				fov = 90,
			}

			return view
		else return end
     
    end
    hook.Add( "CalcView", "catragdollview", catcalcview )
end