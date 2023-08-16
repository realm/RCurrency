//
//  ContentView.swift
//  RCurrency
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            CurrencyListContainerView()
        }
        .onAppear(perform: bootstrap)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}

private func bootstrap() {
    Symbols.loadData()
    UserSymbols.bootstrap()
}
