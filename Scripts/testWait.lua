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
