//
//  SysEntity.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

// MARK: - Sys
struct SysEntity {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Date
}
