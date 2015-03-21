/*=======================
===SCAP module,created===
=======by Lolcats========
=======================*/


if (SERVER) then 

	util.AddNetworkString( "scrcapinfo" )
	util.AddNetworkString( "scrcapreceive" )
	util.AddNetworkString( "scrcapclientrec" )

	local PLUGINNAME = "screencap"
	CAT_Commands[PLUGINNAME] = {}
	CAT_Commands[PLUGINNAME].command = "!screencap"
	CAT_Commands[PLUGINNAME].args = 1
	CAT_Commands[PLUGINNAME].help = "!screencap target"

	if (!file.Exists("cat/scaps", "DATA")) then 
		file.CreateDir("cat/scaps")
	end
	
	concommand.Add("cat_screencap", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end	
		
	local plycando = CAT_CanDoAction(ply, "screencap")
	if plycando == false then
		CAT_PlayerMsg(ply, "Access denied! You don't have permission to use that command.")
		return
	end	

		local victim = CAT_FindPlayerUserID( arguments[1] )
		
			if (victim:IsBetterOrSame(ply)) then
			
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
		
		net.Start("scrcapclientrec")
			net.WriteString(tostring(ply:UserID()))
		net.Send(victim)
		
		CAT_LogActionServer(ply, "Took a screenshot of "..victim:Nick()..".")
		
	end)
		
		net.Receive( "scrcapinfo", function( length, client )
			
			local iscomp = tobool(net.ReadBit())
			local len = net.ReadUInt(32)
			local data = net.ReadData(len)
			local caller = net.ReadString()
			
			net.Start("scrcapreceive")
				net.WriteBit(iscomp)
				net.WriteUInt(len,32)
				net.WriteData(data,len)
			net.Send(CAT_FindPlayerUserID(tonumber(caller)))
			
			local stidsanitized = string.sub( client:SteamID(), 11, #client:SteamID() )
			local time = os.time()
			local timestr = os.date( "%m-%d-%Y__%I-%M-%S" , time )
			
			if iscomp then
				data = util.Decompress(data)
			end			
			
			file.Write( "cat/scaps/"..stidsanitized.."__"..timestr..".txt", data )
			
			
	   end )


	   
	   
end

if (CLIENT) then

net.Receive("scrcapclientrec", function()

	local caller = net.ReadString()

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
		net.WriteString(caller)
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





