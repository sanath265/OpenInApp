//
//  SampleLinkHeaderFooterView.swift
//  OpenInApp
//
//  Created by Sanath on 08/07/23.
//

import UIKit

class SampleLinkHeaderFooterView: UITableViewHeaderFooterView {
    
    var buttonAction: ((TapOnLinKType) -> Void)?

    @IBOutlet private var topLinksLabel: UILabel! {
        didSet {
            topLinksLabel.layer.cornerRadius = 18
            topLinksLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet private var recentLinksLabel: UILabel! {
        didSet {
            recentLinksLabel.layer.cornerRadius = 18
            recentLinksLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet private var searchButton: UIButton! {
        didSet {
            searchButton.layer.cornerRadius = 12
            searchButton.setTitle("", for: .normal)
        }
    }
    
    func setupView() {
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapOnTopLinksLabel))
        topLinksLabel.isUserInteractionEnabled = true
        topLinksLabel.addGestureRecognizer(tapOne)
        
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(tapOnRecentLinksLabel))
        recentLinksLabel.isUserInteractionEnabled = true
        recentLinksLabel.addGestureRecognizer(tapTwo)
    }
    
    @objc func tapOnTopLinksLabel() {
        topLinksLabel.backgroundColor = UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 1)
        topLinksLabel.textColor = .white
        recentLinksLabel.textColor = UIColor(red: 153 / 255, green: 156 / 255, blue: 160 / 255, alpha: 1)
        recentLinksLabel.backgroundColor = .clear
        if let action = buttonAction {
            action(.topLinks)
        }
    }
    
    @objc func tapOnRecentLinksLabel() {
        recentLinksLabel.backgroundColor = UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 1)
        recentLinksLabel.textColor = .white
        topLinksLabel.textColor = UIColor(red: 153 / 255, green: 156 / 255, blue: 160 / 255, alpha: 1)
        topLinksLabel.backgroundColor = .clear
        if let action = buttonAction {
            action(.recentLinks)
        }
    }

}

enum TapOnLinKType {
    case topLinks
    case recentLinks
}
