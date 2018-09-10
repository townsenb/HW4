//
//  UnitsAndModes.swift
//  HW3-Solution
//
//  Created by Jonathan Engelsma on 9/7/18.
//  Copyright © 2018 Jonathan Engelsma. All rights reserved.
//

import Foundation

enum CalculatorMode : String {
    case Length
    case Volume
}
enum LengthUnit : String {
    case Meters = "Meters"
    case Yards = "Yards"
    case Miles = "Miles"
}

enum VolumeUnit : String {
    case Liters
    case Gallons
    case Quarts
}
