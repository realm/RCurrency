//
//  UserSymbols.swift
//  UserSymbols
//
//  Created by Andrew Morgan on 27/08/2021.
//

import Foundation
import RealmSwift

class UserSymbols: Object, ObjectKeyIdentifiable {
    @Persisted var baseSymbol: String
    @Persisted var symbols: List<String>
    
    convenience init (_ baseSymbol: String) {
        self.init()
        self.baseSymbol = baseSymbol
    }
    convenience init (baseSymbol: String, symbols: [String]) {
        self.init()
        self.baseSymbol = baseSymbol
        let _ = symbols.map {
            self.symbols.append($0)
        }
    }
}

extension UserSymbols {
    static func bootstrap() {
        do {
            let realm = try Realm()
            if realm.objects(UserSymbols.self).first == nil {
                let symbols = ["EUR", "USD", "DKK", "MXN", "AED", "INR"]
                try realm.write() {
                    realm.delete(realm.objects(UserSymbols.self))
                    realm.add(UserSymbols(baseSymbol: "GBP", symbols: symbols))
                }

            }
        } catch {
            print("Failed to bootstrap user symbols: \(error.localizedDescription)")
        }
    }
}

