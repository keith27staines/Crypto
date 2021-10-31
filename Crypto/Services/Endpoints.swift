//
//  Endpoints.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import Foundation


enum Endpoint: String {
    
    case coinData = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    var url: URL {
        get throws {
            try URL(endpoint: self)
        }
    }
}

extension CryptoError {
    static func endpointError(_ endpoint: Endpoint) -> CryptoError {
        CryptoError(
            title: "Bad URL for api endpoint",
            description: "A valid url could not be constructed",
            detail: endpoint.rawValue
        )
    }
    
    static func badURLString(_ urlString: String?) -> CryptoError {
        guard let urlString = urlString, !urlString.isEmpty else {
            return CryptoError(
                title: "Bad URL",
                description: "The urlString was missing or empty",
                detail: urlString ?? ""
            )
        }

        return CryptoError(
            title: "Bad URL",
            description: "A valid url could not be constructed",
            detail: urlString
        )
    }
}

extension URL {
    init(endpoint: Endpoint) throws {
        guard
            let url = URL(string: endpoint.rawValue)
        else {
            throw CryptoError.endpointError(endpoint)
        }
        self = url
    }
}
