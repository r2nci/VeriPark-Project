//
//  StockDetailViewModel.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 9.12.2021.
//

import Foundation
import CryptoSwift

protocol StockDetailVMDelegate: AnyObject {
    func getDetail(detail:StockDetailResponseDto)
    func withError(err:String)
}
class StockDetailViewModel {
    weak var delegate: StockDetailVMDelegate?
    func fetchStockDetail(author:String,key:String,iv:String,id:String){
        
        do {
            let aesKey = key
            let key = [UInt8](base64: aesKey)
            
            let aesIV = iv
            let iv = [UInt8](base64: aesIV)
            
            let aes = try AES(key: key, blockMode: CBC(iv: iv))
            let cipherText = try aes.encrypt(Array(id.utf8))
            ApiWrapper.getStockDetail(paramsID: cipherText.toBase64(), paramsAuthor: author) { response in
                self.delegate?.getDetail(detail: response)
            } failure: { err in
                
                self.delegate?.withError(err: err)
            }
        } catch {
            self.delegate?.withError(err: error.localizedDescription)
        }
        
        
    }
}
