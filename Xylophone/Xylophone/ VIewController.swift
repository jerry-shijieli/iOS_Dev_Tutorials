//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation // library used for media

class ViewController: UIViewController{
    
    var audioPlayer : AVAudioPlayer! // nil initially, but no nil in future
    let soundArray = ["note1","note2","note3","note4","note5","note6","note7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        
        playSound(soundArray[sender.tag - 1])
        
    }
    
    func playSound(_ soundFileName: String){ // _ means call func with param name hidden
        let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!) // use try to handle runtime error
        } catch {
            print(error)
        }
        
        audioPlayer.play()
    }

}

