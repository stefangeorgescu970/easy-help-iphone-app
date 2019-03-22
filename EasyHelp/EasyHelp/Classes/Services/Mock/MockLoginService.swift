//
//  MockLoginService.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockLoginService: LoginService {
    
    private let acceptedAccounts = MockGlobalData.acceptedAccounts()
    
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (ProfileData?, NSError?) -> ()) {
    }
    
    func signupUser(withName name: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ()) {
    }
    
    func logoutUser(callback: @escaping ((Bool?) -> ())) {
    }
    
}
