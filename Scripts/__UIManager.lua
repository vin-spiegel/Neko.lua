--컨트롤 클래스 & 기본 설정값
Control = {
    x = 0,
    y = 0,
    pivotX = 0.5,
    pivotY = 0.5,
    anchor = 4,
    color = Color(0, 0, 0, 100),
    showOnTop = false
}

--멤버함수
function Control:Add(parent, child)
    parent.AddChild(child)
end

--자식 클래스 생성
function Control:init(obj)
    setmetatable(obj, self)
    self.__index = self
    return obj
end

--패널 기본값
panel =
    Control:init {
    width = Client.width * 0.35,
    height = Client.height * 0.75
}
function panel:new(obj)
    setmetatable(obj, self)
    self.__index = self

    local temp = Panel(Rect(obj.x, obj.y, obj.width, obj.height))

    temp.pivotX, temp.pivotY = obj.pivotX, obj.pivotY
    temp.anchor = obj.anchor
    temp.showOnTop = obj.showOnTop
    temp.color = obj.color

    return temp
end

--그리드패널 기본값
gridPanel =
    Control:init {
    width = 100,
    height = 100,
    cellSize = Point(100, 100),
    horizontal = true,
    vertical = true
}
function gridPanel:new(obj)
    setmetatable(obj, self)
    self.__index = self

    local temp = Image(obj.path, Rect(obj.x, obj.y, obj.width, obj.height))

    temp.pivotX, temp.pivotY = obj.pivotX, obj.pivotY
    temp.anchor = obj.anchor
    temp.showOnTop = obj.showOnTop

    gridPanel.cellSize = obj.cellSize
    gridPanel.horizontal = obj.horizontal
    gridPanel.vertical = obj.vertical

    return temp
end

--스크롤패널 기본값
scrollPanel =
    Control:init {
    width = 100,
    height = 100,
    masked = true,
    horizontal = true,
    vertical = true,
    showHorizontalScrollbar = true,
    showVerticalScrollbar = true
}
function scrollPanel:new(obj)
    setmetatable(obj, self)
    self.__index = self

    local temp = Image(obj.path, Rect(obj.x, obj.y, obj.width, obj.height))

    temp.pivotX, temp.pivotY = obj.pivotX, obj.pivotY
    temp.anchor = obj.anchor
    temp.showOnTop = obj.showOnTop

    gridPanel.horizontal = obj.horizontal
    gridPanel.vertical = obj.vertical
    gridPanel.showHorizontalScrollbar = obj.showHorizontalScrollbar
    gridPanel.showVerticalScrollbar = obj.showVerticalScrollbar

    return temp
end

--버튼객체 기본값
button =
    Control:init {
    width = 80,
    height = 50,
    color = Color(255, 255, 255),
    text = "",
    textColor = Color(0, 0, 0),
    textSize = 16
}
function button:new(obj)
    setmetatable(obj, self)
    self.__index = self

    local temp = Button(obj.text, Rect(obj.x, obj.y, obj.width, obj.height))

    temp.pivotX, temp.pivotY = obj.pivotX, obj.pivotY
    temp.anchor = obj.anchor
    temp.showOnTop = obj.showOnTop
    temp.color = obj.color
    temp.textSize = obj.textSize
    temp.textColor = obj.textColor

    return temp
end

--이미지객체 기본값
image =
    Control:init {
    path = "폴더/파일명.png",
    width = 100,
    height = 100,
    imageType = 0,
    fillMethod = 4,
    fillClockwise = true
}
function image:new(obj)
    setmetatable(obj, self)
    self.__index = self

    local temp = Image(obj.path, Rect(obj.x, obj.y, obj.width, obj.height))

    temp.pivotX, temp.pivotY = obj.pivotX, obj.pivotY
    temp.anchor = obj.anchor
    temp.showOnTop = obj.showOnTop
    temp.imageType = obj.imageType
    temp.fillMethod = obj.fillMethod
    temp.fillClockwise = obj.fillClockwise

    return temp
end

--텍스트 객체 기본값
text =
    Control:init {
    text = "기본텍스트",
    color = Color(255, 255, 255),
    width = 100,
    height = 100,
    pivotX = 0.5,
    pivotY = 0.5,
    anchor = 4,
    textAlign = 0,
    textSize = 15,
    showOnTop = true
}
function text:new(obj)
    setmetatable(obj, self)
    self.__index = self

    local temp = Text(obj.text, Rect(obj.x, obj.y, obj.width, obj.height))

    temp.pivotX, temp.pivotY = obj.pivotX, obj.pivotY
    temp.anchor = obj.anchor
    temp.showOnTop = obj.showOnTop

    temp.textAlign = obj.textAlign
    temp.textSize = obj.textSize

    return temp
end
