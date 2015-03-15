/*=======================
==VMute module, created==
=======by Lolcats========
=======================*/


if (SERVER) then


	local PLUGINNAME = "voicemute"
	CAT_Commands[PLUGINNAME] = {}
	CAT_Commands[PLUGINNAME].command = "!voicemute"
	CAT_Commands[PLUGINNAME].args = 1
	CAT_Commands[PLUGINNAME].help = "!voicemute target"

	
	concommand.Add("cat_voicemute", function( ply, command, arguments )

		local victim = CAT_FindPlayerUserID( arguments[1] )

		
		if (!IsValid(ply)) then
			ply = "Console"
		end
		
		
		local plycando = CAT_CanDoAction(ply, "blind")
			if plycando == false then
		return end		
			
		if (victim:IsBetterOrSame(ply)) then
				
			CAT_PlayerMsg(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
				
			return
		end

		
		if (victim:GetNWBool("cat_isvmuted")) then
	
			local isvmute = victim:GetNWBool("cat_isvmuted")
				
			if (isvmute) then
				victim:SetNWBool("cat_isvmuted", false)
				
				CAT_LogAction(ply, "Un-voice muted "..victim:Nick()..".")
				
			else
				victim:SetNWBool("cat_isvmuted", true)
				victim:SendLua( "LocalPlayer():ConCommand( \"-voicerecord\" )" )
				CAT_LogAction(ply, "Voice muted "..victim:Nick()..".")
			end
		else
			victim:SetNWBool("cat_isvmuted", true)
			victim:SendLua( "LocalPlayer():ConCommand( \"-voicerecord\" )" )			
			CAT_LogAction(ply, "Voice muted "..victim:Nick()..".")
		end	
	end)	
end

if (CLIENT) then

	local function plyvmute(ply)

		if (ply:GetNWBool("cat_isvmuted") == true) then
			RunConsoleCommand( "-voicerecord" )	
		else
		end
end

hook.Add("PlayerStartVoice", "cat_voicemute", plyvmute)

end









