//
//  SearchPresenter.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentSomething(response: Search.Something.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    // MARK: Presentation Logic
    
    func presentSomething(response: Search.Something.Response) {
        let viewModel = Search.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
