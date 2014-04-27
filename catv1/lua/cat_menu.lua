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
		
		local dumbicon1 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/application' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 27,
			w 	= 16,
			h 	= 16
		}
		local dumbicon2 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/rainbow' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 49,
			w 	= 16,
			h 	= 16
		}
		local dumbicon3 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/wrench' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 72,
			w 	= 16,
			h 	= 16
		}
		local dumbicon4 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/asterisk_yellow' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 94,
			w 	= 16,
			h 	= 16
		}
		
		draw.TexturedQuad( dumbicon1 )
		draw.TexturedQuad( dumbicon2 )
		draw.TexturedQuad( dumbicon3 )
		draw.TexturedQuad( dumbicon4 )
	end
	
	local title = rightadminmenu:AddOption( "CAT V.1", function() end)
	title:SetPaintBackground(false)
	--Should add a spacer to keep the submenus from auto opening.
	rightadminmenu:AddSpacer()
	
	-- Server Commands submenu.
	local servcmds = rightadminmenu:AddSubMenu( "Server Actions" )
	servcmds:SetMinimumWidth(200)
	servcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, servcmds:GetMinimumWidth(), servcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		
		local dumbicon1 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/find' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 4,
			w 	= 16,
			h 	= 16
		}
		local dumbicon2 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/application_xp_terminal' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 25,
			w 	= 16,
			h 	= 16
		}
		local dumbicon3 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/wand' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 47,
			w 	= 16,
			h 	= 16
		}
		local dumbicon4 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/photos' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 69,
			w 	= 16,
			h 	= 16
		}
	draw.TexturedQuad( dumbicon1 )
	draw.TexturedQuad( dumbicon2 )
	draw.TexturedQuad( dumbicon3 )
	draw.TexturedQuad( dumbicon4 )

	end
	
	rightadminmenu:AddSpacer()
	
	
	
	
	
	-- "Fun" Commands submenu.
	local funcmds = rightadminmenu:AddSubMenu( "Fun" )
	funcmds:SetMinimumWidth(200)
	funcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, funcmds:GetMinimumWidth(), funcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		
		local dumbicon1 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/heart' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 4,
			w 	= 16,
			h 	= 16
		}
		local dumbicon2 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/anchor' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 25,
			w 	= 16,
			h 	= 16
		}
		local dumbicon3 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/weather_sun' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 47,
			w 	= 16,
			h 	= 16
		}
		local dumbicon4 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/weather_rain' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 68,
			w 	= 16,
			h 	= 16
		}
		
		local dumbicon5 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/bomb' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 90,
			w 	= 16,
			h 	= 16
		}
		local dumbicon6 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/time' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 113,
			w 	= 16,
			h 	= 16
		}
		local dumbicon7 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/time_go' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 135,
			w 	= 16,
			h 	= 16
		}
		local dumbicon8 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/pill_add' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 156,
			w 	= 16,
			h 	= 16
		}
		
		local dumbicon9 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/pill_delete' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 178,
			w 	= 16,
			h 	= 16
		}
		local dumbicon10 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/contrast_decrease' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 201,
			w 	= 16,
			h 	= 16
		}
		local dumbicon12 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/contrast_increase' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 223,
			w 	= 16,
			h 	= 16
		}
		
		local dumbicon13 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/eye' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 245,
			w 	= 16,
			h 	= 16
		}
		local dumbicon14 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/rainbow' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 267,
			w 	= 16,
			h 	= 16
		}
		local dumbicon15 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/arrow_up' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 289,
			w 	= 16,
			h 	= 16
		}
		local dumbicon16 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/lorry' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 311,
			w 	= 16,
			h 	= 16
		}		
		local dumbicon17 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/cake' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 333,
			w 	= 16,
			h 	= 16
		}	
		local dumbicon18 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/sport_raquet' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 355,
			w 	= 16,
			h 	= 16
		}	
		
		local dumbicon19 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/drink' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 377,
			w 	= 16,
			h 	= 16
		}	
		
		draw.TexturedQuad( dumbicon1 )
		draw.TexturedQuad( dumbicon2 )
		draw.TexturedQuad( dumbicon3 )
		draw.TexturedQuad( dumbicon4 )
		draw.TexturedQuad( dumbicon5 )
		draw.TexturedQuad( dumbicon6 )
		draw.TexturedQuad( dumbicon7 )
		draw.TexturedQuad( dumbicon8 )
		draw.TexturedQuad( dumbicon9 )
		draw.TexturedQuad( dumbicon10 )
		draw.TexturedQuad( dumbicon12 )
		draw.TexturedQuad( dumbicon12 )
		draw.TexturedQuad( dumbicon13 )
		draw.TexturedQuad( dumbicon14 )
		draw.TexturedQuad( dumbicon15 )
		draw.TexturedQuad( dumbicon16 )
		draw.TexturedQuad( dumbicon17 )
		draw.TexturedQuad( dumbicon18 )
		draw.TexturedQuad( dumbicon19 )		
		
	end
	
	rightadminmenu:AddSpacer()
	
	-- "Utilities" Commands submenu
	local utilcmds = rightadminmenu:AddSubMenu( "Utility" )
	utilcmds:SetMinimumWidth(200)
	utilcmds.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, utilcmds:GetMinimumWidth(), utilcmds:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
		local dumbicon1 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/disconnect' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 4,
			w 	= 16,
			h 	= 16
		}
		local dumbicon2 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/exclamation' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 25,
			w 	= 16,
			h 	= 16
		}
		local dumbicon3 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/heart_add' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 47,
			w 	= 16,
			h 	= 16
		}
		local dumbicon4 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/delete' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 70,
			w 	= 16,
			h 	= 16
		}
		local dumbicon5 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/camera_go' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 91,
			w 	= 16,
			h 	= 16
		}
		local dumbicon6 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/application_xp' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 112,
			w 	= 16,
			h 	= 16
		}
		local dumbicon7 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/key' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 134,
			w 	= 16,
			h 	= 16
		}
		draw.TexturedQuad( dumbicon1 )
		draw.TexturedQuad( dumbicon2 )
		draw.TexturedQuad( dumbicon3 )
		draw.TexturedQuad( dumbicon4 )
		draw.TexturedQuad( dumbicon5 )
		draw.TexturedQuad( dumbicon6 )
		draw.TexturedQuad( dumbicon7 )
	end
	
	rightadminmenu:AddSpacer()
	
	
	-- "Teleportation" Commands submenu
	local tpcmds = rightadminmenu:AddSubMenu( "Teleportation" )
	tpcmds:SetMinimumWidth(200)
	tpcmds.Paint = function()
		local dumbicon1 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/arrow_in' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 4,
			w 	= 16,
			h 	= 16
		}
		local dumbicon2 =
		{
			texture = surface.GetTextureID( 'gui/silkicons/arrow_right' ),
			color   = Color( 255, 255, 255, 255 ),
			x 	= 5,
			y 	= 25,
			w 	= 16,
			h 	= 16
		}
		draw.RoundedBox( 6, 0, 0, tpcmds:GetMinimumWidth(), tpcmds:GetMaxHeight(), Color(255,255,255,255))
		draw.TexturedQuad( dumbicon1 )
		draw.TexturedQuad( dumbicon2 )
	end
	
	
	// Server commands //
	
	local cldecals = servcmds:AddOption( "Clear Decals", function()
		RunConsoleCommand("cat_cleardecals")
		rightadminmenu:Hide()
	end)
	
	local rconme = servcmds:AddOption( "RCon Command", function()
		Derma_StringRequest( 
			"Remote Console Command", 
			"What command do you want to run?",
			"",
			function( text )
				RunConsoleCommand("cat_rcon", tostring(text))
			end,
			function( text ) end)
		end)
	local cleanserver = servcmds:AddOption( "Cleanup Server", function()
		RunConsoleCommand("cat_serverclean")
		rightadminmenu:Hide()
	end)
	local cmap = servcmds:AddOption( "Change Map", function()
		Derma_StringRequest( 
			"Change Level", 
			"What map do you wish to change to?",
			"",
			function( text )
				RunConsoleCommand("cat_changemap", tostring(text))
			end,
			function( text ) end)
		end)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// Utility commands //
	
	-- Kick menu
	local kick = utilcmds:AddSubMenu( "Kick" )
	kick:SetMinimumWidth(200)
	kick.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, kick:GetMinimumWidth(), kick:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Ban menu
	local ban = utilcmds:AddSubMenu( "Ban" )
	ban:SetMinimumWidth(200)
	ban.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ban:GetMinimumWidth(), ban:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
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
	end)
	-- Cleanup props menu
	local clean = utilcmds:AddSubMenu( "Clean User's Props" )
	clean:SetMinimumWidth(200)
	clean.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, clean:GetMinimumWidth(), clean:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Expirimental Screenshot menu
	local sreecap = utilcmds:AddSubMenu( "Capture User's Screen" )
	sreecap:SetMinimumWidth(200)
	sreecap.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, sreecap:GetMinimumWidth(), sreecap:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	-- CExec menu
	local CExec = utilcmds:AddSubMenu( "Client ConCommand" )
	CExec:SetMinimumWidth(200)
	CExec.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, CExec:GetMinimumWidth(), CExec:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	-- Set Access menu
	local Sacc = utilcmds:AddSubMenu( "Set Access" )
	Sacc:SetMinimumWidth(200)
	Sacc.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, Sacc:GetMinimumWidth(), Sacc:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	// Fun Commands //
	
	-- Set Health menu
	local health = funcmds:AddSubMenu( "Set Health" ) 
	health:SetMinimumWidth(200)
	health.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, health:GetMinimumWidth(), health:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Set Armor menu
	local armor = funcmds:AddSubMenu( "Set Armor" )
	armor:SetMinimumWidth(200)
	armor.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, armor:GetMinimumWidth(), armor:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
		-- Ignite menu
	local ignite = funcmds:AddSubMenu( "Ignite" )
	ignite:SetMinimumWidth(200)
	ignite.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ignite:GetMinimumWidth(), ignite:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Extingusih menu
	local unignite = funcmds:AddSubMenu( "Extinguish" )
	unignite:SetMinimumWidth(200)
	unignite.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, unignite:GetMinimumWidth(), unignite:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Slay menu
	local slay = funcmds:AddSubMenu( "Slay" )
	slay:SetMinimumWidth(200)
	slay.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, slay:GetMinimumWidth(), slay:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	
	-- Freeze menu
	local freeze = funcmds:AddSubMenu( "Freeze" )
	freeze:SetMinimumWidth(200)
	freeze.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, freeze:GetMinimumWidth(), freeze:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- UnFreeze menu
	local unfreeze = funcmds:AddSubMenu( "Unfreeze" )
	unfreeze:SetMinimumWidth(200)
	unfreeze.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, unfreeze:GetMinimumWidth(), unfreeze:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- God Enable menu
	local god = funcmds:AddSubMenu( "Enable Godmode" )
	god:SetMinimumWidth(200)
	god.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, god:GetMinimumWidth(), god:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	
	-- God Disable menu
	local ungod = funcmds:AddSubMenu( "Disable Godmode" )
	ungod:SetMinimumWidth(200)
	ungod.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, ungod:GetMinimumWidth(), ungod:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Cloak menu
	local cloak = funcmds:AddSubMenu( "Cloak" )
	cloak:SetMinimumWidth(200)
	cloak.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, cloak:GetMinimumWidth(), cloak:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	
	-- Uncloak menu
	local uncloak = funcmds:AddSubMenu( "Uncloak" )
	uncloak:SetMinimumWidth(200)
	uncloak.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, uncloak:GetMinimumWidth(), uncloak:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Blind menu
	local blind = funcmds:AddSubMenu( "Blind" )
	blind:SetMinimumWidth(200)
	blind.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, blind:GetMinimumWidth(), blind:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	
	-- Cause seizure menu
	local seizurepls = funcmds:AddSubMenu( "Cause Seizure" )
	seizurepls:SetMinimumWidth(200)
	seizurepls.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, seizurepls:GetMinimumWidth(), seizurepls:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Rocket menu
	local rocket = funcmds:AddSubMenu( "Rocket" )
	rocket:SetMinimumWidth(200)
	rocket.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, rocket:GetMinimumWidth(), rocket:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Set Speed menu
	local gofast = funcmds:AddSubMenu( "Set Speed" )
	gofast:SetMinimumWidth(200)
	gofast.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, gofast:GetMinimumWidth(), gofast:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Set Speed menu
	local givewep = funcmds:AddSubMenu( "Give Weapon" )
	givewep:SetMinimumWidth(200)
	givewep.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, givewep:GetMinimumWidth(), givewep:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	-- Slap menu
	local slapo = funcmds:AddSubMenu( "Slap" )
	slapo:SetMinimumWidth(200)
	slapo.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, slapo:GetMinimumWidth(), slapo:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	-- Gimp menu
	local gimp = funcmds:AddSubMenu( "Gimp" )
	gimp:SetMinimumWidth(200)
	gimp.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, gimp:GetMinimumWidth(), gimp:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	// Teleport Commands //
	
	-- Bring to me menu
	local bring = tpcmds:AddSubMenu( "Bring Player" )
	bring:SetMinimumWidth(200)
	bring.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, bring:GetMinimumWidth(), bring:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	
	-- Goto menu
	local goto = tpcmds:AddSubMenu( "Go to Player" )
	goto:SetMinimumWidth(200)
	goto.Paint = function()
		draw.RoundedBoxEx( 6, 0, 0, goto:GetMinimumWidth(), goto:GetMaxHeight(), Color(255,255,255,255), false, false, false, false )
	end
	
	
	
	rightadminmenu:Open()
	rightadminmenu:SetPos(ScrW()/4, ScrH()/4)
	timer.Simple( 0, function() gui.SetMousePos( ScrW()/4+60, ScrH()/4+20 ) end)
		
		
		
		
		
		
		-- kick
		for k, v in pairs (player.GetAll()) do
		local victim = v:UserID()
		local victimname = v:Nick()
		
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
