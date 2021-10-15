--//컨트롤 클래스
local Control = {
    --( table ) => table
    class = function(self, obj)
        setmetatable(obj, self)
        self.__index = self
        return obj
    end,
    --( number, number, number, number ) => ScriptRect or self
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
    --( ScriptRect ) => ScriptRect or self
    rect = function(self, rec)
        local userdata = self.obj
        if not rec then
            --get
            return userdata.rect
        elseif tostring(rec) == "Game.Scripts.ScriptRect" then
            --set
            userdata.rect = rec
            return self
        end
    end,
    --( number or ScriptPoint,number ) => ScriptPoint or self
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
    --( number ) => number or self
    x = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.x
        elseif type(n) == "number" then
            userdata.x = n
            return self
        end
    end,
    --( number ) => number or self
    y = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.x
        elseif type(n) == "number" then
            userdata.y = n
            return self
        end
    end,
    --( number ) => number or self
    width = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.width
        elseif type(n) == "number" then
            userdata.width = n
            return self
        end
    end,
    --( number ) => number or self
    height = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.height
        elseif type(n) == "number" then
            userdata.height = n
            return self
        end
    end,
    --( number or ScriptPoint ) => ScriptPoint or self
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
    --( number ) => number or self
    pivotX = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.pivotX
        elseif type(n) == "number" then
            userdata.pivotX = n
            return self
        end
    end,
    --( number ) => number or self
    pivotY = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.pivotX
        elseif type(n) == "number" then
            userdata.pivotY = n
            return self
        end
    end,
    --( number ) => number or self
    anchor = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.anchor
        elseif type(n) == "number" then
            userdata.anchor = n
            return self
        end
    end,
    --( number or userdata, number, number, number ) => ScriptColor or nil
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
    --( number or userdata, number, number, number ) => ScriptColor or nil
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
    --( ScriptControl ) => table or self
    children = function(self, obj)
        local userdata = self.obj
        if not obj then
            --get
            return userdata.children
        else
            --set
            if type(obj) == "userdata" then
                userdata.AddChild(obj)
            elseif type(obj) == "table" and obj.obj then
                local child = obj.obj
                -- print(child)
                userdata.AddChild(child)
            end
            return self
        end
    end,
    --( ScriptControl ) => table or self
    child = function(self, obj)
        local userdata = self.obj
        if not obj then
            --get
            return userdata.children
        else
            --set
            if type(obj) == "userdata" then
                userdata.AddChild(obj)
            elseif type(obj) == "table" and obj.obj then
                local child = obj.obj
                -- print(child)
                userdata.AddChild(child)
            end
            return self
        end
    end,
    --( ScriptControl ) => ScriptControl or self
    parent = function(self, obj)
        local userdata = self.obj
        if not obj then
            --get
            return userdata.children
        else
            --set
            if type(obj) == "userdata" then
                obj.AddChild(userdata)
            elseif type(obj) == "table" and obj.obj then
                local parent = obj.obj
                parent.AddChild(userdata)
            end
            return self
        end
    end,
    --( bool ) => bool or self
    showOnTop = function(self, bool)
        local userdata = self.obj
        if bool == nil then
            return userdata.showOnTop
        elseif bool == true then
            userdata.bool = true
            return self
        elseif bool == false then
            userdata.bool = false
            return self
        end
    end,
    --( n ) => n or self
    orderIndex = function(self, n)
        assert(self and self.obj)
        if not n then
            return self.obj.GetOrderIndex()
        elseif n and type(n) == "number" then
            userdata.SetOrderIndex(n)
            return self
        end
    end,
    --() => self
    orderToFirst = function(self)
        assert(self and self.obj)
        self.obj.OrderToFirst()
        return self
    end,
    --() => self
    orderToLast = function(self)
        assert(self and self.obj)
        self.obj.OrderToLast()
        return self
    end,
    --**작동안됨
    --( ScriptUnit ) => self
    attachToUnit = function(self, point, unit)
        print("Control.attachToUnit메소드는 현재 사용 불가능합니다.")
        return self
        -- assert(self and self.obj)
        -- assert(point and tostring(point) == "Game.Scripts.ScriptPoint")
        -- assert(
        --     unit and tostring(unit) == "Game.Scripts.ScriptMyPlayerUnit" or tostring(unit) == "Game.Scripts.ScriptUnit"
        -- )
        -- self.obj.AttachToUnit(point, unit)
        -- return self
    end,
    --**작동안됨
    --( number ) => self
    attachToUnitID = function(self, point, id)
        print("Control.attachToUnitID 메소드는 현재 사용 불가능합니다.")
        return self
        -- assert(self and self.obj)
        -- assert(tostring(point) == "Game.Scripts.ScriptPoint")
        -- assert(type(id) == "number")
        -- self.obj.AttachToUnitID(point, id)
        -- return self
    end,
    --() => self
    clone = function(self)
        assert(self and self.obj)
        self.__index = self
        local inst = setmetatable({obj = self.obj.Clone()}, self)
        return inst
    end,
    --() => self
    Clone = function(self)
        assert(self and self.obj)
        self.__index = self
        local inst = setmetatable({obj = self.obj.Clone()}, self)
        return inst
    end,
    --() => self
    destroy = function(self)
        assert(self and self.obj)
        self.obj.Destroy()
        self = nil
        return
    end,
    --() => self
    Destroy = function(self)
        assert(self and self.obj)
        self.obj.Destroy()
        self = nil
        return
    end,
    --(ScriptControl) => self
    removeChild = function(self, child)
        assert(self and self.obj)
        assert(child and (child.obj or type(child) == "userdata"))
        if child.obj then
            print("case1")
            self.obj.RemoveChild(child.obj)
        else
            print("case2")
            self.obj.RemoveChild(child)
        end
        return self
    end,
    --( table ) => self
    set = function(self, var)
        print("set함수")
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
    --( table ) => table
    __call = function(self, var)
        --인스턴스 객체 생성
        assert(self and self.obj == nil)
        self.__index = self
        return self.new(setmetatable({}, self), var)
    end
}
--전역 클래스 정의
--//Class Panel
panel =
    Control:class {
    --##set properties func
    --( n or ScriptColor,n,n,n} => ScriptColor or self
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
    masked = function(self, bool)
        return self
    end,
    --
    loadPage = function(self)
        return self
    end,
    --( table ) => self
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = Panel()
        return self:set(var)
    end
}
--//Class Button
button =
    Control:class {
    --( number or userdata, number, number, number ) => ScriptColor or nil
    Color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --( number or userdata, number, number, number ) => ScriptColor or nil
    color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --( function ) => EventListner or self
    onClick = function(self, _func)
        local userdata = self.obj
        if not _func then
            --get
            return userdata.onClick
        elseif _func and type(_func) == "function" then
            --set
            userdata.onClick.Add(_func)
            return self
        end
    end,
    --( string ) => string or self
    text = function(self, s)
        local userdata = self.obj
        if not s then
            return userdata.text
        elseif type(s) == "string" then
            userdata.text = s
            return self
        end
    end,
    --( number ) => number or self
    textAlign = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.textAlign
        elseif type(n) == "number" then
            userdata.textAlign = n
            return self
        end
    end,
    --( n or ScriptColor, n, n, n ) => number or self
    textColor = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --( number ) => number or self
    textSize = function(self, n)
        local userdata = self.obj
        if not n then
            return userdata.textSize
        elseif type(n) == "number" then
            userdata.textSize = n
            return self
        end
    end,
    --( table ) => table
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = Button(var[1] or "")
        return self:set(var)
    end
}
--##Text Class
text =
    Control:class {
    --( number or userdata, number, number, number ) => ScriptColor or nil
    color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --( number or userdata, number, number, number ) => ScriptColor or nil
    Color = function(self, r, g, b, a)
        local obj = Control.color(self, r, g, b, a)
        return obj or self
    end,
    --( string ) => string or nil
    text = function(self, s)
        print("텍스트설정")
        local userdata = self.obj
        if not s then
            print("case1")
            return userdata.text
        elseif type(s) == "string" then
            print("case2")
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
        local a = var[1] or ""
        self.obj = Text(var[1] or "")
        self.obj.height = 50
        return self:set(var)
        -- return self
    end
}
--##Class GridPanel
gridPanel =
    Control:class {
    cellSize = function(self, point)
    end,
    horizontal = function(self, bool)
    end,
    vertical = function(self, bool)
    end,
    row = function(self, n)
        -- print("행 수정")
        if n then
            self.values.row = n
        else
            return self.values.row
        end
        return self:draw()
    end,
    column = function(self, n)
        -- print("열 수정")
        if n then
            self.values.column = n
        else
            return self.values.row
        end
        return self:draw()
    end,
    padding = function(self, n)
        -- print("패딩 수정")
        if n then
            self.values.padding = n
        else
            return self.values.row
        end
        return self:draw()
    end,
    draw = function(self, userdata)
        local main = self.obj
        local row = self.values.row
        local column = self.values.column
        local padding = self.values.padding
        local cellX = 0
        local cellY = 0
        local cellWidth = (main.width - ((row + 1) * padding)) / row --3
        local cellHeight = (main.height - ((column + 1) * padding)) / column
        --Add
        local c = 1
        for i = 1, row do
            cellX = i * cellWidth - cellWidth + (padding * i)
            for j = 1, column do
                cellY = j * cellHeight - cellHeight + (padding * j)
                local cell = main.children[c]
                if not cell then
                    cell = Panel()
                    main.AddChild(cell)
                end
                cell.rect = Rect(cellX, cellY, cellWidth, cellHeight)
                cell.color = Color(rand(1, 255), rand(1, 255), rand(1, 255), 150)
                c = c + 1
            end
        end
        --Remove
        if column * row < #main.children then
            local temp = {}
            local startIndex = column * row + 1
            for i = startIndex, #main.children do
                temp[i] = main.children[i]
            end
            for i = startIndex, #main.children do
                main.RemoveChild(temp[i])
                temp[i].Destroy()
                temp[i] = nil
            end
            temp = nil
        end
        return self
    end,
    set = function(self, var)
        --오버라이드
        return Control.set(self, var):draw()
    end,
    --( table ) => table
    new = function(self, var)
        assert(self and self.obj == nil)
        --properties
        self.obj = Panel()
        self.values = {
            row = 1,
            column = 1,
            padding = 0,
            cellSize = Point(30, 30)
        }
        --그리드패널 테스트용 초기값 설정
        self.obj.color = Color(100, 0, 0, 150)
        return self:set(var)
    end
}
scrollPanel =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = ScrollPanel()
        return self:set(var)
    end
}
--##Class Sprite
sprite =
    Control:class {
    --( table ) => table
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = Image()
        return self:set(var)
    end
}
--##Class Image
image =
    Control:class {
    --( table ) => table
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = Image()
        return self:set(var)
    end
}
--##Class Slider
slider =
    Control:class {
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = Slider()
        return self:set(var)
    end
}
--##Class InputPanel
inputPanel =
    Control:class {
    --( table ) => table
    new = function(self, var)
        assert(self and self.obj == nil)
        self.obj = InputField()
        return self:set(var)
    end
}
