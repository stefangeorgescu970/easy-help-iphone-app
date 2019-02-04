//
//  ServerRequest.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation

class ServerRequest {
    private let apiEndpoint: String = "https://easy-help-backend.herokuapp.com/api"
    private var parameters = [String : AnyObject]()
    
    func getEndpoint() -> String {
        return apiEndpoint
    }
    
    func addParameter(key: String, value: AnyObject) {
        parameters[key] = value
    }
    
    func getParameters() -> [String : AnyObject] {
        return parameters
    }
}
