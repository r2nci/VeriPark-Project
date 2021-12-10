//
//  ListViewController.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 8.12.2021.
//

import UIKit
import CryptoSwift

class ListViewController: UIViewController, UITextFieldDelegate {

    var startApp: StartAppResponseDto?
    var source : [StockDto]?
    var isIncreasingPrice = false
    var index = 0
    var searchResult: [StockDto] = []
    var menuSource = ["Hisse ve Endesler","Yükselenler","Düşenler","Hacme göre -30","Hacme göre -50","Hacme göre -100"]
    @IBOutlet weak var tableViewMenu: UITableView! {
        didSet {
            tableViewMenu.register(UINib(nibName: "LeftMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftMenuTableViewCell")
            tableViewMenu.backgroundColor = .white
            tableViewMenu.separatorColor = .none
            tableViewMenu.separatorStyle = .none
            tableViewMenu.delegate = self
            tableViewMenu.dataSource = self
        }
    }
    @IBOutlet weak var viewMenu: UIView! {
        didSet {
            viewMenu.isHidden = true
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
            tableView.backgroundColor = .clear
            tableView.separatorColor = .none
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var labelDiff: UILabel! {
        didSet {
            labelDiff.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewStartActionDiff))
            labelDiff.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var labelPrice: UILabel! {
        didSet {
            labelPrice.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewStartActionPrice))
            labelPrice.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var labelVolume: UILabel! {
        didSet {
            labelVolume.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewStartActionVolume))
            labelVolume.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var labelBuying: UILabel! {
        didSet {
            labelBuying.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewStartActionBuying))
            labelBuying.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var labelSell: UILabel! {
        didSet {
            labelSell.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewStartActionSell))
            labelSell.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func viewStartActionSell() {
        isIncreasingPrice.toggle()
        if searchResult.isEmpty {
            if isIncreasingPrice {
                source = source?.sorted(by: { $0.bid < $1.bid })
            } else {
                source = source?.sorted(by: { $0.bid > $1.bid })
            }
        } else {
            if isIncreasingPrice {
                searchResult = searchResult.sorted(by: { $0.bid < $1.bid })
            } else {
                searchResult = searchResult.sorted(by: { $0.bid > $1.bid })
            }
        }
        tableView.reloadData()
    }
    @objc func viewStartActionBuying() {
        isIncreasingPrice.toggle()
        if searchResult.isEmpty {
            if isIncreasingPrice {
                source = source?.sorted(by: { $0.offer < $1.offer })
            } else {
                source = source?.sorted(by: { $0.offer > $1.offer })
            }
        } else {
            if isIncreasingPrice {
                searchResult = searchResult.sorted(by: { $0.offer < $1.offer })
            } else {
                searchResult = searchResult.sorted(by: { $0.offer > $1.offer })
            }
        }
        tableView.reloadData()
    }
    @objc func viewStartActionVolume() {
        isIncreasingPrice.toggle()
        if searchResult.isEmpty {
            if isIncreasingPrice {
                source = source?.sorted(by: { $0.volume < $1.volume })
            } else {
                source = source?.sorted(by: { $0.volume > $1.volume })
            }
        } else {
            if isIncreasingPrice {
                searchResult = searchResult.sorted(by: { $0.volume < $1.volume })
            } else {
                searchResult = searchResult.sorted(by: { $0.volume > $1.volume })
            }
        }
        tableView.reloadData()
    }
    
    @objc func viewStartActionDiff() {
        isIncreasingPrice.toggle()
        if searchResult.isEmpty {
            if isIncreasingPrice {
                source = source?.sorted(by: { $0.difference < $1.difference })
            } else {
                source = source?.sorted(by: { $0.difference > $1.difference })
            }
        } else {
            if isIncreasingPrice {
                searchResult = searchResult.sorted(by: { $0.difference < $1.difference })
            } else {
                searchResult = searchResult.sorted(by: { $0.difference > $1.difference })
            }
        }
        tableView.reloadData()
    }
    @objc func viewStartActionPrice(){
        isIncreasingPrice.toggle()
        if searchResult.isEmpty {
            if isIncreasingPrice {
                source = source?.sorted(by: { $0.price < $1.price })
            } else {
                source = source?.sorted(by: { $0.price > $1.price })
            }
        } else {
            if isIncreasingPrice {
                searchResult = searchResult.sorted(by: { $0.price < $1.price })
            } else {
                searchResult = searchResult.sorted(by: { $0.price > $1.price })
            }
        }
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.textColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "Sembol arayın",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            textField.delegate = self
            textField.tintColor = .white
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.borderWidth = 2
            textField.keyboardAppearance = .dark
        }
    }
    @IBAction func buttonMenu(_ sender: UIButton) {
        viewMenu.isHidden = false
    }
    var viewModel: ListViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let alert = UIAlertController(title: "Bilgi", message: "Sembol, Fiyat, Fark, Hacim, Alış ve Satış parametrelerine tıklayarak sıralamayı düzenleyebilirsiniz", preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                self.dismiss(animated: true, completion: nil)
            }
           
        })
        viewModel.delegate = self
        viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "all")
        // Do any additional setup after loading the view.
    }
    
    
    
    func aesEncrypt(key: String, iv: String, message: String) throws -> String{
        let data = message.data(using: .utf8)!
        // let enc = try AES(key: key, iv: iv, padding: .pkcs5).encrypt([UInt8](data))
        let enc = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data(enc)
        return encryptedData.base64EncodedString()
    }
    
    
    @IBAction func didChanged(_ sender: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(didEndEditing), object: textField)
        perform(#selector(didEndEditing), with: textField, afterDelay: 1.5)
    }
    @objc func didEndEditing(textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count <= 2 {
            let alert = UIAlertController(title: "UYARI", message: "Arama için en az 3 harfli kelime giriniz", preferredStyle: .alert)
            present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
        searchResult.removeAll()
        if let source = self.source{
            for item in source {
                if (item.symbol.range(of: text,options: .caseInsensitive) != nil) {
                    self.searchResult.append(item)
                }
            }
            if self.searchResult.isEmpty {
                self.textField.text = ""
                let alert = UIAlertController(title: "!!!!", message: "Sonuç Bulunamada", preferredStyle: .alert)
                let action = UIAlertAction(title: "Tamam", style: .cancel) { action in
                }
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.tableView.reloadData()
            }
        }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView != tableViewMenu {
        if searchResult.count == 0 {
            return source?.count ?? 0
        } else {
            return searchResult.count
        } }
        else {
            return menuSource.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView != tableViewMenu {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        if var item = source?[indexPath.row] {
            if searchResult.count == 0 {
                guard let startappResponse = startApp else { return UITableViewCell() }
                do {

                    let aesKey = startappResponse.aesKey
                    let key = [UInt8](base64: aesKey)

                    let aesIV = startappResponse.aesIV
                    let iv = [UInt8](base64: aesIV)

                    let aes = try AES(key: key, blockMode: CBC(iv: iv))
                    let cipherText = try aes.decrypt(Array(base64: item.symbol))
                   item.symbol = cipherText.toBase64()
                    source?[indexPath.row].symbol = cipherText.toBase64()
                } catch {
                    print(error)
                }
                if indexPath.row % 2 == 0 {
                    cell.contentView.backgroundColor = .white
                } else {
                    cell.contentView.backgroundColor = .lightGray
                }
                cell.configure(item: item)
            } else {
                if indexPath.row % 2 == 0 {
                    cell.contentView.backgroundColor = .white
                } else {
                    cell.contentView.backgroundColor = .lightGray
                }
                cell.configure(item: searchResult[indexPath.row])
            }
        
        }
      
       return cell
        } else {
            guard let menuCell = tableViewMenu.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell", for: indexPath) as? LeftMenuTableViewCell else { return UITableViewCell() }
            menuCell.labelTitle.text = menuSource[indexPath.row]
            return menuCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != tableViewMenu {
            let vc = StockDetailViewController()
            vc.id = source?[indexPath.row].id ?? 1
            vc.startApp = startApp
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            switch indexPath.row {
            case 0:
                viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "all")
            case 1:
                viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "increasing")
            case 2:
                viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "decreasing")
            case 3:
                viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "volume30")
            case 4:
                viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "volume50")
            case 5:
                viewModel.fetchStocksList(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", text: "volume100")
            default:
                break
            }
            viewMenu.isHidden = true
        }
        
    }
}
extension ListViewController {
    func aesDecrypt(key: String, iv: String, message: String) throws -> String {
        let data = NSData(base64Encoded: message, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let dec = try AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(dec)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
}
extension ListViewController: ListVMDelegate {
    func withErr(err: String) {
        self.showAlert(withTitle: "Hata", withMessage: err)
    }
    
    func convertErr(err: String) {
    self.showAlert(withTitle: "Hata", withMessage: err)
        self.tableView.reloadData()
    }
    
    func getStockList(stocksList: [StockDto]) {
        self.source = stocksList
        tableView.reloadData()
    }
    
}


extension ListViewController {
    
}
