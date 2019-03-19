//
//  AppServices.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class AppServices {
    static var loginService: LoginService = {
        #if MOCK
        return MockLoginService()
        #else
        return DefaultLoginService()
        #endif
    }()
}
