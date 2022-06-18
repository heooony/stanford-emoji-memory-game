//
//  MemoryGame.swift
//  Emoji Memory Game
//
//  Created by 김동헌 on 2022/06/18.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        // 1. 클릭한 카드가 어떤 카드인지 알아보고, 그 카드의 index를 가져온다.
        // 이미 클릭되어 있거나(isFaceUp), 이미 매칭된 카드는(isMatched) 포함하지 않는다.
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            // 2. indexOfTheOneAndOnlyFaceUpCard는 내가 선택했던 카드의 인덱스를 잠깐 기억하는
            // 장소이다. 즉, 첫 번째 클릭 시에는 nil이며, 처음 클릭이 이루어지면 이 변수에 그 index가
            // 대입되고, 두 번째 클릭하게 되었을 때 이 변수에 담겨져 있던 값과 비교할 수 있게 도와준다.
            // 여기서는 nil이 아닐 시에 이므로, 카드가 이미 한 장 뒤집혀져 있는 상태만을 의미한다.
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // 3. 만약 카드가 한 장 뒤집혀져 있는 상태에서 다른 한 장을 클릭했을 때
                // 임시로 저장되어있던 그 카드와 내용이 같다면 두 카드의 isMatched를 ture로 변환한다.
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                // 4. 두 카드를 모두 뒤집었으므로 임시 저장될 인덱스 값은 존재하지 않는다.
                indexOfTheOneAndOnlyFaceUpCard = nil
            // 2. 이 경우는 아무것도 뒤집혀져 있지 않은 상태 또는, 두 카드가 뒤집혀져 있어서
            // 무엇인가 이벤트를 할 필요가 없을 때 else를 태운다.
            } else {
                // 3. 모든 카드를 뒤집는다.
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                // 4. 모든 카드가 뒤집혀져있는 상태에서 한 장을 선택했으므로 그 인덱스 값을 잠시
                // 기억할 수 있도록 한다.
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            // 해당 카드를 뒤집는다.
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
