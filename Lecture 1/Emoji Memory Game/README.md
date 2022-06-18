# 
# Lecture 1 : Getting Started with SwiftUI
## 타입 추론
```swift
// 1번
return RoundedRectangle(cornerRadius: 25.0)

// 2번
return Text("Hello, world").foregroundColor(.orange).padding()
```
### 핵심 포인트
1. 
- RoundedRectangle에는 **cornerRadius** 라는 label이 담겨있다.
- Text에는 label이 담겨있지 않다.

-> label을 쓰지 않아도 확실히 분별할 수 있을 때에는 Text("~~")와 같이 생략할 수 있다. 하지만 RoundedRectangle은 (25.0)과 같은 문법을 사용할 시에 25.0이 무엇을 가리키는지 알 수 없어서 사용할 수 없는 것이다.

2. 
- foregroundColor(.orange) 는 .orange라는 특이한 문법을 사용한다.

-> swift는 어떠한 클래스나 구조를 **추론** 하는데 최적화 되어 있다. Color.orange라는 것으로 굳이 명시해주지 않아도 swift는 **Color** 라는 클래스를 사용했겠거니 알아서 판단한다!

## 기본 UI
<img width="1453" alt="스크린샷 2022-06-18 오전 1 44 08" src="https://user-images.githubusercontent.com/68142821/174341292-1c7d3b11-87ca-416f-a5f3-e5d75ceef844.png">

### 핵심 포인트
1. 
- 왼쪽에서 해당 코드를 클릭하게 되면 **해당하는 레이블이 미리보기 뷰에서 선택**된다.
- 또한 오른쪽에 속성창을 직접 컨트롤할 수 있는 레이아웃이 출력된다.

## ZStack, 그 외 View
```swift
struct ContentView: View {
    var body: some View {
        ZStack(alignment: .top, content: {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth: 3.0)
            Text("Hello, world!")
                .foregroundColor(.orange)
        })
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}
```

### 핵심 포인트
1. 
- return이 존재하지 않는다.
- 이는 some View라는 명백한 반환 타입이 존재하기 때문에 return이라 명시하지 않아도 됨을 의미한다.

2. 
- ZStack
- Stack이란 무언가 쌓을 수 있는 것을 의미, VStack이란 Vertical Stack을 의미하여 수직으로 쌓아 내리며, HStack이란 Horizontal Stack을 의미하여 수평으로 쌓아가는 과정을 의미함.
- 따라서 ZStack이란 한 레이어 안에 Z축으로 쌓아 올림을 이해하면 되겠다.

3. 
- ZStack에서는 content의 사용이 제일 중요하다.
- 만약 content를 생략하고 싶으면 다음과 같이 사용할 수 있다.
```swift
ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth: 3.0)
            Text("Hello, world!")
                .foregroundColor(.orange)
        })

```
- 속성 값 맨 마지막에 클로저가 오는 경우 다음과 같이 소괄호를 끊고 중괄호로 묶을 수 있다. **이 때에는 label을 명시하지 않아도 된다!**
- 그래서 alignment도 존재하지 않는다면 `ZStack() { ... }` 으로도 가능하고, 더 나아가서 `ZStack { … }` 으로도 생략할 수 있게 된다!

4. 
- `.padding(..)`, `.foregroundColor(..)` 등은 *어디 꼬리표에 붙는가*가 중요하다. ZStack의 꼬리표에 `.padding`이 붙으면 그 안의 요소들은 전체 padding의 효과를 받게된다!
