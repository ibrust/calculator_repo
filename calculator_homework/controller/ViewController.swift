//
//  ViewController.swift
//  calculator_homework
//
//  Created by Ian Rust on 10/19/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var results_label: UILabel!
    
    var running_total = 0.0
    var current_sign = "+"
    var decimal_used = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sign_switcher_handler(_ sender: UIButton) {
        let text = results_label.text ?? ""
        if (current_sign == "+"){
            results_label.text = "-" + text
            current_sign = "-"
        } else {
            let index = text.index(text.startIndex, offsetBy: 1)
            let substring = text.suffix(from: index)
            results_label.text = String(substring)
            current_sign = "+"
        }
    }
    
    @IBAction func clear_data_handler(_ sender: UIButton) {
        running_total = 0
        results_label.text! = "0"
        decimal_used = false
        current_operation = ""
    }
    
    @IBAction func number_input_handler(_ sender: UIButton) {
        let button_id = sender.accessibilityIdentifier ?? ""
        switch button_id {
        case ".":
            if results_label.text != nil && decimal_used == false {
                results_label.text! += "."
            }
            decimal_used = true
        case "0"..."9":
            if let text = results_label.text {
                if (text == "0" || text == "-0"){
                    if button_id == "."{
                        results_label.text = (results_label.text ?? "") + button_id
                    } else {
                        if (current_sign == "+"){
                            results_label.text = button_id
                        } else {
                            results_label.text = "-" + button_id
                        }
                    }
                }
                else if (text.count <= 5){
                    results_label.text = (results_label.text ?? "") + button_id
                }
            }
        default:
            print("error in number_input_handler")
            return
        }
    }
    
    var current_operation = ""
    
    @IBAction func math_sign_handler(_ sender: UIButton) {
        let button_id = sender.accessibilityIdentifier ?? ""
        handle_operation(current_operation)
        switch button_id {
        case "%":
            current_operation = ""
            handle_operation("%")
        case "+":
            current_operation = "+"
        case "-":
            current_operation = "-"
        case "x":
            current_operation = "x"
        case "/":
            current_operation = "/"
        default:
            print("error in math_sign_handler")
            return
        }
    }
    
    func handle_operation(_ operation: String){
        switch operation {
        case "%":
            running_total = running_total * 0.01
            results_label.text! = String(running_total)
        case "+":
            running_total += Double(results_label.text!) ?? 0
        case "-":
            running_total -= Double(results_label.text!) ?? 0
        case "x":
            running_total *= Double(results_label.text!) ?? 0
        case "/":
            running_total /= Double(results_label.text!) ?? 0
        case "":
            running_total = Double(results_label.text!) ?? 0
        default:
            return
        }
        if (results_label.text != nil && operation != "%"){
            results_label.text = ""
        }
    }
    
    @IBAction func equals_handler(_ sender: Any) {
        handle_operation(current_operation)
        results_label.text = String(running_total)
        current_operation = ""
    }
    
}

