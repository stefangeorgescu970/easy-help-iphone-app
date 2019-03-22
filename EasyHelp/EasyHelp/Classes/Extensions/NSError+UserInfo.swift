//
//  NSError+UserInfo.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 22/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

extension NSError {
    var myErrorInfo: String {
        return self.userInfo["description"] as? String ?? "Some error occured. Please try again."
    }
}
