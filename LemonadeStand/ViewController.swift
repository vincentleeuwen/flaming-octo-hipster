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
    // weather outlet
    @IBOutlet weak var weatherImage: UIImageView!
    
    
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
        // transactions based on items to mix
        var enoughSupplies = false
        if (supply.lemons >= lemonsToMix ) {
            supply.lemons -= lemonsToMix
            enoughSupplies = true
        } else {
            showAlertWithText(message: "You have no more lemons!")
        }
        if (supply.iceCubes >= iceCubesToMix) {
            supply.iceCubes -= iceCubesToMix
            enoughSupplies = true
        } else {
            showAlertWithText(message: "You have no more ice cubes!")
        }
        println(enoughSupplies)
        if (enoughSupplies == true) {
            // start simulation
            let lemonadeMixRatio = Double(lemonsToMix) / Double(iceCubesToMix)
            println("ratio: " + "\(lemonadeMixRatio)")
            let randomNumberOfCustomers = calculateWeather(Int(arc4random_uniform(UInt32(10))))
//            println("random number: " + "\(randomNumberOfCustomers)")
            for var i=0; i < randomNumberOfCustomers; i++ {
//             println(i)
                var customer = Customer()
                customer.calculatePreference()
//            println(customer.preference)
                var result = ""
                if (customer.preference < 0.4 && lemonadeMixRatio > 1) {
                    result = "Preference customer #" + "\(i + 1)" + ": " + "\(customer.preference)" + ". Paid!"
                    println(result)
                    supply.money += 1
                } else if (customer.preference >= 0.4 && customer.preference <= 0.6 && lemonadeMixRatio == 1) {
                    result = "Preference customer #" + "\(i + 1)" + ": " + "\(customer.preference)" + ". Paid!"
                    println(result)
                    supply.money += 1
                } else if (customer.preference > 0.6 && lemonadeMixRatio < 1) {
                    result = "Preference customer #" + "\(i + 1)" + ": " + "\(customer.preference)" + ". Paid!"
                    println(result)
                    supply.money += 1
                } else {
                    result = "Preference customer #" + "\(i + 1)" + ": " + "\(customer.preference)" + ". No match, no revenue!"
                    println(result)
                }
            }
        lemonsToPurchase = 0
        iceCubesToPurchase = 0
        loadAllLabels()
        }
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
//                if (supply.lemons > 0 ) {
//                    supply.lemons -= delta
//                } else {
//                    showAlertWithText(message: "You have no more lemons!")
//                }
            }

        } else {
            if ((iceCubesToMix + delta) > -1) {
                iceCubesToMix += delta
//                if (supply.iceCubes > 0) {
//                    supply.iceCubes -= delta
//                } else {
//                    showAlertWithText(message: "No more ice cubes!")
//                }

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
    func calculateWeather (customers: Int) -> Int {
        // calculate weather based on random number
        var adjustedCustomers = 0
        let randomNumber = Int(arc4random_uniform(UInt32(3)))
        println(customers)
//        return customers
        switch randomNumber {
        case(0):
            println("Cold")
            weatherImage.image = UIImage(named: "cold-1")
            adjustedCustomers = customers - 1
        case(1):
            println("Mild")
            weatherImage.image = UIImage(named: "mild-1")
            adjustedCustomers = customers + 4
        case(2):
            println("Warm")
            weatherImage.image = UIImage(named: "warm-1")
            adjustedCustomers = customers + 9
        default:
            adjustedCustomers = customers
        }
        return adjustedCustomers
    }
}

