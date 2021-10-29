//
//  Double+Extensions.swift
//  Crypto
//
//  Created by Keith Staines on 29/10/2021.
//

import Foundation

extension Double {
    
    var asCurrencyStringWith2Decimals: String {
        currencyFormatter(minDecimals: 2, maxDecimals: 2).string(from: NSNumber(value: self)) ?? ""
    }
    
    var asCurrencyStringWith2To6Decimals: String {
        currencyFormatter(minDecimals: 2, maxDecimals: 6).string(from: NSNumber(value: self)) ?? ""
    }
    
    var asPercentageStringWith2DecimalPlaces: String {
        asNumberStringWith2DecimalPlaces + "%"
    }
    
    var asNumberStringWith2DecimalPlaces: String {
        String(format: "%.2f", self)
    }
    
    func currencyFormatter(minDecimals: Int,maxDecimals: Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = minDecimals
        formatter.maximumFractionDigits = maxDecimals
        return formatter
    }
}
