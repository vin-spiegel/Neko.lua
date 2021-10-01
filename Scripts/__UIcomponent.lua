--##UI생성 컴포넌트

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

--네코 객체 생성
Control.Panel = function(obj)
    local temp = Panel()
    temp.color = obj.color
    return temp
end

--객체 생성 멤버함수
function Control:set(obj)
    if not obj or not type(obj) == "table" then
        print("ERROR : 인자를 테이블로 넘겨주세요")
        return
    end

    --생성된 객체가 없을때
    if self[1] and type(self[1]) == "userdata" then
        print("중복된 객체가 있습니다.")
    end

    --들어온 테이블에 Control 클래스 연결
    setmetatable(obj, self)
    self.__index = self
    --네코객체 생성 후 삽입
    local inst = self[obj.type](obj)
    table.insert(obj, inst)
    --값 설정 후 리턴
    return obj
end

--패널 클래스 정의
panel =
    Control:class {
    type = "Panel",
    color = Color(0, 0, 0, 150)
}

Client.RunLater(
    function()
        a = panel:set {}
        a:set {}
        table.print(a)
    end,
    2
)
