/*=======================
==Armor module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "armor"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!armor"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!armor target amount"

concommand.Add("cat_armor", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "armor")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")
		return
	end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:SetArmor(arguments[2])
	
	CAT_LogAction(ply, "Set "..victim:Nick().."'s armor to "..arguments[2]..".")
	
end)