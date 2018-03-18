//
//  QuotationCellViewModel.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxDataSources


class QuotationCellViewModel: CellViewModel, IdentifiableType  {

    let quotation: Quotation
    var identity: String {
        return quotation.identity
    }
    
    init(quotation: Quotation) {
        self.quotation = quotation
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let cellVM = object as? QuotationCellViewModel else { return false }
        
        return quotation == cellVM.quotation
    }
}
