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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // step 2 actions / buttons
    @IBAction func addLemonsToPurchaseButtonPressed(sender: AnyObject) {
        // add lemons to purchase supplies
    }
    @IBAction func reduceLemonsToPurchaseButtonPressed(sender: AnyObject) {
    }
    @IBAction func addIceCubesToPurchaseButtonPressed(sender: AnyObject) {
    }
    @IBAction func reduceIceCubesToPurchaseButtonPressed(sender: AnyObject) {
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
    


}

