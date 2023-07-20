import Foundation


class Calculator {

    weak var delegate: FunctionsToDelegate?
    
    private (set) var text = ""
    
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
    
    func resetingCalculator(){
        delegate?.viewEqualNone()
        text = ""
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
    func checkIfThereIsAPriority() -> Bool {
        if text.contains("/") || text.contains("x") {
            return true
        }
        return false
    }
    
    func calculateThePriorityFirst() -> [String] {
        var priorityToReduce = elements
        while priorityToReduce.contains(where: {$0 == "/" || $0 == "x"}) {
            if let index = priorityToReduce.firstIndex(where: {$0 == "/" || $0 == "x"}) {
                guard let left = Double(priorityToReduce[index - 1]) else {break}
                print(left)
                let operand = priorityToReduce[index]
                print(operand)
                guard let right = Double(priorityToReduce[index + 1]) else {break}
                print(right)
                
                var result : Double = 0
                
                switch operand {
                case "x": result = left * right
                case "/": result = left / right
                default: delegate?.alertFunction(title: "Erreur", message: "Invalid input")
                }
                print(priorityToReduce, "Before the first index - 1")
                priorityToReduce.remove(at: index - 1)
                print(priorityToReduce, "After the first index - 1")
                priorityToReduce.remove(at: index - 1)
                print(priorityToReduce, "After the seconde index - 1")
                priorityToReduce.remove(at: index - 1)
                print(priorityToReduce, "After the third index - 1")
                priorityToReduce.insert("\(result)", at: 2)
                print(priorityToReduce, "Priority after insert result")
                print(result, "Final result")
                }
            }
        print(priorityToReduce, "return priority")
        return priorityToReduce
        
        }
    
        
    
    
    func calculate() {
        guard expressionIsCorrect && expressionHaveEnoughElement else {
            delegate?.alertFunction(title: "Error", message: "Invalid behavior. You must have at least 3 elements, and don't finish by an operator. ")
            return
        }
        // Create local copy of operations
        var appendPriorityToElements = calculateThePriorityFirst()
        var operationsToReduce = elements
        print(operationsToReduce)
       
            
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            guard let left = Double(operationsToReduce[0]) else {return}
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else {return}
           
            var result: Double = 0
            let formater = NumberFormatter()
            formater.numberStyle = .decimal
            formater.maximumFractionDigits = 2
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/":
                if right == 0 {
                    delegate?.alertFunction(title: "Error", message: "Can't divide by zero")
                    resetingCalculator()
                } else {
                    result = left / right
                }
                
            default: delegate?.alertFunction(title: "Error", message: "Invalid operation")
            }
            
            if let formatedNumber = formater.string(from: NSNumber(value: result)) {
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(formatedNumber)", at: 0)
                delegate?.viewEqualNone()
                delegate?.insertToTextView(add: operationsToReduce[0])
                text.removeAll()
                addingText(addText: operationsToReduce[0])
            }
        }
    }
}
