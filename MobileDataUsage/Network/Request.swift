//
//  Request.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

struct Request {
    let baseUrl: String
    let endPoint: String
    let method: HttpMethod
    let params: Data?
    let headers: [String: String]?
    let timeOut: TimeInterval
    
    init (baseUrl: String = "",
          endPoint: String = "",
          method: HttpMethod = .get,
          params: Data? = nil,
          headers: [String: String]? = nil,
          timeOut: TimeInterval = 20) {
        
        self.baseUrl = baseUrl
        self.endPoint = endPoint
        self.method = method
        self.params = params
        self.headers = headers
        self.timeOut = timeOut
    }
}
