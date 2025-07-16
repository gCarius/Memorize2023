//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ruban on 2024-02-10.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    // The structurized core of the app
    var body: some View {
        Text("\(viewModel.theme.name)!").font(.largeTitle).fontWeight(.bold).padding(.top)
        VStack {
            ScrollView {
                cards
            }
            .animation(.default, value: viewModel.cards)
            
            Spacer()
            HStack {
                Text("Score: \(viewModel.score)") // TODO: Add variable Score
                Spacer()
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
                
            }
                .padding(10)

        }
        .padding()
    }
    
    @ViewBuilder
    var cards: some View {
        let aspectRatio: CGFloat = 2/3
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid (columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundStyle(viewModel.theme.color)
        }
    }
        
        
    func gridItemWidthThatFits(
            count: Int,
            size: CGSize,
            atAspectRatio aspectRatio: CGFloat
        ) -> CGFloat {
            let count = CGFloat(count)
            var columnCount = 1.0
            repeat {
                let width = size.width / columnCount
                
                let rowCount = (count / columnCount).rounded(.up)
                if rowCount * width <= size.width {
                    return (size.width / columnCount).rounded(.down)
                }
                columnCount += 1
            } while columnCount < count
            return ((size.width) / count).rounded(.down)
        }
    }
    


// The base initilaizers of the cards
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1/1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill().opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
