//
//  WeatherLocationEntitty.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

struct WeatherLocation: Codable, Equatable {
    var city: String?
    var country: String?
    var countryCode: String?
    var isCurrentLocation: Bool?
}
