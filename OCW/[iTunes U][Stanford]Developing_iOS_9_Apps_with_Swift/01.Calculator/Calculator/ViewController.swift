import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchedDigti(sender: UIButton) {
        let digitText = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textInCurrentDisplay = display.text!
            display.text! = textInCurrentDisplay + digitText
        }else{
            display.text! = digitText
        }
        userIsInTheMiddleOfTyping = true
        
    }
    @IBAction func performOperation(sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            if mathematicalSymbol == "π"{
                display.text! = String(M_PI)
            }
        }
    }

}

