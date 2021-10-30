//
//  API.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import Foundation
import Combine

//class CoinDataService: API<[Coin]> {
//    init() {
//        super.init(endpoint: .coinData)
//    }
//}

struct APIFactory {
    static func makeCoinService() -> API<[Coin]> {
        let coinService = API<[Coin]>(endpoint: .coinData)
        return coinService
    }
    
    class API<Model: Decodable> {
        @Published var model: Model?
        @Published var error: Error? = nil
        let endpoint: Endpoint
        private var subscription: AnyCancellable?
        
        init(endpoint: Endpoint) {
            self.endpoint = endpoint
            get()
        }
        
        private func get() {
            do {
                let url = try endpoint.url
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
                    .decode(type: Model.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .finished:
                            break
                        case .failure(let error):
                            self.error = error
                        }
                    } receiveValue: { fetchedModel in
                        self.model = fetchedModel
                    }
            } catch {
                self.error = error
            }
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
