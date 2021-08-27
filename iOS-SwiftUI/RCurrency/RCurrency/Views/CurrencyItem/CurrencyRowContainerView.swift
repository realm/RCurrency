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
    let baseAmount: Double
    let symbol: String
    
    var rate: Rate? {
        rates.filter(
            NSPredicate(format: "query.from = %@ AND query.to = %@", baseSymbol, symbol)).first
    }
    
    var body: some View {
        if let rate = rate {
            CurrencyRowDataView(rate: rate, baseAmount: baseAmount)
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(Rate.self, from: data) {
                DispatchQueue.main.async {
                    let newRate = Rate(from: decodedResponse.query?.from ?? "",
                                       to: decodedResponse.query?.to ?? "",
                                       date: decodedResponse.date,
                                       result: decodedResponse.result)
                    $rates.append(newRate)
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
        CurrencyRowContainerView(baseSymbol: "GBP", baseAmount: 1.0, symbol: "USD")
    }
}
