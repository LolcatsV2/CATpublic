/*=======================
===SCAP module,created===
=======by Lolcats========
=======================*/


if (SERVER) then 

	util.AddNetworkString( "scrcapinfo" )
	util.AddNetworkString( "scrcapreceive" )

	
	concommand.Add("cat_EXPIRscreencap", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end	
		
	local plycando = CAT_CanDoAction(ply, "screencap")
		if plycando == false then
	return end	

		local victim = CAT_FindPlayerUserID( arguments[1] )
		
			if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
		
		
		victim:ConCommand("_cat_clscreencap "..ply:UserID())
		
	end)
		
		net.Receive( "scrcapinfo", function( length, client )
			
			local iscomp = tobool(net.ReadBit())
			local len = net.ReadUInt(32)
			local data = net.ReadData(len)
			local caller = net.ReadString()
			
			
			if iscomp then
				--data = util.Decompress(data)
				print("Picture is compressed, sending as compressed.")
			end
			
			net.Start("scrcapreceive")
				net.WriteBit(iscomp)
				net.WriteUInt(len,32)
				net.WriteData(data,len)
			net.Send(CAT_FindPlayerUserID(tonumber(caller)))
			
			local stidsanitized = string.sub( client:SteamID(), 11, #client:SteamID() )
			local time = os.time()
			local TimeStr = os.date( "%m-%d-%Y__%I-%M-%S" , time )
			
			if iscomp then
				data = util.Decompress(data)
			end			
			
			file.Write( "cat/scaps/"..stidsanitized.."__"..TimeStr..".txt", data )
			
			
	   end )


	   
	   
end

if (CLIENT) then

	concommand.Add("_cat_clscreencap", function( ply, command, arguments )

		local caller = arguments[1]
	
		local RCD = {}

		RCD.format = "jpeg"
		RCD.h = ScrH()
		RCD.w = ScrW()
		RCD.quality = 30 //100 is max quality, but anything above 30 won't make it through net.
		RCD.x = 0
		RCD.y = 0

		local data = render.Capture( RCD )
		local normlen = string.len(data)
		local cdata = util.Compress(data)
		local clen = string.len(cdata)
		local iscomp = false
		
		if clen<normlen then data=cdata iscomp = true end

		local len = string.len(data)
		
		net.Start("scrcapinfo")
			net.WriteBit(iscomp)
			net.WriteUInt(len,32)
			net.WriteData(data,len)
			net.WriteString(tostring(caller))
		net.SendToServer()
end)

	net.Receive("scrcapreceive", function(len)
	
	local iscomp = tobool(net.ReadBit())
	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
		
	if iscomp then
		data = util.Decompress(data)
	end	
	
	data = util.Base64Encode(data)
	
	local frame = vgui.Create("DFrame")
        frame:SetSize(ScrW()*.75, ScrH()*.75)
        frame:Center(true)
        frame:SetTitle("CAT Screenshot")
        frame:SetVisible(true)
        frame:SetDraggable(true)
        frame:SetSizable(false)
        frame:MakePopup()
		
	local html = frame:Add( "HTML" )
		html:SetHTML( '<style type="text/css"> body { margin: 0; padding: 0; overflow: hidden; } img { width: 100%; height: 100%; } </style> <img src="data:image/jpg;base64,' .. data .. '"> ')
		html:Dock( FILL )
	
	
	
	
	
	
	end)


end





