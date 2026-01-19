//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by . Stu on 2025/12/3.
//

import SwiftUI



// 這是viewModel用來溝通 view, model
class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    // 10組
    private static let emojis = ["👻", "🎃", "🕷", "🦇","😈","👹","☠️","👾","👺","👁️"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 2) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
            
        }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
