//
//  ConfigFetcherProtocol.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

protocol ConfigFetcherProtocol {
    func base() throws -> BaseConfiguration
}
