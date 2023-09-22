//
//  VerticalCollectionViewCell.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    let backColor = #colorLiteral(red: 0.1411764324, green: 0.1411764324, blue: 0.1411764324, alpha: 1)
    let priceAndWeightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description..."
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()

    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    
    let flameImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "flame.fill"))
        imageView.tintColor = .red
        return imageView
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "fork.knife"))
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
        addSubview(priceAndWeightLabel)
        addSubview(flameImageView)
        addSubview(cardImageView)

        let topBackgroundView = UIView()
        topBackgroundView.backgroundColor = backColor
        addSubview(topBackgroundView)
        addSubview(addToCartButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        priceAndWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceAndWeightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceAndWeightLabel.trailingAnchor.constraint(equalTo: flameImageView.leadingAnchor, constant: 5),
            priceAndWeightLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        flameImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flameImageView.leadingAnchor.constraint(equalTo: priceAndWeightLabel.trailingAnchor, constant: 5),
            flameImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            flameImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: priceAndWeightLabel.bottomAnchor, constant: 5),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: cardImageView.bottomAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionLabel.frame = CGRect(x: 10, y: titleLabel.frame.maxY + 2, width: frame.width - 20, height: 65)
    }
    
    func configure(with menuItem: MenuItem) {
        titleLabel.text = menuItem.name
        descriptionLabel.text = menuItem.content
        weightLabel.text = "/\(menuItem.weight)"
        
        if let price = Double(menuItem.price) {
            let priceFormatted = String(format: "%.0f", price)
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(string: "\(priceFormatted)₽", attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 15)
            ]))
            attributedText.append(NSAttributedString(string: "/\(menuItem.weight)", attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 15)
            ]))
            priceAndWeightLabel.attributedText = attributedText
        } else {
            priceAndWeightLabel.text = ""
        }
        
        if let spicy = menuItem.spicy, spicy == "Y" {
            flameImageView.isHidden = false
        } else {
            flameImageView.isHidden = true
        }

        if let imageUrl = URL(string: "https://vkus-sovet.ru\(menuItem.image)") {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.cardImageView.image = image
                    }
                }
            }.resume()
        }
    }
}






