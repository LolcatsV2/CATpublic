/*=======================
==Noclip module,created==
=======by Lolcats========
=======================*/

local function plynoclipgo(ply, inorout)
	
	local plycando = CAT_CanDoAction(ply, "noclip")
		if plycando == false then		
	return false end
	
	if (CAT_Config.LogNoclip) then 
		if (inorout) then 
			CAT_LogActionServer(ply, "entered noclip.")
		else
			CAT_LogActionServer(ply, "exited noclip.")
		end
	end
	return true
end

hook.Add( "PlayerNoClip", "cat_noclip", plynoclipgo)
