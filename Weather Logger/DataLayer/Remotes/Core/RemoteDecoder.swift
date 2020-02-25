//
//  RemoteDecoder.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

protocol RemoteDecoderProtocol {
    func decode<T: Decodable>(data: Data, urlResponse: URLResponse) throws -> T
}

extension Remote {
    struct Decoder {
        struct Json: RemoteDecoderProtocol {
            func decode<T: Decodable>(data: Data, urlResponse: URLResponse) throws -> T {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }
        }
    }
}
