//
//  SizesCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 15.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

final class SizeCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var sizeLabel: UILabel!

}

// MARK: - Public API

extension SizeCell {
    
    func setup(size: Size) {
        if size.avail == true {
            sizeLabel.textColor = .white
            backgroundColorView.backgroundColor = UIColor(hexString: "#9f1a6e")
        }
        sizeLabel.text = size.size
    }
    
}
