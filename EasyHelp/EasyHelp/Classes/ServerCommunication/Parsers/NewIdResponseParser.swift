//
//  NewIdResponseParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 01/06/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewIdResponseParser: ServerResponseParser {
    var newId: Int?
    
    override func doParse(content: JSON) {
        if let id = content["newId"].int {
            newId = id
        }
    }
    
    override func getResult() -> AnyObject? {
        return newId as AnyObject
    }
    
}
