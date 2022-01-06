//
//  CoinData.swift
//  CoinTracker
//
//  Created by Sungwoong Kang on 2022/01/05.
//

import Foundation

struct Coin: Codable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int    
}

struct CoinDetail: Codable {
    let id: String
    let name: String
    let links: [Link]
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case links = "links_extended"
    }
}

struct Link: Codable {
    let url: String
    let type: String
}

struct priceResponse: Decodable {
    let id: String
    let name: String
    let symbol: String
    let price: Double
    let percentage: Double
    
    init(from decoder: Decoder) throws {
        let rawResponse = try Price(from: decoder)
        
        id = rawResponse.id
        name = rawResponse.name
        symbol = rawResponse.symbol
        price = rawResponse.quotes.usd.price
        percentage = rawResponse.quotes.usd.percentage
    }
}

fileprivate struct Price: Decodable {
    let id: String
    let name: String
    let symbol: String
    let quotes: Quotes
}

fileprivate struct Quotes: Decodable {
    let usd: USD
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

fileprivate struct USD: Decodable{
    let price: Double
    let percentage: Double
    
    enum CodingKeys: String, CodingKey {
        case price
        case percentage = "market_cap_change_24h"
    }
}
