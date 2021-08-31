//
//  CurrencyRowData.swift
//  CurrencyRowData
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI
import RealmSwift

struct CurrencyRowContainerView: View {
    @ObservedResults(Rate.self) var rates
    
    let baseSymbol: String
    @Binding var baseAmount: Double
    let symbol: String
    var action: () -> Void = {}
    
    var rate: Rate? {
        rates.filter(
            NSPredicate(format: "query.from = %@ AND query.to = %@", baseSymbol, symbol)).first
    }
    
    var body: some View {
        // TODO: Check if the rate's date matches today's
        if let rate = rate {
//            if rate.isToday {
                CurrencyRowDataView(rate: rate, baseAmount: $baseAmount, action: action)
//            } else {
//                Text("Loading Data...")
//                    .onAppear(perform: loadData)
//            }
        } else {
            Text("Loading Data...")
                .onAppear(perform: loadData)
        }
    }
    
    private func loadData() {
        guard let url = URL(string: "https://api.exchangerate.host/convert?from=\(baseSymbol)&to=\(symbol)") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        print("Network request: \(url.description)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(Rate.self, from: data) {
                DispatchQueue.main.async {
//                    if let existingRate = rate {
//                        do {
//                            let realm = try Realm()
//                            try realm.write() {
//                                guard let thawedrate = existingRate.thaw() else {
//                                    print("Couldn't thaw existingRate")
//                                    return
//                                }
//                                thawedrate.date = decodedResponse.date
//                                thawedrate.result = decodedResponse.result
//                            }
//                        } catch {
//                            print("Unable to update existing rate in Realm")
//                        }
//                    } else {
                    let newRate = Rate(from: decodedResponse.query?.from ?? "",
                                       to: decodedResponse.query?.to ?? "",
                                       date: decodedResponse.date,
                                       result: decodedResponse.result)
                    newRate.pendingRefresh = false
                    $rates.append(newRate)
//                    }
                }
            } else {
                print("No data received")
            }
        }
        .resume()
    }
}

struct CurrencyRowData_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowContainerView(baseSymbol: "GBP",
                                 baseAmount: .constant(1.0),
                                 symbol: "USD")
    }
}
