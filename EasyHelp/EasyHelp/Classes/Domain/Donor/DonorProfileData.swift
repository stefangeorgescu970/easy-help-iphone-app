//
//  DonorProfileData.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class DonorProfileData: NSObject, NSCoding {
    private struct Keys {
        static let id = "id"
        static let firstName = "fn"
        static let lastName = "ln"
        static let email = "e"
        static let dateOfBirth = "dob"
        static let county = "co"
        static let ssn = "s"
        static let token = "t"
        static let bloodGroupLetter = "bg"
        static let bloodGroupRh = "r"
        static let isMale = "male"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.id)
        aCoder.encode(firstName, forKey: Keys.firstName)
        aCoder.encode(lastName, forKey: Keys.lastName)
        aCoder.encode(email, forKey: Keys.email)
        aCoder.encode(isMale, forKey: Keys.isMale)
        aCoder.encode(dateOfBirth, forKey: Keys.dateOfBirth)
        aCoder.encode(county, forKey: Keys.county)
        aCoder.encode(ssn, forKey: Keys.ssn)
        aCoder.encode(token, forKey: Keys.token)
        aCoder.encode(bloodGroupLetter, forKey: Keys.bloodGroupLetter)
        aCoder.encode(bloodRh, forKey: Keys.bloodGroupRh)
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeInteger(forKey: Keys.id)
        firstName = aDecoder.decodeObject(forKey: Keys.firstName) as! String
        lastName = aDecoder.decodeObject(forKey: Keys.lastName) as! String
        email = aDecoder.decodeObject(forKey: Keys.email) as! String
        dateOfBirth = aDecoder.decodeObject(forKey: Keys.dateOfBirth) as? Date
        isMale = aDecoder.decodeObject(forKey: Keys.isMale) as? Bool
        county = aDecoder.decodeObject(forKey: Keys.county) as? String
        ssn = aDecoder.decodeObject(forKey: Keys.ssn) as? String
        token = aDecoder.decodeObject(forKey: Keys.token) as! String
        bloodGroupLetter = aDecoder.decodeObject(forKey: Keys.bloodGroupLetter) as? String
        bloodRh = aDecoder.decodeObject(forKey: Keys.bloodGroupRh) as? Bool
    }
    
    var id: Int
    
    var firstName: String
    var lastName: String
    var email: String
    
    var dateOfBirth: Date?
    var county: String?
    var ssn: String?
    
    var bloodGroupLetter: String?
    var bloodRh: Bool?
    
    var isMale: Bool?
    
    var token: String
    
    public init(id: Int, email: String, token: String, firstName: String, lastName: String) {
        self.id = id
        self.email = email
        self.token = token
        self.lastName = lastName
        self.firstName = firstName
    }
    
    public func shouldSeeOnboarding() -> Bool {
        #if MOCK
        return false
        #endif
        
        return county == nil
    }
}
