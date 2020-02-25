//
//  WeatherFetcher.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 24.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

protocol WeatherFetcherProtocol {
    func weather(
        cityName: String?,
        cityId: String?,
        coordinate: Coordinate?,
        zipCode: String?
    ) throws -> WeatherEntity
}

class WeatherFetcher: WeatherFetcherProtocol {
    static let shared = WeatherFetcher()
    private init() {}
    
    func weather(
        cityName: String?,
        cityId: String?,
        coordinate: Coordinate?,
        zipCode: String?
    ) throws -> WeatherEntity {
        let apiKey = Constants.apiKey
        var latStr: String?
        var lonStr: String?
        
        if let lat = coordinate?.lat, let lon = coordinate?.lon {
            latStr = String(lat)
            lonStr = String(lon)
        }
        
        let response = try WeatherEndpoint.shared.weather(
            state: nil,
            countryCode: nil,
            query: WeatherMethod.Get.Query(
                q: cityName,
                id: cityId,
                lat: latStr,
                lon: lonStr,
                zip: zipCode,
                appid: apiKey
            )
        )
        
        return WeatherEntity(
            coord: convert(response.coord),
            weather: convert(response.weather),
            base: response.base ?? "",
            main: convert(response.main),
            visibility: response.visibility ?? 0,
            wind: convert(response.wind),
            clouds: convert(response.clouds),
            date: response.dt ?? Date(),
            sys: convert(response.sys),
            id: response.id ?? 0,
            name: response.name ?? "",
            cod: response.cod ?? 0
        )
    }
    
    private func convert(_ coord: WeatherMethod.Get.Response.Coord?) -> CoordEntity {
        return CoordEntity(
            lon: coord?.lon ?? 0.0,
            lat: coord?.lat ?? 0.0
        )
    }
    
    private func convert(_ remote: [WeatherMethod.Get.Response.Weather]?) -> [Weather] {
        var weathers = [Weather]()
        
        for weather in remote ?? [] {
            guard let id = weather.id else {
                continue
            }
            
            weathers.append(
                Weather(
                    id: id,
                    main: weather.main ?? "",
                    description: weather.weatherDescription ?? "",
                    icon: weather.icon ?? ""
                )
            )
        }
        
        return weathers
    }
    
    private func convert(_ main: WeatherMethod.Get.Response.Main?) -> MainEntity {
        return MainEntity(
            temp: main?.temp ?? 0.0,
            pressure: main?.pressure ?? 0,
            humidity: main?.humidity ?? 0,
            tempMin: main?.tempMin ?? 0.0,
            tempMax: main?.tempMax ?? 0.0
        )
    }
    
    private func convert(_ wind: WeatherMethod.Get.Response.Wind?) -> WindEntity {
        return WindEntity(
            speed: wind?.speed ?? 0.0,
            deg: wind?.deg ?? 0
        )
    }
    
    private func convert(_ cloud: WeatherMethod.Get.Response.Clouds?) -> CloudsEntity {
        return CloudsEntity(
            all: cloud?.all ?? 0
        )
    }
    
    private func convert(_ sys: WeatherMethod.Get.Response.Sys?) -> SysEntity {
        return SysEntity(
            type: sys?.type ?? 0,
            id: sys?.id ?? 0,
            message: sys?.message ?? 0.0,
            country: sys?.country ?? "",
            sunrise: sys?.sunrise ?? Date(),
            sunset: sys?.sunset ?? Date()
        )
    }
}
