//
//  DoctorService.swift
//  EasyHelp
//
//  Created by Georgescu Stefan on 16/09/2018.
//  Copyright © 2018 EasyHelp. All rights reserved.
//

import Foundation

protocol DoctorService {
    func getAllDoctors(callback: @escaping(([Doctor]) -> ()))
}
