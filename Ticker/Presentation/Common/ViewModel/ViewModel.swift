//
//  ViewModel.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift
import RxViewModel


protocol ViewModelType: class {
    var active: Bool { get set }
}

class ViewModel: RxViewModel, ViewModelType {
    
    var disposeBag = DisposeBag()
}
