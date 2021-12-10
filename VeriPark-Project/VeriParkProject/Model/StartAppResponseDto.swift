//
//  StartAppResponseDto.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 7.12.2021.
//

import Foundation

// MARK: - DetailModel
struct StartAppResponseDto: Codable {
    let aesKey, aesIV, authorization: String
    let lifeTime: String
    let status: Status
}

// MARK: - Status
struct Status: Codable {
    let isSuccess: Bool
    let error: Error
}

// MARK: - Error
struct Error: Codable {
    let code: Int
    let message: String
}
