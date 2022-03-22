API = {}

function API.Vector4(MinX,MaxX,MinY,MaxY)

    return {["MinX"] = MinX,["MaxX"] = MaxX,["MinY"] = MinY,["MaxY"] = MaxY}
end

function API.Vector2(X,Y)
    return {["X"] = X,["Y"] = Y}
end

function API.rgb(r,g,b)
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return rgb
end

function API.AddVector2ToTable(Table,Vector2)
    Table["X"] = Vector2["X"]
    Table["Y"] = Vector2["Y"]
    return {Table["X"], Table["Y"]}
end


function API.AddVector4ToTable(Table,Vector4)
    Table["MinX"] = Vector4["MinX"]
    Table["MaxX"] = Vector4["MaxX"]
    Table["MinY"] = Vector4["MinY"]
    Table["MaxY"] = Vector4["MaxY"]
    return {Table["MinX"], Table["MaxX"], Table["MinY"],Table["MaxY"]}
end




return API