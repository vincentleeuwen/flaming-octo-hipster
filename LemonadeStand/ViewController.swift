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
    var moneyLeft = 0
    var lemonInventory = 0
    var iceCubeInventory = 0
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moneyLeft = 10
        lemonInventory = 1
        iceCubeInventory = 1
        println(moneyLeft)
        self.loadTopLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // step 2 actions / buttons
    @IBAction func addLemonsToPurchaseButtonPressed(sender: AnyObject) {
        // add lemons to purchase supplies
        println("add lemon to purchases clicked!")
        var item = inventoryItem()
        addToPurchases(item)
    }
    @IBAction func reduceLemonsToPurchaseButtonPressed(sender: AnyObject) {
        var item = inventoryItem()
        removeFromPurchases(item)
    }
    @IBAction func addIceCubesToPurchaseButtonPressed(sender: AnyObject) {
        println("add ice cube to purchases clicked!")
        var item = inventoryItem()
        item.isLemon = false
//        println(item)
        addToPurchases(item)
    }
    @IBAction func reduceIceCubesToPurchaseButtonPressed(sender: AnyObject) {
        var item = inventoryItem()
        item.isLemon = false
        removeFromPurchases(item)
    }
    
    
    // step 3 actions
    @IBAction func addLemonsToMixButtonPressed(sender: AnyObject) {
    }
    @IBAction func reduceLemonsToMixButtonPressed(sender: AnyObject) {
    }
    @IBAction func addIceCubesToMixButtonPressed(sender: AnyObject) {
    }
    @IBAction func reduceIceCubesToMixButtonPressed(sender: AnyObject) {
    }
    
    // Start day button pressed
    @IBAction func startDayButtonPressed(sender: AnyObject) {
    }
    
    func loadTopLabels () {
        moneyLeftInTheBankLabel.text = "$" + "\(moneyLeft)"
        lemonsLeftLabel.text = "\(lemonInventory)" + " Lemons"
        iceCubesLeftLabel.text = "\(iceCubeInventory)" + " Ice Cubezzz"
    }
    
    func addToPurchases (product: inventoryItem) {
        println(product)
        if (product.isLemon == true) {
            lemonsToPurchase += 1
            println(lemonsToPurchase)
        } else {
            println("Adding ice cubes...")
            iceCubesToPurchase += 1
        }
    lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
    iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
    }
    func removeFromPurchases (product: inventoryItem) {
        if (product.isLemon == true) {
            if (lemonsToPurchase > 0) {
                lemonsToPurchase -= 1
            }
        } else {
            if (iceCubesToPurchase > 0) {
                iceCubesToPurchase -= 1
            }
        }
    lemonsToPurchaseLabel.text = "\(lemonsToPurchase)"
    iceCubesToPurchaseLabel.text = "\(iceCubesToPurchase)"
    }
    


}

