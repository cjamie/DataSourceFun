//
//  MyDatasource.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import UIKit

final class MyDatasource<T>: NSObject, UITableViewDataSource {
    
    private let datas: [T]
    
    init(_ datas: [T]) {
        self.datas = datas
    }
    
    func register(with tableView: UITableView) {
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentifier) as? MyCell else {
            fatalError("bad cell")
        }
        cell.setup(data: datas[indexPath.row] as! MyData)
        return cell
    }
}

final class MyCell: UITableViewCell {
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
    
    func setup(data: MyData) {
        
        headlineLabel.text = String.localizedStringWithFormat(
            NSLocalizedString("FirstNumberOfWords", comment: "First %d word(s)"), data.numberOfWords
        )
        
        bodyLabel.text = data.sentence
    }
    
    // MARK: - Helpers
    
    private static var basicLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
    private func setupLabelsAndConstraints() {
        
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)

        contentView.addSubviews([headlineLabel, bodyLabel])

        headlineLabel.adjustsFontForContentSizeCategory = true
        bodyLabel.adjustsFontForContentSizeCategory = true

        NSLayoutConstraint.activate([
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headlineLabel.trailingAnchor),headlineLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: bodyLabel.lastBaselineAnchor, multiplier: 1),
            bodyLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: headlineLabel.lastBaselineAnchor, multiplier: 1),
        ])
    }
}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview)
    }
}
