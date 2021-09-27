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

--자식 클래스 생성
function Control:init(obj)
    setmetatable(obj, self)
    self.__index = self
    return obj
end

--패널 기본값 설정
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

--버튼객체 기본값 설정
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

--이미지객체 기본값 설정
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

--test
mainPanel = panel:new {}
mainbtn = button:new {text = "x"}
img = image:new {}
