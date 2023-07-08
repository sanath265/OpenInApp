//
//  ChartTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 07/07/23.
//

import UIKit

final class ChartTableViewCell: UITableViewCell {
    
    @IBOutlet private var greetingLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView() {
        nameLabel.text = "sanath"
        greetingLabel.text = greetingMessageAccordingToTime()
    }
    
    func greetingMessageAccordingToTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12 : return "Good Morning"
        case 12..<16 : return "Good Afternoon"
        case 16..<22 : return "Good Evening"
        default: return "Good Night"
        }
    }
    
}
