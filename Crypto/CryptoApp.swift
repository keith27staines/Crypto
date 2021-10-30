//
//  CryptoApp.swift
//  Crypto
//
//  Created by Keith Staines on 28/10/2021.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
                    
            }
            .environmentObject(homeViewModel)
        }
    }
}
