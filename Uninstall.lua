local file = require("filesystem")

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
    print("removeing "..val["Name"].." from /home/"..val["Name"])
    if file.exists("/home/"..val["Name"]) then
        file.remove("/home/"..val["Name"])
    else
        print("file "..val["Name"].." does not exists/been removed from /home/"..val["Name"])
    end
end
print("Done")
