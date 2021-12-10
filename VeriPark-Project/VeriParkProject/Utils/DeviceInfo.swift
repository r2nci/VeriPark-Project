//
//  DeviceInfo.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 7.12.2021.
//

import Foundation
import CoreTelephony
import UIKit


class DeviceInfo {
   static  func deviceName() -> String {

        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { uid, element in
            guard let value = element.value as? Int8, value != 0 else { return uid }
            return uid + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
        
    }
    
    static func deviceVersion() -> String {
        
        let currentDevice = UIDevice.current
        return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
        
    }
    
    static func getUUID() -> String {
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            return uuid
        } else {
            return ""
        }
    }
    
    static func getPlatformName() -> Bool {
                #if IOS_SIMULATOR
                    return true
                #else
                    return false
                #endif
        }
}
