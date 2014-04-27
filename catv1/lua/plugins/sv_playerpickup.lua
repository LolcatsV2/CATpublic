/*=======================
==Pickup module,created==
=======by Lolcats========
=======================*/

function Playerpickup(ply, ent)
	
	
	local plycando = CAT_CanDoAction(ply, "pickupplayers")
		if plycando == false then
	return false end
	
	
	if (!ent:IsPlayer()) then return end
	
	
	
	
		if (ent:IsBetterOrSame(ply)) then
			
			
			return false
		end
		
		
	
				ent:Freeze(true)
				ent:SetMoveType(MOVETYPE_NOCLIP)
				return true
	
	
	
	
end
hook.Add( "PhysgunPickup", "PhysgunPickup", Playerpickup )


function playerdrop(ply, ent)
if ent:IsPlayer() then
			ent:SetMoveType(MOVETYPE_WALK)
			ent:Freeze(false)
		end
end
hook.Add( "PhysgunDrop", "PhysgunDrop", playerdrop)
