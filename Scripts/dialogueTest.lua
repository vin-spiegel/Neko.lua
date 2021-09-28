local dialogue = {}
local mainPanel
local textPanel
local skip = false
local state = false
local index = 1

local Animation = {}
function Animation:typing(obj)
    print("타이핑 애니메이션")
end
function Animation:popUp(obj, t)
    local obj = obj
    local origin = Point(obj.width, obj.height)
    local sum = Point(obj.width / 10, obj.height / 10) --증감량
    local t = t * 0.1

    Iterator = function(res)
        res = res or Point(0, 0)

        if res.x >= origin.x or res.y >= origin.y then
            obj.width = origin.x
            obj.height = origin.y
            return
        end

        res.x = res.x + sum.x
        res.y = res.y + sum.y
        obj.width = res.x
        obj.height = res.y
        Client.RunLater(
            function()
                Iterator(res)
            end,
            t
        )
    end
    Iterator()
end
function Animation:popDown(obj, t)
    local obj = obj
    obj.DOScale(Point(0, 0), t)
end

function dialogue:clear()
    skip = false
    state = false
    index = 1
    mainPanel.Destroy()
    mainPanel = nil
    textPanel.Destroy()
    textPanel = nil
end

function dialogue:animation(obj)
    if not obj or type(obj) ~= "string" then
        print("Error: String 타입이 아닙니다.")
        print(obj, type(obj))
        return
    end
    local objText = obj

    self.Iterator = function(res)
        if skip or objText == res then
            textPanel.text = objText
            skip = false
            state = true
            return
        elseif objText == "" then
            return
        end
        local res = res or ""
        res = string.sub(objText, 1, #res + 2)
        textPanel.text = res

        Client.RunLater(
            function()
                self.Iterator(res)
            end,
            0.05
        )
    end

    self.Iterator()
end

--종료함수
function dialogue:popDown()
    if not mainPanel then
        return
    end
    local sum = Point(mainPanel.width / 10, mainPanel.height / 10) --증감량
    textPanel.text = ""
    self.Iterator2 = function(res)
        local res = res or Point(mainPanel.width, mainPanel.height)

        if res.x <= 0 or res.y <= 0 then
            self:clear()
            return
        end
        res.x = res.x - sum.x
        res.y = res.y - sum.y
        mainPanel.width = res.x
        mainPanel.height = res.y
        Client.RunLater(
            function()
                self.Iterator2(res)
            end,
            0.01
        )
    end
    self.Iterator2()
end

function dialogue:create(req)
    local dialogue = req
    if mainPanel then
        return
    end

    mainPanel =
        panel:new {
        width = Client.width * 0.8,
        height = Client.height * 0.3,
        pivotY = 1,
        anchor = 7,
        color = Color(0, 0, 0, 180),
        showOnTop = true
    }
    textPanel =
        text:new {
        -- text = dialogue[index],
        width = mainPanel.width - 40,
        height = mainPanel.height - 40,
        parent = mainPanel
    }
    local skipBtn =
        button:new {
        text = ">>",
        anchor = 5,
        pivotX = 1,
        pivotY = 0.5,
        textColor = Color(255, 255, 255),
        color = Color(0, 0, 0, 0),
        onClick = function()
            --애니메이션 실행중이라면 애니스킵, 이미 스킵되어있다면 스킵 초기화 하고 다음 인덱스 실행
            if state == false then
                skip = true
                state = true
            elseif state == true then
                state = false
                if dialogue[index + 1] then
                    index = index + 1
                    textPanel.text = dialogue[index]
                    self:animation(textPanel.text)
                else
                    self:popDown()
                    return
                end
            end
        end,
        parent = mainPanel
    }

    return mainPanel, textPanel
end

--팝업
function dialogue:popUp(action, text)
    if not mainPanel then
        return
    end
    local startText = text
    local origin = Point(mainPanel.width, mainPanel.height)
    local sum = Point(mainPanel.width / 10, mainPanel.height / 10) --증감량

    Iterator = function(res)
        res = res or Point(0, 0)

        if res.x >= origin.x or res.y >= origin.y then
            mainPanel.width = origin.x
            mainPanel.height = origin.y
            Client.RunLater(
                function()
                    textPanel.text = startText
                    dialogue:animation(textPanel.text)
                end,
                0.2
            )
            return
        end

        res.x = res.x + sum.x
        res.y = res.y + sum.y
        mainPanel.width = res.x
        mainPanel.height = res.y
        Client.RunLater(
            function()
                Iterator(res)
            end,
            0.01
        )
    end
    Iterator()
end

--전역함수
function Dialogue(text)
    local mainPanel, textPanel = dialogue:create(text)
    Animation:popUp(mainPanel, 0.1)
    RunLater {
        Animation.typing,
        textPanel,
        text,
        time = 0.1
    }
    --대사 애니메이션 시작
    -- dialogue:popUp(mainPanel, text[1])
    -- dialogue:animation(textPanel.text)
end

--테스트코드
RunLater {
    Dialogue,
    {
        portrait = false,
        "현재 파이널 시티 주위를 떠도는 괴상한 소문이 있다.",
        "A마을을 넘어 B마을로 건너가는 산길에는 도깨비가 있다고 한다..",
        "주위를 탐방하여 소문의 근원을 확인하자.",
        "어쩌면 진귀한 아이템을 들고있을지도?"
    },
    time = 3
}

-- Client.RunLater(
--     function()
--         Dialogue {
--             portrait = false,
--             "현재 파이널 시티 주위를 떠도는 괴상한 소문이 있다.",
--             "A마을을 넘어 B마을로 건너가는 산길에는 도깨비가 있다고 한다..",
--             "주위를 탐방하여 소문의 근원을 확인하자.",
--             "어쩌면 진귀한 아이템을 들고있을지도?"
--         }
--     end,
--     2
-- )
