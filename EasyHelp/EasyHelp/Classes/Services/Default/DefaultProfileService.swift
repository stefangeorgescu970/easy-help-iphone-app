//
//  DefaultLoginService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import Alamofire

class DefaultProfileService: ProfileService {
    
    private let myUserDefaults = UserDefaults.standard
    private let userDefaultsKey = "currentUser"
    
    func getCurrentUser() -> DonorProfileData? {
        let data = myUserDefaults.object(forKey: userDefaultsKey) as? Data
        return NSKeyedUnarchiver.unarchiveObject(with: data ?? Data()) as? DonorProfileData
    }
    
    func saveCurrentUser(_ user: DonorProfileData) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        myUserDefaults.set(data, forKey: userDefaultsKey)
    }
    
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (DonorProfileData?, NSError?) -> ()) {
        let request = ServerRequest(endpoint: "login", controller: "users")
        request.addParameter(key: "email", value: email)
        request.addParameter(key: "password", value: password)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            
            
            callback(data as? DonorProfileData, nil)
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(nil, error)
        })
        
        Server.sharedInstance.send(request, parser: DonorProfileDataParser(), callback: callback)
    }
    
    func signupUser(withFirstName firstName: String, withLastName lastName: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "register", controller: "users")
        request.addParameter(key: "email", value: email)
        request.addParameter(key: "firstName", value: firstName)
        request.addParameter(key: "lastName", value: lastName)
        request.addParameter(key: "password", value: password)
        request.addParameter(key: "userType", value: 0)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            if let success = data as? Bool {
                if success {
                    callback(nil)
                    return
                }
            }
            callback(ErrorUtils.getDefaultServerError())
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
    
    func updateCountyAndSSN(newCounty: String, newSSN: String, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "updateSsnCounty", controller: "donor")
        request.addParameter(key: "donorId", value: getCurrentUser()!.id)
        request.addParameter(key: "ssn", value: newSSN)
        request.addParameter(key: "county", value: newCounty)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            if let success = data as? Bool {
                if success {
                    callback(nil)
                    return
                }
            }
            callback(ErrorUtils.getDefaultServerError())
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(error)
        })
        
        Server.sharedInstance.send(request, parser: ServerResponseParser(), callback: callback)
    }
    
    func updateBloodGroup(bloodGroup: String, rh: Bool, callback: @escaping (NSError?) -> ()) {
        let request = ServerRequest(endpoint: "updateBloodGroup", controller: "donor")
        request.addParameter(key: "donorId", value: getCurrentUser()!.id)
        request.addParameter(key: "groupLetter", value: bloodGroup)
        request.addParameter(key: "rh", value: rh)
        
        let callback = SimpleServerCallback(successBlock: { (data) in
            if let success = data as? Bool {
                if success {
                    callback(nil)
                    return
                }
            }
            callback(ErrorUtils.getDefaultServerError())
        }, errorBlock: { (error) in
            let error = error as! NSError
            callback(error)
        })
        
        Server.sharedInstance.send(request, parser: ServerResponseParser(), callback: callback)
    }
}
