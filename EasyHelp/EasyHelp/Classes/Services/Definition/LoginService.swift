//
//  LoginService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

protocol LoginService {
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (DonorProfileData?, NSError?) -> ())
    
    func signupUser(withName name: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ())
    
    func logoutUser(callback: @escaping ((Bool?) -> ()))
}
