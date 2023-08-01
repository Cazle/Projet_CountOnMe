import Foundation

class Calculator {

    weak var delegate: CalculatorDelegate?
    private var text = "" {
        didSet {
            delegate?.updateDisplay(with: text)
        }
    }
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    func resetingCalculator() {
        text.removeAll()
    }
    
    func addingText(addText: String) {
        text.append(addText)
    }
    func addingOperand(operand: String) {
        if expressionIsCorrect && dontStartWithAnOperand() {
            addingText(addText: " \(operand) ")
        } else {
            delegate?.alertFunction(message: "You can't start with an operator, or having two operators following each others.")
            return
        }
    }
    
    func addingNumberText(numbertext: String) {
        addingText(addText: numbertext)
    }
    
   private func showTheResult(of elements: [String]) {
        resetingCalculator()
        addingText(addText: elements[0])
    }
    
   private func dontStartWithAnOperand() -> Bool {
       !text.isEmpty
    }
        
    private func formatingNumbers(_ number: Double, maximumDigits: Int = 2) -> String? {
        let formater = NumberFormatter()
        formater.maximumFractionDigits = maximumDigits
        return formater.string(from: NSNumber(value: number))
    }
    
    private func calculateThePriorityFirst() -> [String] {
        var priorityToReduce = elements
        
        while priorityToReduce.contains(where: {$0 == "/" || $0 == "x"}) {
            if let index = priorityToReduce.firstIndex(where: {$0 == "/" || $0 == "x"}) {
                guard let left = Double(priorityToReduce[index - 1]) else {break}
                let operand = priorityToReduce[index]
                guard let right = Double(priorityToReduce[index + 1]) else {break}
                
                var result: Double = 0
                
                switch operand {
                case "x": result = left * right
                case "/":
                    if right == 0 {
                        delegate?.alertFunction(message: "Can't divide by zero")
                        resetingCalculator()
                    } else {
                        result = left / right
                    }
                default: delegate?.alertFunction(message: "Invalid input")
                }
                if let formatedNumber = formatingNumbers(result) {
                    for _ in 0...2 {
                        priorityToReduce.remove(at: index - 1)
                    }
                    priorityToReduce.insert("\(formatedNumber)", at: index - 1)
                    showTheResult(of: priorityToReduce)
                }
            }
        }
        return priorityToReduce
    }
    func calculate() {
        guard expressionIsCorrect && expressionHaveEnoughElement else {
            delegate?.alertFunction(
                message: "Invalid behavior. You must have at least 3 elements, and don't finish by an operator.")
            return
        }
        var operationToReduce = calculateThePriorityFirst()
        while operationToReduce.count > 1 {
            guard let left = Double(operationToReduce[0]) else {return}
            let operand = operationToReduce[1]
            guard let right = Double(operationToReduce[2]) else {return}
           
            var result: Double = 0
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: delegate?.alertFunction(message: "Invalid operation")
            }
            if let formatedNumber = formatingNumbers(result) {
                operationToReduce = Array(operationToReduce.dropFirst(3))
                operationToReduce.insert("\(formatedNumber)", at: 0)
                showTheResult(of: operationToReduce)
            }
        }
    }
}
