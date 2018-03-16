//
//  BaseInteractor.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift


class Interactor<Input, Output> {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func asObservable(params: Input) -> Observable<Output> {
        preconditionFailure("\(#function) should be implemented in subclass")
    }
}

extension Interactor where Input: Any {
    
    func execute(with params: Input, onNext: ((Output) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
        Observable.just(params)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .flatMap(asObservable)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: onNext, onError: onError, onCompleted: onCompleted)
            .disposed(by: disposeBag)
    }
}

extension Interactor where Input == Void {
    
    func execute(onNext: ((Output) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
        execute(with: (), onNext: onNext, onError: onError, onCompleted: onCompleted)
    }
    
    func asObservable() -> Observable<Output> {
        return asObservable(params: ())
    }
}
