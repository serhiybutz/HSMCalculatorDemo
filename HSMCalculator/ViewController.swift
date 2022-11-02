//
//  ViewController.swift
//  HSMCalculator
//
//  Created by Serhiy Butz on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

import UIKit

let Precision = 14

class ViewController: UIViewController {
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var firstRowStack: UIStackView!
    @IBOutlet weak var secondRowStack: UIStackView!
    @IBOutlet weak var thirdRowStack: UIStackView!
    @IBOutlet weak var fourthRowStack: UIStackView!
    @IBOutlet weak var fifthRowStack: UIStackView!
    @IBOutlet weak var numpadStack: UIStackView!
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var theRedLine: UIProgressView!

    lazy var controller = Controller(actions: self)
    var currentIns: String.Index!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        inputTextView.textContainer.maximumNumberOfLines = 1
        inputTextView.invalidateIntrinsicContentSize()
        inputTextView.textContainer.lineBreakMode = .byTruncatingHead
        inputTextView.isScrollEnabled = true

        self.controller.start()
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        let text = sender.titleLabel!.text!
        if let key = Key.init(rawValue: text) {
            controller.dispatch(CalcEvent(from: key))
        } else {
            print("Unknown key \"\(text)\"")
        }
    }
}
