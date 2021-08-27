//
//  TestSearchView.swift
//  TestSearchView
//
//  Created by Andrew Morgan on 27/08/2021.
//

import SwiftUI

struct TestSearchView: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink(destination: Text(name)) {
                        Text(name)
                    }
                }
            }
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.self) { result in
                    Text("Are you looking for \(result)?").searchCompletion(result)
                }
            }
            .navigationTitle("Contacts")
        }
    }
    var searchResults: [String] {
            if searchText.isEmpty {
                return names
            } else {
                return names.filter { $0.contains(searchText) }
            }
        }

}

struct TestSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TestSearchView()
    }
}
