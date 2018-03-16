//
//  Binder.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


protocol AutoBinder {
    func bindViewModel()
}

protocol CellAutoBinder {
    func bindViewModel(_ vm: CellViewModelType?)
}

class Binder<T: ViewModelHolder> {
    
    class func bindViewModel(holder: T) {
    }
    
    final class func bindViewModel(holder: T, vm: CellViewModelType?) {
        holder.viewModel = vm as? T.VM
        bindViewModel(holder: holder)
    }
}
