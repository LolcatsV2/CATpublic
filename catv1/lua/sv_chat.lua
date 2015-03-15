util.AddNetworkString( "cattagsstatus" )

local function sendstatonjoin(ply)
net.Start("cattagsstatus")
	net.WriteString(tostring(CAT_Config.UseCatTags))
net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "sendonjoinstatus", sendstatonjoin)

local function dochatcommands(ply, text)

	local exptext = string.Explode(" ", text)
	
	if (string.StartWith(text, "!")) then
	
		for k, v in pairs (CAT_Commands) do
			if (v.command == exptext[1]) then
				if (CAT_CanDoAction(ply, k)) then
					local cleanargs = table.remove(exptext, 1)
					local victim = easylua.FindEntity(exptext[1])
					
					if (#exptext > v.args or !victim:IsPlayer()) then
					
						CAT_PlayerMsg(ply, Color(255, 255, 255, 255), "[CAT] That's not how you do it!")
						CAT_PlayerMsg(ply, Color(255, 255, 255, 255), "[CAT] HELP TEXT: "..v.help)
						return
						
					else
					
						local cleanargs = table.remove(exptext, 1)
						local fineargs = table.concat(exptext, " ")
						ply:ConCommand("cat_"..k.." "..victim:UserID().." "..fineargs)
						return
					end
				end
			end
		end
	end
end

hook.Add("PlayerSay", "dochatcommands", dochatcommands)
