//
//  MemorizeGame.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-05-17.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> //Visible variable privately mutable
    private(set) var score: Int = 0
    private var checkOAOCard: Bool = false
    
    init (numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) { // cardContentFactory is a fucntion (FUNCTIONAL PROGRAMMING)
        cards = []
        // add numberOfPairOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        //cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatch = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatch].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatch].isMatched = true
                        score += 2
                        checkOAOCard = false
                    } else {
                        deductScore(chosenIndex, potentialMatch)
                        checkOAOCard = false
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                    if cards[chosenIndex].isSelected {
                        checkOAOCard = true
                    }
                }
                cards[chosenIndex].isFaceUp = true
            }
            cards[chosenIndex].isSelected = true
        }
    }
    
    mutating private func deductScore(_ chosenIndex: Int, _ potentialMatchIndex: Int) {
            if cards[chosenIndex].isSelected{
                score -= 1
            }
            if cards[potentialMatchIndex].isSelected && checkOAOCard {
                score -= 1
            }
        }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content)\(isFaceUp ? "up" : "down"), \(isMatched ? "matched" : "unmatched")"
        }
        
        var isFaceUp = false
        var isMatched = false
        var isSelected = false
        let content: CardContent
        
        var id: String
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
