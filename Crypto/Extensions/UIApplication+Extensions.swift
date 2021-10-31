//
//  UIApplication+Extensions.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
