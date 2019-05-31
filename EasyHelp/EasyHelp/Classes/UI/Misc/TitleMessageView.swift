//
//  TitleMessageView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 31/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class TitleMessageView: UIView {
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.font = AppFonts.regularFontWithSize(18)
        label.textColor = AppColors.appRed
        label.text = title
        label.sizeToFit()
        label.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin]
        self.addSubview(label)
        
        label.center = CGPoint(x: frame.width / 2, y: (frame.height) / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
