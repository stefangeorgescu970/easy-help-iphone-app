//
//  AppInterfaceFormatter.swift
//  EasyHelp
//
//  Created by Stefan Georgescu on 14/03/2019.
//  Copyright © 2019 EasyHelp. All rights reserved.
//


import UIKit

class AppInterfaceFormatter {
    static func createLink(_ title: String, linkPart: String? = nil) -> UIButton {
        var linkString:String = title
        if let linkPartU = linkPart {
            linkString = linkPartU
        }
        let linkRange = (title as NSString).range(of: linkString)
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.backgroundColor = UIColor.clear
        
        let attributedStringNormal = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: AppFonts.regularFontWithSize(16),
            NSAttributedString.Key.foregroundColor: AppColors.appRed
            ])
        attributedStringNormal.beginEditing()
        attributedStringNormal.addAttributes([
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: linkRange)
        attributedStringNormal.endEditing()
        btn.setAttributedTitle(attributedStringNormal, for: UIControl.State())
        btn.setAttributedTitle(attributedStringNormal, for: UIControl.State.selected)
        
        let attributedStringHighlight = NSMutableAttributedString(attributedString: attributedStringNormal)
        attributedStringHighlight.beginEditing()
        attributedStringHighlight.addAttributes([
            NSAttributedString.Key.foregroundColor: AppColors.appRed
            ], range: linkRange)
        attributedStringHighlight.endEditing()
        btn.setAttributedTitle(attributedStringHighlight, for: UIControl.State.highlighted)
        btn.setAttributedTitle(attributedStringHighlight, for: [UIControl.State.selected, UIControl.State.highlighted])
        
        btn.titleLabel?.numberOfLines = 2
        btn.titleLabel?.textAlignment = NSTextAlignment.center
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        btn.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        btn.sizeToFit()
        
        return btn
        
    }
    
    static func createLongLabel(text: String) -> UILabel {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let attributedText: NSAttributedString = NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
        
        let result = UILabel(frame: CGRect(x: 30, y: 145, width: UIScreen.main.bounds.width - 2 * 30, height: 600))
        result.font = AppFonts.regularFontWithSize(16)
        result.textColor = AppColors.appRed
        result.attributedText = attributedText
        result.numberOfLines = 0
        result.textAlignment = NSTextAlignment.center
        let resultSize = result.sizeThatFits(result.frame.size)
        result.frame.size.height = resultSize.height
        
        return result
    }
    
    static func createHeader(title: String, subtitle: String?) -> UIView {
        if let subtitleU = subtitle {
            return self.createHeader(title: title, subtitleAttributedString: NSAttributedString(string: subtitleU))
        } else {
            return self.createHeader(title: title, subtitleAttributedString: nil)
        }
    }
    
    static func createHeader(title: String, subtitleAttributedString: NSAttributedString?) -> UIView {
        let marginH:CGFloat = 15
        var bounds = UIScreen.main.bounds
        bounds.size.width -= 2 * marginH
        
        let headerView = UIView()
        
        let headerViewWrapper = UIView()
        headerViewWrapper.autoresizingMask = [UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleWidth]
        
        let titleLabel: UILabel = UILabel()
        titleLabel.font = AppFonts.lightFontWithSize(21)
        titleLabel.textColor = AppColors.appRed
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.numberOfLines = 0
        titleLabel.frame = CGRect(origin: CGPoint.zero, size: titleLabel.sizeThatFits(bounds.size))
        titleLabel.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        
        let subtitleLabel:UILabel = UILabel(frame: CGRect.zero)
        var withSubtitle = false
        if let subtitleU = subtitleAttributedString {
            withSubtitle = true
            subtitleLabel.font = AppFonts.lightFontWithSize(12)
            subtitleLabel.textColor = AppColors.appRed
            subtitleLabel.attributedText = subtitleU
            subtitleLabel.textAlignment = NSTextAlignment.center
            subtitleLabel.numberOfLines = 2
            subtitleLabel.frame = CGRect(origin: CGPoint.zero, size: subtitleLabel.sizeThatFits(bounds.size))
            subtitleLabel.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        }
        
        let scrVer = AppScreenUtils.screenVersion
        headerView.frame = CGRect(x: marginH, y: scrVer < 5 ? 10 : 20, width: bounds.width, height: scrVer < 5 ? 65 : 75)
        headerViewWrapper.frame = CGRect(x: 0, y: 0, width: bounds.width, height: titleLabel.bounds.height + subtitleLabel.bounds.height + 5)
        headerViewWrapper.center = CGPoint(x: headerView.frame.width / 2, y: headerView.frame.height / 2)
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: titleLabel.bounds.height + (withSubtitle ? 0 : 7.5))
        subtitleLabel.frame = CGRect(x: 0, y: titleLabel.bounds.height + 5, width: bounds.width, height: subtitleLabel.bounds.height)
        
        headerViewWrapper.addSubview(titleLabel)
        headerViewWrapper.addSubview(subtitleLabel)
        headerView.addSubview(headerViewWrapper)
        
        return headerView
    }
    
    static func addUnderline(toTextField textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = AppColors.appRed.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    static func addSeparator(view: UIView, yOffset: CGFloat, marginSpacing: CGFloat, height: CGFloat, color: UIColor = AppColors.appRed) {
        let sep = UIView(frame: CGRect(x: marginSpacing, y: yOffset, width: view.frame.width - 2 * marginSpacing, height: height))
        sep.backgroundColor = color
        view.addSubview(sep)
    }
    
    static func createBoldFontLabel(fontSize: CGFloat, text: String = "", color: UIColor = AppColors.appRed) -> UILabel {
        let label = UILabel()
        label.font = AppFonts.boldFontWithSize(fontSize)
        label.textAlignment = .center
        label.contentMode = .center
        label.text = text
        label.textColor = color
        return label
    }
    
    static func createRegularFontLabel(fontSize: CGFloat, text: String = "", color: UIColor = AppColors.appRed) -> UILabel {
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
    
    static func addDefaultInfoRow(toView: UIView, leftText: String, rightText: String, marginSpacing: CGFloat, yOffset: CGFloat, isAlert: Bool, accIdStub: String, index: Int) -> CGFloat {
        let leftLabel = UILabel()
        leftLabel.font = AppFonts.boldFontWithSize(16)
        leftLabel.text = leftText
        leftLabel.sizeToFit()
        leftLabel.textColor = isAlert ? AppColors.appRed : AppColors.almostBlack
        leftLabel.frame = CGRect(x: marginSpacing,
                                 y: yOffset,
                                 width: leftLabel.frame.width,
                                 height: leftLabel.frame.height)
        leftLabel.accessibilityIdentifier = "\(index)-left\(accIdStub)"
        toView.addSubview(leftLabel)
        
        let rightLabelMaximumWidth = toView.frame.width - leftLabel.frame.width - 3 * marginSpacing
        
        let rightLabel = UILabel()
        rightLabel.textColor = isAlert ? AppColors.appRed : AppColors.almostBlack
        rightLabel.text = rightText
        rightLabel.sizeToFit()
        rightLabel.lineBreakMode = .byTruncatingMiddle
        rightLabel.frame = CGRect(x: max(toView.frame.width - marginSpacing - rightLabel.frame.width, toView.frame.width - marginSpacing - rightLabelMaximumWidth),
                                  y: yOffset,
                                  width: min(rightLabelMaximumWidth, rightLabel.frame.width),
                                  height: rightLabel.frame.height)
        rightLabel.accessibilityIdentifier = "\(index)-right\(accIdStub)"
        toView.addSubview(rightLabel)
        
        return rightLabel.frame.height
    }
    
    static func addVerticalSeparator(toView: UIView, xOffset: CGFloat, yOffset: CGFloat, width: CGFloat, height: CGFloat, color: UIColor = AppColors.appRed) {
        let verticalLine = UIView(frame: CGRect(x: xOffset,
                                                y: yOffset,
                                                width: width,
                                                height: height))
        verticalLine.layer.cornerRadius = 1
        verticalLine.backgroundColor = color
        toView.addSubview(verticalLine)
    }
    
    static func navigationBarButtonWithIcon(_ icon: UIImage?, highlightIcon: UIImage?) -> UIButton {
        let button = navigationBarButton()
        
        let actualIcon = icon
        let actualHighlightIcon = highlightIcon
        button.setImage(actualIcon, for: UIControl.State())
        button.setImage(actualHighlightIcon, for: UIControl.State.selected)
        button.setImage(actualHighlightIcon, for: UIControl.State.highlighted)
        
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.frame.size.width = max(icon?.size.width ?? 0, button.frame.width)
        let inset: CGFloat = 4
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        return button
    }
    
    static func navigationBarButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 42, height: 44))
        button.adjustsImageWhenDisabled = false;
        button.adjustsImageWhenHighlighted = false;
        button.backgroundColor = UIColor.clear
        return button
    }
    
    static func defaultYesNoControl() -> UISegmentedControl {
        let control = UISegmentedControl(items: ["NO", "YES"])
        control.tintColor = AppColors.appRed
        return control
    }
    
    static func defaultStepperControl() -> UIStepper {
        let stepper = UIStepper(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        stepper.sizeToFit()
        stepper.tintColor = AppColors.appRed
        stepper.value = 1
        stepper.stepValue = 1
        stepper.minimumValue = 0
        
        return stepper
    }
    
    static func defaultTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = AppColors.appRed
        
        return textField
    }
}
