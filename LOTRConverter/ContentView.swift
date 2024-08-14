//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Arunachalam on 10/08/24.
//

import SwiftUI
import TipKit


struct ContentView: View {
    
    @State var showExchangeInfo: Bool = false
    @State var showSelectCurrency: Bool = false
    
    @State var leftAmount: String = ""
    @State var rightAmount: String = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @Preference(\.leftCurrency) var leftCurrency: Currency
    @Preference(\.rightCurrency) var rightCurrency: Currency
    
    var body: some View {
        ZStack {
            //            Image Background
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                //
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                HStack{               
                    CurrencyField(currency: $leftCurrency,
                                  showSelectCurrency: $showSelectCurrency,
                                  field: $leftAmount,
                                  typing: _leftTyping
                    )
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    CurrencyField(currency: $rightCurrency,
                                  showSelectCurrency: $showSelectCurrency,
                                  field: $rightAmount,
                                  typing: _rightTyping
                    )
                    .multilineTextAlignment(.trailing)
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.rect(cornerRadius: 40))
                Spacer()
                //                info Button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                        rightTyping = false
                        leftTyping = false
                    } label: {
                        Image(systemName: "info.circle.fill")
                        
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
            .padding(2)
        }
        .task {
            try? Tips.configure()
        }
        .onTapGesture {
            rightTyping = false
            leftTyping = false
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency
                    .convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency
                .convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                rightAmount = leftCurrency
                    .convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency
                .convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
                .presentationDetents([.fraction(0.99), .large])
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: self.$leftCurrency, bottomCurrency: self.$rightCurrency)
                .presentationDetents([.fraction(0.99),.large])
        }
    }
}

#Preview {
    ContentView()
}

