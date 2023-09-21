//
//  HorizontalCollectionViewCell.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let cellColor = #colorLiteral(red: 0.258012116, green: 0.2628343999, blue: 0.2671281695, alpha: 1)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let subMenuCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = cellColor
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(subMenuCountLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subMenuCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            subMenuCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    
    func configure(with category: Category) {
        nameLabel.text = category.name
        subMenuCountLabel.text = "\(category.subMenuCount) товаров"
        imageView.image = nil
        
        if let imageURL = URL(string: "https://vkus-sovet.ru\(category.image)") {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let self = self {
                            self.imageView.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}




