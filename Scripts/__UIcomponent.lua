--##UI생성 컴포넌트

(function()
    --컨트롤 클래스 : 멤버변수, 멤버함수 선언
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
        TopLeft = 0,
        -- TopCenter = 1
        -- TopRight = 2
        -- MiddleLeft = 3
        -- MiddleCenter = 4
        -- MiddleRight = 5
        -- BottomLeft = 6
        -- BottomCenter = 7
        -- BottomRight = 8
        showOnTop = false,
        visible = true
    }

    --자식 클래스 생성 메소드
    function Control:class(obj)
        setmetatable(obj, self)
        self.__index = self
        return obj
    end

    --타입 정의
    function Control:setType()
        --패널 클래스 정의
        panel =
            Control:class {
            type = "Panel",
            color = Color(0, 0, 0, 150)
        }
        self.Panel = function(obj)
            local temp = Panel()
            temp.color = obj.color
            return temp
        end

        --그리드 패널 클래스 정의
        gridPanel =
            Control:class {
            type = "GridPanel",
            cellSize = Point(50, 50),
            horizontal = true,
            vertical = true
        }
        self.GridPanel = function(obj)
            local temp = GridPanel()
            temp.cellSize = obj.cellSize
            temp.horizontal = obj.horizontal
            temp.vertical = obj.vertical
            return temp
        end

        --스크롤 패널 클래스 정의
        scrollPanel =
            Control:class {
            type = "ScrollPanel",
            masked = true,
            horizontal = true,
            vertical = true,
            showHorizontalScrollbar = true,
            showVerticalScrollbar = true
        }
        self.ScrollPanel = function(obj)
            local temp = ScrollPanel()
            temp.masked = obj.masked
            temp.horizontal = obj.horizontal
            temp.vertical = obj.vertical
            temp.showHorizontalScrollbar = obj.showHorizontalScrollbar
            temp.showVerticalScrollbar = obj.showVerticalScrollbar
            return temp
        end

        --버튼 클래스 정의
        button =
            Control:class {
            type = "Button",
            color = Color(255, 255, 255),
            text = "",
            textColor = Color(0, 0, 0),
            textSize = 16,
            textAlign = 5,
            -- UpperLeft = 1,
            -- UpperCenter = 2
            -- UpperRight = 3
            -- MiddleLeft = 4
            -- MiddleCenter = 5
            -- MiddleRight = 6
            -- LowerLeft = 7
            -- LowerCenter = 8
            -- LowerRight = 9
            onClick
        }
        self.Button = function(obj)
            local temp = Button(obj.text)
            temp.color = obj.color
            temp.textSize = obj.textSize
            temp.textColor = obj.textColor
            if obj.onClick then
                temp.onClick.Add(obj.onClick)
            end
            return temp
        end

        --이미지 클래스 정의
        image =
            Control:class {
            type = "Image",
            path = "폴더/파일명.png",
            imageType = 0,
            -- Simple = 0,
            -- Sliced ​​= 1,
            -- Tiled = 2,
            -- Filled = 3
            fillMethod = 4,
            -- 가로 = 0
            -- 세로 = 1
            -- 방사형 90 = 2
            -- 방사형 180 = 3
            -- 방사형 360 = 4
            fillClockwise = true
        }
        self.Image = function(obj)
            local temp = Image(obj.path)
            temp.imageType = obj.imageType
            temp.fillMethod = obj.fillMethod
            temp.fillClockwise = obj.fillClockwise
            return temp
        end

        --텍스트 클래스 정의
        text =
            Control:class {
            type = "Text",
            text = "",
            color = Color(255, 255, 255),
            textAlign = 0,
            textSize = 15
        }
        self.Text = function(obj)
            local temp = Text(obj.text)
            temp.textAlign = obj.textAlign
            temp.textSize = obj.textSize
            return temp
        end
    end
    Control:setType()

    --객체 생성 멤버함수
    function Control:new(obj)
        setmetatable(obj, self)
        self.__index = self
        local inst = self[obj.type](obj)

        --프리셋 설정
        if obj.rect == Control.rect then
            inst.rect = Rect(obj.x, obj.y, obj.width, obj.height)
        else
            inst.rect = obj.rect
        end
        if obj.pivot == Control.pivot then
            inst.pivotX, inst.pivotY = obj.pivotX, obj.pivotY
        else
            inst.pivotX, inst.pivotY = obj.pivot.x, obj.pivot.y
        end
        inst.anchor = obj.anchor
        inst.showOnTop = obj.showOnTop

        --객체 부모연결
        if obj.parent then
            obj.parent.AddChild(inst)
        end

        return inst
    end
end)()
