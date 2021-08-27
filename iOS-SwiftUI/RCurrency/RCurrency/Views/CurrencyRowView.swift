//
//  CurrencyRow.swift
//  CurrencyRow
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct CurrencyRowView: View {
    let value: Double
    let symbol: String
    
    var body: some View {
        HStack {
            Image(symbol.lowercased())
            Text("\(symbol): ")
                .font(.largeTitle)
            Spacer()
            Text("\(value)")
                .font(.largeTitle)
        }
        .padding()
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(value: 3.23, symbol: "USD")
    }
}
