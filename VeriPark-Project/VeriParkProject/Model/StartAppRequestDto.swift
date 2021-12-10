//
//  StartAppRequestDto.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 7.12.2021.
//

import Foundation

class StartAppRequestDto: Codable {
    
var deviceID, systemVersion, platformName, deviceModel: String
var manifacturer: String

enum CodingKeys: String, CodingKey {
    case deviceID = "deviceId"
    case systemVersion, platformName, deviceModel, manifacturer
}

init(deviceID: String, systemVersion: String, platformName: String, deviceModel: String, manifacturer: String) {
    self.deviceID = deviceID
    self.systemVersion = systemVersion
    self.platformName = platformName
    self.deviceModel = deviceModel
    self.manifacturer = manifacturer
}
}
