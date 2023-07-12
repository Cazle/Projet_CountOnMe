import Foundation


class Calculator {

    var delegate: functionsToDelegate?
    
    var text = ""
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
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
    func addingOperand(operand: String){
        if canAddOperator {
            delegate?.insertToTextView(add: operand)
            addingText(addText: operand)
        } else {
            delegate?.alertFunction(title: "Error", message: "You have to add one operator at a time.")
            return
        }
    }
    func addingNumberText(numbertext: String){
        if expressionHaveResult {
            delegate?.insertToTextView(add: "")
        }
        delegate?.insertToTextView(add: numbertext)
        addingText(addText: numbertext)
    }
    
    func calculate() {
        guard expressionIsCorrect && expressionHaveEnoughElement else {
            delegate?.alertFunction(title: "Error", message: "Invalid behavior. You must have at least 3 elements, and don't finish by an operator. ")
            return
        }
        // Create local copy of operations
        var operationsToReduce = elements
        print("this is the first", operationsToReduce)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
        
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
                
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
            delegate?.insertToTextView(add: " = " + operationsToReduce[0])
        }
    }
}
