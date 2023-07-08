//
//  ChartResultCollectionViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 07/07/23.
//

import UIKit

class ChartResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var chartResultImage: UIImageView! {
        didSet {
            chartResultImage.layer.cornerRadius = chartResultImage.frame.width / 2
        }
    }
    
    @IBOutlet var chartResultValue: UILabel!
    @IBOutlet var chartResultKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(image: String, key: String, value: String) {
        chartResultImage.image = UIImage(named: image)
        chartResultValue.text = value
        chartResultKey.text = key
        self.layer.cornerRadius = 8
    }

}
