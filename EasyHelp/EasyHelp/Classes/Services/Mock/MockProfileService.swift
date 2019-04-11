//
//  MockProfileService.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockProfileService: ProfileService {
    
    private let userDefs = UserDefaults.standard
    private let defsKey = "mockLogIn"
    
    private let acceptedAccounts = MockGlobalData.acceptedAccounts()
    
    func getCurrentUser() -> DonorProfileData? {
        if userDefs.bool(forKey: defsKey) {
            return MockGlobalData.getMockProfile()
        }
        return nil
    }
    
    func saveCurrentUser(_ user: DonorProfileData) {
        userDefs.set(true, forKey: defsKey)
    }
    
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (DonorProfileData?, NSError?) -> ()) {
        if let accPassword = self.acceptedAccounts[email] {
            if accPassword == password {
                callback(MockGlobalData.getUncompleteMockProfile(), nil)
            } else {
                callback(nil, NSError())
            }
        } else {
            callback(nil, NSError())
        }
    }
    
    func signupUser(withFirstName firstName: String, withLastName lastName: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [unowned self] in
            if self.acceptedAccounts.keys.contains(email) {
                callback(NSError())
            } else {
                callback(nil)
            }
        }
    }
    
    func logoutUser(callback: @escaping ((Bool?) -> ())) {
        userDefs.set(false, forKey: defsKey)
        callback(true)
    }
    
    
    func getDonationSummary(id: Int, callback: @escaping (DonorSummaryData?, NSError?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(DonorSummaryData(), nil)
        }
    }
    
}
