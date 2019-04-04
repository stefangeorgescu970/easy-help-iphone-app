//
//  DefaultMiscService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DefaultMiscService: MiscService {
    private var cachedAppEnums: AppEnums? = nil
    
    func getCounties(callback: @escaping ([String]?, NSError?) -> ()) {
        if let cachedAppEnums = cachedAppEnums {
            callback(cachedAppEnums.counties, nil)
        }
        
        let request = ServerRequest(endpoint: "enums")
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            let appEnums = data as? AppEnums
            self.cachedAppEnums = appEnums
            callback(appEnums?.counties, nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: AppEnumsParser(), callback: callback, method: .get)
    }
}
