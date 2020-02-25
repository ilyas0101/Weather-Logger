//
//  RemoteEntities.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

extension Remote {
    enum HttpMethod: String {
        case get
        case post
        case put
        case delete
    }
    
    enum ContentType: String {
        case json = "application/json"
        case urlEncoded = "application/x-www-form-urlencoded"
    }
    
    enum HttpHeader {
        case contentType(ContentType)
        case authorization(Authorization)
        case channel
        
        enum Authorization {
            case none(String)
            case bearer(String)
        }

        func pair() -> (key: String, value: String) {
            switch self {
            case .contentType(let value):
                return (key: "content-type", value: value.rawValue)
            case .authorization(let authorization):
                switch authorization {
                case .none(let token):
                    return (key: "authorization", value: token)
                case .bearer(let token):
                    return (key: "authorization", value: "Bearer \(token)")
                }
            case .channel:
                return (key: "channel-type", value: "IOS")
            }
        }
    }
}

extension Remote.HttpHeader: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pair().key)
    }
    
    static func == (lhs: Remote.HttpHeader, rhs: Remote.HttpHeader) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
