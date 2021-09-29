local dialogue = {}
local mainPanel
local textPanel

function dialogue:create(texts)
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
        rect = Rect(0, 0, mainPanel.width, mainPanel.height),
        color = Color(0, 0, 0, 0),
        parent = mainPanel
    }

    skipBtn.onClick.Add(
        function()
            --애니메이션이 포함되어있는 온클릭 함수
            Animation:typingOnClick(mainPanel, textPanel, texts)
        end
    )
end

--대화 호출 함수 --global
function Dialogue(texts)
    if mainPanel and mainPanel.visible then
        return
    elseif mainPanel and not mainPanel.visible then
        --초기화
        textPanel.text = ""
        Animation:reset()
    elseif not mainPanel then
        dialogue:create(texts)
    end

    Animation:popUp(mainPanel, 0.1)
    Client.RunLater(
        function()
            Animation:typing(textPanel, texts[1], 0.55)
        end,
        0.4
    )
end

--테스트코드
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
