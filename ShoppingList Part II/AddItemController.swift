//
//  AddItemController.swift
//  ShoppingList Part II
//
//  Created by Paul STUART (000389223) on 10/13/21.
//

import UIKit
import SQLite3

class AddItemController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var db: OpaquePointer? = nil
    var groupArray: [String] = ["Grocery", "Tech", "Books", "Clothing", "Other"]
    
    
    @IBOutlet weak var ItemNameTextField: UITextField!
    @IBOutlet weak var ItemPriceTextField: UITextField!
    @IBOutlet weak var ItemCategoryTextField: UIPickerView!
    @IBOutlet weak var ItemQuantityTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
    }
    
    override func viewWillAppear(_ animated: Bool) {
            // Load the style Colour Settings from the Colour Class
            super.viewWillAppear(animated)
            self.view.backgroundColor = Colour.sharedInstance.selectedColour
        }
    
    // Populate the Picker View Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupArray[row] as String
    }
   
    
    // Insert new data into database from the form -----------------------------------------
    func insertQuery(item:String, price:Double, group:String, qty:Int) {
        let insertSQL = "INSERT INTO shoppingList(ItemName, ItemPrice, ItemType, Quantity) VALUES ('\(item)','\(price)','\(group)','\(qty)')"
        print(insertSQL)
        var queryStatement: OpaquePointer? = nil
        if sqlite3_open(appDelegate.getDBPath(), &db) == SQLITE_OK
        {
            print("Successfully opened connection to database ")
            
            if (sqlite3_prepare_v2(db, insertSQL, -1, &queryStatement, nil) == SQLITE_OK)
            {
                if sqlite3_step(queryStatement) == SQLITE_DONE
                {
                    print("Record Inserted!")
                    statusLabel.text = "Record Inserted!"
                }
                else
                {
                    print("Fail to Insert")
                }
                sqlite3_close(db)
            }
            else
            {
                print("Unable to open database")
            }
        }
    }
  
    // On Click Event for the Add Button -----------------------------------------
    @IBAction func addClick(_ sender: Any) {
        
        var itemName:String?
        var itemPrice:Double?
        var itemGroup:String?
        var itemQty:Int?
        
        itemName = ItemNameTextField.text
        itemPrice = NSString(string:ItemPriceTextField.text!).doubleValue
        itemGroup = groupArray[ItemCategoryTextField.selectedRow(inComponent: 0)]
        itemQty = NSString(string:ItemQuantityTextField.text!).integerValue
        
        // Validation of entry inputs
        let alertController = UIAlertController (title: "Error", message: "Cannot leave field blank", preferredStyle: .alert)
        let alertAction = UIAlertAction(title:"Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        if (itemName == "" || itemPrice == 0 || itemQty == 0)
        {
            self.present(alertController, animated: true, completion:nil)
        }
        else {
            print(itemGroup!)
            
            insertQuery(item: itemName!, price: itemPrice!, group: itemGroup!, qty: itemQty!)
            let s = Product(key: 222, name: itemName!, price: itemPrice!, type: itemGroup!, quantity: itemQty!)
            appDelegate.ShoppingList.append(s)
            
            statusLabel.text = "Record Added"
            ItemNameTextField.text = ""
            ItemPriceTextField.text = ""
            ItemQuantityTextField.text = ""
            }
        }
}
