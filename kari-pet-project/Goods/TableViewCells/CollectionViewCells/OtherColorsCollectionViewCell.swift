//
//  OtherColorsCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 15.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

final class OtherColorsCollectionViewCell: UICollectionViewCell, CellsRegistration {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension OtherColorsCollectionViewCell {
    func setup(image: String) {
        //colorView.backgroundColor = .black
        //colorView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        if let url = URL(string: image){
            self.imageView.sd_setImage(with: url)
        }
    }
}
