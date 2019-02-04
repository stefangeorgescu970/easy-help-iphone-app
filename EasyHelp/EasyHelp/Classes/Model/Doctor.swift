//
//  Doctor.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation

class Doctor {
    var id: Int = -1
    var firstName: String = ""
    var lastName: String = ""
    
    func getStringRep() -> String {
        return "\(id), " + firstName + ", " + lastName
    }
    
    init(id: Int, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
