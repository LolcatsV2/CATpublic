util.AddNetworkString( "cattagsstatus" )

local function sendstatonjoin(ply)
net.Start("cattagsstatus")
	net.WriteString(tostring(CAT_Config.UseCatTags))
net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "CAT_SendOnJoinStatus", sendstatonjoin)

//Thanks CapsAdmin / Everyone at Metastruct
local function compare(a, b)

	if a == b then return true end
	if a:find(b, nil, true) then return true end
	if a:lower() == b:lower() then return true end
	if a:lower():find(b:lower(), nil, true) then return true end

	return false
end

local function comparenick(a, b)
	local MatchTransliteration = GLib and GLib.UTF8 and GLib.UTF8.MatchTransliteration
	if not MatchTransliteration then return compare (a, b) end
	
	if a == b then return true end
	if a:lower() == b:lower() then return true end
	if MatchTransliteration(a, b) then return true end

	return false
end

local function easylua_FindEntity(str)
	if not str then return nil end

	str = tostring(str)

	-- steam id
	if str:find("STEAM") then
		for key, _ply in pairs(player.GetAll()) do
			if _ply:SteamID() == str then
				return _ply
			end
		end
	end

	if str:sub(1,1) == "_" and tonumber(str:sub(2)) then
		str = str:sub(2)
	end

	if tonumber(str) then
		ply = Entity(tonumber(str))
		if ply:IsValid() then
			return ply
		end
	end
	
	-- search exact
	for _,ply in pairs(player.GetAll()) do
		if ply:Nick()==str then
			return ply
		end
	end
	
	-- Search bots so we target those first
	for key, ply in pairs(player.GetBots()) do
		if comparenick(ply:Nick(), str) then
			return ply
		end
	end
	
	-- search from beginning of nick
	for _,ply in pairs(player.GetHumans()) do
		if ply:Nick():lower():find(str,1,true)==1 then
			return ply
		end
	end
	
	-- Search normally and search with colorcode stripped
	for key, ply in pairs(player.GetAll()) do
		if comparenick(ply:Nick(), str) then
			return ply
		end
		if comparenick(ply:Nick():gsub("%^%d", ""), str) then
			return ply
		end
	end

end

local function dochatcommands(ply, text)

	local exptext = string.Explode(" ", text)
	
	if (string.StartWith(text, "!")) then
	
		for k, v in pairs (CAT_Commands) do
			if (v.command == exptext[1]) then
				if (CAT_CanDoAction(ply, k)) then
					local cleanargs = table.remove(exptext, 1)
					local victim = easylua_FindEntity(exptext[1])
					
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

hook.Add("PlayerSay", "CAT_DoChatCommands", dochatcommands)
