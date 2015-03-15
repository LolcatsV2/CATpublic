CAT_BanTable = CAT_BanTable or {}
CAT_BanTable.ban = {}
net.Receive("cat_sendbans", function(len)

	local name = net.ReadString()
	local sid = net.ReadString()
	local ubdate = net.ReadString()
	local reason = net.ReadString()
	local brname = net.ReadString()

	CAT_BanTable.ban[sid] = {}
	CAT_BanTable.ban[sid].name = name
	CAT_BanTable.ban[sid].id = sid
	CAT_BanTable.ban[sid].ubdate = ubdate
	CAT_BanTable.ban[sid].reason = reason
	CAT_BanTable.ban[sid].brname = brname
end
)

net.Receive("cat_removeban", function(len)

	local sid = net.ReadString()

	CAT_BanTable.ban[sid] = nil
end
)

concommand.Add("+CAT_menu", function(ply, command, arguments)

	local canopen = false
	local allowtoopen = {
	["superadmin"] = true,
	["admin"] = true
	}	
	
	if (allowtoopen[ply:GetUserGroup()]) then canopen = true end	
	if (canopen != true) then return end 
	
	rightadminmenu = vgui.Create("DMenu")
	rightadminmenu:SetMinimumWidth(200)
	rightadminmenu.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, rightadminmenu:GetMinimumWidth(), rightadminmenu:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	local title = rightadminmenu:AddOption( "CAT V.1.2", function() end)
	title:SetPaintBackground(false)
	--Should add a spacer to keep the submenus from auto opening.
	rightadminmenu:AddSpacer()
	
	-- Server Commands submenu.
	local servcmds, pnl = rightadminmenu:AddSubMenu( "Server Actions" )
	servcmds:SetMinimumWidth(200)
	servcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, servcmds:GetMinimumWidth(), servcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/application.png")
	rightadminmenu:AddSpacer()

	-- "Fun" Commands submenu.
	local funcmds, pnl = rightadminmenu:AddSubMenu( "Fun" )
	funcmds:SetMinimumWidth(200)
	funcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, funcmds:GetMinimumWidth(), funcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/rainbow.png")
	
	rightadminmenu:AddSpacer()
	
	-- "Utilities" Commands submenu
	local utilcmds, pnl = rightadminmenu:AddSubMenu( "Utility" )
	utilcmds:SetMinimumWidth(200)
	utilcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, utilcmds:GetMinimumWidth(), utilcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/wrench.png")
	
	rightadminmenu:AddSpacer()
	
	
	-- "Teleportation" Commands submenu
	local tpcmds, pnl = rightadminmenu:AddSubMenu( "Teleportation" )
	tpcmds:SetMinimumWidth(200)
	tpcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, tpcmds:GetMinimumWidth(), tpcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false)
	end
	pnl:SetIcon("icon16/asterisk_yellow.png")

	rightadminmenu:AddSpacer()	
	
	
	if (string.lower(engine.ActiveGamemode()) == "darkrp") then
		-- "DarkRP" Commands submenu
		local rpcmds, pnl = rightadminmenu:AddSubMenu( "DarkRP Actions" )
		rpcmds:SetMinimumWidth(200)
		rpcmds.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, rpcmds:GetMinimumWidth(), rpcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false)
		end
		pnl:SetIcon("icon16/joystick.png")
		
		rightadminmenu:AddSpacer()	
	end
	
	if (ply:GetUserGroup() == "superadmin") then 
		-- "Panic" button
		local panic = rightadminmenu:AddOption( "Panic", function()
			RunConsoleCommand("cat_panic")
			rightadminmenu:Hide()
		end):SetIcon("icon16/exclamation.png")
	
		rightadminmenu:AddSpacer()
	
		-- "Über Panic" button
		local upanic = rightadminmenu:AddOption( "Über Panic", function()
			RunConsoleCommand("cat_uberpanic")
			rightadminmenu:Hide()
		end):SetIcon("icon16/clock_red.png")	
	end
	
	// Server commands //
	
	--Clear Decals
	local cldecals = servcmds:AddOption( "Clear Decals", function()
		RunConsoleCommand("cat_cleardecals")
		rightadminmenu:Hide()
	end):SetIcon("icon16/find.png")
	
	--RCon
	local rconme = servcmds:AddOption( "RCon Command", function()
		Derma_StringRequest( 
			"Remote Console Command", 
			"What command do you want to run?",
			"",
			function( text )
				RunConsoleCommand("cat_rcon", tostring(text))
			end,
			function( text ) end)
	end):SetIcon("icon16/application_xp_terminal.png")
	
	-- Cleanup Server
	local cleanserver = servcmds:AddOption( "Cleanup Server", function()
		RunConsoleCommand("cat_serverclean")
		rightadminmenu:Hide()
	end):SetIcon("icon16/wand.png")
	
	--Change Map
	local cmap = servcmds:AddOption( "Change Map", function()
		Derma_StringRequest( 
			"Change Level", 
			"What map do you wish to change to?",
			"",
			function( text )
				RunConsoleCommand("cat_changemap", tostring(text))
			end,
			function( text ) end)
	end):SetIcon("icon16/photos.png")
	
	-- Devmode Toggle
	local dodev = servcmds:AddOption( "Toggle Developer Mode", function()
		RunConsoleCommand("cat_devmode")
		rightadminmenu:Hide()
	end):SetIcon("icon16/bug_edit.png")
	

	// Utility commands //
	
	-- Kick menu
	local kick, pnl = utilcmds:AddSubMenu( "Kick" )
	kick:SetMinimumWidth(200)
	kick.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, kick:GetMinimumWidth(), kick:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/disconnect.png")
	
	-- Ban menu
	local ban, pnl = utilcmds:AddSubMenu( "Ban" )
	ban:SetMinimumWidth(200)
	ban.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ban:GetMinimumWidth(), ban:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/exclamation.png")
	
	-- unban
	local unban = utilcmds:AddOption( "Unban", function()


		local bgboard = vgui.Create("DFrame")
		bgboard:SetSize(640, 480)
		bgboard:Center()
		bgboard:SetTitle("")
		bgboard:MakePopup()
		bgboard.Paint = function()
			draw.RoundedBox( 8, 0, 0, bgboard:GetWide(), bgboard:GetTall(), Color( 255, 255, 255, 255 ) )
		end

		local bantbl = vgui.Create("DListView", bgboard)
		bantbl:SetSize(bgboard:GetWide()-30, bgboard:GetTall()-70)
		bantbl:SetPos(15, 30)
		bantbl:AddColumn( "Name" ):SetFixedWidth(150)
		bantbl:AddColumn( "SteamID" ):SetFixedWidth(120)
		bantbl:AddColumn( "Reason" ):SetFixedWidth(120)
		bantbl:AddColumn( "Banned By" ):SetFixedWidth(100)	
		bantbl:AddColumn( "Ban Remaining" )		

		local searcher = vgui.Create( "DTextEntry", bgboard )
		searcher:SetPos( 15, bantbl:GetTall()+37 )
		searcher:SetSize( 115, 25 )
		searcher:SetText( "Search by SteamID" )
		searcher.OnEnter = function( self )
		
			bantbl:Clear()
			
			for k, v in pairs (CAT_BanTable.ban) do

				local undofixreason = string.gsub(CAT_BanTable.ban[k].reason, "_", " ")
				local undofixname = string.gsub(CAT_BanTable.ban[k].name, "_", " ")
				local undofixbrname = string.gsub(CAT_BanTable.ban[k].brname, "_", " ")
	
				if (CAT_BanTable.ban[k].ubdate == "never") and (CAT_BanTable.ban[k].id == self:GetValue()) then
					bantbl:AddLine(undofixname, CAT_BanTable.ban[k].id, undofixreason, undofixbrname, CAT_BanTable.ban[k].ubdate)
				elseif (CAT_BanTable.ban[k].id == self:GetValue()) then
					bantbl:AddLine(undofixname, CAT_BanTable.ban[k].id, undofixreason, undofixbrname, CAT_BanTable.ban[k].ubdate.." minutes")
				end		
			end		
		end
		
		local rbutton = vgui.Create("DButton", bgboard) -- todo: figure out why you have to press twice
		rbutton:SetSize(165,30)
		rbutton:SetPos(bantbl:GetWide()-470, bantbl:GetTall()+35)
		rbutton:SetText("Refresh Ban Table")
		rbutton:SetFont("Trebuchet24")
		rbutton.DoClick = function()
		bantbl:Clear()
			RunConsoleCommand("cat_refreshbans")

			for k, v in pairs (CAT_BanTable.ban) do

			local undofixreason = string.gsub(CAT_BanTable.ban[k].reason, "_", " ")
			local undofixname = string.gsub(CAT_BanTable.ban[k].name, "_", " ")
			local undofixbrname = string.gsub(CAT_BanTable.ban[k].brname, "_", " ")

			if (CAT_BanTable.ban[k].ubdate == "never") then
				bantbl:AddLine(undofixname, CAT_BanTable.ban[k].id, undofixreason, undofixbrname, CAT_BanTable.ban[k].ubdate)
			else
				bantbl:AddLine(undofixname, CAT_BanTable.ban[k].id, undofixreason, undofixbrname, CAT_BanTable.ban[k].ubdate.." minutes")
			end
		end
		end
		rbutton.Paint = function()
		
		draw.RoundedBox(2, 0, 0, rbutton:GetWide(), rbutton:GetTall(), Color(150, 255, 150))
		
		end
		
		
		local ubutton = vgui.Create("DButton", bgboard)
		ubutton:SetSize(140,30)
		ubutton:SetPos(bantbl:GetWide()-295, bantbl:GetTall()+35)
		ubutton:SetText("Unban")
		ubutton:SetFont("Trebuchet24")
		ubutton.DoClick = function()
			local selectedn = bantbl:GetSelectedLine()
			local getsline = bantbl:GetLine(selectedn)
			if (!IsValid(getsline)) then return end
			RunConsoleCommand("cat_unban", getsline:GetValue(2) )
			bantbl:RemoveLine(selectedn)
		end
		ubutton.Paint = function()
		
		draw.RoundedBox(2, 0, 0, ubutton:GetWide(), ubutton:GetTall(), Color(255, 150, 150))
		
		end

		local ebutton = vgui.Create("DButton", bgboard)
		ebutton:SetSize(140,30)
		ebutton:SetPos(bantbl:GetWide()-145, bantbl:GetTall()+35)
		ebutton:SetText("Edit Ban")
		ebutton:SetFont("Trebuchet24")
		ebutton.DoClick = function()

			local selectedn = bantbl:GetSelectedLine()
			local getsline = bantbl:GetLine(selectedn)
			if (!IsValid(getsline)) then return end


			local editmenu = vgui.Create("DFrame")
			editmenu:SetSize(320, 280)
			editmenu:Center()
			editmenu:SetTitle("Ban List")
			editmenu:MakePopup()

			local nametag = vgui.Create("DLabel", editmenu)
			nametag:SetPos(28, 43)
			nametag:SetText("Name: ")
			nametag:SizeToContents()


			local namebox = vgui.Create( "DTextEntry", editmenu )
			namebox:SetPos( 60, 40 )
			namebox:SetSize( 180, 20 )
			namebox:SetText( getsline:GetValue(1) )
			namebox.OnEnter = function( self )
				chat.AddText( self:GetValue() )
			end

			local steamidtag = vgui.Create("DLabel", editmenu)
			steamidtag:SetPos(15, 83)
			steamidtag:SetText("SteamID: ")
			steamidtag:SizeToContents()


			local sidbox = vgui.Create( "DTextEntry", editmenu )
			sidbox:SetPos( 60, 80 )
			sidbox:SetSize( 180, 20 )
			sidbox:SetText( getsline:GetValue(2) )
			sidbox.OnEnter = function( self )
				chat.AddText( self:GetValue() )
			end

			local reasontag = vgui.Create("DLabel", editmenu)
			reasontag:SetPos(20, 123)
			reasontag:SetText("Reason: ")
			reasontag:SizeToContents()


			local reasonbox = vgui.Create( "DTextEntry", editmenu )
			reasonbox:SetPos( 60, 120 )
			reasonbox:SetSize( 180, 20 )
			reasonbox:SetText( getsline:GetValue(3) )
			reasonbox.OnEnter = function( self )
				chat.AddText( self:GetValue() )
			end

			local bbytag = vgui.Create("DLabel", editmenu)
			bbytag:SetPos(4, 163)
			bbytag:SetText("Banned by: ")
			bbytag:SizeToContents()


			local bbybox = vgui.Create( "DTextEntry", editmenu )
			bbybox:SetPos( 60, 160 )
			bbybox:SetSize( 180, 20 )
			bbybox:SetText( getsline:GetValue(4) )
			bbybox.OnEnter = function( self )
				chat.AddText( self:GetValue() )
			end

			local banltag = vgui.Create("DLabel", editmenu)
			banltag:SetPos(2, 203)
			banltag:SetText("Ban Length: ")
			banltag:SizeToContents()


			local banlbox = vgui.Create( "DTextEntry", editmenu )	
			banlbox:SetPos( 60, 200 )
			banlbox:SetSize( 180, 20 )
			local fixlength = string.gsub(getsline:GetValue(5), " minutes", "")
			banlbox:SetText( fixlength )
			banlbox.OnEnter = function( self )
				chat.AddText( self:GetValue() )	
			end

			local redoban = vgui.Create("DButton", editmenu)
			redoban:SetSize(140,30)
			redoban:SetPos(90, 235)
			redoban:SetText("Do Ban")
			redoban.DoClick = function()

			if (namebox:GetValue() == "" or sidbox:GetValue() == "" or reasonbox:GetValue() == "" or bbybox:GetValue() == "" or banlbox:GetValue() == "") then return end

			local fixbrname = string.gsub(bbybox:GetValue(), " ", "_")
			local fixname = string.gsub(namebox:GetValue(), " ", "_")
			local fixreason = string.gsub(reasonbox:GetValue(), " ", "_")


			RunConsoleCommand("cat_ban", fixbrname, sidbox:GetValue(), fixreason,  banlbox:GetValue(), fixname )

			editmenu:Close()

			end
			
		end
		ebutton.Paint = function()
		
		draw.RoundedBox(2, 0, 0, ebutton:GetWide(), ebutton:GetTall(), Color(255, 255, 150))
		
		end	


		
		for k, v in pairs (CAT_BanTable.ban) do

		local undofixreason = string.gsub(CAT_BanTable.ban[k].reason, "_", " ")
		local undofixname = string.gsub(CAT_BanTable.ban[k].name, "_", " ")
		local undofixbrname = string.gsub(CAT_BanTable.ban[k].brname, "_", " ")


		if (CAT_BanTable.ban[k].ubdate == "never") then
			bantbl:AddLine(undofixname, CAT_BanTable.ban[k].id, undofixreason, undofixbrname, CAT_BanTable.ban[k].ubdate)
		else
			bantbl:AddLine(undofixname, CAT_BanTable.ban[k].id, undofixreason, undofixbrname, CAT_BanTable.ban[k].ubdate.." minutes")
		end
		end


	end):SetIcon("icon16/heart_add.png")
	
	--Observer Ban Menu
	local obsban, pnl = utilcmds:AddSubMenu( "Observer Ban" )
	obsban:SetMinimumWidth(200)
	obsban.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, obsban:GetMinimumWidth(), obsban:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/lock.png")
	
	-- Cleanup props menu
	local clean, pnl = utilcmds:AddSubMenu( "Clean User's Props" )
	clean:SetMinimumWidth(200)
	clean.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, clean:GetMinimumWidth(), clean:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/delete.png")
	
	-- Expirimental Screenshot menu
	local sreecap, pnl = utilcmds:AddSubMenu( "Capture User's Screen" )
	sreecap:SetMinimumWidth(200)
	sreecap.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, sreecap:GetMinimumWidth(), sreecap:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/camera_go.png")
	
	-- CExec menu
	local CExec, pnl = utilcmds:AddSubMenu( "Client ConCommand" )
	CExec:SetMinimumWidth(200)
	CExec.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, CExec:GetMinimumWidth(), CExec:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/application_xp.png")

	-- isnt cheater menu
	local icheat, pnl = utilcmds:AddSubMenu( "Flag as Non-Cheater" )
	icheat:SetMinimumWidth(200)
	icheat.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, icheat:GetMinimumWidth(), icheat:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/flag_green.png")
	
	-- Set Access menu
	local Sacc, pnl = utilcmds:AddSubMenu( "Set Access" )
	Sacc:SetMinimumWidth(200)
	Sacc.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, Sacc:GetMinimumWidth(), Sacc:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/key.png")
	
	
	// Fun Commands //
	
	-- Set Health menu
	local health, pnl = funcmds:AddSubMenu( "Set Health" ) 
	health:SetMinimumWidth(200)
	health.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, health:GetMinimumWidth(), health:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/heart.png")
	
	-- Set Armor menu
	local armor, pnl = funcmds:AddSubMenu( "Set Armor" )
	armor:SetMinimumWidth(200)
	armor.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, armor:GetMinimumWidth(), armor:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/anchor.png")
	
		-- Ignite menu
	local ignite, pnl = funcmds:AddSubMenu( "Ignite" )
	ignite:SetMinimumWidth(200)
	ignite.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ignite:GetMinimumWidth(), ignite:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/weather_sun.png")
	
	-- Extingusih menu
	local unignite, pnl = funcmds:AddSubMenu( "Extinguish" )
	unignite:SetMinimumWidth(200)
	unignite.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, unignite:GetMinimumWidth(), unignite:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/weather_rain.png")
	
	-- Slay menu
	local slay, pnl = funcmds:AddSubMenu( "Slay" )
	slay:SetMinimumWidth(200)
	slay.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, slay:GetMinimumWidth(), slay:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/bomb.png")
	
	-- Freeze menu
	local freeze, pnl = funcmds:AddSubMenu( "Freeze" )
	freeze:SetMinimumWidth(200)
	freeze.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, freeze:GetMinimumWidth(), freeze:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/time.png")
	
	-- UnFreeze menu
	local unfreeze, pnl = funcmds:AddSubMenu( "Unfreeze" )
	unfreeze:SetMinimumWidth(200)
	unfreeze.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, unfreeze:GetMinimumWidth(), unfreeze:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/time_go.png")
	
	-- God Enable menu
	local god, pnl = funcmds:AddSubMenu( "Enable Godmode" )
	god:SetMinimumWidth(200)
	god.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, god:GetMinimumWidth(), god:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/pill_add.png")
	
	-- God Disable menu
	local ungod, pnl = funcmds:AddSubMenu( "Disable Godmode" )
	ungod:SetMinimumWidth(200)
	ungod.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ungod:GetMinimumWidth(), ungod:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/pill_delete.png")
	
	-- Ragdoll/Unragdoll menu
	local ragdoll, pnl = funcmds:AddSubMenu( "Toggle Ragdoll" )
	ragdoll:SetMinimumWidth(200)
	ragdoll.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ragdoll:GetMinimumWidth(), ragdoll:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/lightning.png")
	
	-- Cloak menu
	local cloak, pnl = funcmds:AddSubMenu( "Cloak" )
	cloak:SetMinimumWidth(200)
	cloak.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, cloak:GetMinimumWidth(), cloak:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/contrast_decrease.png")
	
	-- Uncloak menu
	local uncloak, pnl = funcmds:AddSubMenu( "Uncloak" )
	uncloak:SetMinimumWidth(200)
	uncloak.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, uncloak:GetMinimumWidth(), uncloak:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/contrast_increase.png")
	
	-- Blind menu
	local blind, pnl = funcmds:AddSubMenu( "Blind" )
	blind:SetMinimumWidth(200)
	blind.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, blind:GetMinimumWidth(), blind:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/eye.png")

	-- Cause seizure menu
	local seizurepls, pnl = funcmds:AddSubMenu( "Cause Seizure" )
	seizurepls:SetMinimumWidth(200)
	seizurepls.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, seizurepls:GetMinimumWidth(), seizurepls:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/rainbow.png")
	
	-- Rocket menu
	local rocket, pnl = funcmds:AddSubMenu( "Rocket" )
	rocket:SetMinimumWidth(200)
	rocket.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, rocket:GetMinimumWidth(), rocket:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/arrow_up.png")
	
	--Bomb menu
	local bomb, pnl = funcmds:AddSubMenu( "Bomb" )
	bomb:SetMinimumWidth(200)
	bomb.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, bomb:GetMinimumWidth(), bomb:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/sport_8ball.png")
	
	-- Set Speed menu
	local gofast, pnl = funcmds:AddSubMenu( "Set Speed" )
	gofast:SetMinimumWidth(200)
	gofast.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, gofast:GetMinimumWidth(), gofast:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/lorry.png")
	
	-- Firework menu
	local firefuck, pnl = funcmds:AddSubMenu( "Firework" )
	firefuck:SetMinimumWidth(200)
	firefuck.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, firefuck:GetMinimumWidth(), firefuck:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/star.png")
	
	-- Set Speed menu
	local givewep, pnl = funcmds:AddSubMenu( "Give Weapon" )
	givewep:SetMinimumWidth(200)
	givewep.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, givewep:GetMinimumWidth(), givewep:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/cake.png")
	
	-- Slap menu
	local slapo, pnl = funcmds:AddSubMenu( "Slap" )
	slapo:SetMinimumWidth(200)
	slapo.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, slapo:GetMinimumWidth(), slapo:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/sport_raquet.png")
	
	-- Gimp menu
	local gimp, pnl = funcmds:AddSubMenu( "Gimp" )
	gimp:SetMinimumWidth(200)
	gimp.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, gimp:GetMinimumWidth(), gimp:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/drink.png")
	
	-- Mute menu
	local mute, pnl = funcmds:AddSubMenu( "Chat Mute" )
	mute:SetMinimumWidth(200)
	mute.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, mute:GetMinimumWidth(), mute:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/pencil_delete.png")
	
	-- Voice Mute menu
	local vmute, pnl = funcmds:AddSubMenu( "Voice Mute" )
	vmute:SetMinimumWidth(200)
	vmute.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, vmute:GetMinimumWidth(), vmute:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/sound_mute.png")	
	
	
	
	// Teleport Commands //
	
	-- Bring to me menu
	local bring, pnl = tpcmds:AddSubMenu( "Bring Player" )
	bring:SetMinimumWidth(200)
	bring.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, bring:GetMinimumWidth(), bring:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/arrow_in.png")
	
	-- Goto menu
	local goto, pnl = tpcmds:AddSubMenu( "Go to Player" )
	goto:SetMinimumWidth(200)
	goto.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, goto:GetMinimumWidth(), goto:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/arrow_right.png")
	
	// DarkRP Commands //	
	if (string.lower(engine.ActiveGamemode()) == "darkrp") then

		-- Set Money menu
		local setm, pnl = rpcmds:AddSubMenu( "Set Money" )
		setm:SetMinimumWidth(200)
		setm.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, setm:GetMinimumWidth(), setm:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/money.png")	
		
		-- Set Job menu
		local setj, pnl = rpcmds:AddSubMenu( "Set Job" )
		setj:SetMinimumWidth(200)
		setj.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, setj:GetMinimumWidth(), setj:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/user_go.png")		

		-- Ban Job menu
		local banj, pnl = rpcmds:AddSubMenu( "Ban from Job" )
		banj:SetMinimumWidth(200)
		banj.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, banj:GetMinimumWidth(), banj:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/user_delete.png")		

		-- Unban Job menu
		local unbanj, pnl = rpcmds:AddSubMenu( "Unban from Job" )
		unbanj:SetMinimumWidth(200)
		unbanj.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, unbanj:GetMinimumWidth(), unbanj:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/user_add.png")
		
		-- Set Name menu
		local setn, pnl = rpcmds:AddSubMenu( "Set Name" )
		setn:SetMinimumWidth(200)
		setn.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, setn:GetMinimumWidth(), setn:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end
		pnl:SetIcon("icon16/house.png")	
	end
	
	
	rightadminmenu:Open()
	rightadminmenu:SetPos(ScrW()/4, ScrH()/5.5)
	timer.Simple( 0, function() gui.SetMousePos( ScrW()/4+60, ScrH()/5.5+20 ) end)
		
		
		
		
		
		
		
for k, v in pairs (player.GetAll()) do
	local victim = v:UserID()
	local victimname = v:Nick()
		
		
	// Utility Command Players //	
	-- Kick	
	local tokick = kick:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Kick Player", 
			"Why do you want to kick "..victimname.."?",
			"",
			function( text )
				RunConsoleCommand("cat_kick", tostring(victim), tostring(text))
			end,
			function( text ) end)
	end)
		
	-- ban
	local toban = ban:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Ban Reason", 
			"Why do you want to ban "..victimname.."?",
			"",
			function( text )
				Derma_StringRequest( 
					"Ban Time", 
					"How long do you want to ban "..victimname.."? (Ban Time is in minutes.)",
					"",
					function( text2 )
						RunConsoleCommand("cat_ban", tostring(victim), tostring(text), tostring(text2))
					end,
				function( text2 ) end)
			end,
		function( text ) end)
	end)
	
	-- Observer Ban	
	local toobsban = obsban:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Observer Ban Player", 
			"How long do you want to observer ban "..victimname.."?",
			"",
			function( text )
				RunConsoleCommand("cat_observerban", tostring(victim), tostring(text))
			end,
			function( text ) end)
	end)	
	
	-- cleanup props
	local toclean = clean:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_cprops", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- screen cap
	local toscap = sreecap:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_EXPIRscreencap", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- CEXEC
	local docexec = CExec:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"CExec", 
			"What command do you want to run on "..victimname.."? (Certain commands are disabled by default.)",
			"",
			function( text )
				RunConsoleCommand("cat_cexec", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	
	-- isnt cheater props
	local toicheat = icheat:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_isntcheater", tostring(victim))
		rightadminmenu:Hide()
	end)	
	
	-- Set Access submenu
	local saccsub = Sacc:AddSubMenu( v:Nick() )
	saccsub:SetMinimumWidth(200)
	saccsub.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, saccsub:GetMinimumWidth(), saccsub:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Set Access user submenu
	local subuser = saccsub:AddOption( "User", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "user")
		rightadminmenu:Hide()
	end):SetIcon( "icon16/user.png" )
	
	-- Set Access mod submenu
	local submod = saccsub:AddOption( "Moderator", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "mod")
		rightadminmenu:Hide()
	end):SetIcon( "icon16/user_gray.png" )	

	-- Set Access admin submenu
	local subadmin = saccsub:AddOption( "Staff", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "staff")
		rightadminmenu:Hide()
	end):SetIcon( "icon16/star.png" )
	
		-- Set Access owner submenu
	local subsadmin = saccsub:AddOption( "Owner", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "owner")
		rightadminmenu:Hide()
	end):SetIcon( "icon16/tux.png" )
	
	// Fun Command Players //
	-- set health
	local tosethp = health:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Set Health", 
			"What do you want to set "..victimname.."'s health to?",
			"",
			function( text )
				RunConsoleCommand("cat_health", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	-- Set armor
	local tosetarm = armor:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Set Armor", 
			"What do you want to set "..victimname.."'s armor to?",
			"",
			function( text )
				RunConsoleCommand("cat_armor", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	-- ignite
	local toburn = ignite:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Ignite", 
			"How long do you want to set "..victimname.." on fire for? (In Seconds)",
			"",
			function( text )
				RunConsoleCommand("cat_ignite", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	-- extinguish
	local toext = unignite:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_extinguish", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- slay
	local tokill = slay:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_slay", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- rocket
	local torocket = rocket:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_rocket", tostring(victim))
		rightadminmenu:Hide()
	end)
	--bomb
	local tobomb = bomb:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_bomb", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- freeze
	local tofreeze = freeze:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Freeze", 
			"How long do you want to freeze "..victimname.." for? (In Seconds)",
			"",
			function( text )
				RunConsoleCommand("cat_freeze", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	-- unfreeze
	local tothaw = unfreeze:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_unfreeze", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- god enable
	local togod = god:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_god", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- god disable
	local toungod = ungod:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_ungod", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- toggle ragdoll
	local todoll = ragdoll:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_ragdoll", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- cloak
	local tocloak = cloak:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_cloak", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- uncloak
	local touncloak = uncloak:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_uncloak", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- blind
	local toblind = blind:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_blind", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- seizure
	local toseize = seizurepls:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_seizure", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- set speed
	local toseize = gofast:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Freeze", 
			"What do you want to set "..victimname.."'s speed to? (200 is default)",
			"",
			function( text )
				RunConsoleCommand("cat_setspeed", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	
	-- firework
	local tofirefuck = firefuck:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_firework", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- give weapon
	local toseize = givewep:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Give Weapon", 
			"What do you want to give "..victimname.."?",
			"",
			function( text )
				RunConsoleCommand("cat_give", tostring(victim), tostring(text))
			end,
			function( text ) end)
		rightadminmenu:Hide()
	end)
	-- Slap
	local getslapped = slapo:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Slap Times", 
			"How many times do you want to slap "..victimname.."?",
			"",
			function( text )
				Derma_StringRequest( 
					"Slap Damage", 
					"How much damage will each slap do to "..victimname.."?",
					"",
					function( text2 )
						RunConsoleCommand("cat_slap", tostring(victim), tostring(text), tostring(text2))
					end,
					function( text2 ) end)
			end,
			function( text ) end)
		end)
		-- Gimp
	local togimp = gimp:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_gimp", tostring(victim))
		rightadminmenu:Hide()
	end)
		
		-- Mute
	local tomute = mute:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_mute", tostring(victim))
		rightadminmenu:Hide()
	end)

		-- Voice Mute
	local tovmute = vmute:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_voicemute", tostring(victim))
		rightadminmenu:Hide()
	end)

	
	-- bring
	local tobring = bring:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_bring", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	-- goto
	local togoto = goto:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_goto", tostring(victim))
		rightadminmenu:Hide()
	end)
	
	if (string.lower(engine.ActiveGamemode()) == "darkrp") then
		-- set money
		local tosetm = setm:AddOption( v:Nick(), function()
			Derma_StringRequest( 
				"Set Money", 
				"How much do you want to set "..victimname.."'s wallet to?",
				"",
				function( text )
					RunConsoleCommand("cat_setmoney", tostring(victim), tostring(text))
				end,
				function( text ) end)
			rightadminmenu:Hide()
		end)	
		
		-- Set Job subsubmenu
		local setjob = setj:AddSubMenu( v:Nick() )
		setjob:SetMinimumWidth(200)
		setjob.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, setjob:GetMinimumWidth(), setjob:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end	
		setjob:SetMaxHeight(340)
		
		for jobk, value in SortedPairsByMemberValue(team.GetAllTeams(), "Name") do
		
			local tosetj = setjob:AddOption( value.Name, function()
				RunConsoleCommand("cat_setjob", tostring(victim), jobk)
				rightadminmenu:Hide()
			end)
			
		end

		-- Ban Job subsubmenu
		local banjob = banj:AddSubMenu( v:Nick() )
		banjob:SetMinimumWidth(200)
		banjob.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, banjob:GetMinimumWidth(), banjob:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end	
		banjob:SetMaxHeight(340)
		
		for jobk, value in SortedPairsByMemberValue(team.GetAllTeams(), "Name") do
		
			local tobanj = banjob:AddOption( value.Name, function()
				Derma_StringRequest( 
				"Ban from Job", 
				"How long do you want to ban "..victimname.." from the job for? (In Minutes)",
				"",
				function( text )
					RunConsoleCommand("cat_banjob", tostring(victim), jobk, tostring(text))
				end,
				function( text ) end)			
				rightadminmenu:Hide()
			end)
			
		end

		-- Unban Job subsubmenu
		local unbanjob = unbanj:AddSubMenu( v:Nick() )
		unbanjob:SetMinimumWidth(200)
		unbanjob.Paint = function()
			draw.RoundedBoxEx( 6, 0, 0, unbanjob:GetMinimumWidth(), unbanjob:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		end	
		unbanjob:SetMaxHeight(340)
		
		for jobk, value in SortedPairsByMemberValue(team.GetAllTeams(), "Name") do
		
			local tobanj = unbanjob:AddOption( value.Name, function()	
				RunConsoleCommand("cat_unbanjob", tostring(victim), jobk)		
				rightadminmenu:Hide()
			end)
			
		end
		
		-- set name
		local tosetn = setn:AddOption( v:Nick(), function()
			Derma_StringRequest( 
				"Set RP Name", 
				"What do you want to set "..victimname.."'s name to?",
				"",
				function( text )
					RunConsoleCommand("cat_setname", tostring(victim), tostring(text))
				end,
				function( text ) end)
			rightadminmenu:Hide()
		end)	
		end
	end

end)

concommand.Add("-CAT_menu", function()
	CloseDermaMenus()
end)
