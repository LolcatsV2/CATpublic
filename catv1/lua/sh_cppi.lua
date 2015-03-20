//A nicely corrupted version of CPPI. I don't know who uses this, but standards are nice.

if (!CAT_Config.UseCATPP) then return end

if (CPPI) then MsgC(Color(255, 50, 122), "TWO CPPIs loaded! Did you refresh the CPPI file, or are you using another Prop Protection? Continuing regardless...\n") end

CPPI = CPPI or {}
CPPI.CPPI_DEFER = 9997116 --\99\97\116 = cat
CPPI.CPPI_NOTIMPLEMENTED = 676584 --\67\65\84 = CAT

function CPPI:GetName()
	return "CAT's Prop Protection"
end

function CPPI:GetVersion()
	return "universal.1"
end

function CPPI:GetInterfaceVersion()
	return 1.3
end

function CPPI:GetNameFromUID(uid)
	local ply = uid and player.GetByUniqueID(tostring(uid)) or nil
	if uid and not IsValid(ply) then return false end
	return ply:Nick()
end

function CPPI:GetPlayerFromName(name)
	for _, v in pairs (player.GetAll()) do
		if v:Nick() == name then
			return v
		end
	end
end

local PLAYER = FindMetaTable("Player")
function PLAYER:CPPIGetFriends()
	return CPPI.CPPI_NOTIMPLEMENTED
end

local ENTITY = FindMetaTable("Entity")
function ENTITY:CPPIGetOwner()
	if SERVER then
		return self:GetPlayerOwner(), self:GetPlayerOwner():UniqueID()
	else
		return CPPI:GetPlayerFromName(self:GetNWString("FounderName"))
	end
end

if SERVER then
	function ENTITY:CPPISetOwner(ply)
		
		self:SetPlayerOwner(ply)
		
		return true
	end

	function ENTITY:CPPISetOwnerUID(UID)
		local ply = UID and player.GetByUniqueID(tostring(UID)) or nil
		if UID and not IsValid(ply) then return false end
		return self:CPPISetOwner(ply)
	end

	function ENTITY:CPPICanTool(ply, tool)
		return CAT_BlockToolgun(ply, tool)
	end

	function ENTITY:CPPICanPhysgun(ply)
		return CAT_BlockPhysgun(ply, self)
	end

	function ENTITY:CPPICanPickup(ply)
		return CAT_BlockGravGun(ply, self)
	end

	function ENTITY:CPPICanPunt(ply)
		return CAT_BlockGravGun(ply, self)
	end

	function ENTITY:CPPICanUse(ply)								// Just annoying for players
		return CPPI.CPPI_NOTIMPLEMENTED
	end

	function ENTITY:CPPICanDamage(ply)							// Just annoying for players
		return CPPI.CPPI_NOTIMPLEMENTED
	end

	function ENTITY:CPPIDrive(ply)
		return CAT_BlockDriving(ply, self)
	end

	function ENTITY:CPPICanProperty(ply, property)
		return CAT_BlockPropertyList(ply, self)
	end

	function ENTITY:CPPICanEditVariable(ply, key, val, editTbl) // What/Why?
		return CPPI.CPPI_NOTIMPLEMENTED
	end
end