//
//  ContentView.swift
//  RCurrency
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CurrencyRowContainerView(baseSymbol: "GBP", baseAmount: 1, symbol: "USD")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .onAppear(perform: { Symbols.loadData() })
    }
}
