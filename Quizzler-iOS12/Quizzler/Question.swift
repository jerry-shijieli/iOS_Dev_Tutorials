//
//  Question.swift
//  Quizzler
//
//  Created by Jerry on 9/11/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    let answer : Bool
    let questionText: String
    
    init(text : String, correctAnswer : Bool) {
        questionText = text
        answer = correctAnswer
    }
}
