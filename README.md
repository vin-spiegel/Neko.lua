# Neko.lua 🐱

#### Neko.lua는 네코랜드의 스크립팅을 도와주는 Lua 라이브러리 입니다.

* 네코랜드에서 `고급기능`을 구현하려면, 대부분 `여러개 메소드와 콜백함수를 엮어서 만들어야 했습니다.`
* `이쁘고 멋진 UI`를 만드려면 `클라이언트 스크립트가 굉장히 더러워졌습니다.`
* 네코랜드 개발환경에 조금이라도 도움이 될까 생각하여 조금씩 만들게 되었습니다.

#### 구현된 함수들 💬
- - -

#### Server Scripts
 
  * `callbacks`
    * callbacks.onEquipItem:Add() - 아이템 장착 콜백
    * callbacks.offEquipItem:Add() - 아이템 장착 해제 콜백
  * `Extensions`
    * RunLater{}

#### Client Scripts

  * `Control`
    * panel:new{}
    * gridPanel:new{}
    * scrollPanel:new{}
    * button:new{}
    * image:new{}
    * text:new{}
    
    * Animation:popUp()
    * Animation:popDown()
  * `Extensions`
    * RunLater{}

#### 사용방법 💬
- - -
* `Scripts`폴더와 `ServerScripts`폴더의 스크립트 파일들을 다운로드 받으셔서 파일이 폴더의 가장 위로 정렬되게 해주세요.

* Neko.lua는 `전역 메소드`입니다. 일반적인 모듈과 다르게 `require` 를 지원하지 않습니다.
* 전역으로 정의된 메소드들은 *변수할당, 함수명으로 사용을 할 수 없습니다.*

---
* `Control` : 클라이언트 UI를 생성해주는 클래스입니다.
  * 멤버함수 `new{}`로 선언과 동시에 모든 프로퍼티에 대한 pre-set을 지정할수 있으며, 인스턴스를 반환합니다. 
  * 모든 `Control` 하위 객체들의 pre-set 지정시 키 값을 명시해야합니다.
  
    ```lua
    local mainPanel = panel:new {} -- 프로퍼티를 명시하지 않으면 panel객체에 정의된 기본값으로 객체가 생성됩니다.

    local subPanel = 
      panel:new {
      width = 100, --프로퍼티는 키값을 직접 명시해야 합니다.
      height = 100,
      anchor = 0,
      pivotX = 0.5
      color = Color(0,0,0,150) 
      parent = mainPanel, -- 선언과 동시에 부모 객체를 연결할 수 있습니다.
    }

    local myImg = 
      image:new {
      path = "Icon/001.png"
    }

    local myBtn = 
      button:new {
      text = "닫기버튼", 
      onClick = function()  --`button` 객체의 `onClick` 이벤트 또한 함수로 첨부하여 이벤트 리스너를 생성할 수 있습니다.
        print("클릭하였습니다.") 
      end,
      parent = subPanel
    }
    ```

* `callbacks.onEquipItem`, `callbacks.offEquipItem` : 아이템을 장착하고 벗을때 호출되는 이벤트입니다.
  * 호출될 함수의 인자 형식 : `function(ScriptUnit unit, Titem item, number slot)`

    [1] unit : 이벤트가 일어난 유닛 객체(userdata)

    [2] item : 장착 or 해제한 아이템 객체(userdata)

    [3] slot : 장착 or 해제한 아이템이 있던 캐릭터 슬롯 번호(number)
    ```lua
    --호출될 함수의 인자형식
    function myCallback(unit,item,slot)
      print(unit,item,slot)
    end
    callbacks.onEquipItem:Add(myCallback) -- 아이템을 장착했을 때 호출되는 이벤트를 설정합니다.

    --아이템을 장착 해제했을 때 호출되는 이벤트를 설정합니다.
    callbacks.offEquipItem:Add(
       function(unit, item, slot)
           print("아이템 해제 : ", unit, item, "슬롯 번호 : " .. slot, "아이템 id : " .. item.id)
       end
    )
    ```
* `RunLater` : 일정 시간 후에, 정해진 함수를 실행합니다.
  * Syntax
  ```lua
  RunLater{
   Closure callback,
   time = number,
   parameter...
  }
  ```
  * 예제
  ```lua
  function foo(a,b,c)
    print(a,b,c)
  end
  RunLater{foo,1,2,3,time = 2} --2초뒤 foo함수 실행
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


