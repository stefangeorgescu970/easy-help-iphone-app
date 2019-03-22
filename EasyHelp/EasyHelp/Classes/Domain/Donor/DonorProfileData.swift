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
        static let city = "ci"
        static let country = "co"
        static let ssn = "s"
        static let token = "t"
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.id)
        aCoder.encode(firstName, forKey: Keys.firstName)
        aCoder.encode(lastName, forKey: Keys.lastName)
        aCoder.encode(email, forKey: Keys.email)
        aCoder.encode(dateOfBirth, forKey: Keys.dateOfBirth)
        aCoder.encode(city, forKey: Keys.city)
        aCoder.encode(country, forKey: Keys.country)
        aCoder.encode(ssn, forKey: Keys.ssn)
        aCoder.encode(token, forKey: Keys.token)
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeInteger(forKey: Keys.id)
        firstName = aDecoder.decodeObject(forKey: Keys.firstName) as? String
        lastName = aDecoder.decodeObject(forKey: Keys.lastName) as? String
        email = aDecoder.decodeObject(forKey: Keys.email) as! String
        dateOfBirth = aDecoder.decodeObject(forKey: Keys.dateOfBirth) as? Date
        city = aDecoder.decodeObject(forKey: Keys.city) as? String
        country = aDecoder.decodeObject(forKey: Keys.country) as? String
        ssn = aDecoder.decodeObject(forKey: Keys.ssn) as? String
        token = aDecoder.decodeObject(forKey: Keys.token) as! String
    }
    
    var id: Int
    
    var firstName: String?
    var lastName: String?
    var email: String
    
    var dateOfBirth: Date?
    var city: String?
    var country: String?
    var ssn: String?
    
    var token: String
    
    public init(id: Int, email: String, token: String) {
        self.id = id
        self.email = email
        self.token = token
    }
}
