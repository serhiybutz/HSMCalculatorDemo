//
//  Actions.swift
//  HSMCalculator
//
//  Created by Serhiy Butz on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

protocol Actions {
    func clear()
    func insert(_ key: Key)
    func negate()
    func displayResult(_ result: Double)
    func getOperand() -> Double
    func alert(_ message: String, completion: (() -> Void)?)
}

extension Actions {
    func alert(_ message: String) {
        alert(message, completion: nil)
    }
}
