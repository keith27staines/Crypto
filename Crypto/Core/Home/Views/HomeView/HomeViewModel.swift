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
    @Published var searchText: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    let coinService = APIFactory.makeCoinService()
    
    init() {
        subscribeToDataServices()
    }
    
    func subscribeToDataServices() {
        $searchText
            .combineLatest(coinService.$model)
            .map(filteredCoins)
            .sink { result in
            } receiveValue: { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &subscriptions)
    }
    
    private func filteredCoins(text: String, coins: [Coin]?) -> [Coin] {
        guard let coins = coins, !searchText.isEmpty else {
            return coins ?? []
        }
        return coins.filter { coin in
            let text = text.lowercased()
            let id = (coin.id ?? "").lowercased()
            let symbol = (coin.symbol ?? "").lowercased()
            let name = (coin.name ?? "").lowercased()
            let isIncluded = id.contains(text) || name.contains(text) || symbol.contains(text)
            return isIncluded
        }
    }
}
