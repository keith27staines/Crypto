//
//  HomeView.swift
//  Crypto
//
//  Created by Keith Staines on 28/10/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            Color
                .theme
                .background
                .ignoresSafeArea()
            
            VStack {
                homeHeaderView
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView().navigationBarHidden(true)
            }
            NavigationView {
                HomeView().navigationBarHidden(true)
            }
            .preferredColorScheme(.dark)
        }
    }
}
