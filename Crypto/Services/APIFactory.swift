//
//  APIFactory.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import Foundation
import Combine

extension APIFactory {
    static func makeCoinService() -> API<[Coin]> {
        let coinService = API<[Coin]>(endpoint: .coinData)
        return coinService
    }
    
    static func makeImageGetter(urlString: String?) -> ImageGetter {
        ImageGetter(urlString: urlString)
    }
}

struct APIFactory {
    
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
                    .tryMap { try Network().transformSessionOutputToData($0) }
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



