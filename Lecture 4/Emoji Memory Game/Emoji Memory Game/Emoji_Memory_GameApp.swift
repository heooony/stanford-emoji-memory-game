//
//  Emoji_Memory_GameApp.swift
//  Emoji Memory Game
//
//  Created by 김동헌 on 2022/06/18.
//

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
