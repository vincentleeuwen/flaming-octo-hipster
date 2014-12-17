//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Vincent van Leeuwen on 16/12/14.
//  Copyright (c) 2014 Vincent van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // define objects
    @IBOutlet weak var moneyLeftInTheBankLabel: UILabel!
    @IBOutlet weak var lemonsLeftLabel: UILabel!
    @IBOutlet weak var iceCubesLeftLabel: UILabel!
    // step 2 outlets
    @IBOutlet weak var lemonsToPurchaseLabel: UILabel!
    @IBOutlet weak var iceCubesToPurchaseLabel: UILabel!
    // step 3 outlets
    @IBOutlet weak var moreLemonsLabel: UILabel!
    @IBOutlet weak var moreIceCubesLabel: UILabel!
    
    // set variables
    var supply = Supplies()
    var moneyLeft = 0
    var lemonInventory = 0
    var iceCubeInventory = 0
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        supply.money = 10
        supply.lemons = 1
        supply.iceCubes = 1
//        println(moneyLeft)
        self.loadAllLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // step 2 actions / buttons
    @IBAction func addLemonsToPurchaseButtonPressed(sender: AnyObject) {
        // add lemons to purchase supplies
//        println("add lemon to purchases clicked!")
        var item = inventoryItem()
        if (moneyInTheBank(supply) == true) {
            addToPurchases(item)
        } else {
            showAlertWithText(message: "You have no more dinero!")
        }
    }
    @IBAction func reduceLemonsToPurchaseButtonPressed(sender: AnyObject) {
        var item = inventoryItem()
        removeFromPurchases(item)
    }
    @IBAction func addIceCubesToPurchaseButtonPressed(sender: AnyObject) {
//        println("add ice cube to purchases clicked!")
        var item = inventoryItem()
        item.isLemon = false
//        println(item)
        if (moneyInTheBank(supply) == true) {
            addToPurchases(item)
        } else {
            showAlertWithText(message: "You have no more dinero!")
        }
    }
    @IBAction func reduceIceCubesToPurchaseButtonPressed(sender: AnyObject) {
        var item = inventoryItem()
        item.isLemon = false
        removeFromPurchases(item)
    }
    
    
    // step 3 actions
    @IBAction func addLemonsToMixButtonPressed(sender: AnyObject) {
        var lemon = inventoryItem()
        updateMix(lemon, delta: 1)
    }
    @IBAction func reduceLemonsToMixButtonPressed(sender: AnyObject) {
        var lemon = inventoryItem()
        updateMix(lemon, delta: -1)
    }
    @IBAction func addIceCubesToMixButtonPressed(sender: AnyObject) {
        var iceCube = inventoryItem()
        iceCube.isLemon = false
        updateMix(iceCube, delta: 1)
    }
    @IBAction func reduceIceCubesToMixButtonPressed(sender: AnyObject) {
        var iceCube = inventoryItem()
        iceCube.isLemon = false
        updateMix(iceCube, delta: -1)
    }
    
    // Start day button pressed
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        let ratio = Double(lemonsToMix) / Double(iceCubesToMix)
        println("ratio: " + "\(ratio)")
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        println("random number: " + "\(randomNumber)")
    }
    
    func loadAllLabels () {
        moneyLeftInTheBankLabel.text = "$" + "\(supply.money)"
        lemonsLeftLabel.text = "\(supply.lemons)" + " Lemons"
        iceCubesLeftLabel.text = "\(supply.iceCubes)" + " Ice Cubezzz"
        moreLemonsLabel.text = "\(lemonsToMix)"
        moreIceCubesLabel.text = "\(iceCubesToMix)"
        lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
        iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
    }
    
    func addToPurchases (product: inventoryItem) {
        println(product)
        if (product.isLemon == true) {
            lemonsToPurchase += 1
            supply.lemons += 1
            supply.money -= product.lemonPrice
//            println(lemonsToPurchase)
        } else {
            println("Adding ice cubes...")
            iceCubesToPurchase += 1
            supply.iceCubes += 1
            supply.money -= product.iceCubePrice
        }
        
    loadAllLabels()
    }
    func removeFromPurchases (product: inventoryItem) {
        if (product.isLemon == true) {
            if (lemonsToPurchase > 0) {
                lemonsToPurchase -= 1
                supply.lemons -= 1
                supply.money += product.lemonPrice
            }
        } else {
            if (iceCubesToPurchase > 0) {
                iceCubesToPurchase -= 1
                supply.iceCubes -= 1
                supply.money += product.iceCubePrice
            }
        }
    loadAllLabels()
    }
    func updateMix (product: inventoryItem, delta: Int) {
//        println(product)
        if (product.isLemon == true) {
            if ((lemonsToMix + delta) > -1) {
                lemonsToMix += delta
                if (supply.lemons > 0 ) {
                    supply.lemons -= delta
                } else {
                    showAlertWithText(message: "You have no more lemons!")
                }
            }

        } else {
            if ((iceCubesToMix + delta) > -1) {
                iceCubesToMix += delta
                if (supply.iceCubes > 0) {
                    supply.iceCubes -= delta
                } else {
                    showAlertWithText(message: "No more ice cubes!")
                }

            }
        }
    loadAllLabels()
    }

    func moneyInTheBank (supply: Supplies) -> Bool {
        if (supply.money > 0) {
            return true
        } else {
            return false
        }
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}

