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
local GUITable = {}

local Screen  = component.gpu
local w, h = Screen.getResolution()

function API.rgbToHex(r,g,b)
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return rgb
end

function API.Clear()
    Screen.setBackground(ExtraData.rgb(0,0,0))
    Screen.fill(1, 1, w, h, " ")
end

function API.GetButtonPanelData(ID)
    return GUITable[ID]
end


function API.ButtonPanel(ID) 
    GUITable[ID] = {
        ["Panels"] = {},
        ["Items"] = {}
    }
    GUITable[ID]["Panels"] = {
        ["Size"] = ExtraData.Vector4(0,10,0,h*2),
        ["Pos"] = ExtraData.Vector2(0,0),
        ["Color"] = ExtraData.rgb(100,100,100)
    }
    local oldColor = Screen.setBackground(GUITable[ID]["Panels"]["Color"])
    Screen.fill( 
    GUITable[ID]["Panels"]["Size"]["MinX"]+GUITable[ID]["Panels"]["Pos"]["X"],  
    GUITable[ID]["Panels"]["Size"]["MinY"]+GUITable[ID]["Panels"]["Pos"]["Y"], 
    (GUITable[ID]["Panels"]["Size"]["MaxX"]+GUITable[ID]["Panels"]["Pos"]["X"]- GUITable[ID]["Panels"]["Size"]["MinX"]+1)-GUITable[ID]["Panels"]["Pos"]["X"], 
    (GUITable[ID]["Panels"]["Size"]["MaxY"]+GUITable[ID]["Panels"]["Pos"]["Y"]- GUITable[ID]["Panels"]["Size"]["MinY"]+1)-GUITable[ID]["Panels"]["Pos"]["Y"]
    ," ")
    Screen.setBackground(oldColor)
    
    return GUITable[ID] 
end

function API.LoadPageAim(PageName,AnimType) 
    return {},{}
end

function API.SetCurrentPage(PageName) 
    Pages[PageName]["CurrentPage"] = true
end

function API.DrawPage(PageName,ParentPanel,PageTable,Page)
    if ParentPanel["Items"][PageName] == NULL then
        ParentPanel["Items"][PageName] = {}
    end
    local Button = ButtonAPI.MakeButton(PageName,ParentPanel["Panels"][PageName]["Pos"]+ExtraData.Vector2(0,0),ExtraData.Vector4(0,10,0,4),Page["OverRideFunctions"]["ClickFunction"])
    table.insert(ParentPanel["Items"][PageName],Button)
end

function API.GetPageData(PageName)
    return Pages[PageName] 
end

function API.EditPage(PageName,DataTable)
    Pages[PageName]["PageData"] = DataTable
end

function API.PageLoadFunction(PageName,ParentPanel,PageTable,Page) 
    if Page["CurrentPage"] == true then
        Page["PageData"] = PageTable
        API.DrawPage(PageName,ParentPanel,PageTable,Page) 
    else 
        return
    end
end

function API.MakePage(PageName,ParentPanel,PageTable,OverRidePageFunction,OverRideClickedFunction)
    Pages[PageName] = {
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
        },
        ["PageData"] = {}
    }
    local Page = Pages[PageName]
    local Count = 0
    for i,t in pairs(Pages) do
        Count = Count+1
    end
    if Count == 1 then
        Page["CurrentPage"] = true
    else
        Page["CurrentPage"] = false
    end

    if OverRidePageFunction == NULL then
        API.PageLoadFunction(PageName,ParentPanel,PageTable,Page)
    else
        Page["OverRideFunctions"]["PageLoadFunction"] = OverRidePageFunction(PageName,ParentPanel,PageTable,Page)
    end
    if ClickedFunction == NULL then
        Page["OverRideFunctions"]["ClickFunction"] = function(CurrentPage,ClickedPage)
            if CurrentPage == ClickedPage then return end
            if CurrentPage == not ClickedPage then 
                API.SetCurrentPage(PageName) 
                Api.DrawPage(PageName,ParentPanel,PageTable,Page)
            end
        end
    else
        Page["OverRideFunctions"]["ClickFunction"] = ClickedFunction(PageName,ParentPanel,PageTable,Page)
    end

    return Page,PageName
end
