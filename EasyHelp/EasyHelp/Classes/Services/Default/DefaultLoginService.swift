//
//  DefaultLoginService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import Alamofire

class DefaultLoginService: LoginService {
    
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (DonorProfileData?, NSError?) -> ()) {
        let request = ServerRequest(endpoint: "login")
        request.addParameter(key: "email", value: email)
        request.addParameter(key: "password", value: password)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(data as? DonorProfileData, nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: DonorProfileDataParser(), callback: callback, encoding: JSONEncoding.default)
    }
    
    func signupUser(withName name: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "register")
        request.addParameter(key: "email", value: email)
        request.addParameter(key: "name", value: name)
        request.addParameter(key: "password", value: password)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(error)
        })
        
        Server.sharedInstance.send(request, parser: ServerResponseParser(), callback: callback)
    }
    
    func logoutUser(callback: @escaping ((Bool?) -> ())) {
        let request = ServerRequest(endpoint: "logout")
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            callback(true)
        }, errorBlock: { (error) in
            callback(false)
        })
        
        Server.sharedInstance.send(request, parser: ServerResponseParser(), callback: callback)
    }
}
