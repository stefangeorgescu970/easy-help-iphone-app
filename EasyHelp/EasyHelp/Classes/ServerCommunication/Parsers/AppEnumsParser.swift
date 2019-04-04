//
//  AppEnumsParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 04/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppEnumsParser: ServerResponseParser {
    var appEnums: AppEnums?
    
    override func doParse(content: JSON) {
        let enums = AppEnums()
        
        if let countiesJsonArray = content["counties"].array {
            let countiesArray = countiesJsonArray.map { (obj) -> String in
                obj.stringValue
            }
            enums.counties = countiesArray
        }
        
        appEnums = enums
    }
    
    override func getResult() -> AnyObject? {
        return appEnums as AnyObject
    }
    
}
