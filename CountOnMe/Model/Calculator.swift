//
//  Calculator.swift
//  CountOnMe
//
//  Created by Kyllian GUILLOT on 03/07/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation


class Calculator {
    
    var text = ""
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    var resetingCalculator : String {
        return  ""
    }
    func addingText(addText: String){
        text.append(addText)
    }
}
