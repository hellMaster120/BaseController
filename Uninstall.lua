local file = require("filesystem")

FilePaths = {
    {
        ["Name"] = "NetworkingAPI.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/NetworkingAPI.lua"
    },
	{
        ["Name"] = "Server.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Server.lua"
    },
	{
        ["Name"] = "Clinet.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Client.lua"
    },
	{
        ["Name"] = "PageAPI.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/PageAPI.lua"
    },
	{
        ["Name"] = "ButtonAPI.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/ButtonAPI.lua"
    },
	{
        ["Name"] = "ReatorAPI.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/ReatorAPI.lua"
    },
	{
        ["Name"] = "Main.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Main.lua"
    },
	{
        ["Name"] = "ExtraData.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/ExtraData.lua"
    },
    {
        ["Name"] = "Uninstall.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Uninstall.lua"
    },
    {
        ["Name"] = "Update.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Update.lua"
    }
}

for name,val in pairs(FilePaths) do
    print("removeing "..val["Name"].." from /home/"..val["Name"])
    if file.exists("/home/"..val["Name"]) then
        file.remove("/home/"..val["Name"])
    else
        print("file "..val["Name"].." does not exists/been removed from /home/"..val["Name"])
    end
end
print("Done")
