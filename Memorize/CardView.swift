//
//  CardView.swift
//  Memorize
//
//  Created by 涂羽華 on 2026/1/19.
//

import SwiftUI

struct CardView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    let card: Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Pie(endAngle: .degrees(240))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.smallest / Constants.FontSize.largest)
                            .aspectRatio(1, contentMode: .fit)
                    )
                    .padding(Constants.inset)
            }
            	.opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatch ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
    
}



struct CardView_Previews: PreviewProvider {
    
    typealias Card = CardView.Card
    
    static var previews: some View {
        CardView(Card(content: "A", id: "test1"))
            .padding()
            .foregroundColor(.green)
    }
    
}
