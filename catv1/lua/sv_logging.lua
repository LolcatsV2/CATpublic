local LogFile = LogFile
local TAG = "CAT_Logging"
local ShouldLogStuff = CAT_Config.ShouldLogStuff

if (!file.Exists("cat/logs", "DATA")) then 
	file.CreateDir("cat/logs")
end

function CAT_WriteToLog(text)
	
	if not text or text == "" then return end
	
	if (type(text) == "table") then
		
		for k, v in pairs (text) do
			if (type(v) == "table") then
				table.remove(text, k)
			end
		end
	
		text = table.concat(text, "")
	
	end
	
	if not LogFile then 
		LogFile = "cat/logs/"..os.date("%m_%d_%Y %I_%M %p")..".txt"
		file.Write(LogFile, os.date().. "\t".. text)
		return
	end
	file.Append(LogFile, "\n"..os.date().. "\t"..text)

end

local function Broadcast_Live(what)

	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			v:PrintMessage(HUD_PRINTCONSOLE, what)
		end
	end

	MsgN(what)


end

-- DarkRP will handle everything for us (I hope).
if (string.lower(engine.ActiveGamemode()) == "darkrp") then 
	ShouldLogStuff = false
end

if (ShouldLogStuff) then
	/*========================================
	PlayerSpawnedSENT
	========================================*/
	hook.Add("PlayerSpawnedSENT", TAG, function(ply, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent) then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SENT"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SENT"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SENT"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SENT"))
		end
	end)

	/*========================================
	PlayerSpawnedNPC
	========================================*/
	hook.Add("PlayerSpawnedNPC", TAG, function(ply, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent) then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SENT"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SENT"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SENT"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SENT"))
		end
	end)

	/*========================================
	PlayerSpawnedSWEP
	========================================*/
	hook.Add("PlayerSpawnedSWEP", TAG, function(ply, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent) then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SWEP"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SWEP"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SWEP"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SWEP"))
		end
	end)

	/*========================================
	PlayerSpawnedVehicle
	========================================*/
	hook.Add("PlayerSpawnedVehicle", TAG, function(ply, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent) then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SENT"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(ent:GetClass() or "Unknown SENT"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SENT"))	
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(ent:GetClass() or "Unknown SENT"))
		end
	end)

	/*========================================
	PlayerSpawnSWEP
	========================================*/
	hook.Add("PlayerSpawnSWEP", TAG, function(ply, class)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		
		Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(class or "Unknown SWEP"))
			
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(class or "Unknown SWEP"))
	end)

	/*========================================
	PlayerSpawnedProp
	========================================*/
	hook.Add("PlayerSpawnedProp", TAG, function(ply, model, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent) then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(model or "Unknown Prop"))
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(model or "Unknown Prop"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(model or "Unknown Prop"))
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(model or "Unknown Prop"))
		end
	end)

	/*========================================
	PlayerSpawnedEffect
	========================================*/
	hook.Add("PlayerSpawnedEffect", TAG, function(ply, model, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not model then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(model or "Unknown Prop"))
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(model or "Unknown Prop"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(model or "Unknown Prop"))
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(model or "Unknown Prop"))
		end
	end)

	/*========================================
	PlayerSpawnedRagdoll
	========================================*/
	hook.Add("PlayerSpawnedRagdoll", TAG, function(ply, model, ent)
		if not IsValid(ply) or not ply:IsPlayer() or not IsValid(ent) then return end
		
		if (ply:GetActiveWeapon():GetClass() == "gmod_tool") and (table.HasValue(ply:GetTool(), "#tool.duplicator.name")) then
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(model or "Unknown Prop"))
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a dupe with "..(model or "Unknown Prop"))
		else
			Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(model or "Unknown Prop"))
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned a "..(model or "Unknown Prop"))
		end
	end)

	/*========================================
	PlayerGiveSWEP
	========================================*/	
	hook.Add("PlayerGiveSWEP", TAG, function(ply, class)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		
		Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Gave themself a "..(class or "Unknown SWEP"))	
		
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Gave himself a "..(class or "Unknown SWEP"))
	end)

	/*========================================
	CanTool
	========================================*/
	hook.Add("CanTool", TAG, function(ply, tr, toolclass)
		if not IsValid(ply) or not ply:IsPlayer() then return end
			
		Broadcast_Live(ply:Nick().." ("..ply:SteamID()..") Attempted to use tool "..(toolclass or "Unknown Tool"))	
		
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Attempted to use tool "..(toolclass or "Unknown Tool"))		

	end)

	/*========================================
	PlayerLeaveVehicle
	========================================*/
	hook.Add("PlayerLeaveVehicle", TAG, function(ply, vehicle)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") exited a "..(IsValid(vehicle) and vehicle:GetClass() or "Unknown Vehicle"))
	end)

	/*========================================
	OnNPCKilled
	========================================*/
	hook.Add("OnNPCKilled", TAG, function(NPC, Killer, Weapon)
		if not IsValid(NPC) then return end
		CAT_WriteToLog(NPC:GetClass().. " was killed by ".. (IsValid(Killer) and (Killer:IsPlayer() and Killer:Nick() or Killer:GetClass()) or "Unknown NPC") .. " with a ".. (IsValid(Weapon) and Weapon:GetClass() or "Unknown Weapon"))
	end)

	/*========================================
	OnPlayerChangedTeam
	========================================*/
	hook.Add("OnPlayerChangedTeam", TAG, function(ply, oldteam, newteam)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") changed from "..team.GetName(oldteam).. " to ".. team.GetName(newteam))
	end)

	/*========================================
	WeaponEquip
	========================================*/
	hook.Add("WeaponEquip", TAG, function(weapon)
			timer.Simple(0, function()
				if not IsValid(weapon) then return end
				local ply = weapon:GetOwner()
				if not IsValid(ply) or not ply:IsPlayer() then return end
				CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Attempted to pick up a "..weapon:GetClass())
			end)
	end)

	/*========================================
	PlayerDeath
	========================================*/
	hook.Add("PlayerDeath", TAG, function(ply, inflictor, Killer)
		local Nick, SteamID, KillerName, InflictorName = (IsValid(ply) and ply:Nick() or "N/A"), (IsValid(ply) and ply:SteamID() or "N/A"),
			(IsValid(Killer) and (Killer:IsPlayer() and Killer:Nick() or Killer:GetClass()) or "N/A"),
			(IsValid(inflictor) and inflictor:GetClass() or "N/A")
		CAT_WriteToLog(Nick.." ("..SteamID..") Got killed by "..KillerName.." with a "..InflictorName)
	end)

	/*========================================
	PlayerSilentDeath
	========================================*/
	hook.Add("PlayerSilentDeath", TAG, function(ply)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was killed silently")
	end)

	/*========================================
	PlayerSay
	========================================*/
	hook.Add("PlayerSay", TAG, function(ply, text, teamonly, dead)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") [".. (dead and "dead, " or "")..((teamonly and "team only") or "all") .."] "..(text and text or ""))
	end)

	/*========================================
	PlayerSpawn
	========================================*/
	hook.Add("PlayerSpawn", TAG, function(ply)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Spawned")
	end)

	/*========================================
	PlayerSpray
	========================================*/
	hook.Add("PlayerSpray", TAG, function(ply)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Sprayed his spray")
	end)

	/*========================================
	PlayerEnteredVehicle
	========================================*/
	hook.Add("PlayerEnteredVehicle", TAG, function(ply, vehicle)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Entered ".. (IsValid(vehicle) and vehicle:GetClass() or "Unknown Vehicle"))
	end)

	/*========================================
	EntityRemoved
	========================================*/
	hook.Add("EntityRemoved", TAG, function(ent) 
		if IsValid(ent) and ent:GetClass() == "prop_physics" then 
			CAT_WriteToLog(ent:GetClass().. "(" .. (ent:GetModel() or "<no model>") .. ") Was removed") 
		end 
	end)

	/*========================================
	PlayerNoClip
	========================================*/
	hook.Add("PlayerNoClip", TAG, function(ply)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Attempted to noclip")
	end)

	--No point in needlessly adding hooks if they aren't used :v
	if (string.lower(engine.ActiveGamemode()) == "darkrp") then

		/*========================================
		onHitAccepted
		========================================*/
		hook.Add("onHitAccepted", TAG, function(ply, target, customer)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(target) or not IsValid(customer) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Accepted a hit on "..target:Nick().." ("..target:SteamID().."), ordered by "..customer:Nick().." ("..target:SteamID()..").")
		end)

		/*========================================
		onHitCompleted
		========================================*/
		hook.Add("onHitCompleted", TAG, function(ply, target, customer)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(target) or not IsValid(customer) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Completed a hit on "..target:Nick().." ("..target:SteamID().."), ordered by "..customer:Nick().." ("..target:SteamID()..").")
		end)

		/*========================================
		onHitFailed
		========================================*/
		hook.Add("onHitFailed", TAG, function(ply, target, reason)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(target) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Completed a hit on "..target:Nick().." ("..target:SteamID().."), for the reason: "..reason.. ".")
		end)

		/*========================================
		onPlayerChangedName
		========================================*/
		hook.Add("onPlayerChangedName", TAG, function(ply, oldname, newname)
			if not IsValid(ply) or not ply:IsPlayer() then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Changed their name from "..oldname.." to "..newname)
		end)

		/*========================================
		onPlayerDemoted
		========================================*/
		hook.Add("onPlayerDemoted", TAG, function(ply, target, reason)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(target) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Demoted "..target:Nick().." ("..target:SteamID()..") for the reason: "..reason.. ".")
		end)

		/*========================================
		playerArrested
		========================================*/
		hook.Add("playerArrested", TAG, function(ply, time, arrestor)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(arrestor) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was arrested by "..arrestor:Nick().." ("..arrestor:SteamID()..") for "..time.. " seconds.")
		end)

		/*========================================
		playerUnArrested
		========================================*/
		hook.Add("playerUnArrested", TAG, function(ply, arrestor)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(arrestor) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was unarrested after being arrested by "..arrestor:Nick().." ("..arrestor:SteamID()..").")
		end)

		/*========================================
		playerWanted
		========================================*/
		hook.Add("playerWanted", TAG, function(ply, wanter, reason)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(wanter) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was wanted by "..wanter:Nick().." ("..wanter:SteamID()..") for the reason: "..reason..".")
		end)

		/*========================================
		playerUnWanted
		========================================*/
		hook.Add("playerUnWanted", TAG, function(ply, unwanter)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(unwanter) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was unwanted by "..unwanter:Nick().." ("..unwanter:SteamID()..").")
		end)

		/*========================================
		playerWarranted
		========================================*/
		hook.Add("playerWarranted", TAG, function(ply, warranter, reason)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(warranter) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was warranted by "..warranter:Nick().." ("..warranter:SteamID()..") for the reason: "..reason..".")
		end)

		/*========================================
		playerUnWarranted
		========================================*/
		hook.Add("playerUnWarranted", TAG, function(ply, unwarranter)
			if not IsValid(ply) or not ply:IsPlayer() or not IsValid(unwarranter) then return end
			CAT_WriteToLog(ply:Nick().." ("..ply:SteamID()..") Was unwarranted by "..unwarranter:Nick().." ("..unwarranter:SteamID()..").")
		end)
		
	end
end















