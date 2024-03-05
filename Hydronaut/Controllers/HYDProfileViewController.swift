//
//  ProfileViewController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 27.02.2024.
//

import UIKit

final class HYDProfileViewController: UIViewController {
    
    //MARK: - Properties
    private let profileView = HYDProfileView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTapGesture()
        setupNavigationBar()
    }
    
    //MARK: - Layout
    private func setupView() {
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        profileView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    //MARK: - Actions
    @objc private func saveButtonTapped() {
        guard let userInfo = profileView.extractUserInfoFromTextField() else {
            let alert = UIAlertController(title: "Hey wait!",
                                          message: "I think there's something you haven't set up correctly.",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Let me check", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        WaterManager.shared.updateUserInfo(with: userInfo)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTap() { view.endEditing(true) }
}
