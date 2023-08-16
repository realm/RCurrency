//
//  CurrencyRow.swift
//  CurrencyRow
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct CurrencyRowView: View {
    var isBase = false
    var value: Double
    let symbol: String
    @Binding var baseValue: Double
    var action: (_: String) -> Void = {_ in }
    
    @State private var amount = "0.0"
    @State private var rate = 0.0
    
    var body: some View {
        VStack {
            HStack {
                if isBase {
                    NavigationLink {
                        SymbolPickerView(action: action, existingSymbols: [])
                    } label: {
                        HStack {
                            Image(symbol.lowercased())
                            Text("\(symbol): ")
                                .font(.largeTitle)
                        }
                        .foregroundColor(.primary)
                    }
                } else {
                    HStack {
                        Image(symbol.lowercased())
                        Text("\(symbol): ")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.primary)
                }
                Spacer()
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .onChange(of: amount, perform: updateValue)
                    .font(.largeTitle)
            }
        }
        .onAppear(perform: calcLocalState)
        .onChange(of: value, perform: { newValue in
            amount = "\(newValue)"
        })
    }
    
    private func calcLocalState() {
        amount = value.description
        rate = value/baseValue
    }
    
    private func updateValue(newAmount: String) {
        guard let newValue = Double(newAmount) else {
            print("\(newAmount) cannot be converted to a Double")
            return
        }
        baseValue = newValue / rate
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CurrencyRowView(value: 3.23, symbol: "USD", baseValue: .constant(1.0))
            CurrencyRowView(value: 1.0, symbol: "GBP", baseValue: .constant(10.0))
        }
    }
}
