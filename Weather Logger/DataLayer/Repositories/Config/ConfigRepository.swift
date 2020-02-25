//
//  ConfigRepository.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

class ConfigRepository: ConfigRepositoryProtocol {
    static let shared = ConfigRepository()
    
    var fetcher: ConfigFetcherProtocol? = ConfigFetcher.shared
    
    private var lastUpdateTime: Date?
    private var _config: Synchronized<BaseConfiguration>
    
    private init() {
        let queue = DispatchQueue(label: "ConfigRepository", qos: .utility, attributes: .concurrent)
        _config = Synchronized(queue: queue)
    }
    
    public func reload(completion: ((Result<Bool, Error>) -> Void)? = nil) {
        guard let time = lastUpdateTime, time.timeIntervalSinceNow < -30 else { return }
        load(completion: completion)
    }
    
    public func load(completion: ((Result<Bool, Error>) -> Void)? = nil) {
        guard let fetcher = fetcher else { return }
        
        lastUpdateTime = Date()
        DispatchQueue.global(qos: .utility).async { [unowned self] in
            do {
                let base = try fetcher.base()
                self.parse(config: base)
                
                DispatchQueue.main.async {
                    completion?(.success(true))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
            }
        }
    }
    
    private func parse(config: BaseConfiguration) {
        _config.set(config)
        
        let endpoints = config.endpoints
        WeatherEndpoint.shared.baseRequest.set(url: endpoints.weather)
    }
}
