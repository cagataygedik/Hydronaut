//
//  MainNavigationController.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 27.02.2024.
//

import UIKit

final class MainNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers([rootViewController], animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationBar.barTintColor = ThemeColor.primaryColor
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
