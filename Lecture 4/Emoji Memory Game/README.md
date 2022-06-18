- [Lecture 4 : More MVVM enum Optionals](#lecture-4---more-mvvm-enum-optionals)
  * [View에서의 ViewModel 사용](#view----viewmodel---)
    + [핵심 포인트](#------)
  * [View의 수정](#view----)
    + [핵심 포인트](#-------1)
  * [View에서 ViewModel, Model까지의 영향](#view---viewmodel--model------)
    + [핵심 포인트](#-------2)
  * [대입, 참조](#------)
    + [핵심 포인트](#-------3)
  * [ObservableObject, Published, ObservedObject](#observableobject--published--observedobject)
    + [핵심 포인트](#-------4)
  * [열거형, enum](#-----enum)
    + [핵심 포인트](#-------5)
  * [Optionals](#optionals)
    + [핵심 포인트](#-------6)
  * [firstIndex(where: { })](#firstindex-where------)
    + [핵심 포인트](#-------7)
  * [where …: Equatable](#where----equatable)
    + [핵심 포인트](#-------8)
    
# Lecture 4 : More MVVM enum Optionals
## View에서의 ViewModel 사용
<img width="293" alt="스크린샷 2022-06-18 오후 11 13 32" src="https://user-images.githubusercontent.com/68142821/174442347-d631adb5-543b-4864-8bb3-285168101f09.png">

### 핵심 포인트
1. 
- ViewModel의 직접적인 접근이 필요로 하기 때문에 viewModel 변수를 직접 만들어 주었다.
- 앞으로는 이 변수를 통해서 model과 직접 소통할 수 있을 것이다.
- struct에서는 값을 직접 넣어주지 않아도 해당 파일에서는 오류가 생기지 않지만, 이를 **직접적으로 호출하는 main에서 문제가 발생한다.**
<img width="309" alt="스크린샷 2022-06-18 오후 11 15 24" src="https://user-images.githubusercontent.com/68142821/174442422-788397cf-b040-4607-ad43-2ddeb4055857.png">

- 일반적으로는 선언 시 바로 값을 대입하는 것 보다는, main에서 viewModel을 생성하고, 그것을 대입하는 경우가 많다.
```swift
import SwiftUI

@main
struct Emoji_Memory_GameApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
```


## View의 수정
```swift
struct CardView: View {
    // 여기서는 Model에 직접적으로 접근한다.
    // 또한 let으로 만들어 변경하지 못하도록 하자.
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                // 사각형 내부 값
                shape.fill().foregroundColor(.white)
                //사각형 틀, 이렇게 두 가지 사각형으로 fill, stroke를 지정해야 한다.
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}
```

### 핵심 포인트
1. 
- 모델을 직접적으로 접근하는 이유는, 이 CardView는 model의 Card 구조체를 구현하는 구현체이기 때문이다.
- 따라서 ViewModel의 접근 없이도 바로 가능하게 할 수 있다.
- 하지만 **최소한으로만 제공**하는걸 잊지 말아야 한다.

<img width="493" alt="스크린샷 2022-06-18 오후 11 27 19" src="https://user-images.githubusercontent.com/68142821/174442881-d4235a8a-96b6-41a7-9d9c-179e6081a8c8.png">

2. 
- ForEach에 담긴 구문에서 어떤 배열을 돌릴까에 대한 값을 `viewModel.cards` 으로 변경하니 이와 같은 오류가 생긴다. 
- 이전에 이것에 대해 설명한 적 있다. String, Int와 같은 기본 타입들은 그 안에 이미 Hashable이 구현되어 있어 id키로 \.self를 사용할 수 있었다. 하지만 viewMode.cards의 구현체는 **MemoryGame<String>.Card**이며, 이것이 Hashable을 지원하는지에 대해서는 그 누구도 알 수 없다. 따라서 우리는 card라는 구조체 안에 각각을 구분할 수 있는 **id를 제작해주어야만 한다.**

<img width="257" alt="스크린샷 2022-06-18 오후 11 32 01" src="https://user-images.githubusercontent.com/68142821/174443059-c2e6e914-2ee0-42fc-8cab-17ebd9c0d3d6.png">

그러니 다음과 같이 수정하자.

## View에서 ViewModel, Model까지의 영향
<img width="311" alt="스크린샷 2022-06-18 오후 11 43 11" src="https://user-images.githubusercontent.com/68142821/174443476-b71d63e7-f1fd-4f76-b4a6-8947d24de7ca.png">

view에서 다음과 같이 CardView에 `onTapGesture` 메소드를 추가했다. 이는 viewModel을 따라 타고 들어간다.

<img width="363" alt="스크린샷 2022-06-18 오후 11 44 47" src="https://user-images.githubusercontent.com/68142821/174443546-4d32e463-3f22-4c9e-a845-9a5efdc3d066.png">

또한 viewModel에서는 model를 타고간다.
이는 **view에서부터 model까지의 흐름**을 보여준다.

<img width="618" alt="스크린샷 2022-06-18 오후 11 46 19" src="https://user-images.githubusercontent.com/68142821/174443596-6897d9b5-3ed4-4341-8d93-5735c733e791.png">

이는 model에서의 모습을 보여준다.

### 핵심 포인트
1. 
- 가장 중요한 것은 view에서부터 viewModel의 변수를 타고 결국 model까지의 순서를 타고 들어가는 모습이다.
- 마지막의 `toggle()`은 `isValue = !isValue`와 같은 구문을 사용할 때의 메소드이다.
- 그러나 함수에 대한 모든 인수는 **let인 상수로 취급**되기 때문에 변경할 수 없다. 이와 같은 문제는 아래에서 해결한다.

## 대입, 참조
<img width="327" alt="스크린샷 2022-06-19 오전 12 07 12" src="https://user-images.githubusercontent.com/68142821/174444486-603d6acc-e3ed-4363-a5c8-e2a527c064d2.png">

### 핵심 포인트
1. 
- `choose()`에서는 해당 카드가 들어오면 `index()`으로 보내서 어떤 카드인지 알아낸다.
- 알아낸 카드는 `chosenCard`변수로 받아 `chosenCard`의 isFaceUp상태를 바꾸게 된다.

**이는 작동이 되지 않는다.**

- 이는 값의 대입이 일어나 `chosenCard`의 상태만 바꿀 뿐, 실질적인 card의 값은 바뀌지 않게 되는 것이다. struct와 class의 차이점을 설명할 때에도 강조 했듯이 값의 대입과 참조는 분명하게 구분지어야 한다.

2. 
<img width="322" alt="스크린샷 2022-06-19 오전 12 12 21" src="https://user-images.githubusercontent.com/68142821/174444733-86557c27-559c-4520-84b1-1a365985713e.png">

- 실질적으로 값을 바꾼다고 해도 구조체 내의 변수를 바꿀 수는 없다.
- 그래서 이 함수는 값을 변경할 수도 있는 함수임을 알려야 하며, 그것을 도와주는 것이 바로 **mutating**이다.
- mutating func는 구조체 내의 변수 값을 변경할 수 있다.

**그러나 여기까지 진행해도 화면이 변경되지 않는다!!** 3가지의 키워드로 화면이 변경되게끔 해보고, 이것으로 **MVVM의 성과**를 보려고 노력해보자.

## ObservableObject, Published, ObservedObject
<img width="432" alt="스크린샷 2022-06-19 오전 12 19 50" src="https://user-images.githubusercontent.com/68142821/174445039-3be61273-b42d-4dda-bcff-069efd20da95.png">

### 핵심 포인트
- ViewModel에서는 ObservableObject를 상속시킨다. 이것은 어떠한 **무언가 변경되었음을 global하게 알릴 수 있는 장치**이다.
- `var objectWillChange: ObservableObjectPublisher` 와 같은 문구는 사실상 무시해도 된다. 이 변수가 궁극적으로 global하게 알릴 수 있도록 도움을 주는 장치이며, 다시 말하면 **ViewModel이 Model의 변경사항을 알릴 수 있도록** 하는 것이다.
- 이러한 변수가 있다는 것만 알아두고, model을 선언하는 선언자 앞에 **@Published**만 붙이면 model이 변경되었을 때 자동으로 감지해주는 역할을 할 수 있다.

**이해를 위해 `objectWillChange` 변수를 언급했다. 신경쓰지 말자!**
- 마지막으로 View에서는 viewModel을 선언한 선언문 앞에 @ObservedObject를 입력하면 된다!

## 열거형, enum
### 핵심 포인트
1. 
- 열거형은 다음과 같이 사용할 수 있다.
```swift
enum FastFoodMenuItem {
    case hamburger
    case fried
    case drink
    case cookie
}
```
- 다음과 같이 관련 데이터를 가질 수 있는 특징도 있다.
```swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink
    case cookie
}

enum FryOrderSize {
    case large
    case small
}
```

2. 
- 사용은 다음과 같이 사용한다
```swift
let menuItem = FastFoodMenuItem.hamburger(patties: 2)
// 불가능 : var yetAnotherItem = .cookie
```

3. 
- switch와의 시너지가 좋다.
```swift
switch menuItem {
    case FastFoodMenuItem.hamburger: print("burger")
    case FastFoodMenuItem.fries: print("fries")
}

// or

switch menuItem {
    case .hamburger: print("burger")
    case .fries: print("fries")
}

// or

switch menuItem {
    case .hamburger(let pattyCount): print("\(pattyCount)")
}
```
4. 
- `.allCases`를 사용하면 모든 for in을 반복할 수 있다. 이는 열거형에서 다음 케이스를 가질 수 있도록 도와주는 함수이다.

**실제로 사용했던 부분**
```swift
    enum Size {
        case adaptive(minimum: CGFloat ...)
        case fixed(CGFloat)
        case flexible(minimum: CGFloat ...)
    }
```

## Optionals
### 핵심 포인트
1. 
- 실제 Optional은 다음과 같이 만들어져있다.
```swift
enum Optional<T> {
    case none
    case some(T)
}
```

2. 
- Optional은 해당 변수가 값을 가지지 않을 경우도 포함시켜주는, 즉 nil의 상태값을 가질수 있도록 한다. 예를 들어, 우리는 지금까지 필요 없는 변수를 0으로 초기화 했지만 nil은 0과는 다르다. **아예 존재하지 않는다.**
- 따라서 변수를 사용할 때에는 변수 이름이 `example`이라고 하면 `example!`과 같이 확실이 **이 변수 안에는 값이 있습니다**라는 사실을 알려야 한다. 또는 if let, guard와 같은 키워드로 nil에 대한 출력을 방어할 수 있다.

3. 
<img width="315" alt="스크린샷 2022-06-19 오전 1 54 17" src="https://user-images.githubusercontent.com/68142821/174448734-121b9f0f-5708-4af3-919f-23fed17b5c92.png">

- 따라서 다음과 같이 Int?형을 반환하게 하고, nil이 반환될 수 있음을 알렸다.
- 그러면 이 index 함수를 사용하는 모든 곳에서도 !를 사용하거나, if let / guard를 사용해야 한다. 만약 !를 사용한 상태에서 그 값이 nil인 참사가 벌어진다면,, 그건 **충돌을 일으킨다!!**

<img width="359" alt="스크린샷 2022-06-19 오전 1 55 55" src="https://user-images.githubusercontent.com/68142821/174448767-6cdc91a1-427e-4088-afe2-af994f5cff42.png">

이와 같이 하길 바란다.

## firstIndex(where: { })
<img width="351" alt="스크린샷 2022-06-19 오전 1 59 29" src="https://user-images.githubusercontent.com/68142821/174448888-c4926567-36ed-4316-abd9-6bd8f87d2a45.png">

다음 두 개의 구문을 보고 `index`라는 사용자 정의 함수를 사용하지 않고도 swift 내장 함수를 사용할 수 있다.

<img width="554" alt="스크린샷 2022-06-19 오전 2 04 08" src="https://user-images.githubusercontent.com/68142821/174449113-32b8945a-9c42-4b56-a6c3-5d41c3df465b.png">

### 핵심 포인트
1. 
- `firstIndex()`는 배열의 첫 번째 요소부터 시작해 마지막 요소까지 찾고, 가장 먼저 조건에 부합하는 요소를 반환한다.
- 이와 마찬가지로 `lastIndex()`는 배열의 마지막 요소부터 시작하며, 가장 먼저 조건에 부합하는 요소를 반환한다.

2. 
- $0은 그 전에 사용했던 클로저의 생략 부분과 동일하다. aCard in aCard.id == card.id와 같은 구문을 aCard를 제외하면서, 이 요소가 첫 번째 요소임을 알려주는 $0을 통해 위와 같은 사진이 되었다.

##  where …: Equatable 
<img width="580" alt="스크린샷 2022-06-19 오전 2 15 42" src="https://user-images.githubusercontent.com/68142821/174449460-b22dc706-fb56-4105-9f65-56ac961ba7d5.png">

### 핵심 포인트
1. 
- CardContent끼리의 비교를 진행할 때에 무조건 ==으로 할 수 없다.
- CardContent는 제네릭으로 생성되었기 때문에 그것이 Int라면 서로 비교가 될 수 있겠지만, **그것이 아닌 다른 타입(==으로 비교할 수 없는 타입)이 존재**할 수 있기 때문에 오류가 발생한다.

2. 
- 이는 CardContent가 서로 비교가 가능한 변수라는 것을 알리는 키워드가 필요하다.
- struct 제일 우측과 중괄호 사이에 `where CardContent: Equatable`과 같은 키워드를 넣으면 해결될 수 있다.
