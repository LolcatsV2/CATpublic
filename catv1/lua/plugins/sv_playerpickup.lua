/*=======================
==Pickup module,created==
=======by Lolcats========
=======================*/

local function Playerpickup(ply, ent)

	if (!ent:IsPlayer()) then return end
	
	local plycando = CAT_CanDoAction(ply, "pickupplayers")
	if plycando == false then
		return false
	end
	

	
	
	
	
	if (ent:IsBetterOrSame(ply)) then
		return false
	end
		
		
	
	ent:SetMoveType(MOVETYPE_NONE)
	ent:SetOwner(ply)
	return true
	
	
	
	
end
hook.Add( "PhysgunPickup", "PhysgunPickup", Playerpickup )


local function playerdrop(ply, ent)
	if ent:IsPlayer() then
		ent:SetMoveType(MOVETYPE_WALK)
		ent:SetOwner()
	end
end
hook.Add( "PhysgunDrop", "PhysgunDrop", playerdrop)
