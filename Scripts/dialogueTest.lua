local skip = false

local function textAnimation(obj)
    if tostring(obj) ~= "Game.Scripts.ScriptText" then
        print("Error : 텍스트 객체가 아닙니다.")
        return
    end

    local obj, objText = obj, obj.text

    Iterator = function(res)
        if skip or objText == res then
            obj.text = objText
            skip = false
            return
        end
        local res = res or ""
        res = string.sub(objText, 1, #res + 2)
        obj.text = res

        Client.RunLater(
            function()
                Iterator(res)
            end,
            0.1
        )
    end

    Iterator()
end

function dialogue(textObj)
    local mainPanel =
        panel:new {
        width = Client.width * 0.8,
        height = Client.height * 0.3,
        pivotY = 1,
        anchor = 7,
        color = Color(0, 0, 0, 180),
        showOnTop = true
    }

    local skipBtn =
        button:new {
        text = "skip",
        anchor = 2,
        pivotX = 1,
        pivotY = 1,
        onClick = function()
            print("skip버튼 클릭")
            skip = true
        end,
        parent = mainPanel
    }

    local contentText =
        text:new {
        text = "괴상한 소문.\nA마을을 넘어 B마을로 건너가는 산길에는 도깨비가 있다고 한다..\n주위를 탐방하여 소문의 근원을 확인하자.",
        width = mainPanel.width - 40,
        height = mainPanel.height - 40,
        parent = mainPanel
    }

    textAnimation(contentText)
end
