//
//  RemoteEndpoint.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 23.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import Foundation

extension Remote {
    
    public class Endpoint: NSObject, URLSessionDelegate {
        let baseRequest = Request()
        
        override init() {
            super.init()
            
            baseRequest.set(session: URLSession(configuration: URLSessionConfiguration.default,
                                                delegate: self,
                                                delegateQueue: nil))
                .set(header: .contentType(.json))
                .set(header: .channel)
        }
        
        /*
         disable SSL Authentication for proxy while debugging
         */
        #if DEBUG
        public func urlSession(_ session: URLSession,
                               didReceive challenge: URLAuthenticationChallenge,
                               completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
        ) {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, nil)
        }
        #else
        public func urlSession(_ session: URLSession,
                               didReceive challenge: URLAuthenticationChallenge,
                               completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
        ) {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
        }
        #endif
    }
    
}
