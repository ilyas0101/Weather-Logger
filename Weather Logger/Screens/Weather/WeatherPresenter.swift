//
//  WeatherPresenter.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

protocol WeatherPresentationLogic {
    func present(result: Result<WeatherModels.GetLocation.Response, Error>)
}

class WeatherPresenter: WeatherPresentationLogic {
    weak var viewController: WeatherDisplayLogic?
    
    // MARK: Presentation Logic

    func present(result: Result<WeatherModels.GetLocation.Response, Error>) {
        switch result {
        case .success(let response):
            
            var cells = [Int: [WeatherModels.Cell]]()
            let weathers = response.weathers
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            for weather in weathers {
                var models = [WeatherModels.Cell]()
                models.append(.cell(info: String(format: "%.1f m/sec", weather.wind.speed), name: nil, image: getWeatherIconFor("wind")))
                models.append(.cell(info: String(format: "%.0f ", weather.main.humidity), name: nil, image: getWeatherIconFor("humidity")))
                models.append(.cell(info: String(format: "%.0f mb", weather.main.pressure), name: nil, image: getWeatherIconFor("pressure")))
                models.append(.cell(info: String(format: "%.0f km", weather.visibility), name: nil, image: getWeatherIconFor("visibility")))
                models.append(.cell(info: timeFormatter.string(from: weather.sys.sunrise), name: nil, image: getWeatherIconFor("sunrise")))
                models.append(.cell(info: timeFormatter.string(from: weather.sys.sunset), name: nil, image: getWeatherIconFor("sunset")))
                cells[weather.id] = models
            }

            print(cells.count)
            viewController?.display(
                viewModel: WeatherModels.GetLocation.ViewModel(
                    weathers: weathers,
                    cells: cells
                )
            )
        case .failure(let error):
            viewController?.display(error: error.localizedDescription)
        }
    }
    
    func getWeatherIconFor(_ type: String) -> UIImage? {
        return UIImage(named: type)
    }
}
