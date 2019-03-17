//
//  MyCell.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import UIKit

class MyCellViewModel: CellRowViewModel, CellViewModelPressible {
    let headlineText: String
    let bodyText: String
    var colored: Boxed<Bool>
    let cellIdentifier: String
    
    var cellPressed: (() -> Void)?

    init(headlineText: String, bodyText: String, colored: Bool){
        self.headlineText = headlineText
        self.bodyText = bodyText
        self.colored = Boxed(colored)
        self.cellIdentifier = MyCell.reuseIdentifier
    }
}

final class MyCell: UITableViewCell, CellConfigurable {
    static let reuseIdentifier = "MyCell"
    
    private let headlineLabel = basicLabel
    private let bodyLabel = basicLabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabelsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabelsAndConstraints()
    }
    
    func setup(viewModel: CellRowViewModel) {
        guard let viewModel = viewModel as? MyCellViewModel else { return }
        
        headlineLabel.text = viewModel.headlineText
        bodyLabel.text = viewModel.bodyText
        
        viewModel.colored.bind { [weak self] isChanged in
            self?.backgroundColor = isChanged ? .red : .yellow
        }
        
        viewModel.cellPressed = { 
            viewModel.colored.value.toggle()
        }
    }
    
    // MARK: - Helpers
    
    private static var basicLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
    private func setupLabelsAndConstraints() {
        contentView.addSubviews([headlineLabel, bodyLabel])
        
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        headlineLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.adjustsFontForContentSizeCategory = true
        
        NSLayoutConstraint.activate([
            // NOTE: - leading and trailing constraints
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headlineLabel.trailingAnchor),
            
            headlineLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: bodyLabel.lastBaselineAnchor, multiplier: 1),
            bodyLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.lastBaselineAnchor, multiplier: 1),
        ])
    }
}
