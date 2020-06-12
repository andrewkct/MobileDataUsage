//
//  NetworkManager.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

class NetworkManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func make<T: Decodable>(request: Request,
                            onSuccess: @escaping ((T) -> Void),
                            onError: @escaping ((String) -> Void)) {
        
        // Set request url
        let requestUrl = URL(string: String(format: "%@%@", request.baseUrl, request.endPoint))!
        var urlRequest = URLRequest(url: requestUrl)
        
        // Set HTTP method
        urlRequest.httpMethod = request.method.rawValue
        
        // Set request header
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Set timeout
        urlRequest.timeoutInterval = request.timeOut
        
        // Set Body
        if urlRequest.httpMethod == HttpMethod.post.rawValue {
            if let data = request.params {
                urlRequest.httpBody = data
            }
        }
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    onError(error.localizedDescription)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    onError("Unexpected error")
                }
                return
            }
            
            // Parsing data
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    onSuccess(models)
                }
            
            } catch let decodeError {
                DispatchQueue.main.async {
                    onError("Error decoding JSON \(decodeError)")
                }
            }
        }
        
        dataTask.resume()
    }
}
