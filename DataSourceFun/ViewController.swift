//
//  ViewController.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import UIKit


typealias MyData = (numberOfWords: Int, sentence: String)

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            datasource.register(with: tableView)
            tableView.dataSource = datasource
        }
    }

    private let datasource: MyDatasource<MyCellViewModel> = makeDataSource()
    
    // MARK: - Helpers
    
    static private func makeDataSource() -> MyDatasource<MyCellViewModel> {
        let datas: [MyData] = [
            (1, "The"),
            (2, "The quick"),
            (3, "The quick brown"),
            (4, "The quick brown fox"),
            (5, "The quick brown fox jumps"),
            (6, "The quick brown fox jumps over"),
            (7, "The quick brown fox jumps over the"),
            (8, "The quick brown fox jumps over the lazy"),
            (9, "The quick brown fox jumps over the lazy dog")
        ]
        
        let viewModels = datas.compactMap {
            MyCellViewModel(
                headlineText: String.localizedStringWithFormat(
                    NSLocalizedString("FirstNumberOfWords",
                                      comment: "First %d word(s)"),
                    $0.numberOfWords
                ),
                bodyText: $0.sentence,
                colored: true
            )
        }
        
        return MyDatasource<MyCellViewModel>(viewModels)
    }
}
