//
//  HYDDrinkWaterViewController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 4.03.2024.
//

import UIKit

final class HYDDrinkWaterViewController: UIViewController {
    
    //MARK: - Properties
    private let drinkWaterView = HYDDrinkWaterView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTapGesture()
        setupNavigationBar()
        addNotificationObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drinkWaterView.animateMarsImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drinkWaterView.drinkWaterButton.setCustomTitleEdgeInsets(bottomInset: view.safeAreaInsets.bottom)
        drinkWaterView.drinkWaterButton.makeCustomConstraints(height: 60 + view.safeAreaInsets.bottom)
    }
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    //MARK: - Layout
    
    private func setupView() {
        title = "Hydronaut"
        view.addSubview(drinkWaterView)
        drinkWaterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        drinkWaterView.viewController = self
    }
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        drinkWaterView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(resetWaterCountToZero))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(goToProfile))
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userIntakeDidChange), name: WaterManager.waterVolumeDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recommendedIntakeDidChange), name: WaterManager.recommendedIntakeDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nickNameDidChange), name: WaterManager.nickNameDidChange, object: nil)
    }
    
    //MARK: - Actions
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    @objc private func resetWaterCountToZero() {
        let alert = UIAlertController(title: "Are you sure?", message: "All the records will be deleted", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            WaterManager.shared.resetVolume()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func goToProfile() {
        navigationController?.pushViewController(HYDProfileViewController(), animated: true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        view.bounds = CGRect(x: 0, y: keyboardSize.size.height/2, width: view.bounds.width, height: view.bounds.height)
    }
    
    @objc private func keyboardWillHide() {
        view.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    @objc private func userIntakeDidChange() {
        drinkWaterView.updateWaterCountLabel()
        drinkWaterView.updateAchievementRateLabel()
        drinkWaterView.updateMarsImage()
        drinkWaterView.updateOnAchievement()
    }
    
    @objc private func recommendedIntakeDidChange() {
        drinkWaterView.updateAchievementRateLabel()
        drinkWaterView.updateMarsImage()
        drinkWaterView.updateGuideLabel()
        drinkWaterView.updateOnAchievement()
    }
    
    @objc private func nickNameDidChange() {
        drinkWaterView.updateGuideLabel()
    }
}
