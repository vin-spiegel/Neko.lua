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
--클릭 구현 함수

function isDownScreen(dt, point)
	local me = Client.myPlayerUnit

	local pos = {}
	pos.x = string.format("%.2f", (point.x) * 1.01 / 32)
	pos.y = string.format("%.2f", math.abs(point.y) / 32)

	--플레이어가 속한 타일 좌표
	local tile = {}
	tile.x = math.ceil(math.ceil(pos.x * 10) / 10)
	tile.y = math.ceil(math.ceil(pos.y * 10) / 10)

	print("클릭한 좌표 : ", pos.x .. "," .. pos.y)
	print("클릭한 타일 : " .. tile.x .. " , " .. tile.y)
end
Client.RunLater(
	function()
		function isDownAdd(dt)
			--스크린터치 && UI터치 안했을때
			if Input.GetMouseButtonDown(0) and not Input.IsTouchUI(0) then
				local pos = GetMousePoint()
				isDownScreen(dt, pos)
			end
		end
		Client.onTick.Add(isDownAdd)
	end,
	2
)
