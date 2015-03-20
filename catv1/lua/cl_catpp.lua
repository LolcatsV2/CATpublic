--Receive the inital status of prop protection when we join.

local physppstatus = physppstatus
local toolppstatus = toolppstatus
local gravppstatus = gravppstatus
local totalppstatus = totalppstatus

net.Receive( "ppstatus", function(length)
	physppstatus = net.ReadString()
	toolppstatus = net.ReadString()
	gravppstatus = net.ReadString()
	totalppstatus = net.ReadString()
end)

--Receive the status of physgun protection when it is changed.
net.Receive( "physppstatus", function(length)
	physppstatus = net.ReadString()
end)

--Receive the status of toolgun protection when it is changed.
net.Receive( "toolppstatus", function(length)
	toolppstatus = net.ReadString()
end)

--Receive the status of gravgun protection when it is changed.
net.Receive( "gravppstatus", function(length)
	gravppstatus = net.ReadString()
end)

CATPP_Buddies = CATPP_Buddies or {}

local offset = 0
local function CAT_ShowOwner()

	if totalppstatus == "false" then return end

	
	local ent = LocalPlayer():GetEyeTraceNoCursor().Entity
	if IsValid(ent) and ent:GetNWString("owner") then

		if ent:IsPlayer() then return end
	
		surface.SetFont("Default")
		local w,h = surface.GetTextSize(ent:GetNWString( "FounderName" ))

		if offset < w then
			offset = math.Min(offset + (RealFrameTime()*600), w)
		end

		

		draw.RoundedBox(4, offset - w, ScrH()/2 - h - 2, w + 10, 20, Color(0, 0, 0, 110))
		draw.DrawText(ent:GetNWString( "FounderName" ), "default", 5 - w + offset, ScrH()/2 - h, Color(255,255,255,255), 0)
		surface.SetDrawColor(255,255,255,255)
	elseif not IsValid(ent) then
	offset = 0
	end	
	

		end
hook.Add("HUDPaint", "createdock", CAT_ShowOwner)



--Create our own font, cause we can.
surface.CreateFont( "cat_clpp", {
	font = "default",
	size = 32,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )



--We should make a neat Q menu thing for this, right?
hook.Add( "AddToolMenuTabs", "CATPP_ToolMenuAdd", function()

	if totalppstatus == "false" then return end

	spawnmenu.AddToolTab( "cat", "CAT", "icon16/book_key.png" ) -- Add a new tab

	spawnmenu.AddToolCategory( "cat", "catpp", "CAT Prop Protection" ) -- Add a category into that new tab

	spawnmenu.AddToolMenuOption( "cat", "catpp", "catppbuddies", "Buddies", "", "", function( panel ) -- We need to populate the toolmenu with something!
		panel:ClearControls()
		
		
		--Backboard for everything
		local backboard = vgui.Create( "DPanel", panel )
		backboard:SetPos( 20, 25 )
		backboard:SetSize( 360, 650 )		

		--A nice label.
		local headthing = vgui.Create("DLabel", backboard)
		headthing:SetFont("cat_clpp")
		headthing:SetText("Prop Protection Buddies")
		headthing:SetPos(30,10)
		headthing:SetTextColor(Color(0,0,0))
		headthing:SizeToContents()

		--list
		local buddylister = vgui.Create("DListView", backboard)
		buddylister:SetPos(40, 75)
		buddylister:SetSize(280, 200)
		buddylister:SetMultiSelect( false )
		buddylister:AddColumn( "Name" )

		for k, v in pairs (CATPP_Buddies) do
			buddylister:AddLine(v)
		end

		--add buddy button
		local buddybutton = vgui.Create("DButton", backboard)
		buddybutton:SetSize(280, 35)
		buddybutton:SetPos(40, 300)
		buddybutton:SetFont("Trebuchet24")
		buddybutton:SetText("Add a Buddy")
		buddybutton.DoClick = function()

			local listy = vgui.Create("DMenu")
				listy:SetPos(gui.MouseX(), gui.MouseY())
				listy:SetMinimumWidth(140)
				for _, v in pairs (player.GetAll()) do
						
					local person = listy:AddOption( v:Nick(), function() 
						net.Start("ppaddbuddy")
							net.WriteString(v:SteamID())
						net.SendToServer()
						CATPP_Buddies[v:SteamID()] = v:Nick()
						buddylister:AddLine(v:Nick())
					end):SetIcon( "icon16/user.png" )
				end
			listy:Open()	
		end

		--remove buddy button
		local unbuddybutton = vgui.Create("DButton", backboard)
		unbuddybutton:SetSize(280, 35)
		unbuddybutton:SetPos(40, 370)
		unbuddybutton:SetFont("Trebuchet24")
		unbuddybutton:SetText("Remove a Buddy")
		unbuddybutton.DoClick = function()

			local listy = vgui.Create("DMenu")
				listy:SetPos(gui.MouseX(), gui.MouseY())
				listy:SetMinimumWidth(140)
				for k, v in pairs (CATPP_Buddies) do
						
					local person = listy:AddOption( v, function() 
						net.Start("ppremovebuddy")
							net.WriteString(k)
						net.SendToServer()
						CATPP_Buddies[k] = nil
						for ind, val in pairs (buddylister:GetLines()) do
							if (val:GetValue(1) == v) then
								buddylister:RemoveLine(ind)
							end
						end
					end):SetIcon( "icon16/user.png" )
				end
			listy:Open()	
		end

	end)	
	
	spawnmenu.AddToolMenuOption( "cat", "catpp", "catppgeneral", "Settings", "", "", function( panel ) -- We need to populate the toolmenu with something!
		panel:ClearControls()
		
		
		local ply = LocalPlayer()
		
		--Backboard for everything
		local backboard = vgui.Create( "DPanel", panel )
		backboard:SetPos( 20, 25 )
		backboard:SetSize( 280, 650 )
		
		--A nice label.
		local headthing = vgui.Create("DLabel", backboard)
		headthing:SetFont("cat_clpp")
		headthing:SetText("General Settings")
		headthing:SetPos(30,10)
		headthing:SetTextColor(Color(0,0,255))
		headthing:SizeToContents()
		
		--Physgun Prop Protection button.
		local physppbut = vgui.Create("DButton", backboard)
		physppbut:SetPos( 15, 70 )
		physppbut:SetText( "Physgun Protection" )
		physppbut:SetSize( 250, 55 )
		physppbut:SetTextColor(Color(0, 0, 0, 0))
		physppbut.DoClick = function()
			RunConsoleCommand("cat_physgunpp")
		end	
		physppbut.Paint = function()
			if (physppstatus == "true") then
				draw.RoundedBox( 8, 0, 0, physppbut:GetWide(), physppbut:GetTall(), Color( 0, 200, 0, 125 ) )
			else
				draw.RoundedBox( 8, 0, 0, physppbut:GetWide(), physppbut:GetTall(), Color( 200, 0, 0, 125 ) )
			end
			draw.SimpleText( "Physgun Protection", "cat_clpp", 5, 10, Color(255,255,255,255) )
		end
		
		--Toolgun Prop Protection button.
		local toolppbut = vgui.Create("DButton", backboard)
		toolppbut:SetPos( 15, 140 )
		toolppbut:SetText( "Toolgun Protection" )
		toolppbut:SetSize( 250, 55 )
		toolppbut:SetTextColor(Color(0, 0, 0, 0))
		toolppbut.DoClick = function()
			RunConsoleCommand("cat_toolgunpp")
		end	
		toolppbut.Paint = function()
			if (toolppstatus == "true") then
				draw.RoundedBox( 8, 0, 0, toolppbut:GetWide(), toolppbut:GetTall(), Color( 0, 200, 0, 125 ) )
			else
				draw.RoundedBox( 8, 0, 0, toolppbut:GetWide(), toolppbut:GetTall(), Color( 200, 0, 0, 125 ) )
			end
			draw.SimpleText( "Toolgun Protection", "cat_clpp", 8, 10, Color(255,255,255,255) )
		end	
		
		--Gravgun Prop Protection button.
		local gravppbut = vgui.Create("DButton", backboard)
		gravppbut:SetPos( 15, 210 )
		gravppbut:SetText( "Gravgun Protection" )
		gravppbut:SetSize( 250, 55 )
		gravppbut:SetTextColor(Color(0, 0, 0, 0))
		gravppbut.DoClick = function()
			RunConsoleCommand("cat_gravgunpp")
		end	
		gravppbut.Paint = function()
			if (gravppstatus == "true") then
				draw.RoundedBox( 8, 0, 0, gravppbut:GetWide(), gravppbut:GetTall(), Color( 0, 200, 0, 125 ) )
			else
				draw.RoundedBox( 8, 0, 0, gravppbut:GetWide(), gravppbut:GetTall(), Color( 200, 0, 0, 125 ) )
			end
			draw.SimpleText( "Gravgun Protection", "cat_clpp", 6, 10, Color(255,255,255,255) )
		end			
	end)
	

	
end )
