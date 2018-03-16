//
//  TikerViewController.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class TickerViewController: TableViewController, ViewModelHolder, AutoBinder {

    var viewModel: TickerViewModel? = TickerViewModel()
    var dataSource: TableViewDataSource<TickerViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = TableViewDataSource(for: self, store: &dataSource)
        subscribeToEvents()
    }
    
    override func configureCellMap() -> CellMap {
        return [
            QuotationCellViewModel.className(): QuotationTableViewCell.className()
        ]
    }
    
    private func subscribeToEvents() {
        viewModel?.cellViewModels
            .asDriver()
            .drive(onNext: { [weak self] (_) in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}
