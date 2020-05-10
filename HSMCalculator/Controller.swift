//
//  Controller.swift
//  HSMCalculator
//
//  Created by Serge Bouts on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

import HSM

/// HSM-based controller of the calculator
class Controller: TopState<CalcEvent> {
    class Ready: State<Controller, Controller> {
        class Result: State<Ready, Controller> {}
        class Begin: State<Ready, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.getOper() == .minus {
                    return Transition(to: top.negated1)
                } else if event.getOper() == .plus {
                    return Transition() // event handled
                }
                return nil
            }
        }
        class Error: State<Ready, Controller> {
            override func entry() {
                guard case .failure(let error) = top.model.result! else { preconditionFailure() }
                switch error {
                case .zeroDivision:
                    top.actions.alert("Cannot divide by 0") {
                        self.top.model.reset()
                        self.top.actions.clear()
                    }
                case .outOfRange:
                    top.actions.alert("Result out of range") {
                        self.top.model.reset()
                        self.top.actions.clear()
                    }
                }
            }
        }
        let result = Result()
        let begin = Begin()
        let error = Error()
        override func initialize() {
            bind(result, begin, error)
            initial = begin
        }
        override func handle(_ event: CalcEvent) -> Transition? {
            if event.isDigit0 {
                return Transition(to: top.operand1.zero1) {
                    self.top.actions.clear()
                }
            } else if event.isDigitWithin1_9 {
                return Transition(to: top.operand1.int1) {
                    self.top.actions.clear()
                    self.top.actions.insert(event.key)
                }
            } else if event.key == .keyPoint {
                return Transition(to: top.operand1.frac1) {
                    self.top.actions.clear()
                    self.top.actions.insert(.key0)
                    self.top.actions.insert(.keyPoint)
                }
            } else if let oper = event.getOper() {
                return Transition(to: top.opEntered) {
                    self.top.model.operand1 = self.top.actions.getOperand()
                    self.top.model.`operator` = oper
                }
            }
            return nil
        }
    }
    class Negated1: State<Controller, Controller> {
        override func entry() {
            self.top.actions.negate()
        }
        override func handle(_ event: CalcEvent) -> Transition? {
            if event.key == .keyCE {
                return Transition(to: top.ready.begin) {
                    self.top.actions.clear()
                }
            } else if event.isDigit0 {
                return Transition(to: top.operand1.zero1) {
                    self.top.actions.insert(.key0)
                }
            } else if event.isDigitWithin1_9 {
                return Transition(to: top.operand1.int1) {
                    self.top.actions.insert(event.key)
                }
            } else if event.key == .keyPoint {
                return Transition(to: top.operand1.frac1) {
                    self.top.actions.insert(event.key)
                }
            }
            return nil
        }
    }
    class Operand1: State<Controller, Controller> {
        class Zero1: State<Operand1, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.isDigitWithin1_9 {
                    return Transition(to: superior.int1) {
                        self.top.actions.insert(event.key)
                    }
                } else if event.key == .keyPoint {
                    return Transition(to: superior.frac1) {
                        self.top.actions.insert(.keyPoint)
                    }
                }
                return nil
            }
        }
        class Int1: State<Operand1, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.isDigit0 || event.isDigitWithin1_9 {
                    return Transition() { // event handled
                        self.top.actions.insert(event.key)
                    }
                } else if event.key == .keyPoint {
                    return Transition(to: superior.frac1) {
                        self.top.actions.insert(.keyPoint)
                    }
                }
                return nil
            }
        }
        class Frac1: State<Operand1, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.isDigit0 || event.isDigitWithin1_9 {
                    return Transition() { // event handled
                        self.top.actions.insert(event.key)
                    }
                }
                return nil
            }
        }
        let zero1 = Zero1()
        let int1 = Int1()
        let frac1 = Frac1()
        override func initialize() {
            bind(zero1, int1, frac1)
        }
        override func handle(_ event: CalcEvent) -> Transition? {
            if event.key == .keyCE {
                return Transition(to: top.ready.begin) {
                    self.top.actions.clear()
                }
            } else if let oper = event.getOper() {
                return Transition(to: superior.opEntered) {
                    self.top.model.operand1 = self.top.actions.getOperand()
                    self.top.model.operator = oper
                }
            }
            return nil
        }
    }
    class OpEntered: State<Controller, Controller> {
        override func handle(_ event: CalcEvent) -> Transition? {
            if event.getOper() == .minus {
                return Transition(to: top.negated2) {
                    self.top.actions.clear()
                }
            } else if event.isDigit0 {
                return Transition(to: top.operand2.zero2) {
                    self.top.actions.clear()
                }
            } else if event.isDigitWithin1_9 {
                return Transition(to: top.operand2.int2) {
                    self.top.actions.clear()
                    self.top.actions.insert(event.key)
                }
            } else if event.key == .keyPoint {
                return Transition(to: top.operand2.frac2) {
                    self.top.actions.clear()
                    self.top.actions.insert(.key0)
                    self.top.actions.insert(.keyPoint)
                }
            }
            return nil
        }
    }
    class Negated2: State<Controller, Controller> {
        override func entry() {
            self.top.actions.negate()
        }
        override func handle(_ event: CalcEvent) -> Transition? {
            if event.key == .keyCE {
                return Transition(to: superior.opEntered)
            } else if event.isDigit0 {
                return Transition(to: top.operand2.zero2)
            } else if event.isDigitWithin1_9 {
                return Transition(to: top.operand2.int2) {
                    self.top.actions.insert(event.key)
                }
            } else if event.key == .keyPoint {
                return Transition(to: top.operand2.frac2) {
                    self.top.actions.insert(.keyPoint)
                }
            }
            return nil
        }
    }
    class Operand2: State<Controller, Controller> {
        class Zero2: State<Operand2, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.isDigitWithin1_9 {
                    return Transition(to: superior.int2) {
                        self.top.actions.insert(event.key)
                    }
                } else if event.key == .keyPoint {
                    return Transition(to: superior.frac2) {
                        self.top.actions.insert(.keyPoint)
                    }
                }
                return nil
            }
        }
        class Int2: State<Operand2, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.isDigit0 || event.isDigitWithin1_9 {
                    return Transition() { // event handled
                        self.top.actions.insert(event.key)
                    }
                } else if event.key == .keyPoint {
                    return Transition(to: superior.frac2) {
                        self.top.actions.insert(.keyPoint)
                    }
                }
                return nil
            }
        }
        class Frac2: State<Operand2, Controller> {
            override func handle(_ event: CalcEvent) -> Transition? {
                if event.isDigit0 || event.isDigitWithin1_9 {
                    return Transition() { // event handled
                        self.top.actions.insert(event.key)
                    }
                }
                return nil
            }
        }
        override func handle(_ event: CalcEvent) -> Transition? {
            if event.key == .keyCE {
                return Transition(to: top.opEntered) {
                    self.top.actions.clear()
                }
            } else if let oper = event.getOper() {
                top.model.operand2 = self.top.actions.getOperand()
                top.model.eval()
                switch top.model.result! {
                case .success(let result):
                    return Transition(to: top.opEntered) {
                        self.top.actions.displayResult(result)
                        self.top.model.operand1 = self.top.actions.getOperand()
                        self.top.model.operator = oper
                    }
                case .failure:
                    return Transition(to: top.ready.error)
                }
            } else if event.key == .keyEquals {
                top.model.operand2 = self.top.actions.getOperand()
                top.model.eval()
                switch top.model.result! {
                case .success(let result):
                    return Transition(to: top.ready.result) {
                        self.top.actions.displayResult(result)
                    }
                case .failure:
                    return Transition(to: top.ready.error)
                }
            } else if event.key == .keyPercent {
                top.model.operand2 = self.top.actions.getOperand()
                switch top.model.operator! {
                case .plus:
                    top.model.operand2 = 1.0 + top.model.operand2! / 100.0
                    top.model.operator = .multiply
                case .minus:
                    top.model.operand2 = 1.0 - top.model.operand2! / 100.0
                    top.model.operator = .multiply
                case .multiply, .divide:
                    top.model.operand2! /= 100.0
                }
                top.model.eval()
                switch top.model.result! {
                case .success(let result):
                    return Transition(to: top.ready.result) {
                        self.top.actions.displayResult(result)
                    }
                case .failure:
                    return Transition(to: top.ready.error)
                }
            }
            return nil
        }
        let zero2 = Zero2()
        let int2 = Int2()
        let frac2 = Frac2()
        override func initialize() {
            bind(zero2, int2, frac2)
        }
    }
    override func entry() {
        model.reset()
        actions.clear()
    }
    override func handle(_ event: CalcEvent) -> Transition? {
        if event.key == .keyC {
            return Transition(to: self) {
                self.model.reset()
                self.actions.clear()
            }
        }
        return nil
    }
    let ready = Ready()
    let negated1 = Negated1()
    let operand1 = Operand1()
    let opEntered = OpEntered()
    let negated2 = Negated2()
    let operand2 = Operand2()
    var model = Model()
    override func initialize() {
        bind(ready, negated1, operand1, opEntered, negated2, operand2)
        initial = ready
    }
    let actions: Actions
    init(actions: Actions) {
        self.actions = actions
        super.init()
    }
}
