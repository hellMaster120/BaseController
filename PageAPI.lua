local ButtonAPI = require("ButtonAPI")
local component = require("component")
local colors = require("colors")
local term = require("term")
local event = require("event")
local computer = require("computer")
local Client = require("Client")
local ExtraData = require("ExtraData")
local serialization = require("serialization")

local API = {}
local Pages = {}

local Screen  = component.gpu
local w, h = Screen.getResolution()

function API.rgbToHex(r,g,b)
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return rgb
end

function API.clear()
    Screen.setBackground(Black)
    Screen.fill(1, 1, w, h, " ")
end

function API.ButtonPanel(Color,Size,pos) 
    local GUITable = {
        ["Panels"] = {},
        ["Iteams"] = {}

    }
    
    print(serialization.serialize(GUITable))
    return GUITable 
end

function API.PageLoadFunction(PageName,ParentPanel,PageTable,Page) 
    if Page["CurrentPage"] == true then
        Page["PageData"] = PageTable
        Api.DrawPage(PageName,ParentPanel,PageTable,Page) 
    else 
        return
    end
end

function API.MakePage(PageName,ParentPanel,PageTable,OverRidePageFunction,OverRideClickedFunction)
    local Page = Pages[PageName]
    local Page = {
        ["CurrentPage"] = false,
        ["OverRideFunctions"] = {
            ["ClickFunction"] = NULL,
            ["PageLoadFunction"] = NULL
        },
        ["ButtonData"] = {
            ["Size"] = ExtraData.Vector4(0,0,0),
            ["Pos"] = ExtraData.Vector2(0,0),
            ["Text"] = PageName,
            ["Color"] = ExtraData.rgb(0,0,0)
        }
        ["PageData"] = {},
    }

    if #Pages == 1 then 
        Page["CurrentPage"] = true
    end
    if ParentPanel == NULL then
        ParentPanel = 
    end
    
    if OverRidePageFunction == NULL then
        Page["OverRideFunctions"]["PageLoadFunction"] = API.PageLoadFunction(PageName,ParentPanel,PageTable,Page)
    else
        Page["OverRideFunctions"]["PageLoadFunction"] = OverRidePageFunction(PageName,ParentPanel,PageTable,Page)
    end
    if ClickedFunction == NULL then
        Page["OverRideFunctions"]["ClickFunction"] = function(CurrentPage,ClickedPage)
            if CurrentPage == ClickedPage then return end
            if CurrentPage != ClickedPage then 
                API.SetCurrentPage(PageName,Page) 
                Api.DrawPage((PageName,ParentPanel,PageTable,Page)
            end
        end
    else
        Page["OverRideFunctions"]["ClickFunction"] = ClickedFunction(PageName,ParentPanel,PageTable,Page)
    end

    Page["OverRideFunctions"]["PageLoadFunction"]()

    return Page,PageName
end

function API.LoadPageAim(PageName,AnimType) 
    return {},{}
end

function API.SetCurrentPage(PageName,Page) 
    Page["CurrentPage"] = true
end

function API.DrawPage(PageName,ParentPanel,PageTable,Page) do
    API.clear()
    table.insert(ParentPanel["Iteams"],Page)

end

function API.DrawPages() do
    API.clear()
    

end

function API.GetPageData(PageName)
    return Pages[PageName] 
end

function API.EditPage(PageName,DataTable)
    Pages[PageName]["PageData"] = DataTable
end


function API.Update() 
    Client.GetServerData()

end

API.MakePage("TestPage",API.ButtonPanel(),{})

while true do 
    API.Update()
end


return API