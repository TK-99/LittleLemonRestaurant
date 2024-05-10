//
//  UIApplication.swift
//
//  Created by tony on 18/3/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}


struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .font(.headline)

                configuration.label
            }
            .font(.caption)
            .foregroundColor(.theme.green)
        })
    }
}
