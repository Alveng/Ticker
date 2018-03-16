//
//  ViewModelHolderContainer.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


protocol ViewModelHolderContainerType: NSObjectProtocol {
    
    associatedtype VMH: ViewModelHolder
    
    init(for viewModelHolder: VMH)
}

class ViewModelHolderContainer<T: ViewModelHolder>: NSObject, ViewModelHolderContainerType {
    
    typealias VMH = T
    
    unowned var viewModelHolder: T
    
    required init(for viewModelHolder: T) {
        self.viewModelHolder = viewModelHolder
    }
    
    convenience init<Store: ViewModelHolderContainer<T>>(for viewModelHolder: T, store: inout Store?) {
        self.init(for: viewModelHolder)
        if let result = self as? Store {
            store = result
        } else {
            preconditionFailure("Could not cast \(self) to \(Store.self)")
        }
    }
}
