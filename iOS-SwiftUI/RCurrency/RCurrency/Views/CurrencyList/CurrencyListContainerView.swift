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
    @State private var showingSetBaseSymbol = false
    @State private var baseAmount = 1.0
    
    var userSymbols: UserSymbols {
        userSymbolResults.first ?? UserSymbols()
    }
    
    var body: some View {
        VStack {
            VStack {
                CurrencyRowContainerView(baseSymbol: userSymbols.baseSymbol,
                                         baseAmount: $baseAmount,
                                         symbol: userSymbols.baseSymbol,
                                         action: { showingSetBaseSymbol.toggle() })
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
                                             symbol: symbol)
                }
                .onDelete(perform: deleteSymbol)
            }
            .refreshable(action: refreshAll)
            Spacer()
            NavigationLink(destination: SymbolPickerView(action: addSymbol,
                                                         existingSymbols: Array(userSymbols.symbols)),
                           isActive: $showingAddSymbol) {}
            NavigationLink(destination: SymbolPickerView(action: setBaseCurrency,
                                                         existingSymbols: []),
                           isActive: $showingSetBaseSymbol) {}
        }
        .navigationBarTitle("Watched Currencies", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddSymbol.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private func setBaseCurrency(_ symbol: String) {
        showingSetBaseSymbol = false
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
    
    private func refreshAll() {
        // TODO: set prendingRefresh to true for all ratea
        print ("Refresh")
        do {
            try Realm().write() {
                rates.forEach() { rate in
                    rate.thaw()?.pendingRefresh = true
                }
            }
        } catch {
            print("Failed to update pendingRefresh for all objects")
        }
    }
}

struct CurrencyListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        UserSymbols.bootstrap()
        
        return CurrencyListContainerView()
    }
}
