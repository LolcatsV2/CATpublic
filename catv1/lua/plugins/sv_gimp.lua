/*=======================
===Gimp module,created===
=======by Lolcats========
=======================*/

concommand.Add("cat_gimp", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "gimp")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end


			local isgimp = victim:GetNWBool("cat_isgimped")
				
			if (isgimp) then
				victim:SetNWBool("cat_isgimped", false)
				CAT_LogAction(ply, "Ungimpped "..victim:Nick()..".")
			else
				victim:SetNWBool("cat_isgimped", true)
				CAT_LogAction(ply, "Gimpped "..victim:Nick()..".")
			end

end)

local function replacegimp(ply, text, teamchat)

	if ply:GetNWBool("cat_isgimped") == true then
		return table.Random(CAT_Config.GimpMessages)
	end
end
hook.Add( "PlayerSay", "IsPlayerGimped", replacegimp)
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawnGimp", function( ply ) ply:SetNWBool( "cat_isgimped", false ) end )
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		