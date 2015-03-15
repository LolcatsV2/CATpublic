/*=======================
==UPanic module,created==
=======by Lolcats========
=======================*/

//Doesn't really need a chat command.
/*local PLUGINNAME = "bring"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!bring"
CAT_Commands[PLUGINNAME].args = 1
CAT_Commands[PLUGINNAME].help = "!bring target"*/

concommand.Add("cat_uberpanic", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "uberpanic")
		if plycando == false then
	return end	
	
	local frozenents = 0
	
	for k, entity in pairs(ents.FindByClass("prop_physics")) do
	
		local phys = entity:GetPhysicsObject()

		phys:Sleep()
		phys:EnableMotion(false)
		frozenents = frozenents + 1
		print(entity)
	
		
    end
	
	CAT_BroadcastMsg(Color(242, 255, 0), ply:Nick(), Color(255, 255, 255), " -> ", Color(255, 0, 0), "Enabled ÜBER Panic Mode for the server. Freezing ALL props...")
	
	CAT_BroadcastMsg(Color(255, 0, 0), "[ÜBER PANIC] ", Color(200, 200, 200), "Froze "..tostring(frozenents).." props." )
	
	--CAT_LogAction(ply, "Set "..victim:Nick().."'s job to "..team.GetAllTeams()[ind].Name..".")
	
	
end)