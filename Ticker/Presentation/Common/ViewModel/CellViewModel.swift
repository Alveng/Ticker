//
//  CellViewModel.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


protocol CellViewModelType: ViewModelType {
}

extension CellViewModelType {
    
    static func className() -> String {
        return String(describing: self)
    }
}

class CellViewModel: ViewModel, CellViewModelType {
    
}
