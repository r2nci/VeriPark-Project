//
//  ListViewModel.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 8.12.2021.
//

import Foundation
import CryptoSwift

protocol ListVMDelegate: AnyObject {
    func getStockList(stocksList:[StockDto])
    func withErr(err:String)
    func convertErr(err:String)
}

class ListViewModel {
    weak var delegate: ListVMDelegate?
    func valueToConvert() {
        
    }
    func fetchStocksList(author:String,key:String,iv:String,text:String){
        
        do {
            let aesKey = key
            let key = [UInt8](base64: aesKey)
            
            let aesIV = iv
            let iv = [UInt8](base64: aesIV)
            
            let aes = try AES(key: key, blockMode: CBC(iv: iv))
            let cipherText = try aes.encrypt(Array(text.utf8))
            
            ApiWrapper.getStocksList(paramsAuthor: author, paramsPerioad: cipherText.toBase64()) { response in
                self.delegate?.getStockList(stocksList: response.stocks)
            } failure: { err in
                self.delegate?.withErr(err: err)
            }
        } catch {
            self.delegate?.convertErr(err: error.localizedDescription)
        }
        
        
    }
}
