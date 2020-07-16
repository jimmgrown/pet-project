//
//  SizesCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 15.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

class SizesCollectionViewCell: UICollectionViewCell, CellsRegistration {

    // MARK: Outlets
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var sizeLabel: UILabel!

}

// MARK: - Public API

extension SizesCollectionViewCell {
    func setup(size: Size) {
        if size.avail == true {
            sizeLabel.textColor = .white
            backgroundColorView.backgroundColor = UIColor(hexString: "#9f1a6e")
        }
        sizeLabel.text = size.size
    }
}
