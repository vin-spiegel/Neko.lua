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

--wait함수
function wait(time)
    local callTime = os.clock() + (time / 1000)
    repeat
    until os.clock() > callTime
end

--table메소드 익스텐션
function table.print(t)
    if not t then
        return false
    end

    print("Table = \n{")
    for k, v in pairs(t) do
        print(string.format("\t%s = %s%s", k, v, (k == #t and "") or ","))
    end
    print("}")
end
