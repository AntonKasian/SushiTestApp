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

    private let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupRightBarButton()
        
        let apiCaller = CategoryApiCaller()
        apiCaller.getCategories { result in
            switch result {
            case .success(let categories):
                
                self.categories = categories
                DispatchQueue.main.async {
                    self.horizontalCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func setupViews() {
        view.backgroundColor = backColor
        view.addSubview(horizontalCollectionView)
        view.addSubview(verticalCollectionView)

        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalCell")
        
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate = self
        verticalCollectionView.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: "VerticalCell")

        NSLayoutConstraint.activate([
            horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            verticalCollectionView.leadingAnchor.constraint(equalTo: horizontalCollectionView.leadingAnchor),
            verticalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 10),
            verticalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
    
    //MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == verticalCollectionView {
            return 10
        } else {
            
            return categories.count
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCollectionViewCell
            cell.layer.cornerRadius = 10
            
            let category = categories[indexPath.item]
            cell.configure(with: category)
            
            return cell
        } else if collectionView == verticalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath) as! VerticalCollectionViewCell
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == horizontalCollectionView {
            return CGSize(width: 120, height: 160)
        } else {
            return CGSize(width: 170, height: 300)
        }
    }
    
}

