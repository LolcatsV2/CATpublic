/*=======================
=Set Job module, created=
=======by Lolcats========
=======================*/

// I dunno how to make this a chat command. Too bad ;v
/*local PLUGINNAME = "setjob"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!setjob"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!setjob target amount"
*/


concommand.Add("cat_setjob", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "setjob")
		if plycando == false then
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	local ind = tonumber(arguments[2])	
	
	victim:changeTeam(ind, true)
	
	print(ind)
	
	CAT_LogAction(ply, "Set "..victim:Nick().."'s job to "..team.GetAllTeams()[ind].Name..".")
	
end)