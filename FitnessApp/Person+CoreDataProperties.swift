//
//  Person+CoreDataProperties.swift
//  FitnessApp
//
//  Created by miguelh on 6/3/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var date: String?
    @NSManaged public var hr: Int16
    @NSManaged public var hrv: Int16
    @NSManaged public var dateobj: Date?

}

extension Person : Identifiable {

}
