//
//  SearchRouter.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

protocol SearchRoutingLogic {
    func routeToSomeWhere()
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}
