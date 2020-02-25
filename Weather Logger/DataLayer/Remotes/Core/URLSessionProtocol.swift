//
//  URLSessionProtocol.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    var delegate: URLSessionDelegate? { get }
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
