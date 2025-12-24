//
//  MemorizeGame.swift
//  Memorize
//
//  Created by . Stu on 2025/12/3.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let choseIndex = cards.firstIndex(where: { cardToCheck in
            cardToCheck.id == card.id
        }){
            if !cards[choseIndex].isFaceUp && !cards[choseIndex].isMatch {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choseIndex].content == cards[potentialMatchIndex].content {
                        cards[choseIndex].isMatch = true
                        cards[potentialMatchIndex].isMatch = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = choseIndex
                }
                cards[choseIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatch = false
        var content: CardContent
        let id: String
    }
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
