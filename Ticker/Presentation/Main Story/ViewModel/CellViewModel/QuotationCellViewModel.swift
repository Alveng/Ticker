//
//  QuotationCellViewModel.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


class QuotationCellViewModel: CellViewModel {

    let quotation: Quotation
    
    init(quotation: Quotation) {
        self.quotation = quotation
    }
}
