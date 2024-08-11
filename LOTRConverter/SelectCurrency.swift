//
//  SelectCurrency.swift
//  LOTRConverter
//
//  Created by Arunachalam on 11/08/24.
//

import SwiftUI

struct SelectCurrency: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var topCurrency: Currency
    
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack {
                
                Text("Select the currency you are starting with : ")
                    .fontWeight(.bold)
                
                IconGrid(currency: $topCurrency)
                
                Text("Select the currency you would like to convert to :")
                    .fontWeight(.bold)
                
                IconGrid(currency: $bottomCurrency)
                
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
    @Previewable @State var topCurrency: Currency = .goldPenny
    @Previewable @State var bottomCurrency: Currency = .goldPenny
    
    SelectCurrency(topCurrency: $topCurrency,bottomCurrency: $bottomCurrency)
}

