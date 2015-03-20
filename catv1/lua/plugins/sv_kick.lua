/*=======================
===Kick module,created===
=======by Lolcats========
=======================*/

local PLUGINNAME = "kick"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!kick"
CAT_Commands[PLUGINNAME].args = math.huge 			-- fuck it
CAT_Commands[PLUGINNAME].help = "!kick target reason"

concommand.Add("cat_kick", function( ply, command, arguments )


	if (!IsValid(ply)) then
		ply = "Console"
	end			

	local plycando = CAT_CanDoAction(ply, "kick")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end

	local victim = CAT_FindPlayerUserID( arguments[1] )

		if (victim:IsBetterOrSame(ply)) then

			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")

			return
		end

	local reason
	
	if (ply == "Console") then
		reason = "Kicked by Console for reason: "..arguments[2]
	else
		reason = "Kicked by "..ply:Nick()..". Reason: "..arguments[2]
	end
	
	CAT_LogAction(ply, "Kicked "..victim:Nick()..". Reason: "..arguments[2])
	victim:Kick(reason)
end)