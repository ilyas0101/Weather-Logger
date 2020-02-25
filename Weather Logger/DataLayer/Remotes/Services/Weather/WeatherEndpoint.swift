//
//  WeatherEndpoint.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

class WeatherEndpoint: Remote.Endpoint {
    static let shared = WeatherEndpoint()
    
    private override init() {
        super.init()
        baseRequest.set(decoder: APIDecoder())
    }
    
    func weather(
        state: String?,
        countryCode: String?,
        query: WeatherMethod.Get.Query) throws -> WeatherMethod.Get.Response {
        
        return try WeatherMethod.Get(
            query: query,
            state: state,
            countryCode: countryCode
        ).send(with: baseRequest)
        
    }
}
