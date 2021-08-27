//
//  CurrencyRowDataView.swift
//  CurrencyRowDataView
//
//  Created by Andrew Morgan on 27/08/2021.
//

import SwiftUI
import RealmSwift

struct CurrencyRowDataView: View {
    @ObservedResults(Rate.self) var rates
    @ObservedRealmObject var rate: Rate
    
    let baseAmount: Double
    
    var body: some View {
        CurrencyRowView(value: (rate.result) * baseAmount, symbol: rate.query?.to ?? "")
            .onAppear(perform: loadData)
    }
    
    private func loadData() {
        guard let query = rate.query else {
            print("Query data is missing")
            return
        }
        guard let url = URL(string: "https://api.exchangerate.host/convert?from=\(query.from)&to=\(query.to)") else {
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
                    $rate.date.wrappedValue = decodedResponse.date
                    $rate.result.wrappedValue = decodedResponse.result
                }
            } else {
                print("No data received")
            }
        }
        .resume()
    }
}

struct CurrencyRowDataView_Previews: PreviewProvider {
    static var previews: some View {
        let rate = Rate(from: "GBP", to: "USD", date: "now", result: 1.2345)
        return CurrencyRowDataView(rate: rate, baseAmount: 1.0)
    }
}
