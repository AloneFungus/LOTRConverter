//
//  ExchangeRate.swift
//  LOTRConverter
//
//  Created by Arunachalam on 11/08/24.
//

import SwiftUI

struct ExtractedView: View {
    
    let leftImage: ImageResource
    let rightImage: ImageResource
    let text: String
    
    var body: some View {
        HStack {
            
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            Text(text)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
        }
    }
}

#Preview {
    ExtractedView(leftImage: .goldpiece,
                  rightImage: .goldpenny,
                  text: "1 Gold Piece = 4 Gold Pennies")
}
