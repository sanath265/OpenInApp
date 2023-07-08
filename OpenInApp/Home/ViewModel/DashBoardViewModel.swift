//
//  DashBoardViewModel.swift
//  OpenInApp
//
//  Created by Sanath on 07/07/23.
//

import Foundation
import UIKit

final class DashBoardViewModel {
    
    var apiResponse: DashBoardModel?
    var dashboardCells: [DashBoardCellType]?
    
    func apiCall(completionHandler: @escaping (DashBoardModel?) -> Void) {
        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else { return }
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(DashBoardModel.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.apiResponse = decodedData
                    completionHandler(decodedData)
                    return
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func registerTableViewCells(_ tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: ChartTableViewCell.self), bundle: nil), forCellReuseIdentifier: DashBoardCellType.urlChart.rawValue)
        tableView.register(UINib(nibName: String(describing: ChartResultCollectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: DashBoardCellType.chartResult.rawValue)
        tableView.register(UINib(nibName: String(describing: SampleLinkViewTableViewCell.self), bundle: nil), forCellReuseIdentifier: DashBoardCellType.links.rawValue)
        tableView.register(UINib(nibName: String(describing: ButtonTableViewCell.self), bundle: nil), forCellReuseIdentifier: DashBoardCellType.viewAllLinks.rawValue)
        tableView.register(UINib(nibName: String(describing: SupportTableViewCell.self), bundle: nil), forCellReuseIdentifier: DashBoardCellType.supportWhatsapp.rawValue)
        tableView.register(UINib(nibName: String(describing: SupportTableViewCell.self), bundle: nil), forCellReuseIdentifier: DashBoardCellType.frequentlyAskedQA.rawValue)
    }
    
    func updateCells() {
        var cells = [DashBoardCellType]()
        cells.append(DashBoardCellType.urlChart)
        cells.append(DashBoardCellType.chartResult)
        cells.append(DashBoardCellType.links)
        cells.append(DashBoardCellType.viewAllLinks)
        cells.append(DashBoardCellType.supportWhatsapp)
        cells.append(DashBoardCellType.frequentlyAskedQA)
        dashboardCells = cells
    }
    
    func configureDashBoardResultData() -> [DashBoardResultModel]? {
        var result = [DashBoardResultModel]()
        guard let apiResponse else { return nil }
        
        if let data = apiResponse.todayClicks,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Today's clicks",
                                             value: data.description,
                                             image: "result_source"))
        }
        
        if let data = apiResponse.totalLinks,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Total links",
                                             value: data.description,
                                             image: "result_source"))
        }
        
        if let data = apiResponse.totalClicks,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Total clicks",
                                             value: data.description,
                                             image: "result_link"))
        }
        
        if let data = apiResponse.topSource,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Top source",
                                             value: data.description,
                                             image: "result_link"))
        }
        
        if let data = apiResponse.topLocation,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Top location",
                                             value: data.description,
                                             image: "result_location"))
        }
        
        if let data = apiResponse.startTime,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Start time",
                                             value: data.description,
                                             image: "time"))
        }
        
        if let data = apiResponse.appliedCampaign,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Applied campaign",
                                             value: data.description,
                                             image: "result_link"))
        }
        
        if let data = apiResponse.extraIncome,
           !data.description.isEmpty {
            result.append(DashBoardResultModel(key: "Extra income",
                                             value: data.description,
                                             image: "result_link"))
        }
        
        return result
    }
}
