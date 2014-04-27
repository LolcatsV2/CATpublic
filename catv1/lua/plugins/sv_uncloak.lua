/*=======================
=Uncloak module, created=
=======by Lolcats========
=======================*/

concommand.Add("cat_uncloak", function( ply, command, arguments )
	
	if (!IsValid(ply)) then
		ply = "Console"
	end			
	
	local plycando = CAT_CanDoAction(ply, "uncloak")
		if plycando == false then
	return end
	
	local victim = CAT_FindPlayerUserID( arguments[1] )
	
		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
	
	victim:SetRenderMode( RENDERMODE_NORMAL )
	victim:SetColor( 255, 255, 255, 255 )
	victim:SetCollisionGroup( COLLISION_GROUP_PLAYER )
				
	for k, v in ipairs( victim:GetWeapons() ) do
		v:SetRenderMode( RENDERMODE_NORMAL )
		v:SetColor( 255, 255, 255, 255 )
	end
	
	CAT_LogAction(ply, "Uncloaked "..victim:Nick()..".")
end)