--##UI생성 컴포넌트
--##__UIcomponent.lua

--##컨트롤 클래스
local Control = {
    -- {number,number,number,number} => ScriptRect or self
    Rect = function(self, x, y, width, height)
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
            return
        end
        return self
    end,
    -- {ScriptRect} => ScriptRect or self
    rect = function(self, rec)
        local userdata = self.obj
        if not rec then
            --get
            print("case1")
            return userdata.rect
        elseif tostring(rec) == "Game.Scripts.ScriptRect" then
            --set
            print("case2")
            userdata.rect = rec
            return self
        end
    end,
    --{number or ScriptPoint,number} => ScriptPoint or self
    xy = function(self, x, y)
        local userdata = self.obj
        if not x and not y then
            return Point(userdata.x, userdata.y)
        elseif tostring(x) == "Game.Scripts.ScriptPoint" then
            userdata.x = x.x
            userdata.y = x.y
            return self
        elseif type(x) == "number" and type(y) == "number" then
            userdata.x = x
            userdata.y = y
            return self
        end
    end,
    --{number} => number or self
    x = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.x
        elseif type(n) == "number" then
            userdata.x = n
            return self
        end
    end,
    --{number} => number or self
    y = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.x
        elseif type(n) == "number" then
            userdata.y = n
            return self
        end
    end,
    --{number} => number or self
    width = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.width
        elseif type(n) == "number" then
            userdata.width = n
            return self
        end
    end,
    --{number} => number or self
    height = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.height
        elseif type(n) == "number" then
            userdata.height = n
            return self
        end
    end,
    --{number or ScriptPoint} => ScriptPoint or self
    pivot = function(self, x, y)
        assert(self.obj)
        local userdata = self.obj
        if not x and not y then
            --get
            return Point(userdata.pivotX, userdata.pivotY)
        elseif tostring(x) == "Game.Scripts.ScriptPoint" then
            --set
            userdata.pivotX = x.x
            userdata.pivotY = x.y
            return self
        elseif type(x) == "number" and type(y) == "number" then
            userdata.pivotX = x
            userdata.pivotY = y
            return self
        end
    end,
    --{number} => number or self
    pivotX = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.pivotX
        elseif type(n) == "number" then
            userdata.pivotX = n
            return self
        end
    end,
    --{number} => number or self
    pivotY = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.pivotX
        elseif type(n) == "number" then
            userdata.pivotY = n
            return self
        end
    end,
    --{number} => number or self
    anchor = function(self, n)
        local userdata = self.obj

        if not n then
            return userdata.anchor
        elseif type(n) == "number" then
            userdata.anchor = n
            return self
        end
    end,
    -- {number or userdata, number, number, number}=> ScriptColor or nil
    Color = function(self, r, g, b, a)
        local userdata = self.obj
        if not r and not g and not b and not a then
            --get
            return userdata.color
        elseif tostring(r) == "Game.Scripts.ScriptColor" then
            --set
            userdata.color = r
        elseif type(r) == "number" and type(g) == "number" and type(b) == "number" and type(a) == "number" then
            --set
            userdata.color.a = a
            userdata.color = Color(r, g, b, a)
        elseif type(r) == "number" and type(g) == "number" and type(b) == "number" then
            --set
            userdata.color = Color(r, g, b)
        end
    end,
    -- {number or userdata, number, number, number}=> ScriptColor or nil
    color = function(self, r, g, b, a)
        local userdata = self.obj
        if not r and not g and not b and not a then
            --get
            return userdata.color
        elseif tostring(r) == "Game.Scripts.ScriptColor" then
            --set
            userdata.color = r
        elseif type(r) == "number" and type(g) == "number" and type(b) == "number" and type(a) == "number" then
            --set
            userdata.color.a = a
            userdata.color = Color(r, g, b, a)
        elseif type(r) == "number" and type(g) == "number" and type(b) == "number" then
            --set
            userdata.color = Color(r, g, b)
        end
    end,
    -- {ScriptControl}=> table or self
    children = function(self, obj)
        local userdata = self.obj
        if not obj then
            --get
            return userdata.children
        else
            --set
            if type(obj) == "userdata" then
                userdata.AddChildren(obj)
            elseif type(obj) == "table" and obj.obj then
                local child = obj.obj
                userdata.AddChildren(child)
            end
        end
    end,
    parent = function(self)
    end,
    --{bool} => bool or self
    showOnTop = function(self, bool)
    end,
    --{n} => n or self
    orderIndex = function(self, n)
    end,
    --{ScriptUnit} => self
    attachToUnit = function(self)
    end,
    --{number} => self
    attachToUnitID = function(self)
    end,
    clone = function(self)
    end,
    destroy = function(self)
    end,
    removeChild = function(self)
    end,
    orderToFirst = function(self)
    end,
    orderToLast = function(self)
    end,
    --{table} => self
    set = function(self, var)
        local tablekeys = function()
            local n = 0
            for _, _ in pairs(var) do
                n = n + 1
            end
            return n
        end

        --설정할 프로퍼티 값이 없을 때
        if not var or (type(var) == "table" and tablekeys() == 0) then
            return self
        end

        --객체에 프로퍼티 값 설정
        for key, v in pairs(var) do
            if self[key] then
                self[key](self, v)
            end
        end
        return self
    end,
    --{table} => table
    class = function(self, obj)
        setmetatable(obj, self)
        self.__index = self
        return obj
    end
}

--#############
--전역 클래스 정의
--#############

--##Panel Class
panel =
    Control:class {
    --##set properties func
    --{n or ScriptColor,n,n,n} => ScriptColor or self
    color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --{n or ScriptColor,n,n,n} => ScriptColor or self
    Color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --{bool} => bool or self
    masked = function(self)
        table.print(self)
        return self
    end,
    --
    --##funcs
    loadPage = function(self)
        print(self)
        return self
    end,
    --{table} => self
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = Panel()}, self)
        return self.set(inst, var)
    end
}

--##button Class
button =
    Control:class {
    -- {number or userdata, number, number, number}=> ScriptColor or nil
    Color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    -- {number or userdata, number, number, number}=> ScriptColor or nil
    color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    -- {function} => EventListner or self
    onClick = function(self, _func)
        local userdata = self.obj
        print(self)
        if not _func then
            --get
            return userdata.onClick
        elseif _func and type(_func) == "function" then
            --set
            print("case2")
            userdata.onClick.Add(_func)
            return self
        end
    end,
    -- {string} => string or self
    text = function(self, s)
        local userdata = self.obj
        if not s then
            return userdata.text
        elseif type(s) == "string" then
            userdata.text = s
            return self
        end
    end,
    -- {number} => number or self
    textAlign = function(self, n)
        local userdata = self.obj

        if not n then
            return userdata.textAlign
        elseif type(n) == "number" then
            userdata.textAlign = n
            return self
        end
    end,
    -- {n or ScriptColor, n, n, n}, => number or self
    textColor = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    -- { number } => number or self
    textSize = function(self, n)
        local userdata = self.obj

        if not n then
            return userdata.textSize
        elseif type(n) == "number" then
            userdata.textSize = n
            return self
        end
    end,
    -- { table } => table
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = Button()}, self)
        return self.set(inst, var)
    end
}

--테스트 코드
function testCode()
    local a =
        button:new {
        rect = Rect(300, 150, 100, 100),
        color = Color(255, 0, 0, 200)
        -- pivot = Point(1, 1)
    }:onClick(
        function()
            print("onClick Test")
        end
    )
end
Client.RunLater(testCode, 2)

--##Text Class
text =
    Control:class {
    --{ number or userdata, number, number, number } => ScriptColor or nil
    color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --{ number or userdata, number, number, number } => ScriptColor or nil
    Color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --{ string } => string or nil
    text = function(self, s)
        local userdata = self.obj
        if not s then
            return userdata.text
        elseif type(s) == "string" then
            userdata.text = s
            return self
        end
    end,
    --( number ) => number or nil
    textAlign = function(self, n)
        local userdata = self.obj

        if not n then
            return userdata.textAlign
        elseif type(n) == "number" then
            userdata.textAlign = n
            return self
        end
    end,
    --( number ) => number or nil
    textSize = function(self, n)
        local userdata = self.obj

        if not n then
            return userdata.textSize
        elseif type(n) == "number" then
            userdata.textSize = n
            return self
        end
    end,
    --( table ) => table or nil
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = Text()}, self)
        return self.set(inst, var)
    end
}

gridPanel =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = GridPanel()}, self)
        return self.set(inst, var)
    end
}
inputPanel =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = InputPanel()}, self)
        return self.set(inst, var)
    end
}
image =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = Image()}, self)
        return self.set(inst, var)
    end
}
sprite =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = Sprite()}, self)
        return self.set(inst, var)
    end
}
slider =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.__index = self
        local inst = setmetatable({obj = Slider()}, self)
        return self.set(inst, var)
    end
}
