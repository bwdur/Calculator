//
//  ViewController.swift
//  Calculator
//
//  Created by brent Durling on 2/23/15.
//  Copyright (c) 2015 Brent Durling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyDisplay: UILabel!
    
    var userIsTypingANumber = false
    var displayDefaultValue = 0
    var operandStack: [Double] = []
    // var operandStack = Array<Double>()
    // another way to declare this array
    
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsTypingANumber{
            if( digit == "." && display.text!.rangeOfString(".") == nil || digit != "."){
                display.text! += digit
            }
        }
        else {
            userIsTypingANumber = true
            display.text = digit
        }
    }
    
    @IBAction func enter() {
        userIsTypingANumber = false
        let digit = (display.text! as NSString).doubleValue
        operandStack.append(displayValue)
        historyDisplay.text! += "  " + display.text!
        println("\(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        historyDisplay.text! += " " + operation
        
        switch operation{
        case "×": performOperation({ $0 * $1 })
        case "÷": performOperation({ $1 / $0 })
        case "+": performOperation({ $0 + $1 })
        case "−": performOperation({ $1 - $0 })
        case "√": performOperation({sqrt($0)})
        case "sin": performOperation({sin($0)})
        case "cos": performOperation({cos($0)})
        case "π": addConstant(M_PI)
        default: break
        }
    }
    
    @IBAction func clear() {
        display.text = "0.0"
        historyDisplay.text = ""
        operandStack = []
    }
    
    func addConstant(constant: Double){
        
        var temp = 0.0
        
        if userIsTypingANumber{
            displayValue = constant * displayValue
        }
        else{
            displayValue = constant
        }
        
        enter()
    }

    func performOperation(operation: (Double, Double) -> Double){
        if userIsTypingANumber{
            enter()
        }
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double){
        if userIsTypingANumber{
            enter()
        }
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
   
    var displayValue: Double{
        get{
            //return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            return (display.text! as NSString).doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsTypingANumber = false
        }
    }
}