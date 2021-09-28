# Neko.lua 🐱

#### Neko.lua는 네코랜드의 스크립팅을 도와주는 Lua 라이브러리 입니다.

* 네코랜드에서 `고급기능`을 구현하려면, 대부분 `여러개 메소드와 콜백함수를 엮어서 만들어야 했습니다.`
* `이쁘고 멋진 UI`를 만드려면 `클라이언트 스크립트가 굉장히 더러워졌습니다.`
* 네코랜드 개발환경에 조금이라도 도움이 될까 생각하여 조금씩 만들게 되었습니다.

#### 구현된 함수들 📎
- - -

##### `Server Scripts`
 
  * callbacks
    * callbacks.onEquipItem:Add() - 아이템 장착 콜백
    * callbacks.offEquipItem:Add() - 아이템 장착 해제 콜백

##### `Client Scripts`

  * Control - 컨트롤 하위 객체들은 다음과 같이 사용 가능합니다.
    * panel:new{}
    * gridPanel:new{}
    * scrollPanel:new{}
    * button:new{}
    * image:new{}
    * text:new{}


#### 사용방법 💬
- - -
* `Scripts`폴더와 `ServerScripts`폴더의 스크립트 파일들을 다운로드 받으셔서 파일이 폴더의 가장 위로 정렬되게 해주세요.

* Neko.lua는 전역 메소드입니다. 일반적인 모듈과 다르게 `require` 를 지원하지 않습니다.
* 전역으로 정의된 메소드들은 변수할당, 함수명으로 사용을 할 수 없습니다.

* `button` , `image` , `text` 메소드는 프로퍼티가 재정의 되어 있습니다.
  ```lua
  local myBtn = 
    button:new {
    text="닫기버튼"
  }

  local myImg = 
    image:new {
    path="Icon/001.png"
  }

  local myText = 
    text:new {
    text="텍스트를 입력해주세요."
  }
  ```
* button 객체의 onClick이벤트를 프로퍼티로 첨부하여 생성할 수 있습니다.
  ```lua
  local myBtn = 
    button:new {
    onClick = function() 
      print("클릭하였습니다.") 
    end
  }
  ```
* 모든 Control 하위 객체들은 선언과 동시에 부모 객체를 연결할 수 있습니다.
  ```lua
  local mainPanel = panel:new {}
  local subPanel = 
    panel:new {
    parent=mainPanel
  }
  ```
* onEquipItem과 offEquipItem에 들어가는 인자는 함수입니다.
  ```lua
  --onEquipItem에 함수 추가하기
  function myCallback(unit,item,slot)
    print(unit,item,slot)
  end

  callbacks.onEquipItem:Add(myCallback)

  --offEquipItem 함수 추가 예제
  callbacks.offEquipItem:Add(
     function(unit, item, slot)
         print("아이템 해제 : ", unit, item, "슬롯 번호 : " .. slot, "아이템 id : " .. item.id)
     end
  )
  ```

### 개발자 👾
- - -
`스피겔(Speigel)`

`Discord : SOS#1461`

### 라이센스 ⚖️
- - -
MIT LICENSE Copyright (c) 2021 `스피겔(Spiegel)`

사용 조건
- 라이센스 및 저작권을 고지할것

세부 사항
- 상업적 이용 (O)
- 수정 (O)
- 배포 (O)
- 개인적 이용 (O)
- 법적 책임 및 보증(X)


