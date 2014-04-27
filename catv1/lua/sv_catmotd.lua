function OpenMOTDAtSpawn( ply )
		ply:ConCommand( "openmotd" )
end
hook.Add( "PlayerInitialSpawn", "OpenMOTDAtSpawn", OpenMOTDAtSpawn )

function motdchatcommand(ply, text)
	if string.find(string.lower(text), "/motd") then
		ply:ConCommand("openmotd")
	end
end
hook.Add("PlayerSay", "chatcommandmotd", motdchatcommand)

util.AddNetworkString( "motdstatus" )

function sendmotdstat(ply)
net.Start("motdstatus")
	net.WriteString(CAT_Config.MOTDURL)
	net.WriteBit(CAT_Config.UseCatMOTD)
net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "sendmotdstatus", sendmotdstat)