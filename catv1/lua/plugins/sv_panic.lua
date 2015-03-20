/*=======================
==Panic module, created==
=======by Lolcats========
=======================*/

concommand.Add("cat_panic", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end	
	
	local plycando = CAT_CanDoAction(ply, "panic")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You're not allowed to use that command.")
		return 
	end
	
	local frozenents = 0
	
	for k, entity in pairs(ents.GetAll()) do
        if entity:IsPlayer() then continue end
		if entity:IsNPC() then continue end
		
		local phys = entity:GetPhysicsObject()

        if IsValid(phys) and phys:IsPenetrating() and not phys:IsAsleep() then
            phys:Sleep()
            phys:EnableMotion(false)
			frozenents = frozenents + 1
		end
	
		
    end
	
	CAT_LogAction(ply, "Enabled Panic Mode for the server. Freezing colliding props...")
	
	CAT_BroadcastMsg(Color(255, 0, 0), "[PANIC] ", Color(200, 200, 200), "Froze "..tostring(frozenents).." colliding props." )
		
	
end)