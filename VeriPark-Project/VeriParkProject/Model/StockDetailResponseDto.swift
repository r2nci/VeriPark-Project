//
//  StockDetailResponseDto.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 9.12.2021.
//

import Foundation

struct StockDetailResponseDto: Codable {
    let isDown, isUp: Bool
    let bid, channge: Double
    let count: Int
    let difference, offer: Double
    let highest: Int
    let lowest, maximum, minimum, price: Double
    let volume: Double
    var symbol: String
    let graphicData: [GraphicDatum]
    let status: Status
}

struct GraphicDatum: Codable {
    let day: Int
    let value: Double
}
