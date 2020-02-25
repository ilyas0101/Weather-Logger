//
//  ConfigFetcher.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

class ConfigFetcher: ConfigFetcherProtocol {
    static let shared = ConfigFetcher()
    private init() { }
    
    func base() throws -> BaseConfiguration {
        struct LocalConfiguration: Decodable {
            let endpoints: EndpointList
        }
        
        guard let configUrl = Bundle(for: type(of: self)).url(forResource: "Config", withExtension: "json") else {
            throw Remote.Error.noContent
        }
        
        do {
            let configData = try Data(contentsOf: configUrl)
            let remoteConfig = try JSONDecoder().decode(LocalConfiguration.self, from: configData)
            
            return BaseConfiguration(
                endpoints: remoteConfig.endpoints
            )
        } catch let error {
            throw error
        }
    }
}
