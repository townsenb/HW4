//
//  ViewController.swift
//  HW3-Solution
//
//  Created by Jonathan Engelsma on 9/7/18.
//  Copyright © 2018 Jonathan Engelsma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var fromUnits: UILabel!
    @IBOutlet weak var toUnits: UILabel!
    @IBOutlet weak var calculatorHeader: UILabel!
    
    var currentMode : CalculatorMode = .Length
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toField.delegate = self
        fromField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // determine source value of data for conversion and dest value for conversion
        var dest : UITextField?

        var val = ""
        if let fromVal = fromField.text {
            if fromVal != "" {
                val = fromVal
                dest = toField
            }
        }
        if let toVal = toField.text {
            if toVal != "" {
                val = toVal
                dest = fromField
            }
        }
        if dest != nil {
            switch(currentMode) {
            case .Length:
                var fUnits, tUnits : LengthUnit
                if dest == toField {
                    fUnits = LengthUnit(rawValue: fromUnits.text!)!
                    tUnits = LengthUnit(rawValue: toUnits.text!)!
                } else {
                    fUnits = LengthUnit(rawValue: toUnits.text!)!
                    tUnits = LengthUnit(rawValue: fromUnits.text!)!
                }
                if let fromVal = Double(val) {
                    let convKey =  LengthConversionKey(toUnits: tUnits, fromUnits: fUnits)
                    let toVal = fromVal * lengthConversionTable[convKey]!;
                    dest?.text = "\(toVal)"
                }
            case .Volume:
                var fUnits, tUnits : VolumeUnit
                if dest == toField {
                    fUnits = VolumeUnit(rawValue: fromUnits.text!)!
                    tUnits = VolumeUnit(rawValue: toUnits.text!)!
                } else {
                    fUnits = VolumeUnit(rawValue: toUnits.text!)!
                    tUnits = VolumeUnit(rawValue: fromUnits.text!)!
                }
                if let fromVal = Double(val) {
                    let convKey =  VolumeConversionKey(toUnits: tUnits, fromUnits: fUnits)
                    let toVal = fromVal * volumeConversionTable[convKey]!;
                    dest?.text = "\(toVal)"
                }
            }
        }
        self.view.endEditing(true)
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        self.fromField.text = ""
        self.toField.text = ""
        self.view.endEditing(true)
    }
    
    @IBAction func modePressed(_ sender: UIButton) {
        clearPressed(sender)
        switch (currentMode) {
        case .Length:
            currentMode = .Volume
            fromUnits.text = VolumeUnit.Gallons.rawValue
            toUnits.text = VolumeUnit.Liters.rawValue
            fromField.placeholder = "Enter length in \(fromUnits.text!)"
            toField.placeholder = "Enter length in \(toUnits.text!)"
        case .Volume:
            currentMode = .Length
            fromUnits.text = LengthUnit.Yards.rawValue
            toUnits.text = LengthUnit.Meters.rawValue
            fromField.placeholder = "Enter volume in \(fromUnits.text!)"
            toField.placeholder = "Enter volume in \(toUnits.text!)"
        }
        calculatorHeader.text = "\(currentMode.rawValue) Conversion Calculator"
        
    }
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == toField) {
            fromField.text = ""
        } else {
            toField.text = ""
        }
    }
}

struct LengthConversionKey : Hashable {
    var toUnits : LengthUnit
    var fromUnits : LengthUnit
}

let lengthConversionTable : Dictionary<LengthConversionKey, Double> = [
    LengthConversionKey(toUnits: .Meters, fromUnits: .Meters) : 1.0,
    LengthConversionKey(toUnits: .Meters, fromUnits: .Yards) : 0.9144,
    LengthConversionKey(toUnits: .Meters, fromUnits: .Miles) : 1609.34,
    LengthConversionKey(toUnits: .Yards, fromUnits: .Meters) : 1.09361,
    LengthConversionKey(toUnits: .Yards, fromUnits: .Yards) : 1.0,
    LengthConversionKey(toUnits: .Yards, fromUnits: .Miles) : 1760.0,
    LengthConversionKey(toUnits: .Miles, fromUnits: .Meters) : 0.000621371,
    LengthConversionKey(toUnits: .Miles, fromUnits: .Yards) : 0.000568182,
    LengthConversionKey(toUnits: .Miles, fromUnits: .Miles) : 1.0
]

struct VolumeConversionKey : Hashable {
    var toUnits : VolumeUnit
    var fromUnits : VolumeUnit
}

let volumeConversionTable : Dictionary<VolumeConversionKey, Double> = [
    VolumeConversionKey(toUnits: .Liters, fromUnits: .Liters) : 1.0,
    VolumeConversionKey(toUnits: .Liters, fromUnits: .Gallons) : 3.78541,
    VolumeConversionKey(toUnits: .Liters, fromUnits: .Quarts) : 0.946353,
    VolumeConversionKey(toUnits: .Gallons, fromUnits: .Liters) : 0.264172,
    VolumeConversionKey(toUnits: .Gallons, fromUnits: .Gallons) : 1.0,
    VolumeConversionKey(toUnits: .Gallons, fromUnits: .Quarts) : 0.25,
    VolumeConversionKey(toUnits: .Quarts, fromUnits: .Liters) : 1.05669,
    VolumeConversionKey(toUnits: .Quarts, fromUnits: .Gallons) : 4.0,
    VolumeConversionKey(toUnits: .Quarts, fromUnits: .Quarts) : 1.0
]


