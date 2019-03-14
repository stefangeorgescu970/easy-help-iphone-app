//
//  EmailUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class EmailUtils {
    static func isValidEmailFormat(_ email: String) -> Bool {
        
        #if MOCK
        return true
        #endif
        
        if !email.contains("@") {
            return false
        }
        
        let split = email.split(separator: "@")
        if split.count != 2 {
            return false
        }
        
        let domain = split[1]
        let domainSplit = domain.split(separator: ".")
        if domainSplit.count != 3 {
            return false
        }
        
        if domainSplit[1] != "ubbcluj" || domainSplit[2] != "ro" || (domainSplit[0] != "cs" && domainSplit[0] != "scs") {
            return false
        }
        return true
    }
    
    static func isProfessorEmail(_ email: String) -> Bool {
        #if MOCK
//        return MockGlobalData.mockingProfessor
        #endif
        
        let domain = email.split(separator: "@")[1]
        let studprof = String(domain.split(separator: ".")[0])
        return studprof == "cs"
    }
}

