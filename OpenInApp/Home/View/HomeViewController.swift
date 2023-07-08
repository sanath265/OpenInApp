//
//  ViewController.swift
//  OpenInApp
//
//  Created by Sanath on 07/07/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var sampleLinksHeight: CGFloat = 0
    let viewModel: DashBoardViewModel = DashBoardViewModel()
    @IBOutlet var dashBoardImageView: UIView! {
        didSet {
            dashBoardImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.layer.cornerRadius = 15
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.registerTableViewCells(tableView)
        viewModel.apiCall() { [weak self] data in
            guard let self else { return }
            DispatchQueue.main.async {
                self.viewModel.updateCells()
                self.tableView.reloadData()
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dashboardCells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cells = viewModel.dashboardCells else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row].rawValue, for: indexPath)
        
        if let cell = cell as? ChartTableViewCell {
            cell.setupView()
            return cell
            
        } else if let cell = cell as? ChartResultCollectionTableViewCell {
            cell.setupView(viewModel: viewModel.configureDashBoardResultData() ?? [])
            return cell
            
        } else if let cell = cell as? SampleLinkViewTableViewCell {
            cell.setupView(topLinksData: viewModel.apiResponse?.data?.topLinks ?? [],
                           recentLinksData: viewModel.apiResponse?.data?.recentLinks ?? [])
            cell.buttonAction = { [weak self] type in
                guard let self else { return }
                switch type {
                case .topLinks:
                    self.sampleLinksHeight = (CGFloat(viewModel.apiResponse?.data?.topLinks?.count ?? 0) * 136) + 66
                case .recentLinks:
                    self.sampleLinksHeight = (CGFloat(viewModel.apiResponse?.data?.recentLinks?.count ?? 0) * 136) + 66
                }
            }
            return cell
            
        } else if let cell = cell as? ButtonTableViewCell {
            return cell
            
        }  else if let cell = cell as? SupportTableViewCell {
            switch cells[indexPath.row] {
            case .frequentlyAskedQA:
                cell.setupView(image: UIImage(named: "FAQ")!,
                               borderColor: UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 0.32),
                               backgroundColor: UIColor(red: 0.908, green: 0.944, blue: 1, alpha: 1),
                               text: "Frequently Asked Questions")
            case .supportWhatsapp:
                cell.setupView(image: UIImage(named: "Whatsapp")!,
                               borderColor: UIColor(red: 0.29, green: 0.82, blue: 0.373, alpha: 0.32),
                               backgroundColor: UIColor(red: 0.29, green: 0.82, blue: 0.373, alpha: 0.12),
                               text: "Talk with us")
            default:
                return UITableViewCell()
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.dashboardCells?[indexPath.row] {
        case .links :
            return (CGFloat(viewModel.apiResponse?.data?.topLinks?.count ?? 0) * 136) + 66
        case .supportWhatsapp, .frequentlyAskedQA:
            return 84
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension UIViewController {
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height - 100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveLinear, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}

extension UIView {
    func addDashedBorder(color: UIColor) {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame
        let shapeRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 40)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: (UIScreen.main.bounds.width - 32) / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [5, 5]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

        self.layer.addSublayer(shapeLayer)
    }
}
