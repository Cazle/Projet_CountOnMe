import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        calculator.addingText(addText: "")
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
            alertFunction(title: "Error", message: "You have to add one operator at a time.")
            return
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" x ")
            calculator.addingText(addText: " x ")
        } else {
            alertFunction(title: "Error", message: "You have to add one operator at a time.")
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" / ")
            calculator.addingText(addText: " / ")
        } else {
            alertFunction(title: "Error", message: "You have to add one operator at a time.")
        }    }
    
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
        textView.text.append(" = \(calculator.calculate())")
    }
    func alertFunction(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

