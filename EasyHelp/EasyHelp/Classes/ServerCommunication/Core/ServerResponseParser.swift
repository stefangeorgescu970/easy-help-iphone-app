//
//  ServerResponseParser.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class ServerResponseParser {
    func doParse(content: JSON) {
        
    }
    
    func getResult() -> AnyObject? {
        return nil
    }
    
    func parseError(content: JSON) -> AnyObject? {
        return NSError()
    }
    
    func parse(_ body: JSON) -> AnyObject? {
        let response = body["model"]
        if response.exists(){
            doParse(content: response)
        } else {
            let error = body["error"]
            if error.exists() {
                return parseError(content: error)
            }
        }
        return getResult()
    }
}
