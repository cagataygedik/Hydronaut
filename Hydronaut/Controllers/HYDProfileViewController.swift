//
//  ProfileViewController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 27.02.2024.
//

import UIKit
import TextFieldEffects

final class HYDProfileViewController: UIViewController {
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ImageTest"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTapGesture()
        setupNavigationBar()
        setupProfileImageView()
    }
    
    //MARK: - Layout
    private func setupView() {
        view.backgroundColor = HYDColors.primaryColor
    }
    
    private func setupTapGesture() {
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(didTap))
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(view).offset(125)
            make.trailing.equalTo(view).offset(-125)
            make.height.equalTo(profileImageView.snp.width)
        }
    }
    
    //MARK: - Actions
    @objc private func saveButtonTapped() {}
    
    @objc private func didTap() { view.endEditing(true) }
}
