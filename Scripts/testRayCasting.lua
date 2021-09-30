local callBtn =
    button:new {
    rect = Rect(100, 100, 30, 30),
    onClick = function()
        Client.FireEvent("getField")
    end
}
