//
//  ButtonTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 08/07/23.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet var viewAllLinksButton: UIButton! {
        didSet {
            viewAllLinksButton.backgroundColor = .clear
            viewAllLinksButton.layer.cornerRadius = 8
            viewAllLinksButton.layer.borderWidth = 1
            viewAllLinksButton.layer.borderColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1).cgColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
