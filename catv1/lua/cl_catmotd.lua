

net.Receive("motdstatus", function(len)

cat_motd_url = net.ReadString()
cat_motd_enable = net.ReadBit()
end)

local motd_title = GetHostName()

concommand.Add( "openmotd", function()
	
	if (cat_motd_enable) then
		
		local window = vgui.Create( "DFrame" )
		window:ShowCloseButton(true)
		window:SetDraggable(false)
		if ScrW() > 640 then
			window:SetSize( ScrW()*0.9, ScrH()*0.9 )
		else
			window:SetSize( 640, 480 )
		end
		window:Center()
		window:SetTitle( motd_title )
		window:MakePopup()
				
		local html = vgui.Create( "HTML", window )
		local AcceptButton = vgui.Create( "DButton", window )
		AcceptButton:SetText( "Close" )
		AcceptButton.DoClick = function()
			window:Close() 
		end
		AcceptButton:SetSize( 100, 40 )
		AcceptButton:SetDisabled( false )
		AcceptButton:SetPos( (window:GetWide() - AcceptButton:GetWide()) / 2, window:GetTall() - AcceptButton:GetTall() - 10 )
	
		html:SetSize( window:GetWide() - 20, window:GetTall() - AcceptButton:GetTall() - 50 )
		html:SetPos( 10, 30 )
		html:OpenURL( cat_motd_url )

		end
	end)

	

	