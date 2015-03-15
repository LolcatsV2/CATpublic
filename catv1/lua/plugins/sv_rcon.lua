/*=======================
===RCon module,created===
=======by Lolcats========
=======================*/

concommand.Add("cat_rcon", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		MsgC(Color(255, 0, 0), "What the hell are you doing. You ARE the console. \n")
	return end				
		
	local plycando = CAT_CanDoAction(ply, "rcon")
		if plycando == false then
	return end
	
	game.ConsoleCommand(arguments[1].."\n")

	CAT_LogActionServer(ply, "ran remote console command "..arguments[1]..".")
	
end)