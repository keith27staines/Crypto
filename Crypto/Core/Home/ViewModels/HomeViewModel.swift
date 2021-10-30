//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var error: Error?
    
    var coinServiceSubscription: AnyCancellable?
    
    let coinService = APIFactory.makeCoinService()
    
    init() {
        subscribeToDataServices()
    }
    
    func subscribeToDataServices() {
        coinServiceSubscription = coinService.$model
            .sink { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
            case .finished:
                break
            }
        } receiveValue: { [weak self] allCoins in
            self?.allCoins = allCoins ?? []
        }

    }
    
    
}
