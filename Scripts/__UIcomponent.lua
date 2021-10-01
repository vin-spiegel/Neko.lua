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
--멤버함수정의
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

--rect get/set
function Control:rect(rec)
    local userdata = self.obj
    if not rec then
        return userdata.rect
    elseif tostring(rec) == "Game.Scripts.ScriptRect" then
        userdata.rect = rec
        return self
    end
end

--x,y point get/set
--@param table point
--@returns userData Point
function Control:xy(x, y)
    local userdata = self.obj
    if not x and not y then
        return Point(userdata.x, userdata.y)
    elseif type(x) == "table" then
        print("table")
        userdata.x = x.x
        userdata.y = x.y
        return self
    elseif type(x) == "number" and type(y) == "number" then
        print("number")
        userdata.x = x
        userdata.y = y
        return self
    end
end
--x point get/set
function Control:x(n)
    local userdata = self.obj
    if not n then
        return userdata.x
    elseif type(n) == "number" then
        userdata.x = n
        return self
    end
end

--y point get/set
function Control:y(n)
    local userdata = self.obj
    if not n then
        return userdata.x
    elseif type(n) == "number" then
        userdata.y = n
        return self
    end
end

--width get/set
function Control:width(n)
    local userdata = self.obj
    if not n then
        return userdata.width
    elseif type(n) == "number" then
        userdata.width = n
        return self
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

--pivot 관련
--pivot get/set
function Control:pivot(x, y)
    local userdata = self.obj
    if not x and not y then
        return Point(userdata.pivotX, userdata.pivotY)
    elseif tostring(x) == "Game.Scripts.ScriptPoint" then
        userdata.pivotX = x.x
        userdata.pivotY = x.y
        return self
    elseif type(x) == "number" and type(y) == "number" then
        userdata.pivotX = x
        userdata.pivotY = y
        return self
    end
end

--pivotX get/set
function Control:pivotX(n)
    local userdata = self.obj
    if not n then
        return userdata.pivotX
    elseif type(n) == "number" then
        userdata.pivotX = n
        return self
    end
end

--pivotY get/set
function Control:pivotY(n)
    local userdata = self.obj
    if not n then
        return userdata.pivotX
    elseif type(n) == "number" then
        userdata.pivotY = n
        return self
    end
end

--anchor get/set
function Control:anchor(n)
    local userdata = self.obj

    if not n then
        return userdata.anchor
    elseif type(n) == "number" then
        userdata.anchor = n
        return self
    end
end

--color get/set
function Control:color(r, g, b, a)
    local userdata = self.obj

    if not n then
        --get
        return userdata.color
    elseif type(r) == "number" and type(g) == "number" and type(b) == "number" then
        --set
        if type(a) == "number" then
            userdata.color = Color(r, g, b, a)
        else
            userdata.color = Color(r, g, b)
        end
        return self
    end
end

--객체 set 함수
function Control:set(var)
    local tablekeys = function()
        local n = 0
        for _, _ in pairs(var) do
            n = n + 1
        end
        return n
    end

    if not var or (type(var) == "table" and tablekeys() == 0) then
        -- print("Error: 설정할 프로퍼티 값이 없습니다.")
        return self
    end

    --객체에 프로퍼티 값 설정
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
    if self.obj then
        print("error : 이미 객체가 있습니다.")
        return
    end
    --들어온 테이블에 Control 클래스 연결
    local inst = setmetatable({}, self)
    self.__index = self

    --유저데이터 타입 객체 생성
    local userdata = self.newUserData()

    --인스턴스에 obj키를 가지는 유저데이터 넣어주기
    inst.obj = userdata

    --들어온 var기준으로 set
    local a = self.set(inst, var)
    return a
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

--##button Class
button =
    Control:class {
    type = "Button",
    --유저데이터 생성 함수
    newUserData = function()
        return Button()
    end
}
function button:onClick(_func)
    local userdata = self.obj

    if not _func then
        --get
        return userdata.onClick
    elseif type(_func) == "function" then
        --set
        userdata.onClick.Add(_func)
        return self
    end
end
function button:text(s)
    local userdata = self.obj
    if not s then
        return userdata.text
    elseif type(s) == "string" then
        userdata.text = s
        return self
    end
end
function button:textColor(n)
    local userdata = self.obj

    if not n then
        --get
        return userdata.color
    elseif type(r) == "number" and type(g) == "number" and type(b) == "number" then
        --set
        if type(a) == "number" then
            userdata.color = Color(r, g, b, a)
        else
            userdata.color = Color(r, g, b)
        end
        return self
    end
end
function button:textAlign(n)
    local userdata = self.obj

    if not n then
        return userdata.textAlign
    elseif type(n) == "number" then
        userdata.textAlign = n
        return self
    end
end
function button:textSize(n)
    local userdata = self.obj

    if not n then
        return userdata.textSize
    elseif type(n) == "number" then
        userdata.textSize = n
        return self
    end
end

--##color Class
color =
    Control:class {
    type = "Color",
    newUserData = function()
        local temp = Color(0, 0, 0, 0)
        return temp
    end
}
function color:color(r, g, b, a)
    print("칼라객체 접근")
    local obj

    if type(r) == "number" and type(g) == "number" and type(b) == "number" then
        --set
        print("case1")
        if type(a) == "number" then
            print("case3")
            obj = Color(r, g, b, a)
        else
            print("case4")
            obj = Color(r, g, b)
        end
    elseif tostring(r) == "Game.Scripts.ScriptColor" then
        print("case2")
        --set
        obj = r
    end
    return obj
end

--##text Class
text =
    Control:class {
    type = "Text",
    newUserData = function()
        local temp = Text()
        return temp
    end
}
function text:color(r, g, b, a)
    local userdata = self.obj
    if not r then
        --get
        return userdata.color
    else
        userdata.color = color:color(r, g, b, a)
        print(userdata.color.r)
        return self
    end
end
function text:text(s)
    print("텍스트 텍스트")
    local userdata = self.obj
    if not s then
        return userdata.text
    elseif type(s) == "string" then
        userdata.text = s
        return self
    end
end
function text:textAlign(n)
    local userdata = self.obj

    if not n then
        return userdata.textAlign
    elseif type(n) == "number" then
        userdata.textAlign = n
        return self
    end
end
function text:textSize(n)
    local userdata = self.obj

    if not n then
        return userdata.textSize
    elseif type(n) == "number" then
        userdata.textSize = n
        return self
    end
end

function testCode()
    -- local a = button:new {text = "안녕하세요 버튼 텍스트"}
    local b = text:new {text = "안녕하세요 텍스트"}:color(255, 2555, 3)
    -- local a = color:new {}:color()
    -- print(a)
end
--테스트 코드
Client.RunLater(testCode, 1)
