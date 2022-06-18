- [Lectrue 3 : MVVM](#lectrue-3---mvvm)
  * [MVVM이란?](#mvvm---)
  * [struct, class](#struct--class)
  * [Generics](#generics)
  * [Model](#model)
    + [핵심 포인트](#------)
  * [ViewModel](#viewmodel)
  * [ViewModel 이슈](#viewmodel---)
    + [핵심 포인트](#-------1)

# Lectrue 3 : MVVM
## MVVM이란?
- **Model, View, ViewModel의 줄임말이다.**
- **Model** : UI Independent Data + Logic, “The Truth”
- **View** : Reflects the Model Stateless
- **Model** -> View : data flows this way(i.e. read-only)

- Model의 변경이 View에게 효율적으로 전달되어야 하며, 해당하는 View의 body var으로 이동해야한다.
- 영향을 받는 부분만 전달해야 하고, 발생해야 한다.
- 즉, 여기서 VM의 등장이 필요로 하다.

- **ViewModel**: Binds View to Model Interpreter
- Model과 View의 인터프리터 역할을 수행할 수 있으며, 네트워크에서 들어오는 데이터,  HTTP Request 등을 담당할 수 있다.
- 이는 View, Model의 부하를 막하주며 코드를 간결하게 해준다.
- Model은 철저하게 Model, 원본의 데이터를 수행해야 하며, View에서는 표현될 때 가공이 되어야 하는 경우 **ViewModel에서 수행**할 수 있다.
- 즉 View는 항상 ViewModel을 통해서 데이터를 받아와야 하며 다음과 같은 흐름을 보일 수 있다.

Model -> **(notices changes : Model의 변경사항 감지)** -> ViewModel(publishes “something changed”) -> View(automatically observes publications, pulls data and rebuilds)

- ViewModel은 특정한 View와 연결되었다는 정보가 없기 때문에 변경사항을 감지하면 그것에 대해 global으로 알린다. 그래야 View가 반응할 수 있기 때문이다.

## struct, class
구조체와 클래스는 모두 어떠한 무언가를 **담을 수 있는** 역할을 하며, 언뜻보면 정말 같은 의미로써 사용되는 것 같다. 그러나 공통점과 차이점을 짚어보면서 사용하는 시기에 대해 분석해보는 능력이 필요로하다.

- 둘 다 var, let과 같은 변수를 가질 수 있다.
- 둘 다 func를 가질 수 있다.
- 둘 다 initializers를 가지고 있다.

그러나,
- struct는 **value type**, class는 **reference type**이다.
- 이는 값을 전달할 때에 struct는 하나의 값을 복사하여 붙여넣기하는 식으로 전달하는 것이지만, class의 경우 자신의 메모리 포인터를 전달할 수 있기 때문에 **복사한 변수에서 값이 변경되면, 기존의 클래스에서도 값이 변경!!**된다.
- ViewModel이 **class**로 선언되어야 하는 이유는 무엇일까?
- 바로 모든 View에서 **공통된 값과 메모리**를 참조해야 한다는 것이다.

또한,
- class는 **free initializes**를 제공해준다. 이는 어떤 값이 할당되지 않으면 **오류가 나는 이유**이다.*(자동으로 이니셜라이즈가 존재하여, 값이 없는건 말도 안된다고 생각하나보다.)* struct에서는 직접 initializes를 구현해야 하기 때문에 어떤 값이 대입되어있지 않아도 **오류를 발생시키지 않는다.**

## Generics
```swift
struct Array<Element> {
	func append(_ element: Element) { ... }
}
```

1. 
- Generics는 쉽게 설명하자면, 어떤 타입을 받을 지 모르는 상태에서 사용할 수 있다.
- 예를 들어 Array<String>으로 생성하고 그 변수에 .append(“asd”)를 사용할 수 있듯이, 어떤 타입으로도 `.append`라는 메소드는 받아들일 수 있도록 준비해야 한다.
- 그럴때 사용하는 것이 Generics 타입이다.

## Model
```swift
import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
```

### 핵심 포인트
1. 
-  `cards`는 card의 집합체 모델이다.
- `Array<Card>`에서 Card라는 generics가 들어갔다.

2. 
- `choose()`는 하나의 선택한 카드에 대해 이벤트를 나누는 함수이다.

3. 
- struct Card는 MemoryGame 내부에 있다. 그 이유는 바깥쪽에 Card를 놓으면, 지금과 같은 단일 프로그램일 경우에는 문제가 없겠지만 **프로그램 개수가 많아지면 많아질수록 다른 Card의 의미와 구분이 힘들어질 수**가 있다.
- 이 Card는 MemoryGame에서 사용하는 Card라는 구조체임을 알려야 한다.

4. 
- `content`의 반환형은 `CardContent`이며, 이는  Generics를 사용한 것이다.
- 카드 내 문구가 String일수도, Image일 수도 있기 때문에 struct구조체 이름 옆에 제네릭을 명시해준다.

5. 
- Foundation을 import한다. SwiftUI를 import하지 않는 이유는, model은 view와 아무런 상관없는 것이기 떄문이다. model에서는 view를 관여하지도, 알 필요도 없다.

## ViewModel
```swift
class EmojiMemoryGame {
    
    static var emojis = ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","🪁","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in EmojiMemoryGame.emojis[pairIndex] }
    }
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
```

### 핵심 포인트
1. 
- static에 대한 설명 아래 참조
- 최대한 **10, 200**을 지키려고 노력함
- 여기서 10, 200이란 **하나의 메소드는 10줄 이내로 최대한 정리하고, 총 줄은 200자 밑으로 하는 규칙**을 의미한다.

## ViewModel 이슈
<img width="801" alt="스크린샷 2022-06-18 오후 6 03 19" src="https://user-images.githubusercontent.com/68142821/174430746-66c800f1-8fe7-424d-9d64-15d003e15585.png">

parameter으로 cards를 넘겨주어야 오류가 해결된다고 함.

<img width="340" alt="스크린샷 2022-06-18 오후 6 04 01" src="https://user-images.githubusercontent.com/68142821/174430775-34230f02-8335-4f40-b53b-4d2047bf8106.png">

실제 구조체에서는 cards에 아무런 값이 할당되어 있지 않기 때문에 위와 같은 오류가 발생

### 핵심 포인트
1. 
- 먼저 `private var model: MemoryGame<String> = MemoryGame<String>(cards: cards)`를 하면 되지 않을까 할 수 있음
- 그렇지만 ViewModel에서는 View의 요청을 받아 model으로 가는 입장이다.
- 즉 위와 같은 문구는, **사용자로부터 cards의 요청을 받고 그것을 모델에게 넘긴다는 마인드가** 된다.

2. 
- 그렇기 때문에 Model에서는 init이라는 메소드로 무엇인가 초기화하는 기능이 필요시된다.

<img width="572" alt="스크린샷 2022-06-18 오후 6 12 22" src="https://user-images.githubusercontent.com/68142821/174431070-354373d0-fbf1-4ed0-ad84-7ff4ed143120.png">

다음은 init메소드이다.
- ViewModel으로부터 몇 개의 카드를 생성할 지에 대해 정보를 받아야 하며, 그 다음으로는 그 카드의 내용이 어떤 것들인지에 대해 입력받아야 한다.
- 즉, 여기서도 Model은 **실질적인 데이터를 갖고 있는것도 아니고, 무엇인가 게임에 대해 결정지을 요소(카드를 몇개 생성할 지에 대해)를 갖고 있는것도 아니다.**
- 그 모든 것들은 ViewModel으로 부터 받아야한다!

3. 
<img width="692" alt="스크린샷 2022-06-18 오후 6 16 59" src="https://user-images.githubusercontent.com/68142821/174440334-e0a5a820-23f7-40ac-8747-4ce4e2fb529a.png">

- 다음과 같이 하나의 함수를 만들어 ViewModel에서 Model에게 넘겨줄 수 있다.
- 클로저를 이용해서 다음과 같이 생략할 수 있다.
	
<img width="740" alt="스크린샷 2022-06-18 오후 6 18 40" src="https://user-images.githubusercontent.com/68142821/174440352-669ee436-9bd2-45da-9c68-becf777c0705.png">

4. 
<img width="997" alt="스크린샷 2022-06-18 오후 6 30 22" src="https://user-images.githubusercontent.com/68142821/174440371-16a2e5f3-b721-4fb9-a8ad-f03fecf7567c.png">
	
- View 에 있었던 emojis 변수를 가져와 다음과 같이 ViewModel에 넣고 그것으로 content를 제작한다고 해보자. 그러나 이 또한 오류가 생긴다.
- 이 오류는 어려울 수도 있겠지만 initializes에 관련한 것이다.
	
<img width="1011" alt="스크린샷 2022-06-18 오후 6 31 55" src="https://user-images.githubusercontent.com/68142821/174440380-46f0285f-ea08-433d-9d6e-ca39991a349c.png">
	
- 다음 상황에서도 똑같은 오류가 난다.
- class에서는 a와 b의 선언이 메모리에 올라가 구현된 instance를 사용하는 것이다.
- 즉, 메모리에 올라가지 않으면 instance로 사용하지 못한다는 것이다.
- 그러나 이러한 과정에는 **어떠한 순서가 존재하지 않기** 때문에 a와 b는 c보다 더 늦게 생성될 수 있으며, 그렇기에 c에서는 a와 b를 참조할 수 없다.
- 이것과는 별개로 func안에 있는 요소들은 **자동으로 동기화가 설정되어 순서를 보장받기 때문에 func와 비교하면 안** 된다.
- 즉, emojis를 사용하기 위해서는 `static`이라는 전역 변수로 설정해주어야만 미리 메모리에 올라가고, 이를 사용할 수 있을 것이다.
