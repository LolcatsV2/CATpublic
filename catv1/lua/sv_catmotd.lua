
local function OpenMOTDAtSpawn( ply )
	if (ply:IsAdmin()) then return end
	ply:ConCommand( "openmotd" )
end
hook.Add( "PlayerInitialSpawn", "CAT_OpenMOTDAtSpawn", OpenMOTDAtSpawn )

local function motdchatcommand(ply, text)
	if (text == "!motd") then
		ply:ConCommand("openmotd")
	end
	
end
hook.Add("PlayerSay", "CAT_ChatCommandMOTD", motdchatcommand)

util.AddNetworkString( "motdstatus" )

local function sendmotdstat(ply)
net.Start("motdstatus")
	net.WriteString(CAT_Config.MOTDURL)
	net.WriteBit(CAT_Config.UseCatMOTD)
net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "CAT_SendMOTDStatus", sendmotdstat)