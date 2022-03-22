local component = require("component")
local colors = require("colors")
local term = require("term")
local event = require("event")
local computer = require("computer")
local ExtraData = require("ExtraData")

local API = {}
local Button={}

local Screen  = component.gpu
local w, h = Screen.getResolution()


local Green = ExtraData.rgb(0,255,0)
local Red = ExtraData.rgb(255,0,0)
local Black = ExtraData.rgb(0,0,0)



function API.clear()
    Screen.setBackground(Black)
    Screen.fill(1, 1, w, h, " ")
end
 
function API.ResetAPI()
  Button = {}
  API.clear()
end

function API.GetButtonData(ID)
    return Button[ID]
end

function API.Mouse() 
    local _, _, x, y = event.pull(1,touch)
    if x == nil or y == nil then
        local h, w = Screen.getResolution()
        Screen.set(h, w, ".")
        Screen.set(h, w, " ")
    else 
        for name, data in pairs(Button) do
            if y>=data["Size"]["MinY"]+data["Pos"]["Y"] and  y <= data["Size"]["MaxY"]+data["Pos"]["Y"] then
                if x>=data["Size"]["MinX"]+data["Pos"]["X"] and x<= data["Size"]["MaxX"]+data["Pos"]["X"] then
                    data["Triggerd"] = true
                end
            end
        end
    end

    for name, data in pairs(Button) do
        data["Func"](name,data["Triggerd"])
        data["Triggerd"] = false
    end

end

function API.MakeButton(ID,Pos,Size,Func)
    Button[ID] = {
        ["Triggerd"] = false,
        ["Pos"] = {},
        ["Size"] = {},
        ["Func"] = Func
    }

    ExtraData.AddVector2ToTable(Button[ID]["Pos"],Pos)
    ExtraData.AddVector4ToTable(Button[ID]["Size"],Size)
    local oldColor = Screen.setBackground(Red)
    Screen.fill( 
    Button[ID]["Size"]["MinX"]+Button[ID]["Pos"]["X"],  
    Button[ID]["Size"]["MinY"]+Button[ID]["Pos"]["Y"], 
    (Button[ID]["Size"]["MaxX"]+Button[ID]["Pos"]["X"]- Button[ID]["Size"]["MinX"]+1)-Button[ID]["Pos"]["X"], 
    (Button[ID]["Size"]["MaxY"]+Button[ID]["Pos"]["Y"]- Button[ID]["Size"]["MinY"]+1)-Button[ID]["Pos"]["Y"]
    ," ")
    Screen.setBackground(oldColor)
    
    return Button[ID],ID
end

function API.ChangeColor(ID,Color) 
    local oldColor = Screen.setBackground(Color)
    Screen.fill( 
    Button[ID]["Size"]["MinX"]+Button[ID]["Pos"]["X"],  
    Button[ID]["Size"]["MinY"]+Button[ID]["Pos"]["Y"], 
    ( Button[ID]["Size"]["MaxX"]+Button[ID]["Pos"]["X"]- Button[ID]["Size"]["MinX"]+1)-Button[ID]["Pos"]["X"], 
    ( Button[ID]["Size"]["MaxY"]+Button[ID]["Pos"]["Y"]- Button[ID]["Size"]["MinY"]+1)-Button[ID]["Pos"]["Y"]
    ," ")
    Screen.setBackground(oldColor)
end

return API