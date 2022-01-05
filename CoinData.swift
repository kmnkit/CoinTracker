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
