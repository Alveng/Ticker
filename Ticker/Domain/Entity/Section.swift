//
//  Section.swift
//  Ticker
//
//  Created by Sergey Klimov on 16.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxDataSources


struct Section: IdentifiableType {
    var header: String
    var items: [Item]
    var identity: String {
        return header
    }
}

extension Section: AnimatableSectionModelType {
    typealias Item = QuotationCellViewModel
    
    init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
}
