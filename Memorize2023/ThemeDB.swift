//
//  ThemeDB.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-05-27.
//

import Foundation
import SwiftUICore

struct ThemeDB {
    
    func chooseTheme(id: Int, numOfPairs: Int) -> Theme {
        switch id {
        case 0:
            return Theme(name: "Vechicles", emoji: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚚","🚛","🚜","✈️","🚁","🚂","🚤"], numberOfPairs: numOfPairs, color: .gray)
        case 1:
            return Theme(name: "Shopping", emoji: ["🛍️","🛒","🏬","💳","🧾","💰","💸","💵","📦","🏷️","🪙","🧺","🏪","🛎️","💲","🪪"], numberOfPairs: numOfPairs, color: .pink)
        case 2:
            return Theme(name: "Animals", emoji: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🦉"], numberOfPairs: numOfPairs, color: .brown)
        case 3:
            return Theme(name: "Foods", emoji: ["🍎","🍊","🍌","🍉","🍇","🍓","🍒","🍍","🥭","🥝","🍅","🥑","🍞","🧀","🍕","🍔"], numberOfPairs: numOfPairs, color: .yellow)
        case 4:
            return Theme(name: "Countries", emoji: ["🇨🇦","🇺🇸","🇬🇧","🇫🇷","🇩🇪","🇯🇵","🇨🇳","🇰🇷","🇧🇷","🇲🇽","🇮🇳","🇦🇺","🇿🇦","🇮🇹","🇪🇸","🇷🇺"], numberOfPairs: numOfPairs, color: .blue)
        case 5:
            return Theme(name: "Music", emoji: ["🎵","🎶","🎼","🎧","🎷","🎸","🎹","🥁","🎺","🎻","📻","🎤","🪕","🪘","💿","📀"], numberOfPairs: numOfPairs, color: .black)
        default:
            return Theme(name: "Animals", emoji: ["🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "🐷", "🐮", "🐗", "🐴", "🐵", "🐿", "🐦"], numberOfPairs: numOfPairs, color: .brown)
        }
    }
    
    struct Theme {
        var name: String
        var emoji: Array<String>
        var numberOfPairs: Int
        var color: Color
    }
}
