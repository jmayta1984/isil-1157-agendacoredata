//
//  TaskDao.swift
//  ToDoApp
//
//  Created by user213116 on 10/5/23.
//

import Foundation
import CoreData
import UIKit

protocol TaskDaoProtocol {
    func add(name: String)
    func delete(name: String)
    func getAll() -> [Task]
}

class TaskDao: TaskDaoProtocol {
    func add(name: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = name
        
        do {
            try context.save()
        } catch (let error){
            print("Error: \(error)")
        }
    }
    
    func delete(name: String) {
        
    }
    
    func getAll() -> [Task] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let request: NSFetchRequest<Task>
        
        request = Task.fetchRequest()
        
        var tasks = [Task]()
        do {
            tasks = try context.fetch(request)
        } catch (let error) {
            print("Error: \(error)")

        }
        return tasks
    }
    
    
}
