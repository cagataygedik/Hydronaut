//
//  ViewController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 27.02.2024.
//

import UIKit
import SnapKit

final class HYDDrinkWaterView: UIView {
    
    //MARK: - Properties
    
    private let baseLabel: UILabel = {
        let label = UILabel()
        label.text = "Well done!\nThe amount you drink today is"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let waterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0ml" //will remove
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let achievementRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress: 0%" //will remove
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    private let marsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ImageTest"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let waterInputTextField = HYDTextField()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "(User) Your recommended daily water intake is (0.0)L."
        label.textAlignment = .center
        return label
    }()
    
    internal let drinkWaterButton = HYDButton()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTopStackView()
        setupImageView()
        setupWaterInputTextField()
        setupBottomStackView()
        animateMarsImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func setupView() {
        backgroundColor = HYDColors.primaryColor
    }
    
    // baseLabel, waterCountLabel, achievementRateLabel
    private func setupTopStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.left.equalTo(safeAreaLayoutGuide).offset(40)
        }
        
        stackView.addArrangedSubview(baseLabel)
        stackView.addArrangedSubview(waterCountLabel)
        stackView.addArrangedSubview(achievementRateLabel)
    }
    
    private func setupImageView() {
        addSubview(marsImageView)
        marsImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-70)
            make.height.equalTo(marsImageView.snp.width)
        }
    }
    
    private func setupWaterInputTextField() {
        addSubview(waterInputTextField)
        waterInputTextField.snp.makeConstraints { make in
            make.top.equalTo(marsImageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
    
    //guideLabel, drinkWaterButton
    private func setupBottomStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        stackView.addArrangedSubview(guideLabel)
        stackView.addArrangedSubview(drinkWaterButton)
        
        drinkWaterButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    internal func animateMarsImageView() {
        marsImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.marsImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton() { print("test") }

}
