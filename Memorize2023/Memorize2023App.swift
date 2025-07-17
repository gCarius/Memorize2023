//
//  Memorize2023App.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-05-13.
//

import SwiftUI

@main
struct Memorize2023App: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
        }
    }
}
