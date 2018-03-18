//
//  TikerViewController.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources


class TickerViewController: TableViewController, ViewModelHolder {

    var viewModel: TickerViewModel? = TickerViewModel()
    private var dataSource: RxTableViewSectionedAnimatedDataSource<Section>?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    private func configureTableView() {
        let cellIdentifier = QuotationTableViewCell.className()
        tableView.register(QuotationTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 108
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { ds, tv, ip, item in
                guard let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier) as? QuotationTableViewCell else {
                    return QuotationTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                }
                
                cell.viewModel = item
                return cell
            },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        })
        
        self.dataSource = dataSource
        
        viewModel?.dataSource
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
