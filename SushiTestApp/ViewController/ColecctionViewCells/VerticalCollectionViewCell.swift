//
//  VerticalCollectionViewCell.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .red
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}

