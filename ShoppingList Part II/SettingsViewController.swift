//
//  SettingsViewController.swift
//  ShoppingList Part II
//
//  Created by Paul STUART (000389223) on 10/13/21.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Colour.sharedInstance.selectedColour = UiColorFromHex(rgbValue: colorArray[colourIndex])

        // Do any additional setup after loading the view.
    }
    
    // Colour Variables [yellow, green, blue, white]
    let colorArray = [ 0xfcff00, 0x05c000, 0x0600ff, 0xffffff ]
    var colourIndex = 3
    
    // Convert hexidecimal values to UIColor Values
    func UiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat(rgbValue & 0x000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue:blue, alpha:alpha)

    }

    // Outlet for the Switch Buttons
    @IBOutlet weak var bgDefaultSwitch: UISwitch!
    @IBOutlet weak var bgGreenSwitch: UISwitch!
    @IBOutlet weak var bgBlueSwitch: UISwitch!
    @IBOutlet weak var bgYellowSwitch: UISwitch!
    
   // Action Events for Each Button
    @IBAction func bgDefaultAction(_ sender: Any) {
        if bgDefaultSwitch.isOn {
            // Turn off all other switches
            bgGreenSwitch.setOn(false, animated: true)
            bgYellowSwitch.setOn(false, animated: true)
            bgBlueSwitch.setOn(false, animated: true)
        }
        // Set Colour to Blue in Colour Class, set to the view
        colourIndex = 3
        Colour.sharedInstance.selectedColour = UiColorFromHex(rgbValue: colorArray[colourIndex])
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
        
    }
    
    @IBAction func bgGreenAction(_ sender: Any) {
        if bgGreenSwitch.isOn {
            // Turn off all other switches
            bgDefaultSwitch.setOn(false, animated: true)
            bgYellowSwitch.setOn(false, animated: true)
            bgBlueSwitch.setOn(false, animated: true)
        }
        // Set Colour to Blue in Colour Class, set to the view
        colourIndex = 1
        Colour.sharedInstance.selectedColour = UiColorFromHex(rgbValue: colorArray[colourIndex])
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
        
    }
    @IBAction func bgBlueAction(_ sender: Any) {
        if bgBlueSwitch.isOn {
            // Turn off all other switches
            bgGreenSwitch.setOn(false, animated: true)
            bgYellowSwitch.setOn(false, animated: true)
            bgDefaultSwitch.setOn(false, animated: true)
        }
        // Set Colour to Blue in Colour Class, set to the view
        colourIndex = 2
        Colour.sharedInstance.selectedColour = UiColorFromHex(rgbValue: colorArray[colourIndex])
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
    }
    @IBAction func bgYellowAction(_ sender: Any) {
        if bgYellowSwitch.isOn {
            // Turn off all other switches
            bgGreenSwitch.setOn(false, animated: true)
            bgDefaultSwitch.setOn(false, animated: true)
            bgBlueSwitch.setOn(false, animated: true)
        }
        // Set Colour to Blue in Colour Class, set to the view
        colourIndex = 0
        Colour.sharedInstance.selectedColour = UiColorFromHex(rgbValue: colorArray[colourIndex])
        self.view.backgroundColor = Colour.sharedInstance.selectedColour
    }
    
    
}
