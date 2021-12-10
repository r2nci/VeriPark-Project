//
//  StocksListResponseDto.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 8.12.2021.
//

import Foundation

struct StocksListResponseDto: Codable {
    let stocks: [StockDto]
    let status: Status
}

// MARK: - Stock
struct StockDto: Codable {
    let id: Int
    let isDown, isUp: Bool
    let bid, difference, offer, price: Double
    let volume: Double
    var symbol: String
}
