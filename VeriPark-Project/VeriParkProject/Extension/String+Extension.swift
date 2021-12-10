//
//  String+Extension.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 7.12.2021.
//

import Foundation
import CryptoSwift

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
  
 
    
}
