//
//  ColorsCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

#warning("Лишний пробел перед {")
final class ColorsCollectionViewCell: UICollectionViewCell, CellsRegistration  {
    
    #warning("Пробел после //")
    //MARK: Outlets

    @IBOutlet private weak var imageView: UIImageView!

}

// MARK: - Public API

#warning("Вертикальные отступы и пробелы после : и перед {")
extension ColorsCollectionViewCell {
    func setup(colors:Colors?){
        #warning("""Видишь вложенные свитчи - знай, что-то ты не так написал. Особенно, когда у одного из них только дефолт кейс, такой свитч не делает ровным счетом ничего""")
        switch colors?.hex {
            
        case "":
            switch colors?.colorName {
            default:
                imageView.backgroundColor = UIColor(hexString: "#b6e6d6")
            }
        case "#FFFFFF":
            imageView.backgroundColor = UIColor(hexString: "#e6e6e6")
            
        default:
            imageView.backgroundColor = UIColor(hexString: colors?.hex)
        }
    }
}
