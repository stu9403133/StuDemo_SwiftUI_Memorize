//
//  MemorizeGame.swift
//  Memorize
//
//  Created by . Stu on 2025/12/3.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    
    func choice(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatch: Bool
        var content: CardContent
    }
}
