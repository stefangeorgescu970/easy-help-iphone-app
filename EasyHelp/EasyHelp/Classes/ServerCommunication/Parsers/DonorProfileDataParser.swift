//
//  DonorProfileDataParser.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 19/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation
import SwiftyJSON

class DonorProfileDataParser: ServerResponseParser {
    private var donorProfileData: DonorProfileData? = nil
    
    override func doParse(content: JSON) {
        print(content)
    }
    
    override func getResult() -> AnyObject? {
        return donorProfileData
    }
}
