//
//  StockDetailViewController.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 9.12.2021.
//

import UIKit
import SwiftChart
import CryptoSwift

class StockDetailViewController: UIViewController {
    var viewModel: StockDetailViewModel = StockDetailViewModel()
    var startApp : StartAppResponseDto?
    var chart = Chart()
    var id : Int = 1
    var day : [String] = []
    var value : [Double] = []
    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDiff: UILabel!
    @IBOutlet weak var labelVolume: UILabel!
    @IBOutlet weak var labelBuy: UILabel!
    @IBOutlet weak var labelSell: UILabel!
    @IBOutlet weak var labelDailyBottom: UILabel!
    @IBOutlet weak var labelMin: UILabel!
    @IBOutlet weak var labelMax: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelDailyPop: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewChart: UIView! {
        didSet {
            viewChart.backgroundColor = .clear
            chart = Chart(frame: CGRect(x: 0, y: 0, width: viewChart.frame.width , height: viewChart.frame.height))
            chart.backgroundColor = .lightGray
            viewChart.addSubview(chart)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        viewModel.delegate = self
     
        viewModel.fetchStockDetail(author: startApp?.authorization ?? "", key: startApp?.aesKey ?? "", iv: startApp?.aesIV ?? "", id: String(id))

    }
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension StockDetailViewController: StockDetailVMDelegate {
    func withError(err: String) {
        self.showAlert(withTitle: "Hata", withMessage: err)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDetail(detail: StockDetailResponseDto) {
        do {

            let aesKey = startApp?.aesKey ?? ""
            let key = [UInt8](base64: aesKey)

            let aesIV = startApp?.aesIV ?? ""
            let iv = [UInt8](base64: aesIV)

            let aes = try AES(key: key, blockMode: CBC(iv: iv))
            let cipherText = try aes.decrypt(Array(base64: detail.symbol))
            labelSymbol.text = "Sembol \(cipherText.toBase64())"
            labelTitle.text = cipherText.toBase64()
        } catch {
            print(error)
        }
        labelPrice.text = "Fiyat \(detail.price)"
        labelDiff.text = "Değişim \(detail.difference)"
        labelVolume.text = "Hacim \(detail.volume)"
        labelBuy.text = "Alış \(detail.bid)"
        labelSell.text = "Satış \(detail.offer)"
        labelDailyBottom.text = "Günlük düşük \(detail.lowest)"
        labelDailyPop.text = "Günlük Yüksek \(detail.highest)"
        labelMax.text = "Max \(detail.maximum)"
        labelMin.text = "Min \(detail.minimum)"
        for item in detail.graphicData {
            self.value.append(item.value)
            self.day.append("\(item.day)")
        }
        if detail.isUp == true {
            imageView.image = UIImage(named: "upArrow")
        } else if detail.isDown == true {
            imageView.image = UIImage(named: "downArrow")
        } else {
            imageView.image = UIImage(named: "equalArrow")
        }
        let series = ChartSeries(value)
        series.color = ChartColors.redColor()
        series.area = true
        chart.add(series)
        chart.minY = detail.minimum
        chart.maxY = detail.maximum
        
    }
}
