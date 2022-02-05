//
//  RemoveItemController.swift
//  ShoppingList Part II
//
//  Created by Paul STUART (000389223) on 10/13/21.
//

import UIKit
import SQLite3

class RemoveItemController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var db: OpaquePointer? = nil
    @IBOutlet weak var shoppingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
        
        // Check SQL DB load
        if sqlite3_open(getDBPath(), &db) == SQLITE_OK {
            print("Successfully opened the connection to database")
            // Run the Select Query
            selectQuery()
        } else {
            print("Unable to open the database")
        }        
    }
    
    // Get the Database Path for Shopping List ------------------------------------------------
    func getDBPath()->String
    {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDir = paths[0]
        let databasePath = (documentDir as NSString).appendingPathComponent("shoppingDB.db")
        return databasePath;
    }
    
    // Select the Table Rows from Database and present ------------------------------------------------
    func selectQuery() {
        let selectQueryStatement = "SELECT * FROM shoppingList"
        var queryStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(db, selectQueryStatement, -1, &queryStatement, nil) == SQLITE_OK)
        {
            print("Query Result:")
            while (sqlite3_step(queryStatement) == SQLITE_ROW)
            {
                let prodID = Int(sqlite3_column_int(queryStatement, 0))
                let nameField = sqlite3_column_text(queryStatement, 1)
                let prodName = String(cString: nameField!)
                let prodPrice = Double(sqlite3_column_double(queryStatement, 2))
                let typeField = sqlite3_column_text(queryStatement, 3)
                let prodType = String(cString: typeField!)
                let quantity = Int(sqlite3_column_int(queryStatement, 4))
                
                print("\(prodName) | \(prodPrice)")
                let item = Product(key: prodID, name: prodName, price: prodPrice, type: prodType, quantity: quantity)
                appDelegate.ShoppingList.append(item)
            }
        }
        else{
            print("SELECT statement could not be prepared", terminator: "")
        }
        sqlite3_finalize(queryStatement)
        sqlite3_close(db)
    }
    
    // Table View functions ------------------------------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.ShoppingList.count
    }
    
    // Display the Database records
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
        let product:Product = appDelegate.ShoppingList[indexPath.row]
        cell.textLabel!.text = product.itemName
        cell.detailTextLabel!.text = "$ " + String(product.itemPrice) + ", Quantity: " + String(product.quantity)
        return cell
    }
    
    // TableView Function for allowing deletion in interface, call the delete Query Function ------------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            // Delete From Database
            let selectedItem:Product = appDelegate.ShoppingList[indexPath.row]
            let itemName:String = selectedItem.itemName
            deleteQuery(itemName: itemName)
            
            // Update the TableView and remove selected Item
            appDelegate.ShoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            //Refresh tableview
            shoppingTable.reloadData()
            // Load the style Colour Settings from the Colour Class
            super.viewWillAppear(animated)
            self.view.backgroundColor = Colour.sharedInstance.selectedColour
            
        }
    
    // Delete Function using SQL Query ------------------------------------------------
    func deleteQuery(itemName:String) {
        let deleteSQL = "DELETE FROM shoppingList WHERE itemName = ('\(itemName)')"
        print(deleteSQL)
        var queryStatement: OpaquePointer? = nil
        if sqlite3_open(appDelegate.getDBPath(), &db) == SQLITE_OK
        {
            print("Successfully conected to database for the delete Query", terminator: "")
            
            if (sqlite3_prepare_v2(db, deleteSQL, -1, &queryStatement, nil) == SQLITE_OK)
            {
                if sqlite3_step(queryStatement) == SQLITE_DONE
                {
                    print("Record Delete!")
                }
                else{
                    print("Failed to Delete Record")
                }
                sqlite3_finalize(queryStatement)
            }
            else{
                print("Delete stateemnt could not be prepared", terminator: "")
            }
            sqlite3_close(db)
        }
        else{
            print("Unable to open Database for delete Query to execute", terminator: "")
        }
    }
    
    
    
    
    

}
