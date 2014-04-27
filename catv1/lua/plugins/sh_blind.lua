if (SERVER) then 
	concommand.Add("cat_blind", function( ply, command, arguments )

	local victim = CAT_FindPlayerUserID( arguments[1] )

	
	if (!IsValid(ply)) then
		ply = "Console"
	end
	
	
	local plycando = CAT_CanDoAction(ply, "blind")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end		
		
	if (victim:IsBetterOrSame(ply)) then
			
		CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
		return
	end
	
	
		if (victim:GetNWBool("cat_isblind")) then
	
			local isblind = victim:GetNWBool("cat_isblind")
				
			if (isblind) then
				victim:SetNWBool("cat_isblind", false)
				
				CAT_LogAction(ply, "Unblinded "..victim:Nick()..".")
				
			else
				victim:SetNWBool("cat_isblind", true)
				
				CAT_LogAction(ply, "Blinded "..victim:Nick()..".")
			end
		else
			victim:SetNWBool("cat_isblind", true)
			CAT_LogAction(ply, "Blinded "..victim:Nick()..".")
		end
	end)
end

if (CLIENT) then

	local function plyblind()
 
 
	local ply = LocalPlayer()
 
	local on = {}
	on[ "$pp_colour_addr" ] = 0
	on[ "$pp_colour_addg" ] = 0
	on[ "$pp_colour_addb" ] = 0
	on[ "$pp_colour_brightness" ] = 0
	on[ "$pp_colour_contrast" ] = 0
	on[ "$pp_colour_colour" ] = 1
	on[ "$pp_colour_mulr" ] = 0
	on[ "$pp_colour_mulg" ] = 0
	on[ "$pp_colour_mulb" ] = 0 

	local off = {}
	off[ "$pp_colour_addr" ] = 0
	off[ "$pp_colour_addg" ] = 0
	off[ "$pp_colour_addb" ] = 0
	off[ "$pp_colour_brightness" ] = 0
	off[ "$pp_colour_contrast" ] = 1
	off[ "$pp_colour_colour" ] = 1
	off[ "$pp_colour_mulr" ] = 0
	off[ "$pp_colour_mulg" ] = 0
	off[ "$pp_colour_mulb" ] = 0 

	if (ply:GetNWBool("cat_isblind") == true) then
		DrawColorModify( on )
	else
		DrawColorModify( off )
	end
end
hook.Add( "RenderScreenspaceEffects", "plyblindnow", plyblind )
end