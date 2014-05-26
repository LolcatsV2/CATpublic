-- Thanks @Mors Quaedam for this.
if SERVER then
        util.AddNetworkString( "CAT_ColorMsg" )
        function CAT_BroadcastMsg(...)
                local args = {...}
                net.Start("CAT_ColorMsg")
                net.WriteTable(args)
                net.Broadcast()
        end
 
        function CAT_PlayerMsg(...)
                local args = {...}
                local ply = args[1]
                table.remove(args,1)
                net.Start("CAT_ColorMsg")
                net.WriteTable(args)
                net.Send(ply)
        end
elseif CLIENT then
        net.Receive("CAT_ColorMsg",function(len)
                local msg = net.ReadTable()
                chat.AddText(unpack(msg))
                chat.PlaySound()
        end)
end