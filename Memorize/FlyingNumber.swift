//
//  FlyingNumber.swift
//  Memorize
//
//  Created by 涂羽華 on 2026/1/30.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text("\(number)")
        }
        
    }
}

#Preview {
    FlyingNumber(number: 5)
}
