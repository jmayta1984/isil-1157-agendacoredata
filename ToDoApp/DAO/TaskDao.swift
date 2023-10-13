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
    func add(name: String, detail: String)
    //func delete(name: String)
    func delete(task: Task)
    func update(task: Task)
    func getAll() -> [Task]
}

class TaskDao: TaskDaoProtocol {
    func add(name: String, detail: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = name
        task.detail = detail
        
        do {
            try context.save()
        } catch (let error){
            print("Error: \(error)")
        }
    }
    
    func delete(task: Task) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(task)
        do {
            try context.save()
        } catch (let error){
            print("Error: \(error)")
        }

    }
    /*
    func delete(name: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let request: NSFetchRequest<Task>
        
        request = Task.fetchRequest()

        request.predicate = NSPredicate(format: "name = %@", name)
        
        var tasks = [Task]()
        do {
            tasks = try context.fetch(request)
            for task in tasks {
                context.delete(task)
            }
            try context.save()
        } catch (let error) {
            print("Error: \(error)")

        }
    }
    */
    
    func update(task: Task){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
          try context.save()
        } catch (let error) {
            print("Error: \(error)")

        }
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
