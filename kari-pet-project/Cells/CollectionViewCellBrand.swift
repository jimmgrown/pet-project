//
//  CollectionViewCellBrand.swift
//  kari-pet-project
//
//  Created by Admin on 16.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CollectionViewCellBrand: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "brandCell"
    
    func setup(response:ModelBlockIdFive){
        if let url = URL(string: response.image){
            imageView.sd_setImage(with: url)
        }
    }
}
