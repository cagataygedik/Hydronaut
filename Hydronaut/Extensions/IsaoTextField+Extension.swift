//
//  IsaoTextField+Extension.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 2.03.2024.
//

import UIKit
import TextFieldEffects

extension IsaoTextField {
    static func initCustomizedField(keyboardType type: UIKeyboardType = .default) -> IsaoTextField {
        let textField = IsaoTextField.init()
        textField.keyboardType = type
        textField.activeColor = .white
        textField.inactiveColor = HYDColors.secondaryColor
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .white
        textField.tintColor = .white
        return textField
    }
}

extension IsaoTextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
