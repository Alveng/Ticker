//
//  CellBinder.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift
import RxCocoa


class CellBinder<T: TableViewCell & ViewModelHolder>: Binder<T> {
    
    override class func bindViewModel(holder: T) {
        let vm = holder.viewModel
        vm?.active = true
        
        let disposable = holder.rx.deallocating.subscribe({ [weak vm] _ in
            vm?.active = false
        })
        disposable.disposed(by: holder.disposeBag)
        
        holder.rx.methodInvoked(#selector(holder.prepareForReuse)).asMaybe().subscribe({ [weak holder, disposable] _ in
            holder?.viewModel?.active = false
            disposable.dispose()
        }).disposed(by: holder.disposeBag)
    }
}

extension CellAutoBinder where Self: TableViewCell, Self: ViewModelHolder {
    
    func bindViewModel(_ vm: CellViewModelType?) {
        CellBinder.bindViewModel(holder: self, vm: vm)
    }
}
