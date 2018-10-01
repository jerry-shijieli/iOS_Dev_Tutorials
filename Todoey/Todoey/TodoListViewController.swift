//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Jerry on 9/30/18.
//  Copyright © 2018 AppTweaker. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    let storageKey : String = "TodoListArray" // key for local storage retrieval
    let defaults = UserDefaults.standard // local storage

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: storageKey) as? [String]{
            itemArray = items
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

         cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: -Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default, handler: {
            (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: self.storageKey)
            self.tableView.reloadData()
        })
        
        alert.addTextField(configurationHandler: {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
