--맵타일정보
local wall = {
	{1, 1, 1, 1, 1, 1, 1, 1},
	{1, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 1, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 1, 1, 1},
	{1, 1, 1, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 1, 0, 0, 1},
	{1, 1, 1, 1, 1, 1, 1, 1}
}
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

function isDownScreen(point)
	local me = Client.myPlayerUnit

	--원래 클릭한 좌표
	local pos = {}
	pos.x = string.format("%.2f", (point.x) * 1.01 / 32)
	pos.y = string.format("%.2f", math.abs(point.y) / 32)

	--플레이어가 속한 타일 좌표
	local tile = {}
	tile.x = math.ceil(math.ceil(pos.x * 10) / 10)
	tile.y = math.ceil(math.ceil(pos.y * 10) / 10)
	-- print("클릭한 좌표 : ", pos.x .. "," .. pos.y)
	-- print("클릭한 타일 : " .. tile.x .. " , " .. tile.y)

	--타일에 맞게 좌표 재현
	local vecPos = {}
	vecPos.x = tile.x * 32
	vecPos.y = tile.y * 32

	if not wall[tile.y] or not wall[tile.y][tile.x] then
		print("<color=#FE642E>[#]맵 바깥을 클릭하였습니다.=>return </color>")
		return
	end

	--커서 그리기
	local cursor = Sprite(cursorImg, Rect(vecPos.x - 16, vecPos.y - 16, 32, 32))

	--통행타일 표기
	if wall[tile.y][tile.x] == 1 then
		cursor.color = Color(255, 20, 0, 110)
		print("<color=#FE642E>[#]통행불가 타일</color>")
	elseif wall[tile.y][tile.x] == 0 then
		cursor.color = Color(0, 255, 0, 110)
		print("<color=#3ADF00>[#]통행가능 타일</color>")
	end
	--커서 지우기
	Client.RunLater(
		function()
			cursor.Destroy()
		end,
		0.5
	)
end
Client.RunLater(
	function()
		function isDownAdd(dt)
			--스크린터치 && UI터치 안했을때
			if Input.GetMouseButtonDown(0) and not Input.IsTouchUI(0) then
				local pos = GetMousePoint()
				isDownScreen(pos)
			end
		end
		Client.onTick.Add(isDownAdd)
	end,
	2
)
