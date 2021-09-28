--UI생성 컴포넌트 #__UIcoponent.lua

--컨트롤 클래스 : 멤버변수, 멤버함수 선언
Control = {
    x = 0,
    y = 0,
    width = 100,
    height = 100,
    pivotX = 0.5,
    pivotY = 0.5,
    anchor = 4,
    showOnTop = false
}

--자식 클래스 생성
function Control:init(obj)
    setmetatable(obj, self)
    self.__index = self
    return obj
end

--패널 기본값 정의
panel =
    Control:init {
    type = "Panel",
    width = Client.width * 0.35,
    height = Client.height * 0.75,
    color = Color(0, 0, 0, 150)
}

--그리드패널 기본값
gridPanel =
    Control:init {
    type = "GridPanel",
    width = 100,
    height = 100,
    cellSize = Point(100, 100),
    horizontal = true,
    vertical = true
}

--스크롤패널 기본값
scrollPanel =
    Control:init {
    type = "ScrollPanel",
    width = 100,
    height = 100,
    masked = true,
    horizontal = true,
    vertical = true,
    showHorizontalScrollbar = true,
    showVerticalScrollbar = true
}

--버튼객체 기본값
button =
    Control:init {
    type = "Button",
    width = 80,
    height = 50,
    color = Color(255, 255, 255),
    text = "",
    textColor = Color(0, 0, 0),
    textSize = 16,
    onClick
}

--이미지객체 기본값
image =
    Control:init {
    type = "Image",
    path = "폴더/파일명.png",
    width = 100,
    height = 100,
    imageType = 0,
    fillMethod = 4,
    fillClockwise = true
}

--텍스트 객체 기본값
text =
    Control:init {
    type = "Text",
    text = "기본텍스트",
    color = Color(255, 255, 255),
    width = 100,
    height = 100,
    textAlign = 0,
    textSize = 15,
    showOnTop = true
}

--타입 지정
Control.setType = {
    Panel = function(obj)
        local temp = Panel()
        temp.color = obj.color
        return temp
    end,
    GridPanel = function(obj)
        local temp = GridPanel()
        temp.cellSize = obj.cellSize
        temp.horizontal = obj.horizontal
        temp.vertical = obj.vertical
        return temp
    end,
    ScrollPanel = function(obj)
        local temp = ScrollPanel()
        temp.masked = obj.masked
        temp.horizontal = obj.horizontal
        temp.vertical = obj.vertical
        temp.showHorizontalScrollbar = obj.showHorizontalScrollbar
        temp.showVerticalScrollbar = obj.showVerticalScrollbar
        return temp
    end,
    Button = function(obj)
        local temp = Button(obj.text)
        temp.color = obj.color
        temp.textSize = obj.textSize
        temp.textColor = obj.textColor
        if obj.onClick then
            print("Added onClick function")
            temp.onClick.Add(obj.onClick)
        end
        return temp
    end,
    Image = function(obj)
        local temp = Image(obj.path)
        temp.imageType = obj.imageType
        temp.fillMethod = obj.fillMethod
        temp.fillClockwise = obj.fillClockwise
        return temp
    end,
    Text = function(obj)
        local temp = Text(obj.text)
        temp.textAlign = obj.textAlign
        temp.textSize = obj.textSize
        return temp
    end
}

--객체 생성 멤버함수
function Control:new(obj)
    setmetatable(obj, self)
    self.__index = self

    if not self.setType[obj.type] then
        print("<color=#ff0000>[#]ERROR : type이 잘못 입력되었습니다.</color>")
        return
    end

    local inst = self.setType[obj.type](obj)
    inst.rect = Rect(obj.x, obj.y, obj.width, obj.height)
    inst.pivotX = obj.pivotX
    inst.pivotY = obj.pivotY
    inst.anchor = obj.anchor
    inst.showOnTop = obj.showOnTop

    --객체 부모연결
    if obj.parent then
        obj.parent.AddChild(inst)
    end
    return inst
end
