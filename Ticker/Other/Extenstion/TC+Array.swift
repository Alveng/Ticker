//
//  TC+Array.swift
//  Ticker
//
//  Created by Sergey Klimov on 16.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


extension Array {
    
    func diff(with second: [Element], with compare: (Element, Element) -> Bool) -> SequenceDiff<Element> {
        let combinations = flatMap { firstElement in (firstElement, second.first { secondElement in compare(firstElement, secondElement) }) }
        let combinations2 = second.flatMap { secondElement in (self.first { firstElement in compare(firstElement, secondElement) }, secondElement) }
        let common = combinations.filter { $0.1 != nil }.flatMap { ($0.0, $0.1!) }
        let removed = combinations.filter { $0.1 == nil }.enumerated().flatMap { ($0, $1.0) }
        let inserted = combinations2.filter { $0.0 == nil }.enumerated().flatMap { ($0, $1.1) }
        
        return SequenceDiff(common: common, removed: removed, inserted: inserted)
    }
}

