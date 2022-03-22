local shell = require("shell")
local wget = loadfile(shell.resolve("wget","lua"))
if not wget then
  io.stderr:write("cannot use this installer without an internet card and wget")
end
FilePaths = {
    {
        ["Name"] = "NetworkingAPI.lua",
        ["Path"] = "https://pastebin.com/raw/ghygSba7"
    },
	{
        ["Name"] = "Server.lua",
        ["Path"] = "https://pastebin.com/raw/1LSFx5xa"
    },
	{
        ["Name"] = "Clinet.lua",
        ["Path"] = "https://pastebin.com/raw/SG2FQ61d"
    },
	{
        ["Name"] = "PageAPI.lua",
        ["Path"] = "https://pastebin.com/raw/X45guLdf"
    },
	{
        ["Name"] = "ButtonAPI.lua",
        ["Path"] = "https://pastebin.com/raw/TGBBpV1Q"
    },
	{
        ["Name"] = "ReatorAPI.lua",
        ["Path"] = "https://pastebin.com/raw/Wx0ujCz0"
    },
	{
        ["Name"] = "Main.lua",
        ["Path"] = "https://pastebin.com/raw/2VX3r8mv"
    },
	{
        ["Name"] = "ExtraData.lua",
        ["Path"] = "https://pastebin.com/raw/bcGDrgxR"
    },
    {
        ["Name"] = "Uninstall.lua",
        ["Path"] = "https://pastebin.com/raw/RwTVMRZ2"
    }
}

for name,val in pairs(FilePaths) do
    print("Downloading "..val["Name"].." to /home/"..val["Name"].." from "..val["Path"].."....")
    wget("-fq",val["Path"], "/home/"..val["Name"])
end
print("Done")
