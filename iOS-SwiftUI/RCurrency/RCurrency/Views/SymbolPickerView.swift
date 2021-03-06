//
//  SymbolPickerView.swift
//  SymbolPickerView
//
//  Created by Andrew Morgan on 27/08/2021.
//

import SwiftUI

struct SymbolPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var action: (String) -> Void
    let existingSymbols: [String]
    
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(searchResults.sorted(by: <), id: \.key) { symbol in
                Button(action: {
                    pickedSymbol(symbol.key)
                }) {
                    HStack {
                        Image(symbol.key.lowercased())
                        Text("\(symbol.key): \(symbol.value)")
                    }
                    .foregroundColor(existingSymbols.contains(symbol.key) ? .secondary : .primary)
                }
                .disabled(existingSymbols.contains(symbol.key))
            }
        }
        .searchable(text: $searchText)
        .navigationBarTitle("Pick Currency", displayMode: .inline)
    }
    
    private func pickedSymbol(_ symbol: String) {
        action(symbol)
        presentationMode.wrappedValue.dismiss()
    }
    
    var searchResults: Dictionary<String, String> {
        if searchText.isEmpty {
            return Symbols.data.symbols
        } else {
            return Symbols.data.symbols.filter {
                $0.key.contains(searchText.uppercased()) || $0.value.contains(searchText)}
        }
    }
}

struct SymbolPickerView_Previews: PreviewProvider {
    static var previews: some View {
        Symbols.loadData()
        return NavigationView {
        SymbolPickerView(action: { _ in }, existingSymbols: ["GBP", "USD"] )
        }
    }
}
