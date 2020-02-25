//
//  Remote.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

struct Remote {
    enum Error: LocalizedError {
        case nilResponse
        case noContent
        case decode(data: Data, underlyingError: Swift.Error)

        public var errorDescription: String? {
            switch self {
            case .nilResponse:
                return NSLocalizedString("İçerik alınamadı", comment: "Nil response received")
            case .noContent:
                return NSLocalizedString("İçerik alınamadı", comment: "No content received")
            case .decode(_, let underlyingError):
                return underlyingError.localizedDescription
            }
        }
    }
}
