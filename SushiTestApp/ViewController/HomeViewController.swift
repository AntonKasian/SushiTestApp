//
//  ViewController.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let backColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupRightBarButton()
    }
    
    private func setupViews() {
        view.backgroundColor = backColor
    }
    
    //MARK: - NavigationView
    
    private func setupNavigationBar() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        
        let imageIcon = UIImageView(image: UIImage(systemName: "circle.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal))
        imageIcon.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let customLabel = UILabel(frame: CGRect(x: 44, y: 0, width: 150, height: 44))
        customLabel.text = "VKUSSOVET"
        customLabel.textColor = .label
        customLabel.font = UIFont.boldSystemFont(ofSize: 22)
        customView.addSubview(imageIcon)
        customView.addSubview(customLabel)
        
        let customBarButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.leftBarButtonItem = customBarButtonItem
    }

    
    private func setupRightBarButton() {
        let phoneImage = UIImage(systemName: "phone")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        let phoneButton = UIBarButtonItem(image: phoneImage, style: .plain, target: self, action: #selector(phoneButtonTapped))
        
        if let font = UIFont(name: "System", size: 22) {
            phoneButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
        
        navigationItem.rightBarButtonItem = phoneButton
    }
    
    
    @objc func phoneButtonTapped() {
        print("Phone button tapped")
    }
    
}

