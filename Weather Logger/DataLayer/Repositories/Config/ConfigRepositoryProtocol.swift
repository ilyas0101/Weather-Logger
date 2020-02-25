//
//  ConfigRepositoryProtocol.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

protocol ConfigRepositoryProtocol {
    func reload(completion: ((Result<Bool, Error>) -> Void)?)
    func load(completion: ((Result<Bool, Error>) -> Void)?)
}
