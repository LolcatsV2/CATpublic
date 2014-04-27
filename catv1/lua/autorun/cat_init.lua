if (SERVER) then
include("cat_server.lua")
elseif (CLIENT) then
include("cat_client.lua")
end
