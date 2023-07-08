//
//  ComingSoonViewController.swift
//  OpenInApp
//
//  Created by Sanath on 08/07/23.
//

import UIKit

class ComingSoonViewController: UIViewController {
    
    var viewTitle: String
    @IBOutlet var dashBoardImageView: UIView! {
        didSet {
            dashBoardImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private var backButton: UIView! {
        didSet {
            backButton.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet private var backButtonImage: UIImageView! {
        didSet {
            backButtonImage.tintColor = .white
        }
    }
    
    @IBOutlet var comingSoonView: UIView! {
        didSet {
            comingSoonView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet private var titleName: UILabel!
    
    init(title: String) {
        self.viewTitle = title
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonClicked))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.isHidden = true
        titleName.text = viewTitle
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }

}
