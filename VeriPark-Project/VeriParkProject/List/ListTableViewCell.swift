//
//  ListTableViewCell.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 8.12.2021.
//

import UIKit
import CryptoSwift

class ListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var labelSymbol: UILabel!
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelSell: UILabel!
    @IBOutlet weak var labelBuy: UILabel!
    @IBOutlet weak var labelVolume: UILabel!
    @IBOutlet weak var labelDiff: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(item:StockDto) {
        labelVolume.text = String(item.volume)
        labelSymbol.text = String(item.symbol)
        labelSell.text = String(item.bid)
        labelBuy.text = String(item.offer)
        labelDiff.text = String(item.difference)
        labelPrice.text = String(item.price)
        if item.isUp == true {
            imageViewIcon.image = UIImage(named: "upArrow")
        } else if item.isDown == true {
            imageViewIcon.image = UIImage(named: "downArrow")
        } else {
            imageViewIcon.image = UIImage(named: "equalArrow")
        }
    }
    
}
