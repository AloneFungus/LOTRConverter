//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Arunachalam on 11/08/24.
//

import SwiftUI

struct SelectCurrency: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                
                Text("Select the currency you are starting with :")
                    .fontWeight(.bold)
                
                CurrencyIcon(currencyImage: .goldpiece, currencyName: "Gold Piece")
                
                Text("Select the currency you would like to convert to :")
                    .fontWeight(.bold)
                
                
                Button("Done") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .foregroundStyle(.black)
        
    }
}

#Preview {
    SelectCurrency()
}
