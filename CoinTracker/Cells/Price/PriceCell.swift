//
//  PriceCell.swift
//  CoinTracker
//
//  Created by Sungwoong Kang on 2022/01/06.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
