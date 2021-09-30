--맵 타일 통행정보 테이블 저장
local Maps = {
	[108] = {
		--#108번 테스트 맵 (8x8)
		{1, 1, 1, 1, 1, 1, 1, 1},
		{1, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 1, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 1, 1, 1},
		{1, 1, 1, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 0, 0, 0, 1},
		{1, 0, 0, 0, 1, 0, 0, 1},
		{1, 1, 1, 1, 1, 1, 1, 1}
	}
}

--타일 통행정보 리턴
function Maps:getWall(fieldID)
	local temp = self[fieldID]
	return temp
end

--클릭 구현 함수
local cursorImg = "Pictures/targetimg.png" -- 커서 경로
function isDownScreen(tile, position)
	local wall = Maps:getWall(Client.field.dataID)

	if not wall[tile.y] or not wall[tile.y][tile.x] then
		print("<color=#FE642E>[#]맵 바깥을 클릭하였습니다.=>return </color>")
		return
	end

	--커서 그리기
	local cursor = Sprite(cursorImg, Rect(position.x - 16, position.y - 16, 32, 32))
	--통행타일 표기
	if wall[tile.y][tile.x] == 1 then
		cursor.color = Color(255, 20, 0, 110)
	elseif wall[tile.y][tile.x] == 0 then
		cursor.color = Color(0, 255, 0, 110)
	end

	--커서 지우기
	Client.RunLater(
		function()
			cursor.Destroy()
		end,
		0.5
	)
end

local selectorRatio = 0.00416 --비례 상수
--커서 좌표 리턴 함수
function GetMousePoint()
	return Point(
		Camera.position.x - (Camera.orthographicSize * Client.width / Client.height) +
			Input.mousePositionToScreen.x * Camera.orthographicSize * selectorRatio,
		-(Camera.position.y - (Camera.orthographicSize) +
			Input.mousePositionToScreen.y * Camera.orthographicSize * selectorRatio)
	)
end

Client.RunLater(
	function()
		function isDownAdd()
			--스크린터치 && UI터치 안했을때
			if Input.GetMouseButtonDown(0) and not Input.IsTouchUI(0) then
				local clickPoint = GetMousePoint() -- 하나 이상 리턴을 받으면 nil나옴 원인을 알 수 없음.

				--타일 좌표
				local tile =
					Point(
					math.ceil(math.ceil((clickPoint.x * 1.01 / 32) * 10) / 10),
					math.ceil(math.ceil((-clickPoint.y / 32) * 10) / 10)
				)

				--타일에 맞게 좌표 재현
				local position = Point(tile.x * 32, tile.y * 32)

				isDownScreen(tile, position)
			end
		end
		Client.onTick.Add(isDownAdd)
	end,
	2
)
