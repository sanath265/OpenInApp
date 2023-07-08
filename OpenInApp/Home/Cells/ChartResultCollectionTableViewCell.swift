//
//  ChatResultCollectionTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 07/07/23.
//

import UIKit

class ChartResultCollectionTableViewCell: UITableViewCell {
    
    var buttonAction: (() -> Void)?
    var viewModel = [DashBoardResultModel]()
    let nibName = String(describing: ChartResultCollectionViewCell.self)
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet var viewAnalyticsButton: UIButton! {
        didSet {
            viewAnalyticsButton.backgroundColor = .clear
            viewAnalyticsButton.layer.cornerRadius = 8
            viewAnalyticsButton.layer.borderWidth = 1
            viewAnalyticsButton.layer.borderColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1).cgColor
        }
    }
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.collectionView?.isScrollEnabled = true
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 12
        layout.collectionView?.showsHorizontalScrollIndicator = false
        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(viewModel: [DashBoardResultModel]) {
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func buttonClicked() {
        if let action = buttonAction {
            action()
        }
    }
}

extension ChartResultCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath)
        let data = viewModel[indexPath.row]
        if let cell = cell as? ChartResultCollectionViewCell {
            cell.setupView(image: data.image, key: data.key, value: data.value)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
