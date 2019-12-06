  //
//  CategoryViewController.swift
//  Todo
//
//  Created by Muhammad Asad Chattha on 01/12/2019.
//  Copyright © 2019 Muhammad Asad Chattha. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {

    // Intances and variables
    var categories: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        loadCategories()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else { fatalError() }
        
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
    }

    // MARK: - TableView DataSouce Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let cellColor = categories?[indexPath.row].color ?? "#1D9BF6"
        cell.textLabel?.text = categories?[indexPath.row].name ?? "You have empty Category list"
        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: UIColor(hexString: cellColor), isFlat: true)
        
        cell.backgroundColor = UIColor(hexString: cellColor)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
         
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    // MARK: - Add new Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
          
            textField = field
            textField.placeholder = "Add a new Category"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // Delete Category Cell
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row]{

            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting Category cell: \(error)")
            }
        }
    }
    
    
    // Save Category in CoreData
    
    func save(category:Category){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error Saving Category in Core Data: \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    // Load Category from Persistent Container
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
    }
    
}
  
  
  
  
  
  
  
  
  
  
  
