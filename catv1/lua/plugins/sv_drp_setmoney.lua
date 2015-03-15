/*=======================
=SetMoney module,created=
=======by Lolcats========
=======================*/

local PLUGINNAME = "setmoney"
CAT_Commands[PLUGINNAME] = {}
CAT_Commands[PLUGINNAME].command = "!setmoney"
CAT_Commands[PLUGINNAME].args = 3
CAT_Commands[PLUGINNAME].help = "!setmoney target amount"



concommand.Add("cat_setmoney", function( ply, command, arguments )

local victim = CAT_FindPlayerUserID( arguments[1] )


if (!IsValid(ply)) then
	ply = "Console"
end


local plycando = CAT_CanDoAction(ply, "setmoney")
	if plycando == false then
return end		
	
if (victim:IsBetterOrSame(ply)) then
		
	CAT_MessagePlayer(ply, "Access denied! \"" .. victim:Nick() .. "\" has same or better access than you.")
		
	return
end

if (tonumber(arguments[2]) == nil) then 
	CAT_MessagePlayer(ply, "You didn't specify a real number. Try again")
	return
end

victim:setDarkRPVar("money", tonumber(arguments[2]))

CAT_LogActionServer(ply, " set "..victim:Nick().."'s money to ".. arguments[2]..".")

end)