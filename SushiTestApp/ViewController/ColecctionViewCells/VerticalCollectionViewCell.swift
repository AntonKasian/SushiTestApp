//
//  VerticalCollectionViewCell.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Магура спайси"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Тунец, соус спайси"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100 ₽ / 50г"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let flameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "flame.fill"))
        imageView.tintColor = .red
        return imageView
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "highlighter"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        return button
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
        backgroundColor = .black
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(flameImageView)
        addSubview(cardImageView)
        addSubview(addToCartButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Устанавливаем фреймы элементов напрямую
        titleLabel.frame = CGRect(x: 10, y: 10, width: frame.width - 20, height: 20)
        descriptionLabel.frame = CGRect(x: 10, y: titleLabel.frame.maxY + 2, width: frame.width - 20, height: 15)
        priceLabel.frame = CGRect(x: 10, y: descriptionLabel.frame.maxY + 25, width: frame.width - 20, height: 20)
        flameImageView.frame = CGRect(x: priceLabel.frame.maxX - 20, y: priceLabel.frame.minY, width: 20, height: 20)
        cardImageView.frame = CGRect(x: 0, y: priceLabel.frame.maxY + 10, width: frame.width, height: frame.height - 150)
        addToCartButton.frame = CGRect(x: 10, y: frame.height - 60, width: frame.width - 20, height: 40)
    }
}






