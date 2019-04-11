//
//  ErrorUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class ErrorUtils {
    static func getDefaultServerError() -> NSError {
        return NSError(domain: "EasyHelp", code: 404, userInfo: ["description": "Some weird error occured."])
    }
    
    static func getInvalidCredentialsError() -> NSError {
        return NSError(domain: "EasyHelp", code: 403, userInfo: ["description": "Provided credentials are not valid."])
    }
}
