/*=======================
=Undecals module,created=
=======by Lolcats========
=======================*/

concommand.Add("cat_cleardecals", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end				
		
	local plycando = CAT_CanDoAction(ply, "cleardecals")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end
	
	for k,v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals")
	end

	CAT_LogAction(ply, "Cleaned decals.")
	
end)