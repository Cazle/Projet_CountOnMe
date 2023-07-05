import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if calculator.expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
        calculator.addingText(addText: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" + ")
            calculator.addingText(addText: " + ")
        } else {
            alertFunction(title: "Error", message: "You have to add one operator at a time.")
            return
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" - ")
            calculator.addingText(addText: " - ")
        } else {
            alertFunction(title: "Error", message: "Yoy have to add one operator at a time.")
            return
        }
    }

    @IBAction func tappedACButton(_ sender: UIButton) {
        textView.text = calculator.resetingCalculator
        calculator.text = ""
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            alertFunction(title: "Zéro!", message: "Démarrez un nouveau calcul !")
            return
        }
        
        guard calculator.expressionHaveEnoughElement else {
            alertFunction(title: "Zéro!", message: "Démarrez un nouveau calcul !")
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = calculator.elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    func alertFunction(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

