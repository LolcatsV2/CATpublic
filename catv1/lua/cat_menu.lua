concommand.Add("+CAT_menu", function(ply, command, arguments)

local canopen = false
	
	if ply:GetNWString("CAT_Usergroup") == "owner" then
		canopen = true
	elseif ply:GetNWString("CAT_Usergroup") == "superadmin" then
		canopen = true
	elseif ply:GetNWString("CAT_Usergroup") == "admin" then
		canopen = true
	end
	if canopen != true then return end -- A really dumb way of doing it, but it works.


	
	
	rightadminmenu = vgui.Create("DMenu")
	rightadminmenu:SetMinimumWidth(200)
	rightadminmenu.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, rightadminmenu:GetMinimumWidth(), rightadminmenu:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	local title = rightadminmenu:AddOption( "CAT V.1", function() end)
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
		Derma_StringRequest( 
			"Unban", 
			"Input the SteamID you want to unban.",
			"",
			function( text )
				RunConsoleCommand("cat_unban", tostring(victim), tostring(text))
			end,
			function( text ) end)
	end):SetIcon("icon16/heart_add.png")
	
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
	
	-- Set Speed menu
	local gofast, pnl = funcmds:AddSubMenu( "Set Speed" )
	gofast:SetMinimumWidth(200)
	gofast.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, gofast:GetMinimumWidth(), gofast:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	pnl:SetIcon("icon16/lorry.png")
	
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
	
	
	rightadminmenu:Open()
	rightadminmenu:SetPos(ScrW()/4, ScrH()/4)
	timer.Simple( 0, function() gui.SetMousePos( ScrW()/4+60, ScrH()/4+20 ) end)
		
		
		
		
		
		
		
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
	
	-- cleanup props
	local toclean = clean:AddOption( v:Nick(), function()
		RunConsoleCommand("cat_cleanuserprops", tostring(victim))
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
	end):SetIcon( "gui/silkicons/user.vtf" )
	
	-- Set Access vip submenu
	local subvip = saccsub:AddOption( "V.I.P.", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "vip")
		rightadminmenu:Hide()
	end):SetIcon( "gui/silkicons/medal_gold_3.vtf" )
	
	-- Set Access mod submenu
	local submod = saccsub:AddOption( "Moderator", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "moderator")
		rightadminmenu:Hide()
	end):SetIcon( "gui/silkicons/user_suit.vtf" )
	
	-- Set Access admin submenu
	local subadmin = saccsub:AddOption( "Admin", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "admin")
		rightadminmenu:Hide()
	end):SetIcon( "gui/silkicons/star.vtf" )
	
	-- Set Access superadmin submenu
	local subsadmin = saccsub:AddOption( "Superadmin", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "superadmin")
		rightadminmenu:Hide()
	end):SetIcon( "gui/silkicons/ruby.vtf" )
		-- Set Access owner submenu
	local subsadmin = saccsub:AddOption( "Owner", function()
		RunConsoleCommand("cat_setaccess", tostring(victim), "owner")
		rightadminmenu:Hide()
	end):SetIcon( "gui/silkicons/tux.vtf" )
	
	// Fun Command Players //
	-- set health
	local tosethp = health:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Set Health", 
			"What do you want to set "..victimname.."'s health to?",
			"",
			function( text )
				RunConsoleCommand("cat_hp", tostring(victim), tostring(text))
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
		RunConsoleCommand("cat_seize", tostring(victim))
		rightadminmenu:Hide()
	end)
	-- set speed
	local toseize = gofast:AddOption( v:Nick(), function()
		Derma_StringRequest( 
			"Freeze", 
			"What do you want to set "..victimname.."'s speed to? (200 is default)",
			"",
			function( text )
				RunConsoleCommand("cat_sspeed", tostring(victim), tostring(text))
			end,
			function( text ) end)
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
	end

end)

concommand.Add("-CAT_menu", function()
	CloseDermaMenus()
end)
