//
//  DefaultDoctorService.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation

class DefaultDoctorService: DoctorService {
    func getAllDoctors(callback: @escaping (([Doctor]) -> ())) {
        let parser = DoctorsParser()
        let request = ServerRequest()
        request.addParameter(key: "id", value: "doctor" as AnyObject)
        request.addParameter(key: "act", value: "getAll" as AnyObject)
        let callback = SimpleServerCallback(successBlock: {(data: AnyObject?) in
            var doctors = [Doctor]()
            if let dataU = data as? [Doctor] {
                doctors = dataU
            }
            callback(doctors)
            
        }, errorBlock: { (error: AnyObject?) in
            callback([Doctor]())
        })
        Server.sharedInstance.send(request, parser: parser, callback: callback)
    }
}
