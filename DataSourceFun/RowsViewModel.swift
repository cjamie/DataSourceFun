//
//  RowsViewModel.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import Foundation

protocol CellRowViewModel {
    var cellIdentifier: String { get }
}

protocol CellConfigurable {
    func setup(viewModel: CellRowViewModel) // Provide a generic function
}

protocol CellViewModelPressible {
    var cellPressed: (()->Void)? { get set }
}
