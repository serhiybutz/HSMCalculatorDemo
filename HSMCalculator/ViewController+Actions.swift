//
//  ViewController+Actions.swift
//  HSMCalculator
//
//  Created by Serhiy Butz on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

import UIKit

extension ViewController: Actions {
    func clear() {
        inputTextView.text! = "0"
    }
    func insert(_ key: Key) {
        if inputTextView.text! == "0" {
            inputTextView.text = key.rawValue
        } else if inputTextView.text! == "-0" {
            inputTextView.text = "-\(key.rawValue)"
        } else {
            inputTextView.text = "\(inputTextView.text!)\(key.rawValue)"
        }
    }
    func negate() {
        if inputTextView.text.prefix(1) == "-" {
            inputTextView.text = String(inputTextView.text!.dropFirst())
        } else {
            inputTextView.text = "-\(inputTextView.text!)"
        }
    }
    func displayResult(_ result: Double) {
        inputTextView.text = result.cleanValue
    }
    func alert(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Calculator", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in })
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: completion)
        }
    }
    func getOperand() -> Double {
        atof(inputTextView.text!)
    }
}

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
