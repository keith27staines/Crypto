//
//  CointRowView.swift
//  Crypto
//
//  Created by Keith Staines on 29/10/2021.
//

import SwiftUI

struct CointRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn { middleColumn }
            Spacer()
            rightColumn
        }
        .font(.subheadline)

    }
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text("\(coin.symbol ?? "")".uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var middleColumn: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text((coin.currentHoldingsValue).asCurrencyStringWith2Decimals)
                .bold()
                .foregroundColor(.theme.accent)
            Text(coin.currentHoldings?.asNumberStringWith2DecimalPlaces ?? "")
                .foregroundColor(
                    (coin.priceChange24H ?? 0) > 0 ? .theme.green : .theme.red
                )
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text(coin.currentPrice?.asCurrencyStringWith2To6Decimals ?? "")
                .bold()
                .foregroundColor(.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageStringWith2DecimalPlaces ?? "")
                .foregroundColor(
                    (coin.priceChange24H ?? 0) > 0 ? .theme.green : .theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
    }
}

struct CointRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CointRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            CointRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }

    }
}
