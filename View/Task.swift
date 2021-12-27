//
//  Task.swift
//  KidsBetter
//
//  Created by bxl on 2021/12/18.
//

import CoreData

public class Task: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task>{
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String
    @NSManaged public var isComplete: Bool
    @NSManaged public var image: Data
    
}
