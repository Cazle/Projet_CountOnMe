import UIKit

protocol FunctionsToDelegate: AnyObject {
    func alertFunction(title: String, message: String)
    func updateDisplay(with: String)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    private let calculator = Calculator()
    
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
    
    @IBAction func operatorsButtons(_ sender: UIButton) {
        guard let operators = sender.title(for: .normal) else {
            return
        }
        calculator.addingOperand(operand: operators)
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.resetingCalculator()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.calculate()
    }
}

extension ViewController: FunctionsToDelegate {
    
    func alertFunction(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func updateDisplay(with text: String) {
        textView.text = text
    }
}
