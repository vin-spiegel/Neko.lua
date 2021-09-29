Animation = {}
function Animation:popUp(obj, t)
    local origin = Point(obj.width, obj.height)
    local sum = Point(math.floor(obj.width * 0.1), math.floor(obj.height * 0.1))

    obj.visible = true
    --자식 객체 비활성화
    if obj.children and #obj.children > 0 then
        -- print("----popUP----")
        for i = 1, #obj.children do
            obj.children[i].visible = false
            -- print(obj.children[i], ":", obj.children[i].visible)
        end
    end

    self.iteratorPopUp = function(res)
        res = res or Point(0, 0)

        --이벤트 끝
        if res.x >= origin.x or res.y >= origin.y then
            --자식 객체 활성화 및 초기화
            obj.width = origin.x
            obj.height = origin.y

            if obj.children and #obj.children > 1 then
                for i = 1, #obj.children do
                    obj.children[i].visible = true
                end
            end
            return
        end

        obj.width = res.x + sum.x
        obj.height = res.y + sum.y
        Client.RunLater(
            function()
                self.iteratorPopUp({x = obj.width, y = obj.height})
            end,
            t * 0.1
        )
    end
    self.iteratorPopUp()
end

function Animation:popDown(obj, t)
    local origin = Point(obj.width, obj.height) -- 참조용 변수
    local sub = Point(math.floor(obj.width * 0.1), math.floor(obj.height * 0.1))

    --자식 객체 비활성화
    if obj.children and #obj.children > 0 then
        -- print("----popDown----")
        for i = 1, #obj.children do
            obj.children[i].visible = false
            -- print(obj.children[i], ":", obj.children[i].visible)
        end
    end

    self.iteratorPopDown = function(res)
        res = res or origin

        --이벤트 끝
        if res.x <= 0 or res.y <= 0 then
            --초기화 후 비활성화
            obj.width = origin.x
            obj.height = origin.y
            obj.visible = false

            return
        end

        obj.width = res.x - sub.x
        obj.height = res.y - sub.y
        Client.RunLater(
            function()
                self.iteratorPopDown({x = obj.width, y = obj.height})
            end,
            t * 0.1
        )
    end
    self.iteratorPopDown()
end

local skip = false
local endTyping = false
local index = 1
function Animation:reset()
    skip = false
    endTyping = false
    index = 1
end
function Animation:typing(obj, texts, t)
    obj.visible = true
    local originText = texts

    self.Iterator = function(res)
        if skip or originText == res or originText == "" then
            --스킵 or 끝났을떄
            obj.text = originText
            endTyping = true
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

function Animation:typingOnClick(mainPanel, textPanel, texts)
    --애니메이션 실행중이라면 애니스킵, 이미 스킵되어있다면 스킵 초기화 하고 다음 인덱스 실행
    if endTyping == false then
        skip = true
    elseif endTyping == true then
        if texts[index + 1] then
            skip = false
            index = index + 1
            Animation:typing(textPanel, texts[index], 0.2)
        else
            Animation:popDown(mainPanel, 0.1)
            return
        end
        skip = false
        endTyping = false
    end
end
