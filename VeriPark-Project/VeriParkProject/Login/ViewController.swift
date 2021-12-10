//
//  ViewController.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 7.12.2021.
//

import UIKit
import CryptoSwift
import Alamofire

class ViewController: UIViewController {
    
    var startAppResponse: StartAppResponseDto?
    var viewModel: LoginViewModel = LoginViewModel()
    @IBOutlet weak var buttonLogin: UIButton! {
        didSet {
            buttonLogin.backgroundColor = .gray
            buttonLogin.setTitleColor(.black, for: .normal)
            buttonLogin.layer.cornerRadius = buttonLogin.frame.height/2
            buttonLogin.setTitle("IMKB Hisse Senetleri/Endeksler", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.startApp()
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        let vc = ListViewController()
//        vc.modalPresentationStyle = .fullScreen
        vc.startApp = self.startAppResponse
//        self.present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: LoginVMDelegate {
    func startAppResponse(response: StartAppResponseDto) {
        self.startAppResponse = response
    }
    func withErr(err:String) {
        self.showAlert(withTitle: "Hata", withMessage: err)
    }
    
}
