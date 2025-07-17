//
//  EmojiMemoryGame.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-05-17.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: ThemeDB.Theme
    private(set) var numberOfPairsOfCards: Int
    
    init () {
        let randomId = Int.random(in: 0..<5)
        numberOfPairsOfCards = 8
        theme = ThemeDB().chooseTheme(id: randomId, numOfPairs: numberOfPairsOfCards)
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    static func createMemoryGame(theme : ThemeDB.Theme) -> MemoryGame<String>{
        return  MemoryGame( numberOfPairOfCards: theme.numberOfPairs ) { pairIndex in //cardContentFactory
            if theme.emoji.indices.contains(pairIndex) {
                return theme.emoji[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    var score: Int {
        model.score
    }


    
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
    
    func newGame() {
        let randomId = Int.random(in: 0..<6)
        numberOfPairsOfCards = Int.random(in: 0..<12)
        theme = ThemeDB().chooseTheme(id: randomId, numOfPairs: numberOfPairsOfCards)
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
        
        
        
        
    }
}

