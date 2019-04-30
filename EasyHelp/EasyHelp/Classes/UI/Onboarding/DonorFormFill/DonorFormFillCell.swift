//
//  DonorFormFillCell.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 30/04/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//

import UIKit

class DonorFormFillCell: UITableViewCell {
    private let questionLabel = UILabel()
    private var numberLabel = UILabel()
    
    func syncView(question: String, answerView: UIView) {
        self.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        questionLabel.font = AppFonts.regularFontWithSize(20)
        questionLabel.textColor = AppColors.almostBlack
        questionLabel.text = question
        questionLabel.textAlignment = NSTextAlignment.center
        questionLabel.numberOfLines = 0
        questionLabel.frame = CGRect(origin: CGPoint(x: 10, y: 10),
                                     size: questionLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.size.width - 20,
                                                                             height: UIScreen.main.bounds.size.height)))
        questionLabel.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - questionLabel.frame.width) / 2, y: questionLabel.frame.origin.y)
        self.addSubview(questionLabel)
        
        answerView.frame = CGRect(x: 20, y: questionLabel.frame.maxY + 10, width: UIScreen.main.bounds.size.width - 40, height: 40)
        self.addSubview(answerView)
        
        if let stepperView = answerView as? UIStepper {
            stepperView.addTarget(self, action: #selector(DonorFormFillCell.didChangeStepperValue(_:)), for: .valueChanged)
            numberLabel.text = "\(Int(stepperView.value))"
            numberLabel.font = AppFonts.regularFontWithSize(20)
            numberLabel.textColor = AppColors.almostBlack
            numberLabel.sizeToFit()
            numberLabel.frame.origin = CGPoint(x: UIScreen.main.bounds.size.width - 20 - numberLabel.frame.width,
                                               y: answerView.frame.origin.y)
            self.addSubview(numberLabel)
        }
        
        self.heightAnchor.constraint(equalToConstant: answerView.frame.maxY + 10).isActive = true
    }
    
    @objc func didChangeStepperValue(_ sender: UIStepper) {
        numberLabel.text = "\(Int(sender.value))"
        numberLabel.sizeToFit()
        numberLabel.frame.origin = CGPoint(x: UIScreen.main.bounds.size.width - 20 - numberLabel.frame.width,
                                           y: numberLabel.frame.origin.y)
    }
}
