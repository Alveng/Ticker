//
//  QuotationTableViewCell.swift
//  Ticker
//
//  Created by Sergey Klimov on 14.03.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import SnapKit


class QuotationTableViewCell: TableViewCell {
    
    lazy var titleLabel = UILabel()
    lazy var lastLabel = UILabel()
    lazy var highestBidLabel = UILabel()
    lazy var percentChangeLabel = UILabel()
    lazy var rightContainerView = UIView()
    
    var viewModel: QuotationCellViewModel? {
        didSet { configureView() }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightContainerView)
        rightContainerView.addSubview(lastLabel)
        rightContainerView.addSubview(highestBidLabel)
        rightContainerView.addSubview(percentChangeLabel)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        rightContainerView.snp.updateConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(titleLabel.snp.right)
        }
        
        lastLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        highestBidLabel.snp.updateConstraints { (make) in
            make.top.equalTo(lastLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        percentChangeLabel.snp.updateConstraints { (make) in
            make.top.equalTo(highestBidLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        super.updateConstraints()
    }

    private func configureView() {
        guard let quotation = viewModel?.quotation else { return }
        
        titleLabel.text = quotation.name
        lastLabel.text = "Last " + quotation.last
        highestBidLabel.text = "Highest Bid " + quotation.highestBid
        percentChangeLabel.text = "% change " + quotation.percentChange
    }
}
