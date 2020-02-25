//
//  WeatherInteractor.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright (c) 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

protocol WeatherBusinessLogic {
    func handle(request: WeatherModels.GetWeather.Request)
    func handle(request: WeatherModels.GetLocation.Request)
}

protocol WeatherDataStore {
    //var name: String { get set }
}

class WeatherInteractor: WeatherBusinessLogic, WeatherDataStore {
    var presenter: WeatherPresentationLogic?
    
    var fetcher: WeatherFetcherProtocol? = WeatherFetcher.shared
    var weathers = [WeatherEntity]()
    // MARK: Business Logic
    
    func handle(request: WeatherModels.GetWeather.Request) {
        getData(cityName: request.city, coordinate: nil)
    }
    
    func handle(request: WeatherModels.GetLocation.Request) {
        let coordinate = Coordinate(lat: request.lat, lon: request.lon)
        getData(cityName: nil, coordinate: coordinate)
    }
    
    private func getData(cityName: String?, coordinate: Coordinate?) {
        DispatchQueue.global(qos: .utility).async {
            do {
                guard let response = try self.fetcher?.weather(cityName: cityName, cityId: nil, coordinate: coordinate, zipCode: nil) else { return }
                
                DispatchQueue.main.async {
                    self.weathers.append(response)
                    self.presenter?.present(
                        result: Result<WeatherModels.GetLocation.Response, Error>.success(
                            WeatherModels.GetLocation.Response(
                                weathers: self.weathers
                            )
                        )
                    )
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    self.presenter?.present(
                        result: Result<WeatherModels.GetLocation.Response, Error>.failure(error)
                    )
                }
            }
        }
    }
}
