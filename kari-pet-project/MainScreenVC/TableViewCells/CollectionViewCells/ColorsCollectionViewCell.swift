//
//  ColorsCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

final class ColorsCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    // MARK: Outlets

    @IBOutlet private weak var imageView: UIImageView!

}

// MARK: - Public API

extension ColorsCollectionViewCell {
    func setup(colors: Colors?){
        #warning("Здесь не нужны отсутпы между кейсами")
        switch colors?.hex {
            
        case "":
            imageView.backgroundColor = UIColor(hexString: "#b6e6d6")
            
        case "#FFFFFF":
            imageView.backgroundColor = UIColor(hexString: "#e6e6e6")
            
        default:
            imageView.backgroundColor = UIColor(hexString: colors?.hex)
        }
    }
    
}
