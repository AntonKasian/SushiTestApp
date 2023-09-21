//
//  HorizontalCollectionViewCell.swift
//  SushiTestApp
//
//  Created by Anton on 21.09.23.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let cellColor = #colorLiteral(red: 0.258012116, green: 0.2628343999, blue: 0.2671281695, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .red
    }
}

