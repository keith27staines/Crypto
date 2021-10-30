//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import SwiftUI


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin]
    
    @Published var portfolioCoins: [Coin]
    
    init() {
        allCoins = [
            DeveloperPreview.instance.coin
        ]
        
        portfolioCoins = [
            DeveloperPreview.instance.coin
        ]
    }
    
    
}
