//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jerry on 10/8/18.
//  Copyright © 2018 AppTweaker. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        //tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    
    func save(_ category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error encoding category array: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            
        }

        return cell
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
    
    // MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category: \(error)")
            }
        }
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default, handler: {
            (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(newCategory)
        })
        
        alert.addTextField(configurationHandler: {
            (alertTextField) in
            
            alertTextField.placeholder = "Create a new category"
            textField = alertTextField
            })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
