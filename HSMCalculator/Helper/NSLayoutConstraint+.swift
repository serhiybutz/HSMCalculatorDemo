//
//  NSLayoutConstraint+.swift
//  HSMCalculator
//
//  Created by Serhiy Butz on 3/09/20.
//  Copyright © 2020 iRiZen.com. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    /// Returns itself with the given priority set (to be used in a *method chaining* fashion).
    @discardableResult
    func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
