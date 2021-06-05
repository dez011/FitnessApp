//
//  HRVDetailsViewController.swift
//  proj
//
//  Created by miguelh on 5/26/21.
//

import UIKit
import CoreData
//GLOBAL
var arrList = [03]




class HRVDetailsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var HRVDetailsLabel: UILabel!
    @IBOutlet weak var hrvFromDatabaseLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var dueDate = Date()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //data for the table
    var items:[Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HRVDetailsLabel.text! = MyVariables.HRVToText
        tableView.dataSource = self
        tableView.delegate = self
        fetchPeople()
    }
    
    @IBAction func data(_ sender: UIButton) {
        
    }

    func fetchPeople(){
        do {
            //fetch request
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            
            //set the filtering and sorting requests can be a variable
            let pred = NSPredicate(format: "date CONTAINS %@", "")
            request.predicate = pred
            //change the argument to request in order to filter
            self.items = try context.fetch(Person.fetchRequest())
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }

    //doesnt work yet
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Person>(entityName: "hr")
        let sort = NSSortDescriptor(key: #keyPath(Person.date),ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            self.items = try context.fetch(Person.fetchRequest())
           // person = try context.fetch(fetchRequest)
        }catch {
            print("cannot fetch")
        }
        
        
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   // var objMainVC2 = ViewController()
    
    @IBAction func onPlusTapped(){
        let newPerson = Person(context: self.context)
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = "dd/MM/yy"
        let datestrfr = dateFormator.string(from: NSDate() as Date)
        
        let theEnt = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let fetch = NSFetchRequest<Person>(entityName: "Person")
        fetch.entity = theEnt!
        let sort = NSSortDescriptor(key: #keyPath(Person.date), ascending:false)
        fetch.sortDescriptors = [sort]
        fetch.fetchLimit = 1
        
        let results = try! context.fetch(fetch) as![Person]
        print("results \(results)")
        if(results.count > 0){
            print("in first if")
            if(results[0].date != datestrfr){
                print("results[0] \(results[0])")
                print("in second if")
                newPerson.hrv = Int16(Double(MyVariables.HRVToText) ?? 0)
                newPerson.hr = Int16(Double(MyVariables.HRToText) ?? 0)
                newPerson.date = datestrfr
                newPerson.dateobj = self.dueDate
                arrList.append(Int(newPerson.hr))
                xAxisLabels.append(String("8"))
                yAxisValues.append(Double(newPerson.hr))
                print("arrListAppend \(arrList)")
            }
        }else {
            print("in else")
           // newPerson.hrv = Int16(Double(MyVariables.HRVToText) ?? 0)
           // newPerson.hr = Int16(Double(MyVariables.HRToText) ?? 0)
            //newPerson.date = datestrfr
           // newPerson.dateobj = self.dueDate
        }
        
        
        
       
        print("hrv to text")
        print(MyVariables.HRVToText)
        print("hr to text")
        print(MyVariables.HRToText)
        print(newPerson)
        
        do{
            print("saved")
            try self.context.save()
        }
        catch{
            print("error")
        }
    
        self.fetchPeople()
        self.tableView.reloadData()

        }
        
    }



extension HRVDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return MyVariables.people.count
        return self.items?.count ?? 0

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "personcell")
//        cell.textLabel?.text = String(MyVariables.people[indexPath.row].hr)
//        cell.detailTextLabel?.text = String(MyVariables.people[indexPath.row].hrv)
//        return cell

        
        let person = self.items![indexPath.row]
        cell.textLabel?.text = String("hrv \(person.hrv)  \(person.date) ")
        cell.detailTextLabel?.text = String("hr \(person.hr)")
        return cell
    }
    
    //swipe to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            //what person to remove
            let personToRemove = self.items![indexPath.row]
            //reomove the person
            self.context.delete(personToRemove)
            //save changes
            do{
                try self.context.save()
            }catch {
                print("error")
            }
            //refresh
            self.fetchPeople()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}


