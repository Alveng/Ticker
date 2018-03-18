//
//  ViewModelHolder.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

protocol ViewModelHolder: class, AutoBinder {
    
    associatedtype VM: ViewModel
    
    var viewModel: VM? { get set }
}
