function getField()
    local f = Server.getField(108)
    local unit = f.units[1]

    print("field크기 : " .. f.width, f.height)
    print("unit좌표 : " .. unit.x / 32, unit.y / 32)
    print("unit현재 타일 : " .. math.ceil(unit.x / 32), math.floor(unit.y / 32 + 0.5))
end

-- Server.RunLater(getField, 2)
Server.GetTopic("getField").Add(getField)
