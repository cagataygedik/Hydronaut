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
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let achievementRateLabel: UILabel = {
        let label = UILabel()
//        label.text = "Progress: 0%"
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
    
    public let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    internal let drinkWaterButton = HYDButton()
    weak var viewController: UIViewController?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTopStackView()
        setupImageView()
        setupWaterInputTextField()
        setupBottomStackView()
        animateMarsImageView()
        updateUI()
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
        
        drinkWaterButton.addTarget(self, action: #selector(didtapDrinkWaterButton), for: .touchUpInside)
    }
    
    internal func animateMarsImageView() {
        marsImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.marsImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    private func updateUI() {
        updateWaterCountLabel()
        updateAchievementRateLabel()
        updateGuideLabel()
    }
    
    // MARK: - Actions
    
    @objc private func didtapDrinkWaterButton() {
        guard let text = waterInputTextField.text, text.isNotEmpty else {
            let alert = UIAlertController(title: "Oopsie", message: "Please enter a value first", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "I'm on it", style: .default)
            alert.addAction(okayAction)
            viewController?.present(alert, animated: true, completion: nil)
            return
        }
        waterInputTextField.text = nil
        
        if WaterManager.shared.recommendedIntake == 0 {
            let alert = UIAlertController(title: "No user info", message: "Please enter your info first", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Take me there", style: .default) { _ in
                self.viewController?.navigationController?.pushViewController(HYDProfileViewController(), animated: true)
            }
            alert.addAction(okayAction)
            viewController?.present(alert, animated: true, completion: nil)
            return
        }
        let waterVolumeString = text.replacingOccurrences(of: "ml", with: "")
        let waterVolume = Int(waterVolumeString) ?? 0
        WaterManager.shared.addWaterVolume(size: waterVolume)
    }
}

//MARK: - Helpers

extension HYDDrinkWaterView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text == " " {
            textField.text = nil
            return
        }
        textField.text = textField.text?.replacingOccurrences(of: " ", with: "")
        textField.text = textField.text! + "ml"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//Updating the views
extension HYDDrinkWaterView {
    func updateMarsImage() {
        
    }
    
    func updateOnAchievement() {
        
    }
    
     func updateGuideLabel() {
        let nickName = WaterManager.shared.nickName
        let recommendedIntake = WaterManager.shared.recommendedIntake
        let liter = Float(recommendedIntake) / Float(1000)
        guideLabel.text = "\(nickName) amount of water you should drink daily is \(liter)L."
    }
    
    func updateAchievementRateLabel() {
        let newRate = WaterManager.shared.achievementRate
        var resultText: String
        if newRate.isNaN || newRate.isInfinite {
            resultText = "0"
        } else {
            resultText = "\(Int(newRate.rounded(.down)))"
        }
        achievementRateLabel.text = "Process: \(resultText)%"
    }
    
    func updateWaterCountLabel() {
        let newVolume = WaterManager.shared.userIntake
        waterCountLabel.text = "\(newVolume)ml"
    }
}
