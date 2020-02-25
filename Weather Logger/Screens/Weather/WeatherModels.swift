//
//  WeatherModels.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

enum WeatherModels {
    enum Cell {
        case cell(info: String, name: String?, image: UIImage?)
        
        func identifier() -> String {
            switch self {
            case .cell:
                return InfoCell.identifier
            }
        }
    }
    
    // MARK: Use cases
    enum GetWeather {
        struct Request {
            let city: String?
        }
    }
    
    enum GetLocation {
        struct Request {
            let lat: Double?
            let lon: Double?
        }
        struct Response {
            let weathers: [WeatherEntity]
        }
        struct ViewModel {
            let weathers: [WeatherEntity]
            let cells: [Int: [WeatherModels.Cell]]
        }
    }
}
