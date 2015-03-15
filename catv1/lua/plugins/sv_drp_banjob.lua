/*=======================
=Ban Job module, created=
=======by Lolcats========
=======================*/

// I dunno how to make this a chat command. Too bad ;v
/*local PLUGINNAME = "banjob"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!banjob"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!banjob target amount"
*/


concommand.Add("cat_banjob", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "banjob")
		if plycando == false then
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	local ind = tonumber(arguments[2])	
	local time = tonumber(arguments[3])
	
	victim:teamBan(ind, time*60)
		
	CAT_LogAction(ply, "Banned "..victim:Nick().." from being "..team.GetAllTeams()[ind].Name.." for "..time.." minutes.")

	
	
end)