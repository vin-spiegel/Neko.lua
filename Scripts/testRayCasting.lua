--셀렉터 리턴 함수
local selectorRatio = 0.00416 --비례 상수
local cursorImg = "Pictures/targetimg.png" -- 커서 경로
function GetMousePoint()
    return Point(
        Camera.position.x - (Camera.orthographicSize * Client.width / Client.height) +
            Input.mousePositionToScreen.x * Camera.orthographicSize * selectorRatio,
        -(Camera.position.y - (Camera.orthographicSize) +
            Input.mousePositionToScreen.y * Camera.orthographicSize * selectorRatio)
    )
end

--버튼 방향 enum
local direction = {
    up = {0, 1}, --0, 1
    down = {0, -1}, --0, -1
    left = {-1, 0}, -- -1, 0
    right = {1, 0} --0, -1
}
--중심점 잡는 함수
function getTilePosition(x, y)
end

function playerGo(dir)
    local me = Client.myPlayerUnit
    local field = Client.field

    --플레이어 좌표 /32
    local pos = {}
    pos.x = string.format("%.2f", me.x / 32)
    pos.y = string.format("%.2f", math.abs(me.y) / 32)

    --플레이어가 속한 타일 좌표
    local tile = {}
    tile.x = math.ceil(pos.x)
    tile.y = math.floor(pos.y + 0.5)

    --타일좌표 기반으로 플레이어 좌표 재현
    local rePos = {}
    rePos.x = (tile.x * 32 - 16) * 1.02252
    rePos.y = -(tile.y * 32 * 0.96625)
    print("이동 전 타일 : " .. tile.x .. " , " .. tile.y)
    print("이동 전 좌표 : " .. me.x .. " , " .. me.y)
    print("좌표 재현 : ", rePos.x, rePos.y)

    if dir and dir == direction.up then
        --위
        me.MoveToPosition(rePos.x, rePos.y + 32)
    elseif dir and dir == direction.down then
        --아래
        me.MoveToPosition(rePos.x, rePos.y - 32)
    elseif dir and dir == direction.left then
        --왼
        me.MoveToPosition(rePos.x - 32, rePos.y)
    elseif dir and dir == direction.right then
        --오
        me.MoveToPosition(rePos.x + 32, rePos.y)
    end
    Client.RunLater(
        function()
            -- me.StopMove()
            -- me.Go(dir[1], dir[2])
            local pos = {}

            pos.x = string.format("%.2f", me.x / 32)
            pos.y = string.format("%.2f", math.abs(me.y) / 32)
            -- print("unit/32좌표 : " .. pos.x .. " , " .. pos.y)
            local tile = {}
            tile.x = math.ceil(pos.x)
            tile.y = math.floor(pos.y + 0.5)
            print("unit현재 타일 : " .. tile.x .. " , " .. tile.y)

            -- print("unit현재 타일 : " .. math.ceil(pos.x / 32), math.floor(math.floor(pos.y) / 32))
        end,
        0.5
    )
end

local controller = {}
function controller:create()
    local mainPanel =
        panel:new {
        rect = Rect(30, -30, 230, 150),
        color = Color(255, 255, 255, 50),
        pivot = Point(0, 1),
        anchor = 6,
        showOnTop = true
    }
    local upButton =
        button:new {
        rect = Rect(0, 0, 70, 70),
        color = Color(150, 0, 0),
        pivotY = 0,
        anchor = 1,
        onClick = function()
            playerGo(direction.up)
        end,
        parent = mainPanel
    }
    local leftButton =
        button:new {
        rect = Rect(0, 0, 70, 70),
        color = Color(150, 0, 0),
        pivot = Point(0, 1),
        anchor = 6,
        onClick = function()
            playerGo(direction.left)
        end,
        parent = mainPanel
    }
    local rightButton =
        button:new {
        rect = Rect(0, 0, 70, 70),
        color = Color(150, 0, 0),
        pivot = Point(1, 1),
        anchor = 8,
        onClick = function()
            playerGo(direction.right)
        end,
        parent = mainPanel
    }
    local downButton =
        button:new {
        rect = Rect(0, 0, 70, 70),
        color = Color(150, 0, 0),
        pivot = Point(0.5, 1),
        anchor = 7,
        onClick = function()
            playerGo(direction.down)
        end,
        parent = mainPanel
    }
end
controller:create()
Client.RunLater(getField, 2)
