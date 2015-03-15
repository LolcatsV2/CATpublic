/*=======================
=Undecals module,created=
=======by Lolcats========
=======================*/

--No Chat Command for this.
-- local PLUGINNAME = "cleardecals"
-- CAT_Commands[PLUGINNAME] = {}
-- CAT_Commands[PLUGINNAME].command = "!cleardecals"
-- CAT_Commands[PLUGINNAME].args = 0
-- CAT_Commands[PLUGINNAME].help = "!cleardecals"

concommand.Add("cat_cleardecals", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end				
		
	local plycando = CAT_CanDoAction(ply, "cleardecals")
		if plycando == false then
	return end
	
	for k,v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals")
	end

	CAT_LogAction(ply, "Cleaned decals.")
	
end)