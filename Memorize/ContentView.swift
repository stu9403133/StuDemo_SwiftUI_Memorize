//
//  ContentView.swift
//  Memorize
//
//  Created by . Stu on 2025/11/5.
//

import SwiftUI

struct ContentView: View {
    let cardContents: [String] = ["👻", "🎃", "🕷", "🦇","😈","👹","☠️","👾","👺","👁️"]
    
    @State var cardLimit: Int = 4
    
    var body: some View {
        
        VStack {
            cards
            HStack {
                Button("More Card") {
                    if cardLimit < cardContents.count {
                        cardLimit += 1
                    }
                    
                }
                
                Spacer()
                
                Button("Less Card") {
                    if cardLimit > 1 {
                        cardLimit -= 1
                    }
                }.foregroundColor(.red)
            }
            
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(cardContents.indices, id: \.self) { index in
                CardView(content: cardContents[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
    
}


struct CardView: View {
    @State var isFaceUp: Bool = true
    @State var content: String = "👻"
    
    var body: some View {
        ZStack {
            if isFaceUp {
                Rectangle().foregroundColor(.orange)
                Rectangle().stroke(lineWidth: 10)
                Text(content).font(.largeTitle)
            } else {
                Rectangle().foregroundColor(.white)
                Rectangle().stroke(lineWidth: 10)
            }
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
