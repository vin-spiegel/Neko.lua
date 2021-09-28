callbacks = {}
callbacks.__index = callbacks

function callbacks:Add(_func)
    table.insert(self.funcs, _func)
end

function callbacks:Run(...)
    for _, func in pairs(self.funcs) do
        func(...)
    end
end

callbacks.onEquipItem = {
    funcs = {}
}
setmetatable(callbacks.onEquipItem, callbacks)

callbacks.offEquipItem = {
    funcs = {}
}
setmetatable(callbacks.offEquipItem, callbacks)

local equipItems = {}
function equipItems:funcs()
    self.get = function(unit)
        local equipItems = {}
        for i = 0, 9 do
            local item = unit.GetEquipItem(i)
            if item then
                equipItems[i] = item.id
            else
                equipItems[i] = -1 -- 아이템 장착하지 않음을 -1로 표시
            end
        end
        return equipItems
    end

    self.update = function(unit, nowItems)
        local temp = unit.customData.equipItems
        for i, v in pairs(nowItems) do
            if v ~= temp[i] and v ~= -1 then
                local item = unit.player.GetItem(v)
                callbacks.onEquipItem:Run(unit, item, i)
            end

            if v ~= temp[i] and temp[i] ~= -1 then
                local item = unit.player.GetItem(temp[i])
                callbacks.offEquipItem:Run(unit, item, i)
            end
        end
        unit.customData.equipItems = nowItems
    end

    self.init = function(unit)
        local nowItems = equipItems.get(unit)
        if not unit.customData.equipItems then
            unit.customData.equipItems = nowItems
            return
        else
            self.update(unit, nowItems)
        end
    end
    Server.onRefreshStats.Add(self.init)
end
equipItems:funcs()

--[[
    테스트
--]]
--1번 테스트 함수
function test01(unit, item, slot)
    print("아이템 장착 : ", unit, item, "슬롯 번호 : " .. slot, "아이템 id : " .. item.id)
end
callbacks.onEquipItem:Add(test01)

--2번 테스트 함수
callbacks.offEquipItem:Add(
    function(unit, item, slot)
        print("아이템 해제 : ", unit, item, "슬롯 번호 : " .. slot, "아이템 id : " .. item.id)
    end
)
