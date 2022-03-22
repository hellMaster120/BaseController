local file = require("filesystem")
local shell = require("shell")
local wget = loadfile(shell.resolve("wget","lua"))
if not wget then
  io.stderr:write("cannot use this installer without an internet card and wget")
end
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
        ["Name"] = "Install.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Install.lua"
    },
    {
        ["Name"] = "Update.lua",
        ["Path"] = "https://raw.githubusercontent.com/hellMaster120/BaseController/main/Update.lua"
    }
}

for name,val in pairs(FilePaths) do
    print("Updateing "..val["Name"].." filePath /home/"..val["Name"].." From "..val["Path"])
    if file.exists("/home/"..val["Name"]) then
        file.remove("/home/"..val["Name"])
    end
    wget("-fq",val["Path"], "/home/"..val["Name"])
    sleep(3)
end
print("Done")
