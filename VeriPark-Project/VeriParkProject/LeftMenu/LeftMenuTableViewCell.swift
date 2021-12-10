//
//  LeftMenuTableViewCell.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 9.12.2021.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var labelTitle: UILabel! {
        didSet {
            labelTitle.textColor = .black
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            labelTitle.textColor = .red
        } else {
            labelTitle.textColor = .black
        }
    }
    
}
