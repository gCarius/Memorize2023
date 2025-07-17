//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ruban on 2024-02-10.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel : EmojiMemoryGame
    
    // The structurized core of the app
    var body: some View {
        Text("\(viewModel.theme.name)!").font(.largeTitle).fontWeight(.bold).padding(.top)
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            HStack {
                score
                Spacer()
                shuffle
                Spacer()
                newGame
            }
            .padding()
        }
        .padding()
    }
        
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    
    private var newGame: some View {
        Button("New Game") {
            withAnimation(.linear(duration: 1)) {
                viewModel.newGame()
            }
        }
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
                    if isDealt(card) {
                        CardView(card)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                            .padding(4)
                            .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                            .zIndex(scoreChange(causedBy: card) != 0 ? 100:0)
                            .onTapGesture {
                                withAnimation {
                                    let scoreBeforeChosing = viewModel.score
                                    viewModel.choose(card)
                                    let scoreChange = viewModel.score - scoreBeforeChosing
                                    lastScoreChange = (scoreChange, card.id)
                                }
                                
                            }
                            .transition(.offset(
                                x: CGFloat.random(in : -1000...1000),
                                y:CGFloat.random(in : -1000...1000)
                            ))
                    }
                    
                }
            }
            .foregroundStyle(viewModel.theme.color)
        }.onAppear {
            withAnimation (.linear(duration: 1)){
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt (_ card: Card) -> Bool {
        return dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    
    @State private var lastScoreChange: (Int, causedByCardId: Card.ID) = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
        
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


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
