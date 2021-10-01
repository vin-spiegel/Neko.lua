--##UI생성 컴포넌트

--컨트롤 클래스 (공용 기본값)
local Control = {
    prototype = {
        x = 0,
        y = 0,
        xy = Point(0, 0),
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
    },
    xy = function(userdata, v)
        userdata.x = v.x
        userdata.y = v.y
        print("xy 호출 : ", userdata.x, userdata.y)
    end,
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

--멤버함수모음
--Rect관련

function Control:Rect(n)
    print("Rect 호출")
end

--객체 set 함수
function Control:set(obj)
    local userdata = self[1] or obj[1]
    if not userdata then
        print("Error: 먼저 obj:new{}로 객체를 생성해주세요.")
        return
    end

    --userdata 객체 값 세팅
    for key, v in pairs(obj) do
        if self[key] and type(self[key]) == "function" then
            print("함수실행")
            self[key](userdata, v)
        elseif self[key] then
            userdata[key] = v
        end
    end

    table.print(self)
end

--네코 객체 생성

--객체 생성및 최초값 설정
function Control:new(var)
    --userdata객체가 없을때 새로 생성
    if self[1] then
        print("이미 객체가 있습니다.")
    end
    --들어온 테이블에 Control 클래스 연결
    local inst = setmetatable({}, self)
    self.__index = self

    --유저데이터 타입 객체 생성
    local userdata = self.newUserData()

    -- --프리셋 설정
    userdata.rect = Rect(self.prototype.x, self.prototype.y, self.prototype.width, self.prototype.height)
    userdata.pivotX, userdata.pivotY = self.prototype.pivotX, self.prototype.pivotY
    userdata.anchor = self.prototype.anchor
    userdata.showOnTop = self.prototype.showOnTop
    userdata.visible = self.prototype.visible

    --인스턴스에 obj키를 가지는 유저데이터 넣어주기
    inst.obj = userdata
    return inst
end

--전역 클래스 정의
--패널 클래스
panel =
    Control:class {
    type = "Panel",
    color = Color(0, 0, 0, 150),
    --유저데이터 생성 함수
    newUserData = function()
        local temp = Panel()
        temp.color = panel.color
        return temp
    end
}
function Control:test()
    print("테스트함수 호출")
    return self
end

function Control:width(n)
    local userdata = self.obj
    if not n then
        return userdata.width
    else
        userdata.width = n
        return self
    end
end
--테스트 코드
Client.RunLater(
    function()
        a =
            panel:new {
            rect = Rect(11, 44, 200, 150),
            xy = Point(22, 33)
        }:test():width(100)
        print(a.type)
    end,
    2
)
