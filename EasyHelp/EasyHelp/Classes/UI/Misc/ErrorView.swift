//
//  ErrorView.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 31/05/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate: class {
    func errorViewDidRequestTryAgain(_ errorView: ErrorView)
}

class ErrorView: UIView {
    
    let button = ButtonWithActivity()
    weak var delegate: ErrorViewDelegate?
    
    init(frame: CGRect, errorMessage: String) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.font = AppFonts.regularFontWithSize(18)
        label.textColor = AppColors.accentRed
        label.text = errorMessage
        label.sizeToFit()
        label.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin]
        self.addSubview(label)
        
        button.setTitle(Strings.Misc.tryAgain(), for: .normal)
        button.setTitleColor(AppColors.appRed, for: .normal)
        button.addTarget(self, action: #selector(ErrorView.didPressTryAgain), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 0, width: frame.width - 120, height: 40)
        self.addSubview(button)
        
        label.center = CGPoint(x: frame.width / 2, y: (frame.height) / 2 - 40)
        button.center = CGPoint(x: frame.width / 2, y: (frame.height) / 2 - 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPressTryAgain() {
        button.showLoading()
        delegate?.errorViewDidRequestTryAgain(self)
    }
}

