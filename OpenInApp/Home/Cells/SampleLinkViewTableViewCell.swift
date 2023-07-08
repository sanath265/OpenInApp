//
//  SampleLinkViewTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 08/07/23.
//

import UIKit

class SampleLinkViewTableViewCell: UITableViewCell {
    let nibname = String(describing: SampleLinkTableViewCell.self)
    let headerNibName = String(describing: SampleLinkHeaderFooterView.self)
    var buttonAction: ((TapOnLinKType) -> Void)?
    var tapOnLinkAction: (() -> Void)?
    private var tableViewData = [LinkData]()
    private var topLinksData = [LinkData]()
    private var recentLinksData = [LinkData]()
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UINib(nibName: nibname, bundle: nil), forCellReuseIdentifier: nibname)
        tableView.register(UINib(nibName: headerNibName, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: headerNibName)
    }
    
    func setupView(topLinksData: [LinkData], recentLinksData: [LinkData]) {
        tableViewData = topLinksData
        self.topLinksData = topLinksData
        self.recentLinksData = recentLinksData
        reloadTableView()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }
    
}

extension SampleLinkViewTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: nibname, for: indexPath)
        
        if let cell = cell as? SampleLinkTableViewCell {
            cell.setupView(model: tableViewData[indexPath.row])
            cell.buttonAction = {
                if let action = self.tapOnLinkAction {
                    action()
                }
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerNibName)
        if let view = view as? SampleLinkHeaderFooterView {
            view.setupView()
            view.buttonAction = { [weak self] type in
                guard let self else { return }
                if let action = buttonAction {
                    action(type)
                }
                switch type {
                case .topLinks:
                    if tableViewData != topLinksData {
                        tableViewData = topLinksData
                        reloadTableView()
                    }
                case .recentLinks:
                    if tableViewData != recentLinksData {
                        tableViewData = recentLinksData
                        reloadTableView()
                    }
                }
            }
            return view
        }
        return UIView()
    }
}
    
