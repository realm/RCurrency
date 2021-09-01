//
//  CurrencyRowDataView.swift
//  CurrencyRowDataView
//
//  Created by Andrew Morgan on 27/08/2021.
//

import SwiftUI
import RealmSwift

struct CurrencyRowDataView: View {
    @ObservedRealmObject var rate: Rate
    
    @Binding var baseAmount: Double
    var action: () -> Void = {}
    
    var body: some View {
        CurrencyRowView(value: (rate.result) * baseAmount,
                        symbol: rate.query?.to ?? "",
                        baseValue: $baseAmount,
                        action: action)
            .onAppear(perform: loadData)
    }
    
    private func loadData() {
        if !rate.isToday {
            guard let query = rate.query else {
                print("Query data is missing")
                return
            }
            guard let url = URL(string: "https://api.exchangerate.host/convert?from=\(query.from)&to=\(query.to)") else {
                print("Invalid URL")
                return
            }
            
            print("Refreshing data from \(url.description)")
            
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
//                        $rate.pendingRefresh.wrappedValue = false
                    }
                } else {
                    print("No data received")
                }
            }
            .resume()
        }
    }
}

struct CurrencyRowDataView_Previews: PreviewProvider {
    static var previews: some View {
        let rate = Rate(from: "GBP", to: "USD", date: "now", result: 1.2345)
        let rate2 = Rate(from: "USD", to: "GBP", date: "now", result: 0.87611)
        
        return List {
            CurrencyRowDataView(rate: rate, baseAmount: .constant(1.0))
            CurrencyRowDataView(rate: rate2, baseAmount: .constant(1.0))
        }
    }
}
