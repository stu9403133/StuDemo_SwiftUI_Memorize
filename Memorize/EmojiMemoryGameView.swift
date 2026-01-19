//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by . Stu on 2025/11/5.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let mySpacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards.animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(mySpacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(Color.orange)
    }
    

    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
