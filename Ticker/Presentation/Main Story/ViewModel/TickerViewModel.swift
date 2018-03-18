//
//  TickerViewModel.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift
import RxDataSources


class TickerViewModel: ViewModel {
    
    private let interactor = TickerInteractor()
    
    private var timer: Observable<Int>!
    private let timeInterval: Double = 5
    private var timerBag = DisposeBag()
    
    private let privateDataSource: Variable<[Section]> = Variable([])
    let dataSource: Observable<[Section]>

    override init() {
        self.dataSource = privateDataSource.asObservable()
        super.init()
        
        subscribeToEvents()
    }
    
    private func subscribeToEvents() {
        didBecomeActive
            .subscribe(onNext: { [weak self] (_) in
                self?.startTimer()
            }).disposed(by: disposeBag)
        
        didBecomeInactive
            .subscribe(onNext: { [weak self] (_) in
                self?.endTimer()
            }).disposed(by: disposeBag)
    }
    
    private func startTimer() {
        timer = Observable<Int>.timer(0, period: timeInterval, scheduler: MainScheduler.instance)
        timer.subscribe(onNext: { [weak self] (_) in
            self?.obtainTiсker()
        }).disposed(by: timerBag)
    }
    
    private func endTimer() {
        timerBag = DisposeBag()
    }
    
    private func obtainTiсker() {
        interactor.execute(onNext: { [weak self] (quotations) in
            self?.filter(quotations: quotations)
        })
    }
    
    private func filter(quotations: [Quotation]) {
        let sortedQuot = quotations.sorted(by: { $0.name < $1.name })
        let items = sortedQuot.map({ QuotationCellViewModel(quotation: $0) })
        privateDataSource.value = [Section(header: "Quotations", items: items)]
    }
}
