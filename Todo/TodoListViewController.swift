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
    var todoArray = [Item]()
    let userDefaults = UserDefaults.standard
    
    //Instance variables & properties
    let newItem = Item()
    let dataPathFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Path: \(dataPathFile)")
        
        loadItems()
        
    }
    
    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = todoArray[indexPath.row]
        cell.textLabel?.text = item.title

        
        //Ternary Operator ==>
        //value = condition ? ifTrueValue : ifFalseValuef
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    
    
    //MARK: TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user click the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.todoArray.append(newItem)
            
            self.saveItems()
            
//            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //SaveData Method
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(todoArray)
            try data.write(to: dataPathFile!)
            
        } catch{
            
            print("Encoding Data error: \(error)")
        }
        tableView.reloadData()
        
    }
    
    
    
    //Load Data from iPhone Storage
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataPathFile!) {
            let decoder = PropertyListDecoder()
            do{
                    todoArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error whilst decoding data: \(error)")
            }
        }
    }
    
}

