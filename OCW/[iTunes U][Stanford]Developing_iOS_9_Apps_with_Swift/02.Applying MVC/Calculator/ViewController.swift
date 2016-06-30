import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTyping = false
    
    private var digitValue: Double{
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchedDigti(sender: UIButton) {
        let digitText = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textInCurrentDisplay = display.text!
            display.text! = textInCurrentDisplay + digitText
        }else{
            display.text! = digitText
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(digitValue)
        }
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        digitValue = brain.result
    }

}

