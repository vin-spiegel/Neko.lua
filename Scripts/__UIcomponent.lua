--##UI생성 컴포넌트

--컨트롤 클래스 (공용 기본값)
local Control = {
    x = 0,
    y = 0,
    xy = Point(0, 0),
    --
    width = 100,
    height = 100,
    rect = Rect(0, 0, 100, 100),
    --
    pivotX = 0.5,
    pivotY = 0.5,
    pivot = Point(0.5, 0.5),
    --
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

--네코 객체 생성
Control.Panel = function(obj)
    local temp = Panel()
    temp.color = obj.color
    return temp
end

--객체 생성및 최초값 설정
function Control:set(obj)
    --세팅 함수
    local setting = function(object)
        local userdata = object[1]
        local addOn = {
            xy = function(v)
                userdata.x = v.x
                userdata.y = v.y
                print(userdata.x, userdata.y)
            end
        }
        for key, v in pairs(obj) do
            if addOn[key] then
                addOn[key](v)
            elseif key ~= 1 then
                userdata[key] = v
            end
        end
    end

    --userdata객체가 없을때 새로 생성
    if not self[1] then
        --들어온 테이블에 Control 클래스 연결
        setmetatable(obj, self)
        self.__index = self

        --userdata객체 생성 후 테이블 삽입
        local inst = self[obj.type](obj)

        --프리셋 설정
        inst.rect = Rect(self.x, self.y, self.width, self.height)
        inst.x, inst.y = self.xy.x, self.xy.y
        inst.pivotX, inst.pivotY = self.pivot.x, self.pivot.y
        inst.anchor = self.anchor
        inst.showOnTop = self.showOnTop
        inst.visible = self.visible

        table.insert(obj, inst)
        setting(obj)
        -- print("생성")
        return obj
    else
        -- print("셋")
        setting(self)
    end
end

--전역 클래스 정의
--패널 클래스
panel =
    Control:class {
    type = "Panel",
    color = Color(0, 0, 0, 150)
}

--테스트 코드
Client.RunLater(
    function()
        a =
            panel:set {
            rect = Rect(1, 1, 150, 150),
            xy = Point(1, 1)
        }
        a:set {
            width = 500,
            xy = Point(123, 123)
        }
    end,
    2
)
