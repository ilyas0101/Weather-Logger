//
//  APIDecoder.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

struct APIDecoder: RemoteDecoderProtocol {
    struct ErrorModel: Decodable {
        let title: String?
        let code: String?
    }
    
    func decode<T>(data: Data, urlResponse: URLResponse) throws -> T where T: Decodable {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            throw Remote.Error.nilResponse
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let interval = try container.decode(TimeInterval.self) / 1_000.0
            
            return Date(timeIntervalSince1970: interval)
        })
        
        guard httpUrlResponse.statusCode == 200 else {
            let error = try decoder.decode(ErrorModel.self, from: data)
            throw AppError.remote(code: error.code, message: error.title)
        }
        
        return try decoder.decode(T.self, from: data)
    }
}
