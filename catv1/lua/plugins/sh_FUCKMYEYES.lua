/*=======================
===qoonafelp[owqtnab[p===
=======ei eaowqpk========
=======================*/
	


if (SERVER) then 


	
	
	concommand.Add("cat_seize", function( ply, command, arguments )

	if (!IsValid(ply)) then
		ply = "Console"
	end
	
		local plycando = CAT_CanDoAction(ply, "seizure")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
		return end	
	

		local victim = CAT_FindPlayerUserID( arguments[1] )

		if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
		
		


		
		if (victim:GetNWBool("cat_hasseizure")) then
	
			local isseizing = victim:GetNWBool("cat_hasseizure")
				
			if (isseizing) then
				victim:SetNWBool("cat_hasseizure", false)
				CAT_LogAction(ply, "Stopped "..victim:Nick().."'s seizure.")
			else
				victim:SetNWBool("cat_hasseizure", true)
				CAT_LogAction(ply, "Caused a seizure in "..victim:Nick()..".")
			end
		else
			victim:SetNWBool("cat_hasseizure", true)
			CAT_LogAction(ply, "Caused a seizure in "..victim:Nick()..".")
		end
	end)
end

if (CLIENT) then

	local function saybyetoureyes()
 
 
	local ply = LocalPlayer()
 
	local on = {}
	on[ "$pp_colour_addr" ] = math.random()
	on[ "$pp_colour_addg" ] = math.random()
	on[ "$pp_colour_addb" ] = math.random()
	on[ "$pp_colour_brightness" ] = 0
	on[ "$pp_colour_contrast" ] = 1
	on[ "$pp_colour_colour" ] = 1
	on[ "$pp_colour_mulr" ] = 1
	on[ "$pp_colour_mulg" ] = 1
	on[ "$pp_colour_mulb" ] = 1 

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
	
	
	
	
	if (ply:GetNWBool("cat_hasseizure") == true) then
		DrawColorModify( on )
	else
		DrawColorModify( off )
	end
end
hook.Add( "RenderScreenspaceEffects", "youreyesaremine", saybyetoureyes )
end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

