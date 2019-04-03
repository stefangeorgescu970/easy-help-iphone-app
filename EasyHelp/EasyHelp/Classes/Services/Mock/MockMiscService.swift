//
//  MockMiscService.swift
//  EasyHelp Mock
//
//  Created by Stefan Georgescu on 03/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class MockMiscService: MiscService {
    func getCounties(callback: @escaping ([String]?, NSError?) -> ()) {
        callback(["Arad", "Timisoara"], nil)
    }
}
