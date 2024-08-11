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
    
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
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
                    VStack {
                        HStack {
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                                
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom,5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(),
                                    arrowEdge: .bottom)
                        
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                            .padding(.bottom,10)
                        
                    }
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    VStack {
                        HStack {
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                                
                        }
                        .padding(.bottom,5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)
                            .padding(.bottom,10)
                    }
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
