//
//  OtherColorsCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 15.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

final class OtherColorCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension OtherColorCell {
    
    func setup(image: String) {
        if let url = URL(string: image){
            self.imageView.sd_setImage(with: url)
        }
    }
    
}
