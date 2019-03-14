//
//  AppSettings.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class AppSettings {
    
    // MARK: - Declarations
    
    fileprivate static let settingsFileName: String = {
        #if DEVELOPMENT
        return "Settings-Dev"
        #else
        return "Settings-Local"
        #endif
    }()
    
    fileprivate static let sharedSettings = AppSettings(plist: settingsFileName)
    
    fileprivate let settings: [String: Any]
    
    fileprivate init(plist: String) {
        guard
            let path = Bundle.main.path(forResource: plist, ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any>
            else {
                settings = [String: Any]()
                return
        }
        
        settings = dictionary
    }
    
    fileprivate func stringValue(_ key: String) -> String {
        return settings[key] as? String ?? ""
    }
    
    fileprivate func boolValue(_ key: String) -> Bool {
        return settings[key] as? Bool ?? false
    }
    
    fileprivate func numberValue(_ key: String) -> NSNumber {
        return settings[key] as? NSNumber ?? NSNumber(value: 0)
    }
    
    // MARK: - Property Access
    
    static let serverProtocol = sharedSettings.stringValue("EH_SETTINGS_SERVER_PROTOCOL")
    static let serverBaseUrl = sharedSettings.stringValue("EH_SETTINGS_SERVER_HOST")
}
