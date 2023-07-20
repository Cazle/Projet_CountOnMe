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
    
    func resetingCalculator() {
        delegate?.viewEqualNone()
        text = ""
    }
    func addingText(addText: String) {
        text.append(addText)
    }
    func addingOperand(operand: String) {
        if canAddOperator {
            delegate?.insertToTextView(add: operand)
            addingText(addText: operand)
        } else {
            delegate?.alertFunction(title: "Error", message: "You have to add one operator at a time.")
            return
        }
    }
    func addingNumberText(numbertext: String) {
        if expressionHaveResult {
            delegate?.insertToTextView(add: "")
        }
        delegate?.insertToTextView(add: numbertext)
        addingText(addText: numbertext)
    }
    
    func printTheResult(of elements : [String]) {
        delegate?.viewEqualNone()
        delegate?.insertToTextView(add: elements[0])
        text.removeAll()
        addingText(addText: elements[0])
    }
    
    func formatingNumbers(_ number: Double, style: NumberFormatter.Style = .decimal, maximumDigits: Int = 2) -> String? {
        let formater = NumberFormatter()
        formater.numberStyle = style
        formater.maximumFractionDigits = maximumDigits
        return formater.string(from: NSNumber(value: number))
    }
    
    func calculateThePriorityFirst() -> [String] {
        var priorityToReduce = elements
        
        while priorityToReduce.contains(where: {$0 == "/" || $0 == "x"}) {
            if let index = priorityToReduce.firstIndex(where: {$0 == "/" || $0 == "x"}) {
                guard let left = Double(priorityToReduce[index - 1]) else {break}
                let operand = priorityToReduce[index]
                guard let right = Double(priorityToReduce[index + 1]) else {break}
                
                var result : Double = 0
                
                switch operand {
                case "x": result = left * right
                case "/":
                    if right == 0 {
                        delegate?.alertFunction(title: "Error", message: "Can't divide by zero")
                        resetingCalculator()
                    } else {
                        result = left / right
                    }
                default: delegate?.alertFunction(title: "Erreur", message: "Invalid input")
                }
                if let formateNumber = formatingNumbers(result){
                    for _ in 0...2{
                        priorityToReduce.remove(at: index - 1)
                    }
                    priorityToReduce.insert("\(formateNumber)", at: index - 1)
                    printTheResult(of: priorityToReduce)
                }
            }
        }
        return priorityToReduce
    }
    func calculate() {
        guard expressionIsCorrect && expressionHaveEnoughElement else {
            delegate?.alertFunction(title: "Error", message: "Invalid behavior. You must have at least 3 elements, and don't finish by an operator. ")
            return
        }
        var appendPriorityToElements = calculateThePriorityFirst()
        while appendPriorityToElements.count > 1 {
            
            guard let left = Double(appendPriorityToElements[0]) else {return}
            let operand = appendPriorityToElements[1]
            guard let right = Double(appendPriorityToElements[2]) else {return}
           
            var result: Double = 0
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: delegate?.alertFunction(title: "Error", message: "Invalid operation")
            }
            if let formatedNumber = formatingNumbers(result){
                appendPriorityToElements = Array(appendPriorityToElements.dropFirst(3))
                appendPriorityToElements.insert("\(formatedNumber)", at: 0)
                printTheResult(of: appendPriorityToElements)
            }
            
            
        }
    }
}
