//
//  GoodsCardCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 14.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

final class GoodsCardCollectionViewCell: UICollectionViewCell, CellsRegistration {

    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension GoodsCardCollectionViewCell {
    func setup(image: String) {
        if let url = URL(string: image){
            self.imageView.sd_setImage(with: url)
        }
    }
}
