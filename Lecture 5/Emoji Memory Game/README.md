- [Lecture 5 : Properties Layout @ViewBuilder](#lecture-5---properties-layout--viewbuilder)
  * [command + click](#command---click)
    + [핵심 포인트](#------)
  * [typealias](#typealias)
    + [핵심 포인트](#-------1)
  * [여러 가지 코드 리팩토링 하는 방법](#-------------------)
    + [1번 리팩토링](#1------)
    + [2번 리팩토링](#2------)
    + [문제점](#---)
    + [3번 리팩토링](#3------)
    + [핵심 포인트](#-------2)
  * [이름 바꾸기 이슈](#---------)
    
# Lecture 5 : Properties Layout @ViewBuilder
## command + click
### 핵심 포인트
1. 
- rename 기능을 통해서 해당하는 변수 또는 클래스 이름을 전체적으로 변경할 수 있다.
- 주석 처리, 문서 처리, 정의한 곳으로 이동, 정의 타입 등에 대한 정보를 알 수 있다.

## typealias
### 핵심 포인트
1. 
- `typealias Card = MemoryGame<String>.Card`와 같은 문구는 `MemoryGame<String>.Card`라는 하나의 타입을 `Card`라는 타입으로 정의하는 것이다.
- 이는 **코드를 간결하게 하며, 해당 코드 내 공통적인 부분들이 많다면 가독성을 늘려주는 역할**을 한다.

2. 
- 저 타입을 선언한 클래스의 이름이 `EmojiMemoryGame`이라면 다른 클래스 내에서는 해당 이름을 `EmojiMemoryGame.Card`라고 축약할 수 있다.
- 많이 사용하지는 않는다고 한다.. 왜지?

## 여러 가지 코드 리팩토링 하는 방법
### 1번 리팩토링

- `CardView(card: card)`라는 코드가 View에서 사용되고 있었다. 이는 card라는 언어가 반복되어 사용되고 있어서 가독성이 떨어진다. *(나는 그렇게 생각해본 적이 없지만,, 들어보니 그런 것 같기도,,*

<img width="300" alt="스크린샷 2022-06-20 오전 1 13 12" src="https://user-images.githubusercontent.com/68142821/174490309-3738bb5b-9cb3-4970-838a-34398ef0357b.png">

- 실제 카드뷰에서는 저 형태로 받고 있었고, 우리는 이것을 init 초기화 함수로 해결할 수 있다.

<img width="359" alt="스크린샷 2022-06-20 오전 1 13 50" src="https://user-images.githubusercontent.com/68142821/174490335-9c6bf335-ad78-4224-a8c8-c69bd91d3cdb.png">

- init을 사용하여 호출하는 곳에서 **어떠한 인자의 이름이 없이도 받을 수 있도록**하고, 그것을 CardView 내 변수에 직접 입력하게 되면서 그 변수를 **private**으로 선언할 수 있게 되었다.

<img width="358" alt="스크린샷 2022-06-20 오전 1 15 31" src="https://user-images.githubusercontent.com/68142821/174490382-97196e4a-3918-4d6e-ac60-b53dd6d6af06.png">

- 또는 다음과 같이 self 키워드를 사용하여 작업할 수도 있다.

- 그러나 이와 같은 코드 변경은 코드의 줄 수를 더 길어지게 하며, 굳이 할 필요가 없는 행동이라고 한다.. 참고하자!

### 2번 리팩토링

<img width="542" alt="스크린샷 2022-06-20 오전 1 17 49" src="https://user-images.githubusercontent.com/68142821/174490435-a75faef4-ac6c-490f-8eff-555628181476.png">

### 문제점

- `indexOfTheOneAndOnlyFaceUpCard`이라는 변수가 불안정하다. cards와 항상 동기화 되지 않기 때문에 해당 변수의 값이 변경되거나 불러올 때마다 사용 가능한지에 대한 **확정성**을 받아야 한다. 그래서 우리는, 해당 변수를 사용할 때마다 현재 카드가 몇 장 뒤집어져 있는지 확인할 수 있는 **코드를 구현할 것이다.**

<img width="567" alt="스크린샷 2022-06-20 오전 1 37 31" src="https://user-images.githubusercontent.com/68142821/174491301-e51866ec-547c-4e4a-9a5e-f447bc010d89.png">

- 여기서 알아볼 문제들은 더 이상 변수가 아닌 **인라인 함수**로 구현했으며, get{}, set{} 함수를 적절히 사용하여 해당 인라인 함수를 사용할 때 불러오는 법, 세팅하는 법에 대해 마련해 놓았다.
- 또한, set에서는 특별히 `newValue`라는 키워드를 제공한다. 이는 새로 세팅할 값에 대해서 불러올 때에 사용할 수 있다.

**그러나 우리는 이와 같은 작업을 하기 위해 너무 많은 코드를 작성해버렸다!**

그러면 **2번 리팩토링의 결과**인 인라인 함수를 다시 리팩토링 해보자.

### 3번 리팩토링

<img width="578" alt="스크린샷 2022-06-20 오전 1 53 07" src="https://user-images.githubusercontent.com/68142821/174491835-54edc4ce-3086-40d3-b2ac-affffbffcd51.png">

### 핵심 포인트

1. 
- `cards.indices`이란 안전하게 자기 자신에 대한 배열 인덱스 요소를 추출하는 것이다.
- 그 추출된 배열 요소에 `filter()`을 추가하면 해당 조건에 맞는 요소들만 한 번 더 필터를 거쳐서 추출할 수 있다.
- `oneAndOnly`는 `filter()`를 통해 추출된 배열 요소에 추가적인 메소드를 제작해서 넣은 것이다. 따라서 우리는 Array항목에 대한 extension이 필요하다.

<img width="262" alt="스크린샷 2022-06-20 오전 1 57 58" src="https://user-images.githubusercontent.com/68142821/174492053-e6efc18f-ee72-44bb-aced-066e47f13d20.png">

2. 
- `forEach()`는 배열 요소에 대해 루프를 실행하는 명령어이다.
- 즉 한번씩 순회하면서 카드의 `isFaceUp`상태를 업데이트 하기 위해 해당 인라인 함수(indexOfTheOneAndOnlyFaceUpCard)에 들어오는 값이 card의 인덱스 값과 일치하는지 확인한다. 일치하게 되면 **해당 카드의 isFaceUp 상태를 true로 만든다.**

## 이름 바꾸기 이슈
- 내가 어떠한 순서로 이름을 바꾸었는지 기억이 안 난다.
- 하지만 자꾸 계속되는 오류가 있었다.
`The preview provider Content View Previews must belong to at least one target in the current scheme in order to use previews`

- 무언가 자꾸 ContentVIew안에 있는 어떠한 타겟이 속해있지 않다고 하는 것 같지만 코드상에 오류는 없었고 무엇보다 **시뮬레이터에서는 잘 작동한다!!**
- 원인은 ContentView 이름을 EmojiMemoryGameView으로 바꿀 때 **완벽하게 바꾸지 못했나보다.** 이게 내 결론이다.
- 왼쪽 네비게이션 바에 있는 파일들이 모두 출력되는 것인줄 알고있었는데, 이름을 바꾸고도 ContentView라는 녀석이 실제 Finder내에서는 살아있었다,,(네비게이션 바에서는 뜨지 않았음)
- 그 후로 테스트해본 결과 Finder에서 대충 파일 이름을 바꾼 경우 파일 명이 *빨간색으로 보인다거나* 등의 오류가 있었고, Rename을 통해서만 제대로 바꾸어야 겠다는 다짐을 했다.


