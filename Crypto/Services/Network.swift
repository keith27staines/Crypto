//
//  Network.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import Foundation

struct Network {
    func transformSessionOutputToData(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse
        else {
            throw CryptoError.invalidResponse()
        }
        let code = response.statusCode
        guard code >= 200 && code < 300
        else {
            throw CryptoError.httpErrorCode(code)
        }
        return output.data
    }
}
