//
//  ViewController.swift
//  proj
//
//  Created by miguelh on 5/21/21.
//

import UIKit
import HealthKit
import CoreData
var HRVCONSTANT = 80

class ViewController: UIViewController {
    
    @IBOutlet weak var HRVLabel: UILabel!
    @IBOutlet weak var HRLabel: UILabel!
    @IBOutlet weak var stsLabel: UILabel!
    @IBOutlet weak var dayScoreLabel: UILabel!
    @IBOutlet weak var reccomendationLabel: UILabel!
    
    func setSquare(x: Int){
        let screenSize: CGRect = UIScreen.main.bounds
        
        // get screen width.
        let screenWidth = screenSize.width
        
        // get screen height.
        let screenHeight = screenSize.height
        
        // the rectangle top left point x axis position.
        let xPos = 100
        
        // the rectangle top left point y axis position.
        let yPos = 300
        
        // the rectangle width.
        let rectWidth = Int(screenWidth) - 2 * xPos
        
        // the rectangle height.
        let rectHeight = Int(screenHeight) - 2 * yPos
        
        // Create a CGRect object which is used to render a rectangle.
        let rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
        
        // Create a UIView object which use above CGRect object.
        let greenView = UIView(frame: rectFrame)
        
        // Set UIView background color.
        greenView.backgroundColor = UIColor.white
        
        // Add above UIView object as the main view's subview.
        self.view.addSubview(greenView)
 
 if x < HRVCONSTANT{
     print("less than constant")
     print(x)
     print(HRVCONSTANT)
     greenView.backgroundColor = UIColor.red
     self.view.addSubview(greenView)
    reccomendationLabel.text! = "Your HRV is below your average, Please consider taking it easy today."
 }
 if x > HRVCONSTANT{
     print("greater than constant")
     print(x)
     print(HRVCONSTANT)
     greenView.backgroundColor = UIColor.green
     self.view.addSubview(greenView)
    reccomendationLabel.text! = "Your HRV is above your average.  You are ready for any type of workout intensity."

 }
 if x == HRVCONSTANT {
     print("equal to constant")
     print(x)
     print(HRVCONSTANT)
     greenView.backgroundColor = UIColor.gray
     self.view.addSubview(greenView)
    reccomendationLabel.text! = "Your HRV is within your average, You can workout at your normal intensity"


 }
    }

    @IBAction func getReccomendation(_ sender: UIButton) {
        // get screen size object.
               let screenSize: CGRect = UIScreen.main.bounds
               
               // get screen width.
               let screenWidth = screenSize.width
               
               // get screen height.
               let screenHeight = screenSize.height
               
               // the rectangle top left point x axis position.
               let xPos = 100
               
               // the rectangle top left point y axis position.
               let yPos = 300
               
               // the rectangle width.
               let rectWidth = Int(screenWidth) - 2 * xPos
               
               // the rectangle height.
               let rectHeight = Int(screenHeight) - 2 * yPos
               
               // Create a CGRect object which is used to render a rectangle.
               let rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
               
               // Create a UIView object which use above CGRect object.
               let greenView = UIView(frame: rectFrame)
               
               // Set UIView background color.
               greenView.backgroundColor = UIColor.white
               
               // Add above UIView object as the main view's subview.
               self.view.addSubview(greenView)
        
        if Int(MyVariables.HRVToText) ?? 0 < HRVCONSTANT{
            print("less than constant")
            print(Int(MyVariables.HRVToText))
            print(HRVCONSTANT)
            greenView.backgroundColor = UIColor.red
            self.view.addSubview(greenView)
        }
        if Int(MyVariables.HRVToText) ?? 0 > HRVCONSTANT{
            print("greater than constant")
            print(Int(MyVariables.HRVToText))
            print(HRVCONSTANT)
            greenView.backgroundColor = UIColor.green
            self.view.addSubview(greenView)
        }
        if Int(MyVariables.HRVToText) ?? 0 == HRVCONSTANT {
            print("equal to constant")
            print(Int(MyVariables.HRVToText))
            print(HRVCONSTANT)
            greenView.backgroundColor = UIColor.gray
            self.view.addSubview(greenView)

        }
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
        
       /*
        // get screen size object.
               let screenSize: CGRect = UIScreen.main.bounds
               
               // get screen width.
               let screenWidth = screenSize.width
               
               // get screen height.
               let screenHeight = screenSize.height
               
               // the rectangle top left point x axis position.
               let xPos = 100
               
               // the rectangle top left point y axis position.
               let yPos = 300
               
               // the rectangle width.
               let rectWidth = Int(screenWidth) - 2 * xPos
               
               // the rectangle height.
               let rectHeight = Int(screenHeight) - 2 * yPos
               
               // Create a CGRect object which is used to render a rectangle.
               let rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
               
               // Create a UIView object which use above CGRect object.
               let greenView = UIView(frame: rectFrame)
               
               // Set UIView background color.
               greenView.backgroundColor = UIColor.white
               
               // Add above UIView object as the main view's subview.
               self.view.addSubview(greenView)
        */
           
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

            self.setSquare(x: Int(latestHRV))
            
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

