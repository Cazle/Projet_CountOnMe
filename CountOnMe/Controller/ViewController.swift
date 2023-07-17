import UIKit

protocol functionsToDelegate {
    func alertFunction(title: String, message: String)
    func insertToTextView(add: String)
    func viewEqualNone()
}

class ViewController: UIViewController, functionsToDelegate {
    @IBOutlet weak var textView: UITextView!
    
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        calculator.addingText(addText: "")
        calculator.delegate = self
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addingNumberText(numbertext: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.addingOperand(operand: " + ")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.addingOperand(operand: " - ")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.addingOperand(operand: " x ")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.addingOperand(operand: " / ")
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.resetingCalculator()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.calculate()
    }
    
    func alertFunction(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func insertToTextView(add: String){
        textView.text.append(add)
    }
    
    func viewEqualNone(){
        textView.text = ""
    }
}

