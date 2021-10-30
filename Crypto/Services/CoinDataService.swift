//
//  CoinDataService.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [Coin] = []
    @Published var error: Error? = nil
    private var subscription: AnyCancellable?
    
    init() {
        fetchAllCoins()
    }
    
    private func fetchAllCoins() {
        do {
            let url = try Endpoint.coinData.url
            subscription = URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .default))
                .tryMap { output -> Data in
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
                .decode(type: [Coin].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        self.error = error
                    }
                } receiveValue: { coins in
                    self.allCoins = coins
                }
        } catch {
            self.error = error
        }
    }
}

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
}
