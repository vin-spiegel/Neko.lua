--method global
--RunLater 재정의
RunLater = function(obj)
    if not obj or type(obj) ~= "table" or type(obj[1]) ~= "function" then
        print("Error : RunLater")
        return
    end

    local _func = obj[1]
    local time = obj.time or 0
    local parameters = {}

    for i = 2, #obj do
        parameters[i - 1] = obj[i]
    end

    Client.RunLater(
        function()
            _func(table.unpack(parameters))
        end,
        time
    )
end

--test
RunLater {
    function(a, b, c)
        print(a, b, c)
    end,
    "a",
    "b",
    "c",
    time = 2
}

--wait 함수
function myCoroutine(t)
    local m = coroutine.running()
    Client.RunLater(
        function()
            coroutine.resume(m)
        end,
        t
    )
    coroutine.yield()
end
co =
    coroutine.create(
    function()
        local function delay(t)
            myCoroutine(t)
        end
        while true do
            print("\n---코루틴 적용---")
            delay(1)
            print("안녕")
            delay(1)
            print("내 이름은 코루틴이야")
            delay(1)
            print("만나서 반가워!")
            delay(1)
            print("^^7")
            delay(3)
            print("\n---코루틴 미적용---")
            print("안녕")
            print("내 이름은 코루틴이야")
            print("만나서 반가워!")
            print("^^7")
            coroutine.yield()
        end
    end
)
