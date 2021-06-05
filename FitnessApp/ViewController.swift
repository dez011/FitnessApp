//
//  ViewController.swift
//  proj
//
//  Created by miguelh on 5/21/21.
//

import UIKit
import HealthKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var HRVLabel: UILabel!
    @IBOutlet weak var HRLabel: UILabel!
    @IBOutlet weak var stsLabel: UILabel!
    @IBOutlet weak var dayScoreLabel: UILabel!
    
    //var VCHRV = HRVDetailsViewController()
    @IBAction func updateLabelsButton(_ sender: UIButton) {
        self.updateLabels()
        
    }

    
    
    @IBAction func GetDataButton(_ sender: Any) {
        
        stsLabel.text = ""
        DispatchQueue.global().async {
                 // do some stuf
          

            
                DispatchQueue.main.async(execute: { [self] () -> Void in
                     stsLabel.text = ""
                    self.main()
                    //usleep(18000)
                })
                    

                DispatchQueue.main.async(execute: { [self] () -> Void in
                     stsLabel.text = ""
                    self.main2()


                
                })
             }
        updateLabels()
        
    }
    
    func main(){
       latestHR()
        latestHRV()
        
    }
    func main2(){
        
        updateLabels()
        dayStrainScore()
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
        //self.HRVLabel.text = "\(String(describing: latestHRV))"

        // Do any additional setup after loading the view.
    }

    func authorizeHealthKit(){
        
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .heartRate)!,
                            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!])
        
//        let read = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!,
//                        HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!])
//        let share = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
//
        MyVariables.healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                print("(0_0)")
                // Handle the error here.
            }
            else {
                print("granted")
                //self.latestHRV()
            }
        }
    }
    
    func latestHR(){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)


        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (sample, result, error) in
            guard error == nil else {
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            let latestHR = data.quantity.doubleValue(for: unit)
            let latestHRString: String = String(format: "%.1f", latestHR)
            MyVariables.HRToText = latestHRString
            print("Latest HR \(latestHR) ms")
            
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yy hh:mm s"
            let StartDate = dateFormator.string(from: data.startDate)
            let EndDate = dateFormator.string(from: data.endDate)
            print("StartDate \(StartDate) : EndDate \(EndDate)")
            self.dayStrainScore()


        }
        MyVariables.healthStore.execute(query)
        updateLabels()
    }
    
    
    func latestHRV(){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else {
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)


        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (sample, result, error) in
            guard error == nil else {
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "ms")
            let latestHRV = data.quantity.doubleValue(for: unit)
            let latestHRVString: String = String(format: "%.1f", latestHRV)
            //self.HRVLabel.text!=latestHRVString
            MyVariables.HRVToText = latestHRVString
            print("Latest HRV\(latestHRV) ms")
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yy hh:mm s"
            let StartDate = dateFormator.string(from: data.startDate)
            let EndDate = dateFormator.string(from: data.endDate)
            print("StartDate \(StartDate) : EndDate \(EndDate)")
            self.dayStrainScore()


            
        }
        MyVariables.healthStore.execute(query)
        updateLabels()
    }
    
    
    func updateLabels() {
        
        self.HRLabel.text! = MyVariables.HRToText
        self.HRVLabel.text! = MyVariables.HRVToText
        self.dayScoreLabel.text! = MyVariables.dayScoreText
        
    }
    
    
    //right now im calling it before anything else, i need to call it after.
    func dayStrainScore(){
        let getHRLong = Double(MyVariables.HRToText) ?? 0
        let getHRVLong = Double(MyVariables.HRVToText) ?? 0
        let calc = getHRLong + getHRVLong
        let calcString: String = String(calc)

        if(calc < 100){
            print(calc)
            print("bad day")
            MyVariables.dayScoreText = calcString
            self.updateLabels()
        }
        else {
            print("good day")
            MyVariables.dayScoreText = calcString
            //self.updateLabels()
        }
        self.updateLabels()
    }
    
 
    
    
    
    

}

