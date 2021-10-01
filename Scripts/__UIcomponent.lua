--##UI생성 컴포넌트

--컨트롤 클래스 (공용 기본값)
local Control = {
    prototype = {
        x = 0,
        y = 0,
        xy = {0, 0},
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
}

--##########
--멤버함수모음
--##########

--Rect관련

--Rect get/set
function Control:Rect(x, y, width, height)
    local userdata = self.obj
    if type(x) == "number" and type(y) == "number" and type(width) == "number" and type(height) == "number" then
        --set
        userdata.rect = Rect(x, y, width, height)
        return self
    elseif not x and not y and not width and not height then
        --get
        return Rect(userdata.x, userdata.y, userdata.width, userdata.height)
    else
        print("error : 인자 값이 잘못되었습니다.")
    end
end

--height get/set
function Control:height(n)
    local userdata = self.obj
    if not n then
        return userdata.height
    elseif type(n) == "number" then
        userdata.height = n
        return self
    end
end

--x,y point get/set
--@param table point
--@returns userData Point
function Control:xy(point)
    local userdata = self.obj
    if not point then
        return Point(userdata.x, userdata.y)
    elseif type(point) == "table" then
        userdata.x = point[1]
        userdata.y = point[2]
        return self
    end
end

--객체 set 함수
function Control:set(var, inst)
    local userdata
    --최초 생성
    if not var then
        print("Error: 값이 없습니다.")
        return
    elseif inst then
        --inst에 객체가 있을때
        for key, v in pairs(var) do
            if inst[key] then
                inst[key](inst, v)
            end
        end
        return inst
    end

    --self에 객체가 있을때
    for key, v in pairs(var) do
        if self[key] then
            self[key](self, v)
        end
    end
    return self
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

    --들어온 var기준으로 set
    return self:set(var, inst)
end

--가로 길이 get/set
function Control:width(n)
    local userdata = self.obj
    if not n then
        return userdata.width
    elseif type(n) == "number" then
        userdata.width = n
        return self
    end
end

--자식 클래스 생성 메소드
function Control:class(obj)
    setmetatable(obj, self)
    self.__index = self
    return obj
end

--#############
--전역 클래스 정의
--#############

--패널 클래스
panel =
    Control:class {
    type = "Panel",
    --유저데이터 생성 함수
    newUserData = function()
        local temp = Panel()
        --기본값 세팅
        temp.color = Color(0, 0, 0, 155)
        return temp
    end
}

button =
    Control:class {
    type = "Button",
    --유저데이터 생성 함수
    newUserData = function()
        local temp = Button()
        --기본 값 세팅
        temp.color = Color(0, 0, 0, 255)
        return temp
    end
}

--테스트 코드
Client.RunLater(
    function()
        test = panel:new {width = 50, xy = {12, 34}}
        -- test:set {}:Rect(20, 30, 150, 200)
        -- test:width(50):height(50)
    end,
    1
)
