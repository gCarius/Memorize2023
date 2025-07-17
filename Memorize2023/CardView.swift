//
//  CardView.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-07-16.
//

import SwiftUI

typealias Card = CardView.Card

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) {timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.scaleFactor)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(Constants.Pie.inset)
                    )
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
            
        }
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}

#Preview {
    VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "X", id: "test1"))
            CardView(Card(content: "X", id: "test1"))
        }
        HStack {
            CardView(Card(isFaceUp: true, content: "This is a very long string blah blah blah", id: "test1"))
            CardView(Card(content: "X", id: "test1"))
        }
    }
    .padding()
    .foregroundColor(.blue)
}
