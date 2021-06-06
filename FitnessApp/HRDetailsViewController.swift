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
        //xAxisLabels.append("8")
        //yAxisValues.append(25.0)
        //setChart(dataPoints: [String], values: [Double])
        setChart(dataPoints: xAxisLabels, values: yAxisValues)
        self.lineChartView.notifyDataSetChanged()
        viewDidLayoutSubviews()
//        if items != nil{
//        for i in items!{
//            yAxisValues.append(Double(i.hr))
//            xAxisLabels.append(String(i.hr))
//        }
//        }else{
//            print("error")
//            
//        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        
//        if MyVariables.HRToText != nil {
//            
//            HRDetailsLabel.text = MyVariables.HRToText
//        }
        setChart(dataPoints: xAxisLabels, values: yAxisValues)

        //let person = Person(context: PersistenceService.context)
        //fromPersistence.text = String(person.hr)
        // Do any additional setup after loading the view.
    }
    
    
    func layoutSubviews() {
     super.viewDidLayoutSubviews()
 }
    
    

    //setChart(dataPoints: months, values: unitsSold)
    
    
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
    
    
    
    
    
    /*
    var arr = [10,11,15]
    var x = 16
    @IBAction func onPlusTapped2(){

       // let person = Person(context: PersistenceService.context)
      //  person.name="name"
       // person.age=22
        //person.hrv = Double(MyVariables.HRVToText)!
        //person.hr = Int16(Double(MyVariables.HRToText)!)
        //PersistenceService.saveContext()
        ///MyVariables.people.append(person)
        //fromPersistence.text = String(person.hr)
        //self.tableView.reloadData()
       
        x += 5
        arrList.append(Int(x))
        //arr.append(Int(person.hr))
        viewDidLayoutSubviews()
        print(arr)
        
    }
    
    
    
    func layoutSubviews() {
     super.viewDidLayoutSubviews()
 }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y:0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        //arr = [10,11,12]
        //for x in 0..<10 {
        for x in arrList {
            entries.append(ChartDataEntry(x: Double(x),
                                             y: Double(x)))
    }
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
