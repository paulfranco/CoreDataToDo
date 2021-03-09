//
//  TodoItem.swift
//  CoreDataTodo
//
//  Created by Paul Franco on 3/9/21.
//

import Foundation
import CoreData

public class TodoItem: NSManagedObject, Identifiable {
    @NSManaged public var createdAt:Date?
    @NSManaged public var title:String?
}

extension TodoItem {
    static func getAllToDoItems() -> NSFetchRequest<TodoItem> {
        let request:NSFetchRequest<TodoItem> = TodoItem.fetchRequest() as! NSFetchRequest<TodoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
        
    }
}
