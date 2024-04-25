//
//  PasteDisabledTextField.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 28.02.2024.
//

import UIKit

final class HYDTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        textColor = .white
        textAlignment = .center
        backgroundColor = .clear
        placeholder = "Enter the amount"
        tintColor = .white
        keyboardType = .numberPad
        clearButtonMode = .whileEditing
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
                toolBar.barStyle = .default
                toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
                toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil,action: nil),
                                 doneButton
                ]
                toolBar.isUserInteractionEnabled = true
                inputAccessoryView = toolBar
    }
    
    @objc private func doneButtonTapped() {
        let waterVolumeString = (text?.replacingOccurrences(of: "ml", with: ""))!
        let waterVolume = Int(waterVolumeString) ?? 0
        WaterManager.shared.addWaterVolume(size: waterVolume)
        text = ""
        endEditing(true)
        }
}
//Disables paste action from the text field.
extension HYDTextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
