util.AddNetworkString( "cattagsstatus" )

local function sendstatonjoin(ply)
net.Start("cattagsstatus")
	net.WriteString(tostring(CAT_Config.UseCatTags))
net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "sendonjoinstatus", sendstatonjoin)