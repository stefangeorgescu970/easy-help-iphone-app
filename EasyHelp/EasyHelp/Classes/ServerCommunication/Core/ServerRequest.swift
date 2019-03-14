//
//  ServerRequest.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation

class ServerRequest {
    private var apiEndpoint: String
    private var parameters = [String:Any]()
    
    init(endpoint: String, controller: String? = nil, parameters: [String : AnyObject]? = nil) {
        apiEndpoint = ServerUtils.getEndpointAddress(withEndpointPath: endpoint, onController: controller)
        if let parameters = parameters {
            self.parameters = parameters
        }
    }
    
    func getEndpoint() -> String {
        return apiEndpoint
    }
    
    func addParameter(key: String, value: Int) {
        parameters[key] = value
    }
    
    func addParameter(key: String, value: String) {
        parameters[key] = value
    }
    
    func addParameter(key: String, value: Any) {
        parameters[key] = value
    }
    
    func getParameters() -> [String : Any] {
        return parameters
    }
}
