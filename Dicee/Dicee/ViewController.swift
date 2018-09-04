//
//  ViewController.swift
//  Dicee
//
//  Created by Jerry on 9/2/18.
//  Copyright © 2018 AppTweaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var randomDiceIndexLeft: Int = 0
    var randomDiceIndexRight: Int = 0
    
    @IBOutlet weak var diceImageViewLeft: UIImageView!
    @IBOutlet weak var diceImageViewRight: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDiceImage()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        updateDiceImage()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImage()
    }
    
    func updateDiceImage() {
        randomDiceIndexLeft = Int.random(in: 0 ... 5)
        randomDiceIndexRight = Int.random(in: 0 ... 5)
        
        diceImageViewLeft.image = UIImage(named: diceArray[randomDiceIndexLeft])
        diceImageViewRight.image = UIImage(named: diceArray[randomDiceIndexRight])
    }
    
}

