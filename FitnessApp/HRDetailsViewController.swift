//
//  HRDetailsViewController.swift
//  proj
//
//  Created by miguelh on 5/26/21.
//

import UIKit
import Charts
var xAxisLabels = ["1"]
var yAxisValues = [0.0]

class HRDetailsViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var HRDetailsLabel: UILabel!
    @IBOutlet weak var fromPersistence: UILabel!
    var lineChart = LineChartView()
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBAction func minus(_ sender: Any) {
        setChart(dataPoints: xAxisLabels, values: yAxisValues)
        self.lineChartView.notifyDataSetChanged()
        viewDidLayoutSubviews()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        setChart(dataPoints: xAxisLabels, values: yAxisValues)
    }
    
    
    func layoutSubviews() {
     super.viewDidLayoutSubviews()
 }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawValuesEnabled = false

        let chartData = LineChartData(dataSets: [chartDataSet])

        lineChartView.data = chartData

        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisLabels)
        lineChartView.xAxis.setLabelCount(xAxisLabels.count, force: true)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true

        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false

        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.legend.enabled = false
    }

}
