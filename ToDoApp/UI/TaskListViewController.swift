//
//  TaskListViewController.swift
//  ToDoApp
//
//  Created by user213116 on 10/5/23.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = TaskDao().getAll()


    }

    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New task", message: "Add a new task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default ){ action in
            guard let textField = alert.textFields?[0], let taskName = textField.text else {
                return
            }
            guard let textField = alert.textFields?[1], let taskDetail = textField.text else {
                return
            }
            
            TaskDao().add(name: taskName, detail: taskDetail)
            self.tasks = TaskDao().getAll()
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addTextField()
        
        alert.addAction(saveAction)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskViewCell
        
        cell.nameLabel.text = tasks[indexPath.row].name
        cell.detailLabel.text = tasks[indexPath.row].detail

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
      
            TaskDao().delete(task: tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            /*
            self.tasks = TaskDao().getAll()
            self.tableView.reloadData()
            */
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Update task", message: "Modify task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default ){ action in
            guard let textField = alert.textFields?[0], let taskName = textField.text else {
                return
            }
            guard let textField = alert.textFields?[1], let taskDetail = textField.text else {
                return
            }
            
            self.tasks[indexPath.row].name = taskName
            self.tasks[indexPath.row].detail = taskDetail
            TaskDao().update(task: self.tasks[indexPath.row])
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textField in
            textField.text = self.tasks[indexPath.row].name
        }
        alert.addTextField { textField in
            textField.text = self.tasks[indexPath.row].detail
        }
        
        alert.addAction(saveAction)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    

}
