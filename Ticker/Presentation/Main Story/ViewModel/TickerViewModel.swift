//
//  TickerViewModel.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxSwift
import ObservableArray_RxSwift


class TickerViewModel: CellArrayViewModel<QuotationCellViewModel> {
    
    private let interactor = TickerInteractor()
    private var oldQuotations: [Quotation] = []
    
    private var timer: Observable<Int>!
    private let timeInterval: Double = 5
    private var timerBag = DisposeBag()

    override init() {
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
        let sequenceDiff = oldQuotations.diff(with: sortedQuot, with: ==)
        oldQuotations = sortedQuot
        
        if sequenceDiff.common.count == 0 && sequenceDiff.removed.count == 0 && sequenceDiff.inserted.count > 0 {
            let cellViewModels = sequenceDiff.inserted.map({ QuotationCellViewModel(quotation: $0.1) })
            self.cellViewModels.value = ObservableArray(cellViewModels)
        } else if sequenceDiff.inserted.count > 0 || sequenceDiff.removed.count > 0 {
            var cells = cellViewModels.value
            for element in sequenceDiff.removed {
                cells.remove(at: element.0)
            }
            for element in sequenceDiff.inserted {
                cells.insert(QuotationCellViewModel(quotation: element.1), at: element.0)
            }
            cellViewModels.value = cells
        }
    }
}
