//
//  AppInterfaceFormatter.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//


import UIKit

class AppInterfaceFormatter {
    static func addUnderline(toTextField textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = AppColors.darkBlue.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    static func addSeparator(view: UIView, yOffset: CGFloat, marginSpacing: CGFloat, height: CGFloat, color: UIColor = AppColors.darkBlue) {
        let sep = UIView(frame: CGRect(x: marginSpacing, y: yOffset, width: view.frame.width - 2 * marginSpacing, height: height))
        sep.backgroundColor = color
        view.addSubview(sep)
    }
    
    static func createBoldFontLabel(fontSize: CGFloat, text: String = "", color: UIColor = AppColors.darkBlue) -> UILabel {
        let label = UILabel()
        label.font = AppFonts.boldFontWithSize(fontSize)
        label.textAlignment = .center
        label.contentMode = .center
        label.text = text
        label.textColor = color
        return label
    }
    
    static func createRegularFontLabel(fontSize: CGFloat, text: String = "", color: UIColor = AppColors.darkBlue) -> UILabel {
        let label = UILabel()
        label.font = AppFonts.regularFontWithSize(fontSize)
        label.textAlignment = .center
        label.contentMode = .center
        label.text = text
        label.textColor = color
        label.sizeToFit()
        return label
    }
    
    static func addLabel(toView: UIView, withText text: String, xOffset: CGFloat, yOffset: CGFloat) -> CGFloat {
        let label = UILabel()
        label.textColor = AppColors.almostBlack
        label.text = text
        label.sizeToFit()
        label.frame = CGRect(x: xOffset,
                             y: yOffset,
                             width: label.frame.width,
                             height: label.frame.height)
        toView.addSubview(label)
        return label.frame.height
    }
    
    static func addDefaultInfoRow(toView: UIView, leftText: String, rightText: String, marginSpacing: CGFloat, yOffset: CGFloat) -> CGFloat {
        let leftLabel = UILabel()
        leftLabel.font = AppFonts.boldFontWithSize(16)
        leftLabel.text = leftText
        leftLabel.sizeToFit()
        leftLabel.textColor = AppColors.almostBlack
        leftLabel.frame = CGRect(x: marginSpacing,
                                 y: yOffset,
                                 width: leftLabel.frame.width,
                                 height: leftLabel.frame.height)
        toView.addSubview(leftLabel)
        
        let rightLabelMaximumWidth = toView.frame.width - leftLabel.frame.width - 3 * marginSpacing
        
        let rightLabel = UILabel()
        rightLabel.textColor = AppColors.almostBlack
        rightLabel.text = rightText
        rightLabel.sizeToFit()
        rightLabel.lineBreakMode = .byTruncatingMiddle
        rightLabel.frame = CGRect(x: max(toView.frame.width - marginSpacing - rightLabel.frame.width, toView.frame.width - marginSpacing - rightLabelMaximumWidth),
                                  y: yOffset,
                                  width: min(rightLabelMaximumWidth, rightLabel.frame.width),
                                  height: rightLabel.frame.height)
        toView.addSubview(rightLabel)
        
        return rightLabel.frame.height
    }
    
    static func addVerticalSeparator(toView: UIView, xOffset: CGFloat, yOffset: CGFloat, width: CGFloat, height: CGFloat, color: UIColor = AppColors.darkBlue) {
        let verticalLine = UIView(frame: CGRect(x: xOffset,
                                                y: yOffset,
                                                width: width,
                                                height: height))
        verticalLine.layer.cornerRadius = 1
        verticalLine.backgroundColor = color
        toView.addSubview(verticalLine)
    }
}
