
local TAG = "CAT_PP"

CATPP_Buddies = CATPP_Buddies or {}

if (!file.Exists("cat", "DATA")) then 
	MsgN("[[CAT]] Creating settings for the first time...")
	file.CreateDir("cat")
	file.Write("cat/physgunsetting.txt", "true")
	file.Write("cat/hassettings.txt", "true")
	file.Write("cat/toolgunsetting.txt", "true")
	file.Write("cat/gravgunsetting.txt", "true")
end

local physppenabled = tobool(file.Read("cat/physgunsetting.txt", "DATA"))
local toolppenabled = tobool(file.Read("cat/toolgunsetting.txt", "DATA"))
local gravppenabled = tobool(file.Read("cat/gravgunsetting.txt", "DATA"))


util.AddNetworkString( "ppstatus" )
util.AddNetworkString( "physppstatus" )
util.AddNetworkString( "toolppstatus" )
util.AddNetworkString( "gravppstatus" )
util.AddNetworkString( "ppaddbuddy" )
util.AddNetworkString( "ppremovebuddy" )


hook.Add("PlayerInitialSpawn", TAG.."_InitSpawn", function(ply)
	net.Start("ppstatus")
		net.WriteString(tostring(physppenabled))
		net.WriteString(tostring(toolppenabled))
		net.WriteString(tostring(gravppenabled))
		net.WriteString(tostring(CAT_Config.UseCATPP))
	net.Send(ply)
end)

local function CAT_ChangePropProtectionStatus(who, what, to)

	if (what == "physgun") then
	
		file.Write("cat/physgunsetting.txt", tostring(to))
		physppenabled = to
		
		if (who == "Console") then
			MsgC(Color(103, 253, 111), "[[CAT]] Console changed Physgun Protection to "..tostring(physppenabled)..".\n")
		else
			MsgC(Color(103, 253, 111), "[[CAT]] "..who:Nick().." changed Physgun Protection to "..tostring(physppenabled)..".\n")
		end

		net.Start("physppstatus")
			net.WriteString(tostring(physppenabled))
		net.Broadcast()
		
	elseif (what == "toolgun") then

		file.Write("cat/toolgunsetting.txt", tostring(to))
		toolppenabled = to
		
		if (who == "Console") then
			MsgC(Color(103, 253, 111), "[[CAT]] Console changed Toolgun Protection to "..tostring(toolppenabled)..".\n")
		else
			MsgC(Color(103, 253, 111), "[[CAT]] "..who:Nick().." changed Toolgun Protection to "..tostring(toolppenabled)..".\n")
		end

		net.Start("toolppstatus")
			net.WriteString(tostring(toolppenabled))
		net.Broadcast()	
	
	elseif (what == "gravgun") then

		file.Write("cat/gravgunsetting.txt", tostring(to))
		gravppenabled = to
		
		if (who == "Console") then
			MsgC(Color(103, 253, 111), "[[CAT]] Console changed Gravgun Protection to "..tostring(gravppenabled)..".\n")
		else
			MsgC(Color(103, 253, 111), "[[CAT]] "..who:Nick().." changed Gravgun Protection to "..tostring(gravppenabled)..".\n")
		end

		net.Start("gravppstatus")
			net.WriteString(tostring(gravppenabled))
		net.Broadcast()
	
	end

end

net.Receive("ppaddbuddy", function(len, ply)

	local id = net.ReadString()
	
	if (!CATPP_Buddies[ply:SteamID()]) then
		CATPP_Buddies[ply:SteamID()] = {}
	end

	if (table.HasValue(CATPP_Buddies[ply:SteamID()], id)) then return end
	
	table.insert(CATPP_Buddies[ply:SteamID()], #CATPP_Buddies[ply:SteamID()]+1, id)





end)

net.Receive("ppremovebuddy", function(len, ply)

	local id = net.ReadString()
	
	if (!CATPP_Buddies[ply:SteamID()]) then
		CATPP_Buddies[ply:SteamID()] = {}
	end

	table.RemoveByValue(CATPP_Buddies[ply:SteamID()], id)
	
end)

--Concommand for changing the physgun protection.
concommand.Add("cat_physgunpp", function(ply, cmd, args)

	if (!CAT_Config.UseCATPP) then return end
		
	if (!IsValid(ply)) then
		CAT_ChangePropProtectionStatus("Console", "physgun", !physppenabled)
		return
	end
	
	if (ply:IsSuperAdmin()) then
		CAT_ChangePropProtectionStatus(ply, "physgun", !physppenabled)
		return 
	end
end)

--Concommand for changing the toolgun protection.
concommand.Add("cat_toolgunpp", function(ply, cmd, args)

	if (!CAT_Config.UseCATPP) then return end
		
	if (!IsValid(ply)) then
		CAT_ChangePropProtectionStatus("Console", "toolgun", !toolppenabled)
		return
	end
	
	if (ply:IsSuperAdmin()) then
		CAT_ChangePropProtectionStatus(ply, "toolgun", !toolppenabled)
		return 
	end
end)

--Concommand for changing the gravgun protection.
concommand.Add("cat_gravgunpp", function(ply, cmd, args)

	if (!CAT_Config.UseCATPP) then return end
		
	if (!IsValid(ply)) then
		CAT_ChangePropProtectionStatus("Console", "gravgun", !gravppenabled)
		return
	end
	
	if (ply:IsSuperAdmin()) then
		CAT_ChangePropProtectionStatus(ply, "gravgun", !gravppenabled)
		return 
	end
end)

--Setting doors and stuff on map start to world entities.
local function worlddoors(ply, ent)
	if (!CAT_Config.UseCATPP) then return end
	
	for k, v in pairs (ents.GetAll()) do
		v:SetNWString("FounderName", "World")
		v.PlayerOwner = game.GetWorld()		// worldspawn
	end
	
end
hook.Add("InitPostEntity", TAG.."_SetWorld", worlddoors)


--FPtje, you sneaky clever bastard.
--Setting the prop's owner on spawn.
if cleanup then
	local oldcleanup = oldcleanup or cleanup.Add
	function cleanup.Add(ply, Type, ent)
		if not IsValid(ply) or not IsValid(ent) then return oldcleanup(ply, Type, ent) end

		ent:SetPlayerOwner(ply)
		
		if (ent:GetClass() == "gmod_wire_expression2") then
			ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end

		return oldcleanup(ply, Type, ent)
	end
end

-- some things don't call cleanup.Add
-- Well, screw those things.
local undonow = nil

if undo then
	local oldundoplayer = oldundoplayer or undo.SetPlayer
	local oldundoentity = oldundoentity or undo.AddEntity
	
	function undo.AddEntity(ent)
	
		undonow = ent
	
		oldundoentity(ent)
	
	end
	
	function undo.SetPlayer(ply)
		if not IsValid(ply) or not IsValid(undonow) then return oldundoplayer(ply) end
		
		undonow:SetPlayerOwner(ply)
		
		oldundoplayer(ply)
	end
end

--Some silly little helper functions.
local entity = FindMetaTable("Entity")

function entity:SetPlayerOwner(ent)

	if (!ent:IsPlayer()) then
		self:SetNWString("FounderName", "World")
		self.PlayerOwner = ent
		self.PlayerID = "World"
		return
	end
	
	self:SetNWString("FounderName", tostring(ent:Nick()))
	self.PlayerOwner = ent
	self.PlayerID = ent:SteamID()

end

function entity:GetPlayerOwner()

	return self.PlayerOwner

end

function entity:GetPlayerOwnerName()

	return self:GetNWString("FounderName")

end


--Physgun Blocking
function CAT_BlockPhysgun(ply, ent)

	if (!CAT_Config.UseCATPP) then return end
		
	if (CAT_Config.AdminsTouchWorldProps and ent.PlayerOwner == game.GetWorld() and CAT_CanDoAction(ply, "isadmin")) then return true end
	
	if (CAT_Config.AdminsTouchPlayerProps and CAT_CanDoAction(ply, "isadmin") and ent.PlayerOwner != game.GetWorld()) then return true end		

	if (ent.PlayerID and CATPP_Buddies[ent.PlayerID] and table.HasValue(CATPP_Buddies[ent.PlayerID], ply:SteamID())) then return true end
	
	if (ent == cat_ragdoll) then 
		if (ply:IsSuperAdmin()) then
			return true
		else
			return false
		end
	end	

	if (physppenabled) then
		if (ent.PlayerOwner != ply and ent.PlayerOwner != nil) or (ent.GetPlayer and ent:GetPlayer() != ply) then
			return false
		else
			return true
		end
	else
		return true
	end
		
end
hook.Add( "PhysgunPickup", TAG.."_PhysPP", CAT_BlockPhysgun )

--Toolgun blocking
function CAT_BlockToolgun(ply, tr, tool)
	if (!CAT_Config.UseCATPP) then return end
			
	if (CAT_CanTool(ply) == false) then return false end
	
	local ent = ply:GetEyeTrace().Entity	
	
	if (CAT_Config.AdminsTouchWorldProps and ent.PlayerOwner == game.GetWorld() and CAT_CanDoAction(ply, "isadmin")) then return true end
	
	if (CAT_Config.AdminsTouchPlayerProps and CAT_CanDoAction(ply, "isadmin") and ent.PlayerOwner != game.GetWorld()) then return true end		
		
	if (ent.PlayerID and CATPP_Buddies[ent.PlayerID] and table.HasValue(CATPP_Buddies[ent.PlayerID], ply:SteamID())) then return true end
	
	if (ent == cat_ragdoll) then 
		if (ply:IsSuperAdmin()) then
			return true
		else
			return false
		end
	end	
	
	if (ent:IsPlayer()) then
		return false
	end
	
	if (!IsValid(ent)) then
		return true
	end
	
	if (toolppenabled) then
		if (ent.PlayerOwner != ply and ent.PlayerOwner != nil) or (ent.GetPlayer and ent:GetPlayer() != ply) then
			return false
		else
			return true
			
		end
	else
		return true
	end
	
end
hook.Add("CanTool", TAG.."_ToolPP", CAT_BlockToolgun)


--Gravgun blocking
function CAT_BlockGravGun(ply, ent)
	if (!CAT_Config.UseCATPP) then return end
		
	if (CAT_Config.AdminsTouchWorldProps and ent.PlayerOwner == game.GetWorld() and CAT_CanDoAction(ply, "isadmin")) then return true end
	
	if (CAT_Config.AdminsTouchPlayerProps and CAT_CanDoAction(ply, "isadmin") and not ent.PlayerOwner == game.GetWorld()) then return true end		

	if (ent.PlayerID and CATPP_Buddies[ent.PlayerID] and table.HasValue(CATPP_Buddies[ent.PlayerID], ply:SteamID())) then return true end
	
	if (gravppenabled) then
		if (ent.PlayerOwner != ply and ent.PlayerOwner != nil) or (ent.GetPlayer and ent:GetPlayer() != ply) then
			return false
		else
			return true
			
		end
	else
		return true
	end

end
hook.Add("GravGunPickupAllowed", TAG.."_GravPP", CAT_BlockGravGun)
hook.Add("GravGunPunt", TAG.."_GravPuntPP", CAT_BlockGravGun)

--Property List Blocking
function CAT_BlockPropertyList(ply, property, ent)
	if (!CAT_Config.UseCATPP) then return end
		
	if (CAT_Config.AdminsTouchWorldProps and ent.PlayerOwner == game.GetWorld() and CAT_CanDoAction(ply, "isadmin")) then return true end
	
	if (CAT_Config.AdminsTouchPlayerProps and CAT_CanDoAction(ply, "isadmin") and not ent.PlayerOwner == game.GetWorld()) then return true end	
	
	if (ent.PlayerID and CATPP_Buddies[ent.PlayerID] and table.HasValue(CATPP_Buddies[ent.PlayerID], ply:SteamID())) then return true end
	
	if (ent.PlayerOwner != ply and ent.PlayerOwner != nil) or (ent.GetPlayer and ent:GetPlayer() != ply) then
		return false
	else
		return true
	end
end
hook.Add("CanProperty", TAG.."_PropertyPP", CAT_BlockPropertyList)

-- Entity driving blocking
function CAT_BlockDriving(ply, ent)
	if (!CAT_Config.UseCATPP) then return end
		
	if (CAT_Config.AdminsTouchWorldProps and ent.PlayerOwner == game.GetWorld() and CAT_CanDoAction(ply, "isadmin")) then return true end
	
	if (CAT_Config.AdminsTouchPlayerProps and CAT_CanDoAction(ply, "isadmin") and not ent.PlayerOwner == game.GetWorld()) then return true end	
	
	if (ent.PlayerID and CATPP_Buddies[ent.PlayerID] and table.HasValue(CATPP_Buddies[ent.PlayerID], ply:SteamID())) then return true end
	
	if (ent.PlayerOwner != ply and ent.PlayerOwner != nil) or (ent.GetPlayer and ent:GetPlayer() != ply) then
		return false
	else
		return true
	end
end
hook.Add("CanDrive", TAG.."_DrivePP", CAT_BlockDriving)

--Reload Protection Blocking
function CAT_BlockReload(weapon, ply)

	if (!CAT_Config.UseCATPP) then return end
		
	local ent = ply:GetEyeTrace().Entity	
	
	if (!IsValid(ent)) then return end
	
	if (CAT_Config.AdminsTouchWorldProps and ent.PlayerOwner == game.GetWorld() and CAT_CanDoAction(ply, "isadmin")) then return end
	
	if (CAT_Config.AdminsTouchPlayerProps and CAT_CanDoAction(ply, "isadmin") and not ent.PlayerOwner == game.GetWorld()) then return end	
	
	if (ent.PlayerID and CATPP_Buddies[ent.PlayerID] and table.HasValue(CATPP_Buddies[ent.PlayerID], ply:SteamID())) then return true end
	
	if (ent.PlayerOwner != ply and ent.PlayerOwner != nil) or (ent.GetPlayer and ent:GetPlayer() != ply) then
		return false
	else
		return
	end






end
hook.Add("OnPhysgunReload", TAG.."_ReloadPP", CAT_BlockReload)

disconplayers = disconplayers or {}

local okaytools = {
["axis"] = true,
["ballsocket"] = true,
["motor"] = true,
["weld"] = true,
["inflator"] = true,
["physprop"] = true,
["color"] = true,
["material"] = true,
["paint"] = true,
["trail"] = true,
["remover"] = true,
["wire"] = true,
["wire_adv"] = true
}



--Cleanup Disconnected players props.
local function cat_cleandisconprop(ply)
	if (!CAT_Config.UseCATPP) then return end
	if not IsValid(ply) then return end

	local SteamID = ply:SteamID()
	disconplayers[SteamID] = true

	timer.Simple(CAT_Config.DisconCleanupTime, function()
		for k,v in pairs(player.GetAll()) do
			if v:SteamID() == SteamID then
				return
			end
		end
		for k,v in pairs(ents.GetAll()) do
			if IsValid(v) and v.PlayerID == SteamID then
				v:Remove()
			end
		end
		disconplayers[SteamID] = nil 
	end)
end
hook.Add("PlayerDisconnected", TAG.."_DisconCleanup", cat_cleandisconprop)

--Easiest way to do it.
local function IsAdvDupeRunning(ply)

	return (AdvDupe and AdvDupe[ply] and AdvDupe[ply].Pasting)
		
end

--Check if the player is exceeding the spam timer.
local function canspawnobject( ply, spawntype )
	
	if (!CAT_Config.UseCATPP) then return true end
	
	if (ply:GetTool() and okaytools[ply:GetTool().Mode]) then
		return true
	end
		
	if (!ply.SpamTimer) then
	
		ply.SpamTimer = {}
		ply.SpamTimer["spawn"] = 0
		ply.SpamTimer["tool"] = 0
		
	end	

	local delay = CAT_Config.AntispamTime
	
	if (delay != 0) then
	
		if (spawntype == "spawn" and IsAdvDupeRunning(ply)) then
					
			ply.SpamTimer[spawntype] = CurTime()
			return true
					
		end
		
		
		
		if ((CurTime() - ply.SpamTimer[spawntype]) < delay) then
			return false
		end
	end

	ply.SpamTimer[spawntype] = CurTime()
	return true
end

--If they are exceeding it, then warn them and return false on whatever.
local function canspawnobjectmessage( ply, spawntype )
	
	if (!CAT_Config.UseCATPP) then return true end
		
		if (!canspawnobject(ply, spawntype)) then
		
			local delay = CAT_Config.AntispamTime
			local time = delay - (CurTime() - ply.SpamTimer[spawntype])

			if (time > 0) then
				CAT_PlayerMsg(ply, "Creating stuff to fast! Slow down! Wait " .. string.format("%.2f", time) .. " seconds.")
			else
				CAT_PlayerMsg(ply, "Creating stuff to fast! Slow down!")
			end
			return false
			
		end
		
		return true
	
	end

--BLOCK OF CODE
local function CAT_PlayerSpawnRagdoll(ply)	if (!canspawnobjectmessage(ply, "spawn")) then return false end	end
local function CAT_PlayerSpawnProp(ply)		if (!canspawnobjectmessage(ply, "spawn")) then return false end	end
local function CAT_PlayerSpawnEffect(ply)	if (!canspawnobjectmessage(ply, "spawn")) then return false end	end
local function CAT_PlayerSpawnVehicle(ply)	if (!canspawnobjectmessage(ply, "spawn")) then return false end	end
local function CAT_PlayerSpawnSENT(ply)		if (!canspawnobjectmessage(ply, "spawn")) then return false end	end
local function CAT_PlayerSpawnNPC(ply)		if (!canspawnobjectmessage(ply, "spawn")) then return false end	end
	
hook.Add("PlayerSpawnRagdoll", TAG.."_RagdollSpam", CAT_PlayerSpawnRagdoll )
hook.Add("PlayerSpawnProp", TAG.."_PropSpam", CAT_PlayerSpawnProp )
hook.Add("PlayerSpawnEffect", TAG.."_EffectSpam", CAT_PlayerSpawnEffect )
hook.Add("PlayerSpawnVehicle", TAG.."_VehicleSpam", CAT_PlayerSpawnVehicle )
hook.Add("PlayerSpawnSENT", TAG.."_SENTSpam", CAT_PlayerSpawnSENT )
hook.Add("PlayerSpawnNPC", TAG.."_NPCSpam", CAT_PlayerSpawnNPC )
--/END BLOCK OF CODE

--Simple helper function to see if the player is spamming the toolgun. Not sure if it needs to be global or not. Oh well.
function CAT_CanTool(ply)
	
	if (!CAT_Config.UseCATPP) then return true end		
	
	if (!canspawnobjectmessage(ply, "tool")) then
		return false
	end

end


MsgC(Color(46, 255, 137), "[[CAT]] CAT Prop Protection loaded! \n")






