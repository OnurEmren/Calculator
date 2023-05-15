//
//  CalculateViewModel.swift
//  Calculator
//
//  Created by Severus Snape on 9.05.2023.
//

import Foundation

class CalculateViewModel {
    
    var result: Int = 0
    var number1: Double = 0
    var number2: Double = 0
     
     func add(_ number1: Double, _ number2: Double)  -> Int{
        return Int(number1 + number2)
         
     }
    
    func minus(_ number1: Double, _ number2: Double)  -> Int{
       return Int(number1 - number2)
        
    }
    
    func divide(_ number1: Double, _ number2: Double)  -> Int{
       return Int(number1 / number2)
        
    }
    
    func multiply(_ number1: Double, _ number2: Double)  -> Int{
       return Int(number1 * number2)
        
    }
    
}
