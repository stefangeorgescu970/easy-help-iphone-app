//
//  UISegmentedControl+IsSelected.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 02/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func isOptionSelected() -> Bool {
        return selectedSegmentIndex != -1
    }
}
