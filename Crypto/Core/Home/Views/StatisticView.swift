//
//  StatisticView.swift
//  Crypto
//
//  Created by Keith Staines on 01/11/2021.
//

import SwiftUI

struct StatisticView: View {
    
    var model: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(model.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack {
                indicator
                Text((model.change ?? 0.0).asPercentageStringWith2DecimalPlaces)
                    .font(.subheadline)
            }
        }
    }
    
    private var indicator: some View {
        Image(systemName: "triangle.fill").font(.caption2)
            .rotationEffect(isPositive ? Angle(degrees: 0) : Angle(degrees: 180))
            .foregroundColor( isPositive ? .green : .red)
            
    }
    
    private var isPositive: Bool { (model.change ?? 0) >= 0 }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        let statistic = Statistic(title: "Title", value: "Value", change: -1)
        StatisticView(model: statistic)
    }
}
