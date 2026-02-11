//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by . Stu on 2025/11/5.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let mySpacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
            HStack {
                score
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var score : some View {
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
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .padding(mySpacing)
                    .overlay(FlyingNumber(number: scoreChange(causeedBy: card)))
                    .zIndex(scoreChange(causeedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .transition(.scale)
            }
            
        }
        .foregroundColor(viewModel.color)
        .onAppear {
            // deal with the card
            withAnimation(.easeInOut(duration: 2)) {
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
	private func scoreChange(causeedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
