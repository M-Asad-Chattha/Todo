//
//  CategoryViewController.swift
//  Todo
//
//  Created by Muhammad Asad Chattha on 01/12/2019.
//  Copyright © 2019 Muhammad Asad Chattha. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    // Intances and variables
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategories()
    }

    // MARK: - TableView DataSouce Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
         
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    
    // MARK: - Add new Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
          
            textField = field
            textField.placeholder = "Add a new Category"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // Save Category in CoreData
    
    func saveCategories(){
        do{
            try context.save()
        } catch {
            print("Error Saving Category in Core Data: \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    // Load Category from Persistent Container
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Error Loading Cetegories from CoreDate: \(error)")
        }
    }
    
}
