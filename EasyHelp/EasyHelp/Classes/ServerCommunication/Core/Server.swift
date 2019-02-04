//
//  Server.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Server {
    fileprivate struct Holder {
        static let instance = Server()
    }
    
    class var sharedInstance: Server {
        return Holder.instance
    }
    
    private struct Constants {
        static let backgroundSessionIdentifier: String = "easyHelp - backgroundTask"
    }
    
    lazy private var networkManager: SessionManager = {
        let config = URLSessionConfiguration.background(withIdentifier: Constants.backgroundSessionIdentifier)
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: config)
        return manager
    }()
    
    func send(_ request: ServerRequest, parser: ServerResponseParser?, callback: SimpleServerCallback?) {
        self.networkManager.request(request.getEndpoint(), method: .post,  parameters: request.getParameters(), encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success(let value):
                let json = JSON(parseJSON: value)
                if let parsedData = parser?.parse(json) {
                    callback?.onSuccess(parsedData)
                } else {
                    callback?.onError(nil)
                }
            case .failure(let error):
                callback?.onError(error)
            }
        }
    }
}
