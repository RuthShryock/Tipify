//
//  ViewController.swift
//  Tipify
//
//  Created by Ruth Shryock on 8/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSliderLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    let settings = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.becomeFirstResponder();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setting default tip percentage slider
        let tipPercentage = settings.integer(forKey: "tipPercentage")
        tipSlider.value = Float(tipPercentage)
        tipSliderLabel.text = "\(tipPercentage)%"
        
        // Adjusting for light/dark mode
        if(settings.bool(forKey: "darkMode")){
            overrideUserInterfaceStyle = .dark;
        } else {
            overrideUserInterfaceStyle = .light
        }
    
        // Color and formatting for text and background
        formatView()
    }
    
    
    func formatView() {
        // Title formatting
        self.title = "Tipify"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.customSetColor!]
        self.navigationController?.navigationBar.tintColor = CustomColor.customSetColor
        
        // Text Field formatting
        self.billAmountTextField.textColor = CustomColor.customTextColor
        self.billAmountTextField.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        // Adding popup decimal keypad
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
        
        // Segmented Control formatting
        let textColor = CustomColor.customControlColor
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColor!], for: .normal)
        
        // Color formatting
        self.view.backgroundColor = CustomColor.customBackColor
        self.view.subviews.forEach { (view) in
            if let label = view as? UILabel {
                 label.textColor = CustomColor.customTextColor
             }
        }
    }

    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0.00
        // Get total tip by multiplying tip * totalPercentage
        let tipPercentage = round(tipSlider.value)
        let tip = bill * Double(tipPercentage) / 100
        let total = bill + tip
        
        // Update tip slider label
        tipSliderLabel.text = "\(Int(tipPercentage))%"
        // Update tip amount label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Update total amount
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

