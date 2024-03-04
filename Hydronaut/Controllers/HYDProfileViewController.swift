//
//  ProfileViewController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 27.02.2024.
//

import UIKit

final class HYDProfileViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel = HYDProfileViewModel()
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
        print("tapped")
    }
    
    @objc private func didTap() { view.endEditing(true) }
}
