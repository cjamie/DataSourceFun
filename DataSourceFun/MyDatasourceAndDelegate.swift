//
//  MyDatasource.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import UIKit

typealias PressableCellRowViewModel = CellRowViewModel & CellViewModelPressible

final class MyDatasourceAndDelegate<T: PressableCellRowViewModel>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let datas: [T]
    
    init(_ datas: [T]) {
        self.datas = datas
    }
    
    func register(with tableView: UITableView) {
        tableView.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: datas[indexPath.row].cellIdentifier) as? CellConfigurable else {
            fatalError("unconfigurable cell")
        }
        
        cell.setup(viewModel: datas[indexPath.row])
        
        return cell as! UITableViewCell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        datas[indexPath.row].cellPressed?()
    }
    
}
