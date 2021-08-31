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
    
    @State private var showingAddSymbol = false
    
    var userSymbols: UserSymbols {
        userSymbolResults.first ?? UserSymbols()
    }
    
    var body: some View {
        VStack {
            CurrencyRowContainerView(baseSymbol: userSymbols.baseSymbol,
                                     baseAmount: 1.0,
                                     symbol: userSymbols.baseSymbol)
            Divider()
            List {
                ForEach(userSymbols.symbols, id: \.self) { symbol in
                    CurrencyRowContainerView(baseSymbol: userSymbols.baseSymbol,
                                             baseAmount: 1.0,
                                             symbol: symbol)
                }
                .onDelete(perform: deleteSymbol)
            }
            Spacer()
            NavigationLink(destination: SymbolPickerView(action: addSymbol,
                                                         existingSymbols: Array(userSymbols.symbols)),
                           isActive: $showingAddSymbol) {}
        }
        .navigationBarTitle("Watched Currencies", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddSymbol.toggle() }) {
                    Image(systemName: "plus")
                }
            }
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
        
        return CurrencyListContainerView()
    }
}
