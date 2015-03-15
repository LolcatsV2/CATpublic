/*=======================
=UBan Job module,created=
=======by Lolcats========
=======================*/

// I dunno how to make this a chat command. Too bad ;v
/*local PLUGINNAME = "unbanjob"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!unbanjob"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!unbanjob target amount"
*/


concommand.Add("cat_unbanjob", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "unbanjob")
		if plycando == false then
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	local ind = tonumber(arguments[2])	
	
	victim:teamUnBan(ind)
		
	CAT_LogAction(ply, "Unbanned "..victim:Nick().." from being "..team.GetAllTeams()[ind].Name..".")

	
	
end)