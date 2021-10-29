//
//  Coin.swift
//  Crypto
//
//  Created by Keith Staines on 29/10/2021.
//

import Foundation

let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"

struct Coin: Identifiable, Codable {
    var id: String?
    var symbol: String?
    var name: String?
    var image: String?
    var currentPrice: Double?
    var marketCap: Double?
    var marketCapRank: Double?
    var fullyDilutedValuation: Double?
    var totalVolume: Double?
    var high24H: Double?
    var low24H: Double?
    var priceChange24H: Double?
    var priceChangePercentage24H: Double?
    var marketCapChange24H: Double?
    var marketCapChangePercentage24H: Double?
    var circulatingSupply: Double?
    var totalSupply: Double?
    var maxSupply: Double?
    var ath: Double?
    var athChangePercentage: Double?
    var athDate: String?
    var atl: Double
    var atlChangePercentage: Double?
    var atlDate: String?
    var lastUpdated: String?
    var sparklineIn7D: SparklineIn7D
    var priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath = "ath"
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings = "current_holdings"
    }
    
    var currentHoldingsValue: Double { (currentHoldings ?? 0) * (currentPrice ?? 0)}
    var rank: Int { Int(marketCapRank ?? 0) }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
