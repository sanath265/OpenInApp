//
//  SupportTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 08/07/23.
//

import UIKit

class SupportTableViewCell: UITableViewCell {
    
    @IBOutlet private var supportBackgroundView: UIView! {
        didSet {
            supportBackgroundView.layer.cornerRadius = 8
            supportBackgroundView.layer.borderWidth = 1
        }
    }
    @IBOutlet private var supportImage: UIImageView!
    @IBOutlet private var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(image: UIImage, borderColor: UIColor, backgroundColor: UIColor, text: String) {
        supportImage.image = image
        supportBackgroundView.layer.borderColor = borderColor.cgColor
        supportBackgroundView.layer.backgroundColor = backgroundColor.cgColor
        label.text = text
    }
    
}
