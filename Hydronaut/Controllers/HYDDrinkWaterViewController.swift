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
    private var notificationCenter: NotificationCenter
    
    //MARK: - Lifecycle
    
    internal init(notificationCenter center: NotificationCenter = NotificationCenter.default) {
      self.notificationCenter = center
      super.init(nibName: nil, bundle: nil)
      addNotificationObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTapGesture()
        setupNavigationBar()
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
        NotificationCenter.default.addObserver(self, selector: #selector(sceneWillEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
    }
    
    //MARK: - Actions
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    @objc private func resetWaterCountToZero() {
        let deleteAction = UIAlertAction(title: "Reset", style: .destructive) { _ in
            WaterManager.shared.resetVolume()
        }
        showAlert(title: "Are you sure?", message: "All the records will be deleted", action: deleteAction)
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
    
    @objc private func sceneWillEnterForeground() {
        drinkWaterView.animateMarsImageView()
    }
}

extension HYDDrinkWaterViewController {
    func showAlert(title: String, message: String, action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(defaultAction)
        
        if let customAction = action {
            alertController.addAction(customAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
