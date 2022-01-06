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
