local skip = false
local state = false
local dialogue = {}
local index = 1

function dialogue:typing(obj, texts, t)
    obj.visible = true
    local originText = texts

    self.Iterator = function(res)
        if skip or originText == res then
            --스킵 or 끝났을떄
            obj.text = originText
            skip = false
            state = true
            return
        elseif originText == "" then
            return
        end
        local res = res or ""
        res = string.sub(originText, 1, #res + 2)

        --글자반영
        obj.text = res

        Client.RunLater(
            function()
                self.Iterator(res)
            end,
            t * 0.1
        )
    end

    self.Iterator()
end

function dialogue:clear(obj)
end

local mainPanel
local textPanel
function dialogue:create(texts)
    if mainPanel then
        --초기화
        textPanel.text = ""
        skip = false
        state = false
        index = 1
        return mainPanel, textPanel
    end

    mainPanel =
        panel:new {
        rect = Rect(0, 0, Client.width * 0.8, Client.height * 0.3),
        pivotY = 1,
        anchor = 7,
        color = Color(0, 0, 0, 180),
        showOnTop = true
    }

    textPanel =
        text:new {
        rect = Rect(0, 0, mainPanel.width - 40, mainPanel.height - 40),
        parent = mainPanel,
        visible = false
    }

    local skipBtn =
        button:new {
        text = ">>",
        anchor = 5,
        pivot = Point(1, 0.5),
        textColor = Color(255, 255, 255),
        color = Color(0, 0, 0, 0),
        onClick = onClickEvent,
        parent = mainPanel
    }

    skipBtn.onClick.Add(
        function()
            --애니메이션 실행중이라면 애니스킵, 이미 스킵되어있다면 스킵 초기화 하고 다음 인덱스 실행
            if state == false then
                skip = true
                state = true
            elseif state == true then
                state = false
                if texts[index + 1] then
                    index = index + 1
                    dialogue:typing(textPanel, texts[index], 0.2)
                else
                    -- self:popDown()
                    Animation:popDown(mainPanel, 0.1)
                    return
                end
            end
        end
    )

    return mainPanel, textPanel
end

--대화 호출 함수 --global
function Dialogue(texts)
    local mainPanel, textPanel = dialogue:create(texts)
    Animation:popUp(mainPanel, 0.1)
    Client.RunLater(
        function()
            dialogue:typing(textPanel, texts[1], 0.55)
        end,
        0.4
    )
end

--테스트코드
Client.RunLater(
    function()
        Dialogue {
            portrait = false,
            "현재 파이널 시티 주위를 떠도는 괴상한 소문이 있다.",
            "A마을을 넘어 B마을로 건너가는 산길에는 도깨비가 있다고 한다..",
            "주위를 탐방하여 소문의 근원을 확인하자.",
            "어쩌면 진귀한 아이템을 들고있을지도?"
        }
    end,
    2
)
