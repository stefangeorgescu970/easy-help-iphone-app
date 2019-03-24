//
//  UIImage+Resize.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 24/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { (context) in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
