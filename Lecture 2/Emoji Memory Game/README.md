- [Lecture 2 : Getting Started with SwiftUI](#lecture-2---getting-started-with-swiftui)
  * [Previews](#previews)
    + [핵심 포인트](#------)
  * [객체 지향](#-----)
    + [핵심 포인트](#-------1)
  * [새로운 뷰 생성](#--------)
    + [핵심 포인트](#-------2)
  * [View 변수](#view---)
    + [핵심 포인트](#-------3)
    + [핵심 포인트](#-------4)
  * [ForEach](#foreach)
    + [핵심 포인트](#-------5)
  * [코드 정리하는 방법](#----------)
  * [아이콘 사이트](#-------)
  * [LazyVGrid](#lazyvgrid)
    + [핵심 포인트](#-------6)
  * [strokeBorder](#strokeborder)

# Lecture 2 : Getting Started with SwiftUI
## Previews
```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
```

### 핵심 포인트
1. 
- 이 경우는 해당 파일의 이름이 ContentView이어야 한다.
- iOS의 버전이 올라가면서 **dark모드가 탄생**하게 되었기 때문에 두 가지를 직접 테스트 해보고 이상이 없어야 한다.
- 다음과 같은 코드는 미리보기를 두 가지 동시에 볼 수 있도록 한다.

## 객체 지향
```swift
struct ContentView: View {
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(lineWidth: 3.0)
                Text("Hello, world!")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(lineWidth: 3.0)
                Text("Hello, world!")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(lineWidth: 3.0)
                Text("Hello, world!")
            }
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}
```

다음과 같이 코드가 길어지는 경우

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(lineWidth: 3.0)
            Text("Hello, world!")
        }
    }
}
```

다음으로 변경할 수 있음

### 핵심 포인트
1. 
- 코드가 길어질 경우 지저분해지기 때문에, 이를 방지하기 위해 **자주 사용 될 코드는 직접 뷰**로 정의한다.
- 해당 뷰를 직접 생성시에 생기는 문제는 다음 차례에 정리해두었다.


## 새로운 뷰 생성
<img width="472" alt="스크린샷 2022-06-18 오후 12 20 31" src="https://user-images.githubusercontent.com/68142821/174420887-76ce7809-09b0-41d6-b8d1-b1726ecd18aa.png">

### 핵심 포인트
1. 
- 다음과 같이 struct안의 어떤 값이 초기화 되지 않았을 시, 해당 구조체를 사용하기 위해서는 **파라미터 값**을 넘겨주어야만 한다!
- CardView 내에서 해당 값을 초기화하게 되면 사용할 때 굳이 파라미터를 넘겨줄 필요가 없다.
- `var isFaceUp: Bool = true`으로 지정하는 경우 isFaceUp은 **true**라는 값을 통해 Bool값을 유추할 수 있다. 이는 `var isFaceUp = true`로 사용할 수 있다.

2. 
```swift
ZStack {
	if isFaceUp {
		RoundedRectangle(cornerRadius: 20.0)
			.fill()
			.foregroundColor(.white)
                
		RoundedRectangle(cornerRadius: 20.0)
			.stroke(lineWidth: 3)
		Text("😀")
			.font(.largeTitle)
		} else {
			RoundedRectangle(cornerRadius: 20)
			.fill()
		}
	}
}
```
- 다음과 같이 `RoundedRectangle(cornerRadius: 20.0)`의 사용이 잦아지는 경우 이도 `let shape = RoundedRectangle(cornerRadius: 20.0)`와 같이 정리해서 사용할 수 있다. 
- 위와 같이 shape에 타입을 지정하지 않은 이유도 스위프트가 알아서 타입추론을 하는 경우이기 때문이다.

## View 변수
<img width="650" alt="스크린샷 2022-06-18 오후 12 32 28" src="https://user-images.githubusercontent.com/68142821/174421296-b9e826e7-2ed5-4b86-bde1-5d4dfc1a9879.png">


### 핵심 포인트
1. 
- var와 let의 차이는 상수가 아닌지, 상수인지에 대한 논리이다. 즉 `var something = 1`의 값은 언제든 변경이 가능하지만, let으로 생성하면 변경이 불가능 하다.
- 다음과 같은 오류가 출력되는 이유는 **스위프트에서는 뷰가 변경될 수 없기 때문**이다.
- 따라서 변경될 수 있음을 알리는 어떠한 장치가 필요하다.

2. 
- `@State var isFaceUp: Bool = true`으로 상태프로퍼티를 붙이면 해당 값은 변경이 가능한 상태로 파악한다.

<img width="310" alt="스크린샷 2022-06-18 오후 12 41 37" src="https://user-images.githubusercontent.com/68142821/174421540-1312422e-dd78-41bd-ab6c-f2d86ceae1f8.png">

### 핵심 포인트
1. 
- 이와 같이 해당 문자를 집어넣을 수 있다.
- 그런데 이처럼 사용하지는 않는다. 너무나도 많은 수고가 들어가고, **무엇보다도 유지보수가 어렵다.**

## ForEach
<img width="433" alt="스크린샷 2022-06-18 오후 12 46 51" src="https://user-images.githubusercontent.com/68142821/174421666-abab7788-21b6-4e48-8799-724335f32613.png">

물론 다음과 같이 수정 가능하다.

<img width="373" alt="스크린샷 2022-06-18 오후 12 47 18" src="https://user-images.githubusercontent.com/68142821/174421684-a4151f3c-aa5f-429c-95e1-d795dfc89e7f.png">

### 핵심 포인트
1. 
- `id:\.self`를 집어넣지 않으면 ForEach로 생성될 때 각자가 어떠한 값으로 비교되어야 하는지 파악할 수 없다.
- String으로 생성된 배열이기 때문에 예를 들어 [“1”, “1”, “2”]와 값이 같을 때 첫번째의 1과 두번째의 1을 구분할 방법이 존재하지 않는다!
2. **추가 정보**
- Int, String, Float 등과 같은 녀석들은 Hashable이 구현되어 있다. 이 말은 즉슨, id값으로 직접 우리가 변수를 생성하지 않아도, ForEach의 id 값에 \.self만 넣어주어도 작동한다는 의미이다.
- 그러나 Hashable이 구현되지 않은 어떤 사용자 정의 클래스일때에는 오류가 발생하게 된다.
- 방금은 String이기 때문에 swift에서 제공하는 Hashable이 존재하며, 이를 구분할 수 있게 되었다.

이모지 변수 만들기 귀찮으면 다음을 복사하길 바란다.
```swift
var emojis = ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","🪁","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
```


## 코드 정리하는 방법
```swift
struct ContentView: View {
    var emojis = ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","🪁","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            HStack {
				  // 여기의 버튼을 새로운 뷰로 제작
                Button(action: {
                    emojiCount += 1
                }, label: {
                    VStack {
                        Text("Remove")
                        Text("Card")
                    }
                })
                Spacer()
				  // 여기의 버튼을 새로운 뷰로 제작
                Button(action: {
                    emojiCount -= 1
                }, label: {
                    VStack {
                        Text("Add")
                        Text("Card")
                    }
                })
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}
```

변경 후 다음과 같다.

```swift
struct ContentView: View {
    var emojis = ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","🪁","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
            }
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
    
    var remove: some View {
        Button(action: {
            emojiCount += 1
        }, label: {
            VStack {
                Text("Remove")
                Text("Card")
            }
        })
    }
    
    var add: some View {
        Button(action: {
            emojiCount -= 1
        }, label: {
            VStack {
                Text("Add")
                Text("Card")
            }
        })
    }
}
```

더 길어진 것 같지만,, 보기에는 깔끔하다!

## 아이콘 사이트
[여기]([SF Symbols - Apple Developer](https://developer.apple.com/sf-symbols/))로 가면 다양한 아이콘을 볼 수 있고, 이미지로써 사용할 수 있다. 많은 사용 바란다.

```swift
	var remove: some View {
        Button(action: {
            emojiCount += 1
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            emojiCount -= 1
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
```

## LazyVGrid
<img width="469" alt="스크린샷 2022-06-18 오후 1 13 48" src="https://user-images.githubusercontent.com/68142821/174422349-6860bb42-ac74-481f-97f7-568b734f3fc4.png">

### 핵심 포인트
1. 
- column값에는 숫자를 집어넣어도 된다. `column: 3`과 같이.
- 그러나 사진과 같이 사용하면, 해당 컬럼에 대한 설정이나 크기, 공간 등을 세부하게 설정할 수 있다.
- HStack, VStack의 경우 **자신에게 주어진 모든 공간을 할당**하는 특징을 가지고 있어 VStack의 예시로 들면, 높이 100이 주어지면 100을 전체 다 사용한다.
- 그러나 LazyVGrid의 경우는 안의 내용물의 크기에 영향을 받아 container을 형성하기 때문에 그러한 차이가 있다는 것을 알아두면 좋겠다.
- 위의 사진에서 `CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)`와 같이 aspectRatio속성을 추가하면, 카드의 크기 비율을 유지하며 적절한 카드 크기를 제공할 수 있다.

2. 속성 값
- adaptive: (LazyVGrid의 경우) minimum 값 이상의 사이즈로 열마다 가능한 많이 아이템들을 배치하고자 할 때 사용되는 사이즈.
* flexible: (LazyVGrid의 경우) minimum 값 이상의 사이즈로 column 수를 조절 하고 싶을 때 사용되는 사이즈. adaptive와 유사하나 열마다 배치되는 아이템 수를 조절할 수 있다는 점
* fixed: (LazyVGrid의 경우) column 수와 크기를 직접 조절하고 싶을 때 사용하는 사이즈.
[출처]([SwiftUI GridView 그리기 - Jaesung_0o0 - Medium](https://jaesung0o0.medium.com/swiftui-gridview-%EA%B7%B8%EB%A6%AC%EA%B8%B0-2f399c9d754c))


## strokeBorder
- stroke()는 두꺼워질수록 화면을 벗어날 수 있는 소지가 존재하지만, strokeBorder는 화면 해상도로부터 안전하게 지켜주며, 안쪽으로 채워지는 특징을 가지고 있다.
