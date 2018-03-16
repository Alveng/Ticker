//
//  ViewModelHolderDataSource.swift
//  Ticker
//
//  Created by Sergey Klimov on 15.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class ViewModelHolderDataSource<T: ViewModelHolder & CellMapper>: ViewModelHolderContainer<T> where T.VM: CellArrayViewModelType {
    
    weak var viewModel: T.VM?
    let cellMap: CellMap
    
    required init(for viewModelHolder: T) {
        self.viewModel = viewModelHolder.viewModel
        self.cellMap = viewModelHolder.cellMap
        
        super.init(for: viewModelHolder)
    }
}

class TableViewDataSource<T: ViewModelHolder & CellMapper>: ViewModelHolderDataSource<T>, UITableViewDataSource where T.VM: CellArrayViewModelType {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let number = viewModel?.numberOfGroups() else {
            return 0
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = viewModel?.numberOfItemsInGroup(atIndex: section) else {
            return 0
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.itemViewModel(inGroup: indexPath.section, atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        let className = type(of: cellViewModel).className()
        
        guard let identifier = cellMap[className] else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.reusableCell(withIdentifier: identifier, for: indexPath) as? TableViewCell & CellAutoBinder else {
            return UITableViewCell()
        }
        
        cell.bindViewModel(cellViewModel)
        
        return cell
    }
}
