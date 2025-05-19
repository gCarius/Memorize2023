//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ruban on 2024-02-10.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @State var emojis = ["A", "B"]
    @State var cardCount = 2
    @State var themeColor = Color(red: 0, green: 0, blue: 0, opacity: 0.25)
    
    // The structurized core of the app
    var body: some View {
        Text("Memorize!").font(.largeTitle).foregroundStyle(themeColor).fontWeight(.bold)
        VStack {
            ScrollView { cards }
            Spacer()
            themeButtonsSection
        }
        .padding()
    }
    
    // The view of how cards are structured on screen
    var cards: some View {
        LazyVGrid (columns: [GridItem(.adaptive(minimum: CGFloat(220 / sqrt(CGFloat(cardCount) * 1.3))))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(themeColor)
    }
    
    // The button Section "bar"
    var themeButtonsSection: some View {
        HStack {
            themeButton("Vehicles", symbol: "car")
            Spacer()
            themeButton("Shopping", symbol: "cart")
            Spacer()
            themeButton("Animals", symbol: "pawprint")
        }
        .imageScale(.large)
        .font(.largeTitle)
        .foregroundStyle(themeColor)
    }
    
    // The functions for the buttons
    func themeButton(_ choice: String, symbol: String) -> some View {
        Button(action: {
            switch choice {
            case "Vehicles":
                emojis = theme1.shuffled()
                themeColor = Color.red
                cardCount = Int.random(in: 2..<emojis.count)
            case "Shopping":
                emojis = theme2.shuffled()
                themeColor = Color.green
                cardCount = Int.random(in: 2..<emojis.count)
            case "Animals":
                emojis = theme3.shuffled()
                themeColor = Color.brown
                cardCount = Int.random(in: 2..<emojis.count)
            default:
                emojis = theme1.shuffled()
                cardCount = Int.random(in: 2..<emojis.count)
            }
        }, label: {
            VStack {
                Image(systemName: symbol)
                Text(choice).font(.caption)
            }
        })
    }
}


// The base initilaizers of the cards
struct CardView: View {
    let content: String
    @State var isFaceUp = false
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
