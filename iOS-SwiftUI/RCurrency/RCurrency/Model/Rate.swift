//
//  Rates.swift
//  Rates
//
//  Created by Andrew Morgan on 26/08/2021.
//

import RealmSwift
import Foundation

class Rate: Object, ObjectKeyIdentifiable, Codable {
    var motd = Motd()
    var success = false
    @Persisted var query: Query?
    var info = Info()
    @Persisted var date: String
    @Persisted var result: Double
}

extension Rate {
    convenience init(from: String, to: String, date: String, result: Double) {
        self.init()
        self.query?.from = from
        self.query?.to = to
        self.date = date
        self.result = result
    }
}

extension Rate {
    var isToday: Bool {
        let today = Date().description.prefix(10)
        return  date == today
    }
}

class Motd: Codable {
    var msg = ""
    var url = ""
}

class Query: EmbeddedObject, ObjectKeyIdentifiable, Codable {
    @Persisted var from: String
    @Persisted var to: String
    var amount = 0
}

class Info: Codable {
    var rate = 0.0
}
