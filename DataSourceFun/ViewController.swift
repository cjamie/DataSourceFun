//
//  ViewController.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import UIKit


typealias MyData = (numberOfWords: Int, sentence: String)

protocol RowViewModel { }

protocol CellConfigurable {
    func setup(viewModel: RowViewModel) // Provide a generic function
}

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            datasource.register(with: tableView)
            tableView.dataSource = datasource
        }
    }
    
    private let datasource = MyDatasource<MyData>([
        (1, "The"),
        (2, "The quick"),
        (3, "The quick brown"),
        (4, "The quick brown fox"),
        (5, "The quick brown fox jumps"),
        (6, "The quick brown fox jumps over"),
        (7, "The quick brown fox jumps over the"),
        (8, "The quick brown fox jumps over the lazy"),
        (9, "The quick brown fox jumps over the lazy dog")
    ])
}

// wraps a value in a box, which is supplied a closure

final class Box<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    init(_ value: T) {
        self.value = value
    }
}
