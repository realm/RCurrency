//
//  DoubleInput.swift
//  DoubleInput
//
//  Created by Andrew Morgan on 26/08/2021.
//

import SwiftUI

struct DoubleInput: View {
    let title: String
    @Binding var value: Double
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        TextField(title, value: $value, formatter: formatter)
            .keyboardType(.decimalPad)
    }
}

struct DoubleInput_Previews: PreviewProvider {
    static var previews: some View {
        DoubleInput(title: "Number", value: .constant(3.141592654))
    }
}
