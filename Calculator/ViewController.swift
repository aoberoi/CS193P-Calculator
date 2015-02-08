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
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var historyIsBlank = true

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsInTheMiddleOfTypingANumber) {
            if (digit != "." || display.text!.rangeOfString(".") == nil) {
                display.text = display.text! + digit
            }
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendConstant(sender: UIButton) {
        let constant = sender.currentTitle!
        if (userIsInTheMiddleOfTypingANumber) {
            enterFromUser()
        }
        
        switch constant {
        case "π":
            displayValue = M_PI
            enter()
        default: break
        }
        updateHistory(constant)
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if (userIsInTheMiddleOfTypingANumber) {
            enterFromUser()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default: break
        }
        updateHistory(operation)
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = [Double]()
    
    @IBAction func enterFromUser() {
        enter()
        updateHistory(display.text!)
    }
    
    func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
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
    
    func updateHistory(newItem: String) {
        if (historyIsBlank) {
            history.text = newItem
            historyIsBlank = false
        } else {
            history.text = history.text! + " \(newItem)"
        }
    }
}

