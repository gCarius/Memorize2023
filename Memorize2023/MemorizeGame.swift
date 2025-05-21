//
//  MemorizeGame.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-05-17.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card> //Visible variable privately mutable

    init (numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) { // cardContentFactory is a fucntion (FUNCTIONAL PROGRAMMING)
        cards = []
        // add numberOfPairOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    func choose(card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}

