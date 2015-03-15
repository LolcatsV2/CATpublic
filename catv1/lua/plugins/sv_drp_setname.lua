/*=======================
=Set Name module, created=
=======by Lolcats========
=======================*/

// I dunno how to make this a chat command. Too bad ;v
/*local PLUGINNAME = "setjob"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!setjob"
CAT_Commands[PLUGINNAME].args = 2
CAT_Commands[PLUGINNAME].help = "!setjob target amount"
*/


concommand.Add("cat_setname", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "setname")
		if plycando == false then
	return end	
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	local toname = arguments[2]
	local oldname = victim:Nick()
	
	victim:setRPName(toname, false)
		
	CAT_LogAction(ply, "Set "..oldname.."'s RP Name to "..toname..".")
	
end)