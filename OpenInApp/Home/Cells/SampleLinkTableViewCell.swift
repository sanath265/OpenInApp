//
//  SampleLinkTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 08/07/23.
//

import UIKit

class SampleLinkTableViewCell: UITableViewCell {
    
    @IBOutlet private var baseView: UIView! {
        didSet {
            baseView.layer.cornerRadius = 8
        }
    }
    @IBOutlet private var linkImageView: UIImageView! {
        didSet {
            linkImageView.layer.cornerRadius = 8
            linkImageView.layer.borderWidth = 1
            linkImageView.layer.borderColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        }
    }
    @IBOutlet private var linkDescription: UILabel!
    @IBOutlet private var linkCreatedTime: UILabel!
    @IBOutlet private var linkNumberOfClicks: UILabel!
    @IBOutlet private var link: UILabel!
    @IBOutlet private var copyButton: UIButton! {
        didSet {
            copyButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet private var linkView: UIView! {
        didSet {
            linkView.layer.cornerRadius = 8
            linkView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        linkView.addDashedBorder(color: UIColor(red: 166 / 255, green: 199 / 255, blue: 1, alpha: 1))
    }
    
    @IBAction func copyButtonClicked() {
        UIPasteboard.general.string = link.text
        self.window?.rootViewController?.showToast(message: "copied to clipboard")
    }

    func setupView(model: LinkData) {
        if let url = model.originalImage {
            setImageFromURL(urlString: url, imageView: linkImageView)
        }
        linkDescription.text = model.title ?? ""
        linkCreatedTime.text = model.timesAgo ?? ""
        linkNumberOfClicks.text = (model.totalClicks ?? 0).description
        link.text = model.smartLink ?? ""
    }
    
    func setImageFromURL(urlString: String, imageView: UIImageView) {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            // Ensure we have data and it can be converted to an image
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "placeholder") // Set the placeholderImage
                }
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = image // Set the downloaded image to the image view
            }
        }.resume()
    }
}
