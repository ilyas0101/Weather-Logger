//
//  WeatherEntity.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

// MARK: - WeatherEntity
struct WeatherEntity {
    let coord: CoordEntity
    let weather: [Weather]
    let base: String
    let main: MainEntity
    let visibility: Int
    let wind: WindEntity
    let clouds: CloudsEntity
    let date: Date
    let sys: SysEntity
    let id: Int
    let name: String
    let cod: Int
}
