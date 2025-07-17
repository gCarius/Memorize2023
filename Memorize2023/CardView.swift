//
//  CardView.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-07-16.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 4
        static let inset: CGFloat = 5
        struct FontSize {
            static let largets: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largets
            
        }
        struct Pie {
            static let inset: CGFloat = 5
            static let opacity: CGFloat = 0.4
            
            
        }
        
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                
                Pie(endAngle: .degrees(350), )
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largets))
                            .minimumScaleFactor(Constants.FontSize.scaleFactor)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(Constants.inset)
                    )
                    .padding(Constants.Pie.inset)
                    
                
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill().opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}


struct CardView_Previews: PreviewProvider {
    typealias Card = MemoryGame<String>.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "👻", id: "test"))
                CardView(Card(isFaceUp: true, content: "👻", id: "test"))
            }
            HStack {
                CardView(Card(isFaceUp: true, content: "☠", id: "test"))
                CardView(Card(isFaceUp: true, content: "☠", id: "test"))
            }
        }
        .padding(20)
        .foregroundStyle(.green)

        
    }
    
}
