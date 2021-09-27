local mainPanel
function Iterator(req, res)
    if skip or type(req) ~= "string" or req == res then
        return
    end

    local res = res or ""
    res = string.sub(req, 1, #res + 2)
    mainPanel.children[1].text = res
    Client.RunLater(
        function()
            Iterator(req, res)
        end,
        0.05
    )
end

function foo()
    mainPanel =
        panel:new {
        width = Client.width * 0.8,
        height = Client.height * 0.3,
        pivotY = 1,
        anchor = 7,
        color = Color(0, 0, 0, 180),
        showOnTop = true
    }
    mainPanel.AddChild(
        text:new {
            text = "괴상한 소문.\nA마을을 넘어 B마을로 건너가는 산길에는 도깨비가 있다고 한다..\n주위를 탐방하여 소문의 근원을 확인하자.",
            width = mainPanel.width - 40,
            height = mainPanel.height - 40
        }
    )
    Iterator(mainPanel.children[1].text)
end
