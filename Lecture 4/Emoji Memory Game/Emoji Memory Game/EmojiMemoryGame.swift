//
//  EmojiMemoryGame.swift
//  Emoji Memory Game
//
//  Created by 김동헌 on 2022/06/18.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    static var emojis = ["⚽️","🏀","🏈","⚾️","🏉","🏐","🎾","🥎","🥏","🎱","🪀","🏓","🥍","🏑","🏒","🏸","🏏","🪃","🥅","⛳️","🎣","🏹","🛝","🪁","🤿","🥊","🥋","🎽","⛸","🛷","🛼","🛹"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in EmojiMemoryGame.emojis[pairIndex] }
    }
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
