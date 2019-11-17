//
//  ViewController.swift
//  Todo
//
//  Created by Muhammad Asad Chattha on 17/11/2019.
//  Copyright © 2019 Muhammad Asad Chattha. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //Declare propertie here
    var todoArray = ["Home", "Shopping", "Hostel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        cell.textLabel?.text = todoArray[indexPath.row]
        
        let cellSecond = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cellSecond.textLabel?.text = todoArray[indexPath.row]
        
        return cellSecond
    }
    
    //MARK: TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("You tap: \(todoArray[indexPath.row])")
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (alert) in
            //what will happen once the user click the Add Item button on our UIAlert
            
            self.todoArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

