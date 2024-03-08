//
//  HYDButton.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 28.02.2024.
//

import UIKit

final class HYDButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Drink Water 💧", for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        backgroundColor = .white
    }
}

extension HYDButton {
    func setCustomTitleEdgeInsets(bottomInset: CGFloat) {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        titleEdgeInsets = insets
    }
    
    func makeCustomConstraints(height: CGFloat) {
        snp.makeConstraints { maker in
            maker.height.equalTo(height)
        }
    }
}
