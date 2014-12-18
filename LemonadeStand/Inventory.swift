//
//  Inventory.swift
//  LemonadeStand
//
//  Created by Vincent van Leeuwen on 16/12/14.
//  Copyright (c) 2014 Vincent van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

struct inventoryItem {
    var isLemon = true
    var lemonPrice = 2
    var iceCubePrice = 1
}

struct Supplies {
    var money = 0
    var lemons = 0
    var iceCubes = 0
}

class Customer {
    var preference = 0.0
    
    func calculatePreference () {
        preference = Double(arc4random_uniform(UInt32(10))) / 10

    }
}

struct Weather {
    
}