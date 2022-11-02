//
//  CalcEvent.swift
//  HSMCalculator
//
//  Created by Serhiy Butz on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

import Foundation
import HSM

struct CalcEvent: EventProtocol {
    let key: Key
    init(from key: Key) {
        self.key = key
    }
    enum Oper {
        case plus, minus, multiply, divide
    }
    func getOper() -> Oper? {
        switch key {
        case .keyPlus: return .plus
        case .keyMinus: return .minus
        case .keyMultiply: return .multiply
        case .keyDivide: return .divide
        default: return nil
        }
    }
    func getDigit() -> Int? {
        switch key {
        case .key0: return 0
        case .key1: return 1
        case .key2: return 2
        case .key3: return 3
        case .key4: return 4
        case .key5: return 5
        case .key6: return 6
        case .key7: return 7
        case .key8: return 8
        case .key9: return 9
        default: return nil
        }
    }
    var isDigitWithin1_9: Bool {
        if let n = getDigit(), n >= 1 && n <= 9 {
            return true
        } else {
            return false
        }
    }
    var isDigit0: Bool {
        if let n = getDigit(), n == 0 {
            return true
        } else {
            return false
        }
    }
}
