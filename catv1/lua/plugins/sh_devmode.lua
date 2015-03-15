/*=======================
==Devmode module,created==
=======by Lolcats========
=======================*/

cat_devenabled = "false"
local hooks = {
	"Effect",
	"NPC",
	"Prop",
	"Ragdoll",
	"SENT",
	"Vehicle"
}
local allowed = {
	["admin"] = true,
	["superadmin"] = true
}


if (SERVER) then 

	--No Chat Command for this.
	-- local PLUGINNAME = "devmode"

	-- CAT_Commands[PLUGINNAME] = {}
	-- CAT_Commands[PLUGINNAME].command = "!devmode"
	-- CAT_Commands[PLUGINNAME].args = 1
	-- CAT_Commands[PLUGINNAME].help = "!devmode"


	util.AddNetworkString("cat_enabledev")

	concommand.Add("cat_devmode", function( ply, command, arguments )
			
		if (!IsValid(ply)) then
			ply = "Console"
		end		
			
		local plycando = CAT_CanDoAction(ply, "enabledevmode")
			if plycando == false then
		return end
		
		if cat_devenabled == "false" then
			cat_devenabled = "true"
			CAT_LogActionServer(ply, "Enabled dev mode.")
		else
			cat_devenabled = "false"
			CAT_LogActionServer(ply, "Disabled dev mode.")
		end
		
		net.Start("cat_enabledev")
			net.WriteString(cat_devenabled)
		net.Broadcast()
		
		for k, v in pairs (player.GetAll()) do
			if (!allowed[v:GetUserGroup()]) then
			v:Kill()
			end
		end
		
	end)
	
	
	hook.Add("PlayerLoadout", "devmode", function(client)
		if (cat_devenabled == "true" and !allowed[client:GetUserGroup()]) then
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
		hook.Add("PlayerSpawned"..v, "devmode", function(client)
			if (!allowed[client:GetUserGroup()] and cat_devenabled == "true") then
				return false
			end
		end)

		hook.Add("PlayerSpawn"..v, "devmode", function(client)
			if (!allowed[client:GetUserGroup()] and cat_devenabled == "true") then
				return false
			end
		end)
	end

	
	
end

if (CLIENT) then

net.Receive("cat_enabledev", function(len)

cat_devenabled = net.ReadString()
end)


surface.CreateFont("dev_Big", {
		font = "Coolvetica",
		size = 36,
	})

	surface.CreateFont("dev_Small", {
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
	
	if (cat_devenabled == "true" and !allowed[LocalPlayer():GetUserGroup()]) then
	DrawColorModify( on )
	else
	DrawColorModify( off )
	end

end)
	
	
	

	hook.Add("HUDPaint", "devmode", function()
		if (cat_devenabled == "true" and !allowed[LocalPlayer():GetUserGroup()]) then
		draw.SimpleText("You're not allowed in the development mode.", "dev_Big", ScrW() * 0.5 + 1, ScrH() * 0.15 + 1, color_black, 1, 1)
		draw.SimpleText("Thus, you will be a ghost in the map.", "dev_Small", ScrW() * 0.5, ScrH() * 0.2, color_white, 1, 1)
		end
	end)
	
	
	
	
	
	
	
end


/*hook.Add("CanTool", "devmode", function(client)
	if (!allowed[client:GetNWString("CAT_Usergroup")]) and cat_devenabled == "true") then
		return false
	end
end)*/

hook.Add("CanProperty", "devmode", function(client)
	if (!allowed[client:GetUserGroup()] and cat_devenabled == "true") then
		return false
	end
end)

function restrictgive(ply, wep, tbl)

	if (!allowed[ply:GetUserGroup()] and cat_devenabled == "true") then
		return false
	else
		return true
	end
end


hook.Add("PlayerGiveSWEP", "restrictweps", restrictgive)
hook.Add("PlayerSpawnSWEP", "restrictweps", restrictgive)