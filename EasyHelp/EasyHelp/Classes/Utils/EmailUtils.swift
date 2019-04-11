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
        
        return true
    }
}

