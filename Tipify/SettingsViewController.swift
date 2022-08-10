//
//  SettingsViewController.swift
//  Tipify
//
//  Created by Ruth Shryock on 8/8/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var circle1: UIImageView!
    @IBOutlet weak var circle2: UIImageView!
    let settings = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Circle bobbing animations
        UIView.animate(withDuration: 0.4, delay: 0.0,
                       options: [.autoreverse, .repeat], animations: { () -> Void in
           self.circle2.transform = CGAffineTransform(translationX: 0, y: 5)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.0,
                       options: [.autoreverse, .repeat], animations: { () -> Void in
           self.circle1.transform = CGAffineTransform(translationX: 0, y: 5)
        }, completion: nil)
        
        // Setting default tip percentage slider
        let tipPercentage = settings.integer(forKey: "tipPercentage")
        tipSlider.value = Float(tipPercentage)
        tipLabel.text = "\(tipPercentage)%"
        
        // Adjusting for light/dark mode
        if(settings.bool(forKey: "darkMode")){
            darkModeSwitch.isOn = true
            overrideUserInterfaceStyle = .dark;
        } else {
            darkModeSwitch.isOn = false
            overrideUserInterfaceStyle = .light
        }
        
        // Color and formatting for text and background
        formatSettings()
    }
    
  
     func formatSettings() {
        // Title Formatting
        self.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.customSetColor!]
        self.navigationController?.navigationBar.tintColor = CustomColor.customSetColor
         
        // Background and text format
        self.view.backgroundColor = CustomColor.customBackColor
         self.view.subviews.forEach { (view) in
             if let label = view as? UILabel {
                  label.textColor = CustomColor.customTextColor
              }
        }
    }
     
    @IBAction func darkMode(_ sender: Any) {
        if((sender as AnyObject).isOn){
            settings.set(true, forKey: "darkMode")
            overrideUserInterfaceStyle = .dark
            
        } else {
            settings.set(false, forKey: "darkMode")
            overrideUserInterfaceStyle = .light
        }
       
        settings.synchronize()
    }
    
    @IBAction func defaultTipChange(_ sender: UISlider) {
        let tipPercentage = Int((sender).value)
        tipLabel.text = "\(tipPercentage)%"
        settings.set(tipPercentage, forKey: "tipPercentage")
        
        settings.synchronize()
    }
    
}
