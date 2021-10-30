//
//  Errors.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import Foundation


struct CryptoError: Error {
    var title: String
    var description: String
    var detail: String
}
