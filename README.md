# Neko.lua

Neko.lua는 네코랜드의 스크립팅을 도와주는 라이브러리 입니다.
----
* 네코랜드에서 `고급기능`을 구현하려면, 대부분 `여러개 메소드와 콜백함수를 엮어서 만들어야 했습니다.`
* `이쁘고 멋진 UI`를 만드려면 `클라이언트 스크립트가 굉장히 더러워졌습니다.`
* 네코랜드 개발환경에 조금이라도 도움이 될까 생각하여 조금씩 만들게 되었습니다.

사용방법
----
* `Scripts`폴더와 `ServerScripts`폴더의 스크립트 파일들을 다운로드 받으셔서 파일이 폴더의 가장 위로 정렬되게 해주세요.

사용가능 메소드
----
 `Server Scripts`
 ----
  * callbacks
    * callbacks.onEquipItem:Add()
    * callbacks.offEquipItem:Add()

 `Client Scripts`
 ----
  * Control
    * panel:new{}
    * gridPanel:new{}
    * scrollPanel:new{}
    * button:new{}
    * image:new{}
    * text:new{}

라이센스
----
```
Copyright (c) 2021 Spiegel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do
so,subject to the following conditions:

이 소프트웨어의 복제본과 관련된 문서화 파일(“소프트웨어”)을 획득하는 사람은 누구라도 소프트웨어를 별다른 제한 없이 무상으로 사용할 수 있는 권한을 
부여 받는다. 여기에는 소프트웨어의 복제본을 무제한으로 사용, 복제, 수정, 병합, 공표, 배포, 서브라이선스 설정 및 판매할 수 있는 권리와 이상의 
행위를 소프트웨어를 제공받은 다른 수취인들에게 허용할 수 있는 권리가 포함되며, 다음과 같은 조건을 충족시키는 것을 전제로 한다.

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

위와 같은 저작권 안내 문구와 본 허용 문구가 소프트웨어의 모든 복제본 및 중요 부분에 포함되어야 한다.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
THE WARRANTIES OF ERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS 
OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

이 소프트웨어는 상품성, 특정 목적 적합성, 그리고 비침해에 대한 보증을 포함한 어떠한 형태의 보증도 명시적이나 묵시적으로 설정되지 않은 “있는 그대로의” 
상태로 제공된다. 소프트웨어를 개발한 프로그래머나 저작권자는 어떠한 경우에도 소프트웨어나 소프트웨어의 사용 등의 행위와 관련하여 일어나는 
어떤 요구사항이나 손해 및 기타 책임에 대해 계약상, 불법행위 또는 기타 이유로 인한 책임을 지지 않는다.
```