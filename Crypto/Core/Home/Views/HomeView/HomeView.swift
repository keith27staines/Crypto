//
//  HomeView.swift
//  Crypto
//
//  Created by Keith Staines on 28/10/2021.
//

import SwiftUI

struct HomeView: View {
    @State private var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", change: 7),
        Statistic(title: "Title", value: "Value", change: -7),
        Statistic(title: "Title", value: "Value", change: 3),
        Statistic(title: "Title", value: "Value", change: -5)
    ]
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
    }
}

extension HomeView {

    private var contentView: some View {
        VStack {
            homeHeaderView
            statisticsView
            searchBar
            columnHeadersView
            coinListView
            Spacer(minLength: 0)
        }
    }
    
    private var backgroundView: some View {
        Color
            .theme
            .background
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var coinListView: some View {
        if showPortfolio {
            portfolioCoinsList
                .transition(.move(edge: .trailing))
            
        }
        if !showPortfolio {
            allCoinsList
                .transition(.move(edge: .leading))
        }
    }
    
    private var searchBar: some View {
        SearchBar(searchString: $homeViewModel.searchText)
    }
    
    private var columnHeadersView: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CointRowView(coin: coin, showHoldingsColumn: false, imageUrlString: coin.image)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CointRowView(coin: coin, showHoldingsColumn: true, imageUrlString: coin.image)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var homeHeaderView: some View {
        HStack {
            leftButton
            Spacer()
            titleView
            Spacer()
            rightButton
        }
        .padding(.horizontal)
    }
    
    private var leftButton: some View {
        CircleButtonView(iconName: showPortfolio ? "plus" : "info")
            .animation(.none)
            .background(
                CircleButtonAnimationView(animate: $showPortfolio)
                    .foregroundColor(.theme.accent)
            )
    }
    
    private var titleView: some View {
        Text(showPortfolio ? "Portfolio" : "Live Prices")
            .font(.headline)
            .fontWeight(.heavy)
            .foregroundColor(.theme.accent)
            .animation(.none)
    }
    
    private var rightButton: some View {
        CircleButtonView(iconName: "chevron.right")
            .rotationEffect(showPortfolio ? Angle(degrees: 180) : Angle(degrees: 0))
            .onTapGesture {
                withAnimation(.spring()) {
                    showPortfolio.toggle()
                }
            }
    }
    
    private var statisticsView: some View {
        HStack {
            ForEach(statistics) { statistic in
                StatisticView(model: statistic)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .preferredColorScheme(.dark)
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .preferredColorScheme(.dark)
        }
        .environmentObject(dev.homeViewModel)
    }
}
