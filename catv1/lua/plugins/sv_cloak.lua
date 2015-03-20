/*=======================
==Cloak module, created==
=======by Lolcats========
=======================*/

local PLUGINNAME = "cloak"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!cloak"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!cloak target"

concommand.Add("cat_cloak", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "cloak")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	ply:SetNoDraw(true)
	
	for k, v in ipairs( victim:GetWeapons() ) do
		v:SetRenderMode(4)
	end
	
	CAT_LogAction(ply, "Cloaked "..victim:Nick()..".")

end)