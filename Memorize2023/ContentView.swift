//
//  ContentView.swift
//  Memorize
//
//  Created by Ruban on 2024-02-10.
//

import SwiftUI

let theme1: Array<String> = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚚","🚛","🚜","✈️","🚁","🚂","🚤"]
let theme2: Array<String> = ["🛍️","🛒","🏬","💳","🧾","💰","💸","💵","📦","🏷️","🪙","🧺","🏪","🛎️","💲","🪪"]
let theme3: Array<String> = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🦉"]


struct ContentView: View {
    @State var emojis = theme1
    @State var cardCount = 14
    @State var themeColor = Color(red: 0, green: 0.3, blue: 1, opacity: 0.25)
    
    var body: some View {
        Text("Memorize!").font(.largeTitle).foregroundStyle(themeColor).fontWeight(.bold)
        VStack {
            // Allows for user to scroll
            ScrollView { cards }
            Spacer()
            themeButtonsSection
        }
        .padding()
    }
    
    var cards: some View {
        // creates a vertically scrollable collection of views
        // lazy implies that the views are only created when SwiftUI needs to display them
        LazyVGrid (columns: [GridItem(.adaptive(minimum: CGFloat(220 / sqrt(CGFloat(cardCount) * 1.3))))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(themeColor)
    }
    
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
    
    func themeButton(_ choice: String, symbol: String) -> some View {
        Button(action: {
            switch choice {
            case "Vehicles":
                emojis = theme1.shuffled()
                themeColor = Color.gray
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
    ContentView()
}
