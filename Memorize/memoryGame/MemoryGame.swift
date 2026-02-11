//
//  MemorizeGame.swift
//  Memorize
//
//  Created by . Stu on 2025/12/3.
//

import Foundation

// model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
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
        }) {
            if !cards[choseIndex].isFaceUp && !cards[choseIndex].isMatch {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choseIndex].content
                        == cards[potentialMatchIndex].content
                    {
                        cards[choseIndex].isMatch = true
                        cards[potentialMatchIndex].isMatch = true
                        score +=
                            2 + cards[choseIndex].bonus
                            + cards[potentialMatchIndex].bonus
                    } else {
                        if cards[choseIndex].hasBeenSeen {
                            score -= 1
                        }

                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
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
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatch = false {
            didSet {
                if isMatch {
                    stopUsingBonusTime()
                }
            }
        }
        var hasBeenSeen = false
        var content: CardContent
        let id: String
        var lastFaceUpDate: Date?

        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatch && bonusPercentRemaining > 0,
                lastFaceUpDate == nil
            {
                lastFaceUpDate = Date()
            }
        }

        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }

        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }

        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0
                ? max(0, bonusTimeLimit - faceUpTime) / bonusTimeLimit : 0
        }

        var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        var pastFaceUpTime: TimeInterval = 0

        var bonusTimeLimit: Double = 6

    }

}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
