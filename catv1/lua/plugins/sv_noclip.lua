/*=======================
==Noclip module,created==
=======by Lolcats========
=======================*/

local function plynoclipgo(ply, inorout)
	
	local plycando = CAT_CanDoAction(ply, "noclip")
		if plycando == false then
	return false end
	
	return true
end

hook.Add( "PlayerNoClip", "cat_noclip", plynoclipgo)
