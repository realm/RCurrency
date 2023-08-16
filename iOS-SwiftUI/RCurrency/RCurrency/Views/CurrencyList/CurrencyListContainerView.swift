//
//  CurrencyListContainerView.swift
//  CurrencyListContainerView
//
//  Created by Andrew Morgan on 27/08/2021.
//

import SwiftUI
import RealmSwift

struct CurrencyListContainerView: View {
    @ObservedResults(UserSymbols.self) var userSymbolResults
    @ObservedResults(Rate.self) var rates
    
    @State private var showingAddSymbol = false
    @State private var baseAmount = 1.0
    @State private var refreshToggle = false
    
    var userSymbols: UserSymbols {
        userSymbolResults.first ?? UserSymbols()
    }
    
    var body: some View {
        VStack {
            VStack {
                CurrencyRowContainerView(isBase: true,
                                         baseSymbol: userSymbols.baseSymbol,
                                         baseAmount: $baseAmount,
                                         symbol: userSymbols.baseSymbol,
                                         refreshToggle: refreshToggle,
                                         action: setBaseCurrency)
                HStack {
                    Text("Base currency")
                        .font(.caption)
                    Spacer()
                }
            }
            .padding(.horizontal)
            Divider()
            List {
                ForEach(userSymbols.symbols, id: \.self) { symbol in
                    CurrencyRowContainerView(baseSymbol: userSymbols.baseSymbol,
                                             baseAmount: $baseAmount,
                                             symbol: symbol,
                                             refreshToggle: refreshToggle)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteSymbol)
            }
            .refreshable(action: { refreshToggle.toggle() })
            Spacer()
        }
        .navigationBarTitle("RCurrency", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { NavigationLink {
                SymbolPickerView(action: addSymbol, existingSymbols: Array(userSymbols.symbols))
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private func setBaseCurrency(_ symbol: String) {
        do {
            showingAddSymbol = false
            let realm = try Realm()
            try realm.write() {
                guard let thawedUserSymbols = userSymbols.thaw() else {
                    print("Couldn't thaw userSymbols")
                    return
                }
                thawedUserSymbols.baseSymbol = symbol
            }
        } catch {
            print("Unable to set base symbole in Realm")
        }
    }
    
    private func addSymbol(_ symbol: String) {
        do {
            showingAddSymbol = false
            let realm = try Realm()
            try realm.write() {
                guard let thawedUserSymbols = userSymbols.thaw() else {
                    print("Couldn't thaw userSymbols")
                    return
                }
                thawedUserSymbols.symbols.append(symbol)
            }
        } catch {
            print("Unable to delete symbol from Realm")
        }
    }
    
    private func deleteSymbol(at offsets: IndexSet) {
        do {
            let realm = try Realm()
            try realm.write() {
                guard let thawedUserSymbols = userSymbols.thaw() else {
                    print("Couldn't thaw userSymbols")
                    return
                }
                thawedUserSymbols.symbols.remove(atOffsets: offsets)
            }
        } catch {
            print("Unable to delete symbol from Realm")
        }
    }
}

struct CurrencyListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        UserSymbols.bootstrap()
        
        return
            NavigationStack {
                CurrencyListContainerView()
        }
    }
}
