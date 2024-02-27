//
//  ViewController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 27.02.2024.
//

import UIKit
import SnapKit

final class DrinkWaterViewController: UIViewController {
    
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
    
    private let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTapGesture()
        setupNavigationBar()
        setupLabelStackView()
    }
    
    //MARK: - Layout
    
    private func setupView() {
        view.backgroundColor = ThemeColor.primaryColor
        view.isUserInteractionEnabled = true
    }
    
    private func setupTapGesture() {
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(didTap))
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(resetWaterCountToZero))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(goToProfile))
    }
    
    private func setupLabelStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //        stackView.spacing = 2
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        stackView.addArrangedSubview(baseLabel)
        stackView.addArrangedSubview(waterCountLabel)
        stackView.addArrangedSubview(achievementRateLabel)
        
    }
    
    // MARK: - Action
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    @objc private func resetWaterCountToZero() {}
    
    @objc private func goToProfile() {}
}

