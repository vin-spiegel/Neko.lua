local mainPanel =
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
        text = "안녕하세요",
        width = mainPanel.width - 40,
        height = mainPanel.height - 40
    }
)
