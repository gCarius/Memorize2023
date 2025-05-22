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
        Text("Memorize!").font(.largeTitle).foregroundStyle(.gray).fontWeight(.bold)
        VStack {
            ScrollView {
                cards
            }
            .animation(.default, value: viewModel.cards)
            
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
            
        }
        .padding()
    }
    
    // The view of how cards are structured on screen
    var cards: some View {
        LazyVGrid (columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) { //CGFloat(220 / sqrt(CGFloat(viewModel.cards.count)/2 * 1.2))
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(.gray)
    }
    
    //    // The button Section "bar"
    //    var themeButtonsSection: some View {
    //        HStack {
    //            themeButton("Vehicles", symbol: "car")
    //            Spacer()
    //            themeButton("Shopping", symbol: "cart")
    //            Spacer()
    //            themeButton("Animals", symbol: "pawprint")
    //        }
    //        .imageScale(.large)
    //        .font(.largeTitle)
    //        .foregroundStyle(themeColor)
    //    }
    //
    //    // The functions for the buttons
    //    func themeButton(_ choice: String, symbol: String) -> some View {
    //        Button(action: {
    //            switch choice {
    //            case "Vehicles":
    //                emojis = theme1.shuffled()
    //                themeColor = Color.red
    //                cardCount = Int.random(in: 2..<emojis.count)
    //            case "Shopping":
    //                emojis = theme2.shuffled()
    //                themeColor = Color.green
    //                cardCount = Int.random(in: 2..<emojis.count)
    //            case "Animals":
    //                emojis = theme3.shuffled()
    //                themeColor = Color.brown
    //                cardCount = Int.random(in: 2..<emojis.count)
    //            default:
    //                emojis = theme1.shuffled()
    //                cardCount = Int.random(in: 2..<emojis.count)
    //            }
    //        }, label: {
    //            VStack {
    //                Image(systemName: symbol)
    //                Text(choice).font(.caption)
    //            }
    //        })
    //    }
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
