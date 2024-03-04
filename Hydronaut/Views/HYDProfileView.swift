//
//  HYDProfileView.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 4.03.2024.
//

import UIKit
import TextFieldEffects

final class HYDProfileView: UIView {
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ImageTest"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupProfileImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func setupView() {
        backgroundColor = HYDColors.primaryColor
    }
    
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().offset(125)
            make.trailing.equalToSuperview().offset(-125)
            make.height.equalTo(profileImageView.snp.width)
        }
    }
}
