//
//  ViewControllerBinder.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift


class ViewControllerBinder<T: ViewController & ViewModelHolder>: Binder<T> {
    
    override class func bindViewModel(holder: T) {
        holder.rx.methodInvoked(#selector(holder.viewWillAppear(_:))).subscribe({ [weak holder] _ in
            holder?.viewModel?.active = true
        }).disposed(by: holder.disposeBag)
        
        holder.rx.methodInvoked(#selector(holder.viewWillDisappear(_:))).subscribe({ [weak holder] _ in
            holder?.viewModel?.active = false
        }).disposed(by: holder.disposeBag)
    }
}

extension AutoBinder where Self: ViewController, Self: ViewModelHolder {
    
    func bindViewModel() {
        ViewControllerBinder.bindViewModel(holder: self)
    }
}
