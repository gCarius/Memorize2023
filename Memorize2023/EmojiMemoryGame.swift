//
//  EmojiMemoryGame.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-05-17.
//

import SwiftUI
//let theme1: Array<String> = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚚","🚛","🚜","✈️","🚁","🚂","🚤"]
//let theme2: Array<String> = ["🛍️","🛒","🏬","💳","🧾","💰","💸","💵","📦","🏷️","🪙","🧺","🏪","🛎️","💲","🪪"]
//let theme3: Array<String> = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🦉"]

class EmojiMemoryGame: ObservableObject {
    static var emojis = ["🛍️","🛒","🏬","💳","🧾","💰","💸","💵","📦","🏷️","🪙","🧺","🏪","🛎️","💲","🪪"]
    
    static func createMemoryGame() -> MemoryGame<String>{
        return  MemoryGame( numberOfPairOfCards: 6) { pairIndex in //cardContentFactory
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

