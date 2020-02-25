//
//  Synchronized.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

class Synchronized<T> {
    private var value: T?
    private let queue: DispatchQueue
    
    init(queue: DispatchQueue, value: T? = nil) {
        self.queue = queue
        self.value = value
    }
    
    func get() -> T? {
        var value: T?
        queue.sync {
            value = self.value
        }
        return value
    }
    
    func set(_ value: T?) {
        queue.sync(flags: .barrier) {
            self.value = value
        }
    }
}
