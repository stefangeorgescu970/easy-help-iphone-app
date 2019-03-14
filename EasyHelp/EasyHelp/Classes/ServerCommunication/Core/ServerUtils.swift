//
//  ServerUtils.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import Foundation

class ServerUtils {
    struct Holder {
        static var serverProtocol: String?
        static var serverBaseUrl: String?
    }
    
    static var serverProtocol: String {
        get {
            return Holder.serverProtocol ?? AppSettings.serverProtocol
        }
        set {
            Holder.serverProtocol = newValue
        }
    }
    
    static var serverBaseUrl: String {
        get {
            return Holder.serverBaseUrl ?? AppSettings.serverBaseUrl
        }
        set {
            Holder.serverBaseUrl = newValue
        }
    }
    
    static var serverAddress: String {
        return serverProtocol + "://" +  serverBaseUrl
    }
    
    static func getEndpointAddress(withEndpointPath endpoint: String, onController controller: String?) -> String {
        return serverAddress + "/" + (controller != nil ? "\(controller!)/\(endpoint)" : endpoint)
    }
}
