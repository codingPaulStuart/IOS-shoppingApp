//
//  Product.swift
//  ShoppingList Part II
//
//  Created by Paul STUART (000389223) on 10/13/21.
//

import Foundation


public class Product {
    
    public var itemKey: Int
    public var itemName: String
    public var itemPrice: Double
    public var itemType: String
    public var quantity: Int
    
    //default
    public init() {
        self.itemKey = 0000
        self.itemName = ""
        self.itemPrice = 0
        self.itemType = ""
        self.quantity = 0
    }
    
    public init(key: Int, name: String, price: Double, type: String, quantity: Int) {
        self.itemKey = key
        self.itemName = name
        self.itemPrice = price
        self.itemType = type
        self.quantity = quantity
    }
    

    
    func toString() -> String
    {
        return "Name: " + self.itemName + " Price: " + String(self.itemPrice) + " Quantity: " + String(self.quantity)
    }
}
