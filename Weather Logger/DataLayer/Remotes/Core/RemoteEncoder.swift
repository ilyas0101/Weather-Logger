//
//  RemoteEncoder.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

protocol RemoteEncoderProtocol {
    func encode<T: Encodable>(model: T) throws -> Data
}

extension Remote {
    struct Encoder {
        struct Json: RemoteEncoderProtocol {
            func encode<T: Encodable>(model: T) throws -> Data {
                let encoder = JSONEncoder()
                return try encoder.encode(model)
            }
        }
    }
}
