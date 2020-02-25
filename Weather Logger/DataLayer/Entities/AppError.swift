//
//  AppError.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    case remote(code: String?, message: String?)
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case let .remote(code, message):
            return message ?? code ?? "Bilinmeyen hata"
        case let .custom(message):
            return message
        }
    }
}
