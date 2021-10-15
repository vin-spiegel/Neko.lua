local callbacks = {
    Add = function(self, _func)
        assert(type(_func) == "function")
        self[self.type].list[tostring(_func)] = _func
    end,
    Remove = function(self, _func)
        assert(type(_func) == "function")
        assert(self[self.type].list[tostring(_func)])
        self[self.type].list[tostring(_func)] = nil
    end,
    execute = function(self, ...)
        local list = self[self.type].list
        for _, callback in pairs(list) do
            if type(callback) == "function" then
                callback(...)
            end
        end
    end,
    onEquipItem = {
        type = "onEquipItem",
        list = {}
    },
    offEquipItem = {
        type = "offEquipItem",
        list = {}
    }
}
callbacks.__index = callbacks
setmetatable(callbacks.onEquipItem, callbacks)
setmetatable(callbacks.offEquipItem, callbacks)

--EquipItem 이벤트리스너
local equipItems = {
    --현재 착용하고 있는 아이템의 고유 id를 테이블로 넘겨줍니다.
    get = function(self, unit)
        local equipItems = {}
        --0~9번 슬롯 아이템 id가 담긴 인스턴스
        for i = 0, 9 do
            local item = unit.GetEquipItem(i)
            if item then
                equipItems[i] = item.id
            else
                equipItems[i] = -1 -- 아이템 장착하지 않음을 -1로 표시
            end
        end
        return equipItems
    end,
    --아이템을 착용하거나 벗을 때 콜백 트리거를 발동
    trigger = function(unit, nowItems)
        local temp = unit.customData.equipItems
        for i = 0, #nowItems do
            --onEquipItem Fire
            if nowItems[i] ~= temp[i] and nowItems[i] ~= -1 then
                callbacks.onEquipItem:execute(unit, unit.player.GetItem(nowItems[i]), i)
            end
            --offEquipItem Fire
            if nowItems[i] ~= temp[i] and temp[i] ~= -1 then
                callbacks.offEquipItem:execute(unit, unit.player.GetItem(temp[i]), i)
            end
        end
        --커스텀 데이터 업데이트
        unit.customData.equipItems = nowItems
    end,
    init = function(self, unit)
        -- print(self, unit)
        local nowItems = self:get(unit) --현재 착용하고있는 아이템
        if not unit.customData.equipItems then
            --접속 후 커스텀 데이터 최초 대입
            unit.customData.equipItems = nowItems
            return
        else
            self.trigger(unit, nowItems)
        end
    end
}
Server.onRefreshStats.Add(
    function(unit)
        equipItems:init(unit)
    end
)

return callbacks
