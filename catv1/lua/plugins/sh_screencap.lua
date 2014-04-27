/*=======================
===SCAP module,created===
=======by Lolcats========
=======================*/


if (SERVER) then 

	util.AddNetworkString( "scrcapinfo" )

	concommand.Add("cat_EXPIRscreencap", function( ply, command, arguments )
		
	if (!IsValid(ply)) then
		ply = "Console"
	end	
		
	local plycando = CAT_CanDoAction(ply, "screencap")
		if plycando == false then
		
		CAT_MessagePlayer(ply, "Access denied! You don't have permission to use that command.")
		
	return end	

		local victim = CAT_FindPlayerUserID( arguments[1] )
		
			if (victim:IsBetterOrSame(ply)) then
			
			CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
			
			return
		end
		
		
		victim:ConCommand("_cat_clscreencap")
		
	end)
		
		net.Receive( "scrcapinfo", function( length, client )
			
			local iscomp = tobool(net.ReadBit())
			local len = net.ReadUInt(32)
			local data = net.ReadData(len)

			if iscomp then
				data = util.Decompress(data)
				print("Compressed and Decompressed!")
			end
			
			file.Write( "CAT_Screencap.txt", data )
			
			
	   end )

end

if (CLIENT) then

	concommand.Add("_cat_clscreencap", function( ply, command, arguments )

		local RCD = {}

		RCD.format = "jpeg"
		RCD.h = ScrH()
		RCD.w = ScrW()
		RCD.quality = 25 //100 is max quality, but anything above 30 won't make it through net.
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
		net.SendToServer()
end)

end





