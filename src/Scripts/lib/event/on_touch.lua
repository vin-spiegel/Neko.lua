local fps = 60 --move이벤트 fps설정

local Screen = {
    --@properties
    callbacks = {}, -- 함수가 담기는 테이블
    x = 0, --커서를 누른 x좌표
    y = 0, --커서를 누른 y좌표
    dx = 0, --커서가 움직인 x좌표
    dy = 0, --커서가 움직인 y좌표
    timer = 0, --온틱 타이머
    fps = math.floor(1 / fps * 100) / 100,
    isDown = false,
    --@functions
    --( number deltaTime ) => nil
    update = function(self, dt)
        --isDown//마우스를 누를 때
        if Input.GetMouseButtonDown(0) then
            self.dx = Input.mousePositionToScreen.x
            self.dy = Input.mousePositionToScreen.y
            local e = {
                state = "begin",
                dx = self.dx,
                dy = self.dy
            }
            --타이머 돌아감
            self:run(e)
            self.isDown = true
        end
        --isMove//커서가 누른채 움직일 때
        self.timer = self.timer + dt
        if
            self.isDown and self.timer > self.fps and --30fps
                (self.dx ~= Input.mousePositionToScreen.x or self.dy ~= Input.mousePositionToScreen.y)
         then
            self.dx = Input.mousePositionToScreen.x
            self.dy = Input.mousePositionToScreen.y
            local e = {
                state = "move",
                dx = self.dx,
                dy = self.dy
            }
            self:run(e)
            self.timer = 0
        end
        --isUp//마우스를 땔 때
        if Input.GetMouseButtonUp(0) then
            self.dx = Input.mousePositionToScreen.x
            self.dy = Input.mousePositionToScreen.y
            local e = {
                state = "end",
                dx = self.dx,
                dy = self.dy
            }
            self:run(e)
            self.isDown = false
        end
    end,
    --( table field : string state, number dx, number dy ) => nil
    run = function(self, e)
        for i = 1, #self.callbacks do
            self.callbacks[i](e)
        end
    end
}

--업데이트 함수 온틱 등록
Client.onTick.Add(
    function(dt)
        Screen:update(dt)
    end
)

--전역 테이블 선언
touchCallback = {}
touchCallback.Add = function(_func)
    assert(type(_func) == "function")
    table.insert(Screen.callbacks, _func)
end

--테스트용 움직이는 패널 예제 입니다.
local mainPanel, btn =
    (function()
    local main = Panel(Rect(Client.width / 2, Client.height / 2, 150, 200))
    main.color = Color(0, 0, 0, 150)
    main.pivotX, main.pivotY = 0, 0
    local btn = Button("버튼1", Rect(0, 0, 64, 64))
    btn.onClick.Add(
        function()
            main.color = Color(rand(1, 255), rand(1, 255), rand(1, 255))
        end
    )
    main.AddChild(btn)
    return main
end)()

--클릭 이벤트 함수
local isDown = false
local pivot = Point(0, 0)
local event = {
    ["begin"] = function(e)
        if
            (e.dx >= mainPanel.x and mainPanel.x + mainPanel.width >= e.dx) and
                (e.dy >= mainPanel.y and mainPanel.y + mainPanel.height >= e.dy) and
                mainPanel.visible
         then
            pivot.x = e.dx - mainPanel.x
            pivot.y = e.dy - mainPanel.y
            isDown = true
        else
            isDown = false
        end
    end,
    ["move"] = function(e)
        if not isDown then
            return
        end
        mainPanel.x = e.dx - pivot.x
        mainPanel.y = e.dy - pivot.y
    end,
    ["end"] = function(e)
        isDown = false
    end
}

Client.RunLater(
    touchCallback.Add(
        function(e)
            event[e.state](e)
        end
    ),
    2
)
