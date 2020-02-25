//
//  SearchInteractor.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func doSomething(request: Search.Something.Request)
}

protocol SearchDataStore {
    //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    
    // MARK: Business Logic

    func doSomething(request: Search.Something.Request) {
    }
}
