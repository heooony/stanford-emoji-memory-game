//
//  EmojiMemoryGame.swift
//  Emoji Memory Game
//
//  Created by 김동헌 on 2022/06/18.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    typealias Card = MemoryGame<String>.Card
    
    private static var emojis = ["🪁","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","⚽️","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in EmojiMemoryGame.emojis[pairIndex] }
    }
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
