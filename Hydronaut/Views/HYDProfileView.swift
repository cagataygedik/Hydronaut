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
    
    private let nameTextField: IsaoTextField = IsaoTextField.initCustomizedField()
    private let heightTextField: IsaoTextField = IsaoTextField.initCustomizedField(keyboardType: .numberPad)
    private let weightTextField: IsaoTextField = IsaoTextField.initCustomizedField(keyboardType: .numberPad)
    
    private var arrangeSubviews: [UIStackView] = []
    
    private lazy var mainVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: arrangeSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupProfileImageView()
        setupMainStackView()
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
    
    private func arrangeVerticalStackViews() {
        let nameVerticalStackView = makeConfiguredStackView(title: "Please set a nickname", textField: nameTextField)
        arrangeSubviews.append(nameVerticalStackView)
        
        let heightVerticalStackView = makeConfiguredStackView(title: "Please set your height (cm)", textField: heightTextField)
        arrangeSubviews.append(heightVerticalStackView)
        
        let weightVerticalStackView = makeConfiguredStackView(title: "Please enter your weight (kg)", textField: weightTextField)
        arrangeSubviews.append(weightVerticalStackView)
    }
    
    private func setupMainStackView() {
        arrangeVerticalStackViews()
        
        addSubview(mainVerticalStackView)
        mainVerticalStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.greaterThanOrEqualTo(0)
        }
    }
}
//MARK: - Extensions

extension HYDProfileView {
    private func makeConfiguredStackView(title: String, textField: UITextField) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
}
