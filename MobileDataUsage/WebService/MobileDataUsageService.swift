//
//  ApiManager.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

class MobileDataUsageService {
    func getMobileDataUsage(onSuccess: @escaping ((MobileDataUsage) -> Void),
                            onError: @escaping ((String) -> Void)) {
        
        // Set params
        let mobileDataUsageEndpoint = String(format: "%@?resource_id=%@", "/action/datastore_search", AppConstant.resourceId)
        
        let request = Request(baseUrl: AppConstant.baseUrl,
                              endPoint: mobileDataUsageEndpoint,
                              method: .get,
                              params: nil,
                              headers: nil)
        
        let networkManager = NetworkManager()
        networkManager.make(request: request, onSuccess: { (data: MobileDataUsage) in
            onSuccess(data)
        
        }) { (error) in
            onError(error)
        }
    }
}
