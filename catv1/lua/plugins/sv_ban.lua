/*=======================
===Ban module, created===
=======by Lolcats========
=======================*/

concommand.Add("cat_ban", function( ply, command, arguments )

	if (!IsValid(ply)) then
		ply = "Console"
	end	

	local plycando = CAT_CanDoAction(ply, "ban")
		if plycando == false then

		CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")

	return end	

	if (isstring(arguments[5])) then -- Contingency for redoing a ban
		CAT_Ban(arguments[1], arguments[2], arguments[3], tonumber(arguments[4]), arguments[5])
		local undofixname = string.gsub(arguments[5], "_", " ")
		local undofixreason = string.gsub(arguments[3], "_", " ")
		CAT_LogAction(ply, "Re-banned "..undofixname.." for: "..arguments[4].." minutes".." for reason: "..undofixreason)
	return end

	local victim = CAT_FindPlayerUserID( arguments[1] )
	local btime = tonumber(arguments[3])
	local reason = "Banned by: "..ply:Nick().." for the reason: '"..arguments[2].."' Ban length: "..btime.." minutes."


		if (victim:IsBetterOrSame(ply)) then

			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")

			return
		end

	CAT_LogAction(ply, "Banned "..victim:Nick().." for: "..btime.." minutes. Reason: "..arguments[2])

	if (!isnumber(btime)) then return end	

	CAT_Ban(ply, victim, arguments[2], btime)
	game.ConsoleCommand("kickid "..victim:UserID().." \""..reason.."\"\n")


end)