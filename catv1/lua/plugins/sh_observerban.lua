/*=======================
=Obs.Ban module, created=
=======by Lolcats========
=======================*/

local hooks = {
	"Effect",
	"NPC",
	"Prop",
	"Ragdoll",
	"SENT",
	"Vehicle"
}

if (SERVER) then 

	local PLUGINNAME = "observerban"

	CAT_Commands[PLUGINNAME] = {}
	CAT_Commands[PLUGINNAME].command = "!observerban"
	CAT_Commands[PLUGINNAME].args = 2
	CAT_Commands[PLUGINNAME].help = "!observerban who length"


	util.AddNetworkString("cat_obsban")

	concommand.Add("cat_observerban", function( ply, command, arguments )
			
		if (!IsValid(ply)) then
			ply = "Console"
		end		
			
		local plycando = CAT_CanDoAction(ply, "observerban")
		if plycando == false then
			CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")
			return
		end
		
		local victim = CAT_FindPlayerUserID( arguments[1] )
		local time = arguments[2]
		
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
		
		
		if (victim:GetNWBool("CAT_ObserverBan")) then
			victim:SetNWBool("CAT_ObserverBan", false)
		else
			victim:SetNWBool("CAT_ObserverBan", true)
			timer.Create("ObsBan_"..victim:SteamID(), time, 1, function ()
			
				if ( IsValid(victim) and victim:GetNWBool("CAT_ObserverBan")) then
					RunConsoleCommand("cat_observerban", victim:UserID())
				end
				
			end)
		end
		
		if (victim:GetNWBool("CAT_ObserverBan")) then
			victim:StripWeapons()
			victim:SetRenderMode(4)
			victim:SetColor(Color(255, 255, 255, 75))
			victim:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			victim:SetWalkSpeed(140)
			victim:SetRunSpeed(140)
			victim:DrawShadow(false)		
			victim:SetAvoidPlayers(false)
			
			CAT_LogAction(ply, "Observer Banned "..victim:Nick().." for "..time.." seconds.")
			
		else
		
			for k, v in pairs (CAT_Config.GiveRagWeps) do
				victim:Give(v)
			end	
			
			victim:SetColor(Color(255, 255, 255, 255))
			victim:DrawShadow(true)
			victim:SetWalkSpeed(200)
			victim:SetRunSpeed(400)
			victim:SetCollisionGroup(COLLISION_GROUP_PLAYER)

			CAT_LogAction(ply, "Un-Observer Banned "..victim:Nick()..".")
			
		end
		
		
		
	end)
	
	
	hook.Add("PlayerLoadout", "CAT_observerban", function(client)
		if (client:GetNWBool("CAT_ObserverBan")) then
			timer.Simple(0.01, function()
				client:StripWeapons()
				client:SetRenderMode(4)
				client:SetColor(Color(255, 255, 255, 75))
				client:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				client:SetWalkSpeed(140)
				client:SetRunSpeed(client:GetWalkSpeed())
				client:DrawShadow(false)
			end)

			client:SetAvoidPlayers(false)
		else
			client:SetColor(Color(255, 255, 255, 255))
			client:DrawShadow(true)

		end
	end)

	for k, v in pairs(hooks) do
		hook.Add("PlayerSpawned"..v, "CAT_observerban", function(client)
			if (client:GetNWBool("CAT_ObserverBan")) then
				return false
			end
		end)

		hook.Add("PlayerSpawn"..v, "CAT_observerban", function(client)
			if (client:GetNWBool("CAT_ObserverBan")) then
				return false
			end
		end)
	end

end

if (CLIENT) then

surface.CreateFont("banned_big", {
		font = "Coolvetica",
		size = 36,
	})

	surface.CreateFont("banned_small", {
		font = "Coolvetica",
		size = 20
	})

	
	local on = {}
	on[ "$pp_colour_addr" ] = 0
	on[ "$pp_colour_addg" ] = 0
	on[ "$pp_colour_addb" ] = 0
	on[ "$pp_colour_brightness" ] = 0
	on[ "$pp_colour_contrast" ] = 0.7
	on[ "$pp_colour_colour" ] = 0.4
	on[ "$pp_colour_mulr" ] = 0
	on[ "$pp_colour_mulg" ] = 0
	on[ "$pp_colour_mulb" ] = 0 

	local off = {}
	off[ "$pp_colour_addr" ] = 0
	off[ "$pp_colour_addg" ] = 0
	off[ "$pp_colour_addb" ] = 0
	off[ "$pp_colour_brightness" ] = 0
	off[ "$pp_colour_contrast" ] = 1
	off[ "$pp_colour_colour" ] = 1
	off[ "$pp_colour_mulr" ] = 0
	off[ "$pp_colour_mulg" ] = 0
	off[ "$pp_colour_mulb" ] = 0 
	
hook.Add( "RenderScreenspaceEffects", "dograyscale", function()

	local ply = LocalPlayer()
	
	if (ply:GetNWBool("CAT_ObserverBan")) then
		DrawColorModify( on )
	else
		DrawColorModify( off )
	end

end)
	
	
	

hook.Add("HUDPaint", "CAT_observerban", function()
	if (LocalPlayer():GetNWBool("CAT_ObserverBan")) then
	draw.SimpleText("You have been banned! (oh no)", "banned_big", ScrW() * 0.5 + 1, ScrH() * 0.15 + 1, color_black, 1, 1)
	draw.SimpleText("You will not be able to interact with anything until your ban expires.", "banned_small", ScrW() * 0.5, ScrH() * 0.2, color_white, 1, 1)
	end
end)
	
	
	
	
	
	
	
end


hook.Add("CanTool", "CAT_observerban", function(client)
	if (client:GetNWBool("CAT_ObserverBan")) then
		return false
	end
end)

hook.Add("CanProperty", "CAT_observerban", function(client)
	if (client:GetNWBool("CAT_ObserverBan")) then
		return false
	end
end)

local function restrictgive(client, wep, tbl)

	if (client:GetNWBool("CAT_ObserverBan")) then
		return false
	else
		return true
	end
end


hook.Add("PlayerGiveSWEP", "restrictweps", restrictgive)
hook.Add("PlayerSpawnSWEP", "restrictweps", restrictgive)