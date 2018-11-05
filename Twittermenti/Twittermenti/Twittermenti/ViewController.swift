//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    var swifter: Swifter?
    
    let sentimentClassifier = TwitterSentimentClassifier()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let filepath = Bundle.main.path(forResource: "secret", ofType: "plist") else {
            fatalError("Cannot find the Property List file for API Keys!")
        }
        
        if let keys = NSDictionary(contentsOfFile: filepath) {
            if let API_Key = keys["API_Key"] as? String, let API_Secret_Key = keys["API_Secret_Key"] as? String {
            
                swifter = Swifter(consumerKey: API_Key, consumerSecret: API_Secret_Key)
                
                let prediction = try! sentimentClassifier.prediction(text: "@apple is good")
                print(prediction.label)
                
                swifter?.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
                    //print(results)
                }) { (error) in
                    print("There is an error with API request, \(error)")
                }
                
            } else {
                fatalError("Cannot find API Keys!")
            }
        } else {
            fatalError("Cannot find API Keys!")
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

