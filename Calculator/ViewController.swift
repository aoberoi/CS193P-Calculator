//
//  ViewController.swift
//  Calculator
//
//  Created by Ankur Oberoi on 2/7/15.
//  Copyright (c) 2015 Ankur Oberoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Impicitly unwrapped optional: The ! at the end of the type actually represents an
    // optional (?) that the compiler will forcibly unwrap on every use. The rationale is
    // that the value is nil when the object is initialized, but before its ever used, the
    // storyboard is wired up and it remains set for the entire lifetime of the ViewController
    // instance.
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    let brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsInTheMiddleOfTypingANumber) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if (userIsInTheMiddleOfTypingANumber) {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

