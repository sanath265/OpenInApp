//
//  ChartTableViewCell.swift
//  OpenInApp
//
//  Created by Sanath on 07/07/23.
//

import UIKit
import Charts
import Foundation

final class ChartTableViewCell: UITableViewCell {
    
    @IBOutlet private var greetingLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var chartView: LineChartView! {
        didSet {
            chartView.layer.cornerRadius = 8
            chartView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            chartView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private var chartOverviewView: UIView! {
        didSet {
            chartOverviewView.layer.cornerRadius = 8
            chartOverviewView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            chartOverviewView.layer.masksToBounds = true
        }
    }
    @IBOutlet private var chartHeadingLabel: UILabel!
    @IBOutlet private var chartLegend: UILabel!
    @IBOutlet private var chartLegendView: UIView! {
        didSet {
            chartLegendView.layer.cornerRadius = 6
            chartLegendView.layer.borderWidth = 1
            chartLegendView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(data: [String: Int]) {
        nameLabel.text = "sanath"
        greetingLabel.text = greetingMessageAccordingToTime()
        createChart(chartData: data)
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
    
    func createChart(chartData: [String: Int]) {
        var entries = [ChartDataEntry]()
        var count: Double = 0
        var xAxisLabels = [String]()
        let data = chartData.sorted { $0.key < $1.key }
        data.forEach { (key, value) in
            entries.append(ChartDataEntry(x: count, y: Double(value)))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            if let date = dateFormatter.date(from: key) {
                dateFormatter.dateFormat = "dd MMM"
                let formattedDateString = dateFormatter.string(from: date)
                xAxisLabels.append(formattedDateString)
            }
            count += 1
        }
        chartLegend.text = "\(xAxisLabels.first ?? "") - \(xAxisLabels.last ?? "")"
        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.colors = [UIColor(red: 14 / 255, green: 111 / 255, blue: 1, alpha: 1)]
        dataSet.circleColors = [UIColor.clear]
        dataSet.circleHoleColor = UIColor.clear
        dataSet.lineWidth = 2.0
        dataSet.drawValuesEnabled = false
        let gradientColors = [UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 1).cgColor,
                              UIColor(red: 0.055, green: 0.435, blue: 1, alpha: 0).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)
        dataSet.drawFilledEnabled = true
        dataSet.fill = LinearGradientFill(gradient: gradient!, angle: 270)
        let chartData = LineChartData(dataSet: dataSet)
        chartView.data = chartData
        chartView.isUserInteractionEnabled = false
        chartView.backgroundColor = UIColor.white
        chartView.xAxis.labelTextColor = UIColor(red: 0.6, green: 0.612, blue: 0.627, alpha: 1)
        chartView.xAxis.gridColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        chartView.leftAxis.gridColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        chartView.rightAxis.gridColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        let xAxisValueFormatter = XAxisStringValueFormatter(labels: xAxisLabels)
        chartView.xAxis.valueFormatter = xAxisValueFormatter
        chartView.leftAxis.labelTextColor = UIColor(red: 0.6, green: 0.612, blue: 0.627, alpha: 1)
        chartView.rightAxis.labelTextColor = .white
        chartView.legend.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.setExtraOffsets(left: 20, top: 15, right: 0, bottom: 15)
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 9)
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 9)
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
//        chartView.xAxis.setLabelCount(5, force: true)
        chartView.xAxis.axisMaxLabels = 7
    }
}

class XAxisStringValueFormatter: NSObject, AxisValueFormatter {
    private var xAxisLabels: [String] = []
    
    init(labels: [String]) {
        super.init()
        self.xAxisLabels = labels
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index >= 0 && index < xAxisLabels.count {
            return xAxisLabels[index]
        }
        return ""
    }
}
