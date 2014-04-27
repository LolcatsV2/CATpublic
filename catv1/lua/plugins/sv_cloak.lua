/*=======================
==Cloak module, created==
=======by Lolcats========
=======================*/

concommand.Add("cat_cloak", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "cloak")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:SetRenderMode( RENDERMODE_NONE )
	victim:SetColor( 255, 255, 255, 0 )
	victim:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	for k, v in ipairs( victim:GetWeapons() ) do
		v:SetRenderMode( RENDERMODE_NONE )
		v:SetColor( 255, 255, 255, 0 )
	end
	
	CAT_LogAction(ply, "Cloaked "..victim:Nick()..".")

end)