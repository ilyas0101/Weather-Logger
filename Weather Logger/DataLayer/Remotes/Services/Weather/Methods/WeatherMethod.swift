//
//  WeatherCityNameMethod.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

struct WeatherMethod {
    static let path = ""
    
    struct Get {
        struct Query: Encodable {
            let q: String?
            let id: String?
            let lat: String?
            let lon: String?
            let zip: String?
            let appid: String
        }
        struct Response: Decodable {
            let coord: Coord?
            let weather: [Weather]?
            let base: String?
            let main: Main?
            let visibility: Int?
            let wind: Wind?
            let clouds: Clouds?
            let dt: Date?
            let sys: Sys?
            let id: Int?
            let name: String?
            let cod: Int?
            
            struct Clouds: Decodable {
                let all: Int?
            }
            
            struct Coord: Decodable {
                let lon, lat: Double?
            }
            
            struct Main: Decodable {
                let temp: Double?
                let pressure, humidity: Int?
                let tempMin, tempMax: Double?
                
                enum CodingKeys: String, CodingKey {
                    case temp, pressure, humidity
                    case tempMin = "temp_min"
                    case tempMax = "temp_max"
                }
            }
            
            struct Sys: Decodable {
                let type, id: Int?
                let message: Double?
                let country: String?
                let sunrise, sunset: Date?
            }
            
            struct Weather: Decodable {
                let id: Int?
                let main, weatherDescription, icon: String?
                
                enum CodingKeys: String, CodingKey {
                    case id, main
                    case weatherDescription = "description"
                    case icon
                }
            }
            
            struct Wind: Decodable {
                let speed: Double?
                let deg: Int?
            }
        }
        
        let query: Query
        let state: String?
        let countryCode: String?
        
        func send(with request: Remote.Request) throws -> Response {
            var convertedPath = path
            
            if let state = state {
                convertedPath = path.replacingOccurrences(of: "{state}", with: state)
            }
            
            if let countryCode = countryCode {
                convertedPath = path.replacingOccurrences(of: "{countryCode}", with: countryCode)
            }
            
            return try Remote.Request(with: request)
                .set(method: .get)
                .set(url: request.url?.appendingPathComponent(convertedPath), query: query)
                .send()
        }
    }
}
