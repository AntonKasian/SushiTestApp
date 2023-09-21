//
//  ViewController.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    let backColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
    
    var categories: [Category] = []

    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupRightBarButton()
        
        CategoryApiCaller.shared.getCategories { result in
            switch result {
            case .success(let response):
                self.categories = response.menuList
                self.collectionView.reloadData() // Обновите коллекцию
            case .failure(let error):
                print("Ошибка получения данных: \(error)")
            }
        }


    }
    
    private func setupViews() {
        view.backgroundColor = backColor

        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalCell")
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
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
    
    //MARK: - Horizontal collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCollectionViewCell
        cell.layer.cornerRadius = 10

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

}

