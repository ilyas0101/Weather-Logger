//
//  WeatherRouter.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

protocol WeatherRoutingLogic {
    func routeToSomeWhere()
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: NSObject, WeatherRoutingLogic, WeatherDataPassing {
    weak var viewController: WeatherViewController?
    var dataStore: WeatherDataStore?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}
