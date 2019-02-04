//
//  DoctorsParser.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DoctorsParser: ServerResponseParser {
    private var doctors: [Doctor]?
    
    override func doParse(content: JSON) {
        self.doctors = [Doctor]()
        
        if let array = content.array {
            for doctor in array {
                guard let id = doctor["id"].int,
                    let firstName = doctor["firstName"].string,
                    let lastName = doctor["lastName"].string else {
                        continue
                }
                doctors?.append(Doctor(id: id, firstName: firstName, lastName: lastName))
            }
        }
    }
    
    override func getResult() -> AnyObject? {
        return doctors as AnyObject
    }
}
