/*=======================
===Give module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "give"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!give"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!give target weaponname"

concommand.Add("cat_give", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "give")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	local weapontogive = arguments[2]
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end


		victim:Give(weapontogive)
		CAT_LogAction(ply, "Gave "..victim:Nick().." a "..weapontogive..".")

end)