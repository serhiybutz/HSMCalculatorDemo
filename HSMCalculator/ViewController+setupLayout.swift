//
//  ViewController+setupLayout.swift
//  HSMCalculator
//
//  Created by Serge Bouts on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

import UIKit

extension ViewController {
    func setupLayout() {

        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.distribution = .fillEqually
        topStack.axis = .vertical

        NSLayoutConstraint.activate([
            topStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            topStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            topStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            topStack.bottomAnchor.constraint(equalTo: theRedLine.topAnchor , constant: -10),
            topStack.heightAnchor.constraint(lessThanOrEqualToConstant: 50).withPriority(.init(rawValue: 999))
        ])

        inputTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            inputTextView.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
            inputTextView.widthAnchor.constraint(equalTo: topStack.widthAnchor),
        ])

        theRedLine.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            theRedLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 10),
            theRedLine.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -10),
            theRedLine.bottomAnchor.constraint(equalTo: numpadStack.topAnchor, constant: -10)
        ])

        numpadStack.translatesAutoresizingMaskIntoConstraints = false
        numpadStack.distribution = .fillEqually
        numpadStack.axis = .vertical

        NSLayoutConstraint.activate([
            numpadStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            numpadStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            numpadStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numpadStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            numpadStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])

        firstRowStack.translatesAutoresizingMaskIntoConstraints = false
        firstRowStack.distribution = .fillEqually

        NSLayoutConstraint.activate([
            firstRowStack.leadingAnchor.constraint(equalTo: numpadStack.leadingAnchor),
            firstRowStack.trailingAnchor.constraint(equalTo: numpadStack.trailingAnchor),
            firstRowStack.widthAnchor.constraint(equalTo: numpadStack.widthAnchor)
        ])

        secondRowStack.translatesAutoresizingMaskIntoConstraints = false
        secondRowStack.distribution = .fillEqually

        NSLayoutConstraint.activate([
            secondRowStack.leadingAnchor.constraint(equalTo: numpadStack.leadingAnchor),
            secondRowStack.trailingAnchor.constraint(equalTo: numpadStack.trailingAnchor),
            secondRowStack.widthAnchor.constraint(equalTo: numpadStack.widthAnchor)
        ])

        thirdRowStack.translatesAutoresizingMaskIntoConstraints = false
        thirdRowStack.distribution = .fillEqually

        NSLayoutConstraint.activate([
            thirdRowStack.leadingAnchor.constraint(equalTo: numpadStack.leadingAnchor),
            thirdRowStack.trailingAnchor.constraint(equalTo: numpadStack.trailingAnchor),
            thirdRowStack.widthAnchor.constraint(equalTo: numpadStack.widthAnchor)
        ])

        fourthRowStack.translatesAutoresizingMaskIntoConstraints = false
        fourthRowStack.distribution = .fillEqually

        NSLayoutConstraint.activate([
            fourthRowStack.leadingAnchor.constraint(equalTo: numpadStack.leadingAnchor),
            fourthRowStack.trailingAnchor.constraint(equalTo: numpadStack.trailingAnchor),
            fourthRowStack.widthAnchor.constraint(equalTo: numpadStack.widthAnchor)
        ])

        fifthRowStack.translatesAutoresizingMaskIntoConstraints = false
        fifthRowStack.distribution = .fillEqually

        NSLayoutConstraint.activate([
            fifthRowStack.leadingAnchor.constraint(equalTo: numpadStack.leadingAnchor),
            fifthRowStack.trailingAnchor.constraint(equalTo: numpadStack.trailingAnchor),
            fifthRowStack.widthAnchor.constraint(equalTo: numpadStack.widthAnchor)
        ])
    }
}
