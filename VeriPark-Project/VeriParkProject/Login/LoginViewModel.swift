//
//  LoginViewModel.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 8.12.2021.
//

import UIKit

protocol LoginVMDelegate: AnyObject {
    func startAppResponse(response:StartAppResponseDto)
    func withErr(err:String)
}

class LoginViewModel {
    
    weak var delegate: LoginVMDelegate?
    
    func startApp() {
        ApiWrapper.getStartApp { response in
            self.delegate?.startAppResponse(response: response)
        } failure: { err in
            self.delegate?.withErr(err: err)
        }
    }
}
