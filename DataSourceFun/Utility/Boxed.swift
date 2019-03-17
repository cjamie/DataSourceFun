//
//  Boxed.swift
//  DataSourceFun
//
//  Created by Jamie Chu on 3/16/19.
//  Copyright © 2019 Jamie Chu. All rights reserved.
//

import Foundation

// wraps a value in a box, which is supplied a closure that is executed upon change.

final class Boxed<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    func bind(_ fireNow: Bool = true, listener: @escaping Listener) {
        self.listener = listener
        if fireNow { listener(value) }
    }
    
    init(_ value: T) {
        self.value = value
    }
}

protocol Disposable {
    func dispose()
}

extension Boxed: Disposable {
    func dispose() {
        listener = nil
    }
}
