//
//  CoinLinkCell.swift
//  CoinTracker
//
//  Created by Sungwoong Kang on 2022/01/06.
//

import UIKit

class CoinLinkCell: UITableViewCell {
    
    var link: String?

    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapLinkButton(_ sender: UIButton) {
        guard let url = self.link else { return }
        let linkUrl = URL(string: url)

        UIApplication.shared.open(linkUrl!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()        
    }
    
}
