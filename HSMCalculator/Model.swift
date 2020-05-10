//
//  Model.swift
//  HSMCalculator
//
//  Created by Serge Bouts on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

struct Model {
    enum Error: Swift.Error {
        case zeroDivision
        case outOfRange
    }
    var `operator`: CalcEvent.Oper?
    var operand1: Double?
    var operand2: Double?
    var result: Result<Double, Error>?
    mutating func eval() {
        guard let `operator` = `operator`,
              let operand1 = operand1,
              let operand2 = operand2 else { preconditionFailure() }

        var result: Double!
        switch `operator` {
        case .plus:
            result = operand1 + operand2
        case .minus:
            result = operand1 - operand2
        case .multiply:
            result = operand1 * operand2
        case .divide:
            if operand2 != 0.0 {
                result = operand1 / operand2
            } else {
                self.result = .failure(.zeroDivision)
                return
            }
        }
        if -1.0e10...1.0e10 ~= result! {
            self.result = .success(result!)
            return
        } else {
            self.result = .failure(.outOfRange)
        }
    }
    mutating func reset() {
        `operator` = nil
        operand1 = nil
        operand2 = nil
        result = nil
    }
}
