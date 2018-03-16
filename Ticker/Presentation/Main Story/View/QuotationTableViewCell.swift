//
//  QuotationTableViewCell.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class QuotationTableViewCell: TableViewCell, ViewModelHolder, CellAutoBinder {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var highestBidLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    var viewModel: QuotationCellViewModel? {
        didSet { configureView() }
    }
    
    private func configureView() {
        guard let quotation = viewModel?.quotation else { return }
        
        titleLabel.text = quotation.name
        lastLabel.text = "last " + quotation.last
        highestBidLabel.text = "highestBid " + quotation.highestBid
        percentChangeLabel.text = "percentChange " + quotation.percentChange
    }
}
