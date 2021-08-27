//
//  ContentView.swift
//  RCurrency
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CurrencyRowContainerView(baseSymbol: "GBP", baseAmount: 1, symbol: "EUR")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
