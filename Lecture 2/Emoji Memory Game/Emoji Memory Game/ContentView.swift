//
//  ContentView.swift
//  Emoji Memory Game
//
//  Created by 김동헌 on 2022/06/18.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","🪁","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            /*
             공간을 최대한으로 준다.
             하지만 HStack의 경우 주어진 모든 화면을 최대한으로 이용하기 때문에
             HStack 안에 Spacer가 껴있는 경우 아무런 효과도 없다. minLength 속성으로 spacerd의
             공간을 넓힐 수도 있다.
            */
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        /*
         action 설명 : if문을 주면서 해당 값에는 이벤트가 작성하지 않도록 한다.
         label 설명 : label에는 해당 버튼에 들어갈 내용을 선택한다. 지금처럼 이미지가 될 수도 있다.
         */
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                // 사각형 내부 값
                shape.fill().foregroundColor(.white)
                //사각형 틀, 이렇게 두 가지 사각형으로 fill, stroke를 지정해야 한다.
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
