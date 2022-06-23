- [Lecture 6: Protocols Shapes](#lecture-6--protocols-shapes)
  * [protocol](#protocol)
    + [핵심 포인트](#------)
  * [GeometryReader의 좋은 습관](#geometryreader-------)
    + [핵심 포인트](#-------1)
    
# Lecture 6: Protocols Shapes
## protocol
### 핵심 포인트
1. Java의 interfact 역할 수행
- 프로토콜은 **정의 또는 제시**만 할 뿐 스스로 기능을 구현하지 않는다.
- 프로토콜은 다음과 같이 생성한다.

ex 1)
```swift
protocol 프로토콜이름 {
    // definition
}
```
```swift
protocol Student {
    // property is always var
    var height: Double { get set }
    var name: String { get }
    static var schoolNumber: Int { get set }
}
```

ex 2)
```swift
protocol Moveable {
    func move(by: Int)
    var hasMoved: Bool { get }
    var distanceFromStart: Int { get set }
}

protocol Vehicle: Moveable {
    var passengerCount: Int { get set }
}

class Car: Vehicle {
    // must implement move(by:), hasMoved, distanceFromStart and passengerCount
}
```

2. 
- 다음과 같은 상황으로는 드물게 사용된다.
```swift
func travelAround(using moveable: Moveable)
let foo = [Moveable]
```

- 구조체 열거체의 경우에 프로토콜이 많이 이용된다.
```swift
struct EmojiMemoryGameView: View
// or
class EmojiMemoryGame: ObservableObject
```

- 또는 다음과 같은 상황에서도 사용된다.
```swift
init(data: Data) where Data: Collection, Data.Element: Identifiable
```

- **그러나 프로토콜은 코드 공유를 위해서 많이 사용되어진다!!**
- 프로토콜은 extension의 사용으로 **구현**이 가능해진다.
```swift
protocol View {
    var body: some View
}

extension View {
    func foregroundColor(_ color: Color) -> some View { /*implementation*/ }
    func font(_font: Font?) -> some View { /*implementation*/ }
    func blur(radius: CGFloat, opaque: Bool) -> some View { /*implementation*/ }
}
```

- Identifiable은 ID 타입에 Hashable을 주어 간단하게 구별하능한 id를 구현하게끔 도와주었다.
```swift
protocol Identifiable {
    associatedtype ID: Hashable
    var id: ID { get }
}
```

## GeometryReader의 좋은 습관
![image](https://user-images.githubusercontent.com/68142821/175329173-78ada0ed-19c0-46e8-8a5d-dd609da14c08.png)

### 핵심 포인트
1. 
- `VStack`은 Vertical 즉, 수직으로 모든 가능한 자리를 포함한다. 휴대폰의 높이가 100이라고 가정하고, 다른 요소가 없다면 `VStack` 은 100이라는 사이즈를 **그대로 가지게 된다.**
- 저 코드에서는 원래 `LazyVGrid, GeomtryReader`만 존재했었다.
- 왜 VStack과 Spacer을 추가했을까

2. 
- GeometryReader 내부의 LazyVGrid는 크기가 일정하지 않다, 즉, content의 크기 영향을 받아 사이즈가 결정된다.따라서 GeometryReader가 올바른 수행을 하지 못할 수도 있다.
- 따라서 VStack을 넣어 가능한 **모든 크기**를 차지하게 하고, Spacer으로 유연성을 제공했다. -> LazyVGrid에서 사용할 수 있는 공간의 맨 위로 올라갈 것으로 예측하게 도와줌
