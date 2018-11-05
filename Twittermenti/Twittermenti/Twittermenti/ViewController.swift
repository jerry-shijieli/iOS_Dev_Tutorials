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

    }

    @IBAction func predictPressed(_ sender: Any) {
    
        if let searchText = textField.text {
            guard let filepath = Bundle.main.path(forResource: "secret", ofType: "plist") else {
                fatalError("Cannot find the Property List file for API Keys!")
            }
            
            if let keys = NSDictionary(contentsOfFile: filepath) {
                if let API_Key = keys["API_Key"] as? String, let API_Secret_Key = keys["API_Secret_Key"] as? String {
                    
                    swifter = Swifter(consumerKey: API_Key, consumerSecret: API_Secret_Key)
                    
                    swifter?.searchTweet(using: searchText, lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
                        
                        var tweets = [TwitterSentimentClassifierInput]()
                        var sentimentScore : Double = 0.0

                        if let resultTweets = results.array {
                            for i in 0..<resultTweets.count {
                                if let tweetText = resultTweets[i]["full_text"].string {
                                    print(tweetText)
                                    let tweetForClassification = TwitterSentimentClassifierInput(text: tweetText)
                                    tweets.append(tweetForClassification)
                                }
                            }
                        }

                        do {
                            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                                for pred in predictions {
                                    switch(pred.label) {
                                    case "Pos": sentimentScore += 1
                                    case "Neg": sentimentScore -= 1
                                    default: sentimentScore += 0
                                    }
                                }
                        }catch {
                                print("Cannot make prediction!")
                        }

                        sentimentScore = sentimentScore / Double((tweets.count+1)) * 100
                        print(sentimentScore)
                        
                        if sentimentScore > 20 {
                            self.sentimentLabel.text = "😍"
                        } else if sentimentScore > 10 {
                            self.sentimentLabel.text = "😀"
                        } else if sentimentScore > 0 {
                            self.sentimentLabel.text = "🙂"
                        } else if sentimentScore == 0 {
                            self.sentimentLabel.text = "😑"
                        } else if sentimentScore > -10 {
                            self.sentimentLabel.text = "☹️"
                        } else if sentimentScore > -20 {
                            self.sentimentLabel.text = "😡"
                        } else {
                            self.sentimentLabel.text = "👿"
                        }
                        
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
    }
    
}

