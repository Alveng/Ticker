//
//  SequenceDiff.swift
//  Ticker
//
//  Created by Sergey Klimov on 16.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


struct SequenceDiff<E> {
    public let common: [(E, E)]
    public let removed: [(Int, E)]
    public let inserted: [(Int, E)]
    public init(common: [(E, E)] = [], removed: [(Int, E)] = [], inserted: [(Int, E)] = []) {
        self.common = common
        self.removed = removed
        self.inserted = inserted
    }
}
