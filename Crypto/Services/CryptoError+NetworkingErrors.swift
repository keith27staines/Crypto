//
//  NetworkingErrors.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import Foundation

extension CryptoError {
    
    static func httpErrorCode(_ code: Int) -> CryptoError {
        CryptoError(
            title: "http error \(code)",
            description: "The http response is invalid",
            detail: ""
        )
    }
    
    static func invalidResponse() -> CryptoError {
        CryptoError(
            title: "Invalid Http response",
            description: "The http response is invalid",
            detail: ""
        )
    }
    
    static func invalidImageData() -> CryptoError {
        CryptoError(
            title: "Invalid image data",
            description: "An image could not be constructed from the data",
            detail: ""
        )
    }
        
}
