//
//  ProfileService.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

protocol ProfileService {
    func loginUser(withEmail email: String, andPassword password: String, callback: @escaping (DonorProfileData?, NSError?) -> ())
    
    func signupUser(withFirstName firstName: String, withLastName lastName: String, withEmail email: String, withPassword password: String, callback: @escaping (NSError?) -> ())
    
    func logoutUser(callback: @escaping ((Bool?) -> ()))
    
    func getCurrentUser() -> DonorProfileData?
    
    func saveCurrentUser(_ user: DonorProfileData)
    
    func updateCountyAndSSN(newCounty: String, newSSN: String, callback: @escaping (NSError?) -> ())
    
    func updateBloodGroup(bloodGroup: String, rh: Bool, callback: @escaping (NSError?) -> ())
}
