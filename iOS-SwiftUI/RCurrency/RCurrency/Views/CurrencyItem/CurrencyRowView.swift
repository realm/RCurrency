//
//  CurrencyRow.swift
//  CurrencyRow
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct CurrencyRowView: View {
    var value: Double
    let symbol: String
    @Binding var baseValue: Double
    let pendingRefresh: Bool
    var action: () -> Void = {}
    
    @State private var amount = "0.0"
    @State private var rate = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: action) {
                    HStack {
                        Image(symbol.lowercased())
                        Text("\(symbol): ")
                            .font(.largeTitle)
                    }
                }
                .foregroundColor(.primary)
                Spacer()
                TextField("Amount", text: $amount)
                    .onChange(of: amount, perform: updateValue)
                    .font(.largeTitle)
            }
            if pendingRefresh {
                HStack {
                    Text("Pending refresh")
                        .font(.caption)
                    Spacer()
                }
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
            CurrencyRowView(value: 3.23, symbol: "USD", baseValue: .constant(1.0), pendingRefresh: false)
            CurrencyRowView(value: 1.0, symbol: "GBP", baseValue: .constant(10.0), pendingRefresh: true)
        }
    }
}
