/*=======================
===Mute module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "mute"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!mute"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!mute target"

concommand.Add("cat_mute", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "mute")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end


			local ismuted = victim:GetNWBool("cat_ismuted")
				
			if (ismuted) then
				victim:SetNWBool("cat_ismuted", false)
				CAT_LogAction(ply, "Unmuted "..victim:Nick()..".")
			else
				victim:SetNWBool("cat_ismuted", true)
				CAT_LogAction(ply, "Muted "..victim:Nick()..".")
			end

end)

local function replacemute(ply, text, teamchat)

	if ply:GetNWBool("cat_ismuted") == true then
		return ""
	end
end
hook.Add( "PlayerSay", "IsPlayermuted", replacemute)
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawnMute", function( ply ) ply:SetNWBool( "cat_ismuted", false ) end )
			
			
			