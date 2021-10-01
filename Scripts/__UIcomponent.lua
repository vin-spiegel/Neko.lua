--##UI생성 컴포넌트

(function()
    --컨트롤 클래스
    local Control = {
        x = 0,
        y = 0,
        width = 100,
        height = 100,
        rect = Rect(0, 0, 100, 100),
        pivotX = 0.5,
        pivotY = 0.5,
        pivot = Point(0.5, 0.5),
        anchor = 4,
        showOnTop = false,
        visible = true
    }

    --자식 클래스 생성 메소드
    function Control:class(obj)
        setmetatable(obj, self)
        self.__index = self
        return obj
    end

    --타입 정의
    function Control:setType()
        --패널 클래스 정의
        panel =
            Control:class {
            type = "Panel",
            color = Color(0, 0, 0, 150)
        }
        self.Panel = function(obj)
            local temp = Panel()
            temp.color = obj.color
            return temp
        end
    end

    --객체 생성 멤버함수
    function Control:new(obj)
        setmetatable(obj, self)
        self.__index = self
        local inst = self[obj.type](obj)

        --프리셋 설정
        if obj.rect == Control.rect then
            inst.rect = Rect(obj.x, obj.y, obj.width, obj.height)
        else
            inst.rect = obj.rect
        end
        if obj.pivot == Control.pivot then
            inst.pivotX, inst.pivotY = obj.pivotX, obj.pivotY
        else
            inst.pivotX, inst.pivotY = obj.pivot.x, obj.pivot.y
        end
        inst.anchor = obj.anchor
        inst.showOnTop = obj.showOnTop
        inst.visible = obj.visible
        -- inst.enable = obj.enable

        --객체 부모연결
        if obj.parent then
            obj.parent.AddChild(inst)
        end

        return inst
    end
end)()
