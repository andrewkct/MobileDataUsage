//
//  ApiManager.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import Foundation

class MobileDataUsageService {
    func getMobileDataUsage() {
        // Set params
        let getMobileDataUsageEndpoint = String(format: "%@?resource_id=", "/action/datastore_search", AppConstant.resourceId)
        
        let request = Request(baseUrl: AppConstant.baseUrl,
                              endPoint: getMobileDataUsageEndpoint,
                              method: .get,
                              params: nil,
                              headers: nil)
        
        let nm = NetworkManager()
        nm.make(request: request, onSuccess: { [weak self] (data: MobileDataUsage) in
            print("Success \(data)")
        }) { (error) in
            print("Error \(error)")
        }
    }
}
