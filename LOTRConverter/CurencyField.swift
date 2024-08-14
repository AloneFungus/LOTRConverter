//
//  CurencyField.swift
//  LOTRConverter
//
//  Created by Arunachalam on 14/08/24.
//

import SwiftUI

struct CurrencyField: View {
    
    @Binding var currency: Currency
    @Binding var showSelectCurrency: Bool
    @Binding var field: String
    @FocusState var typing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(currency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                Image(currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                
            }
            .padding(.bottom,5)
            .onTapGesture {
                showSelectCurrency.toggle()
            }
            TextField("Amount", text: $field)
                .textFieldStyle(.roundedBorder)
                .focused($typing)
                .keyboardType(.decimalPad)
                .padding(.bottom,10)
        }
    }
}


#Preview {
    @Previewable @State var currency: Currency = .copperPenny
    @Previewable @State var showCurrency: Bool = false
    @Previewable @State var field: String = "12"
    @Previewable @FocusState var typing: Bool
    
    
    CurrencyField(currency: $currency,
                  showSelectCurrency: $showCurrency,
                  field: $field,
                  typing: _typing)
}
