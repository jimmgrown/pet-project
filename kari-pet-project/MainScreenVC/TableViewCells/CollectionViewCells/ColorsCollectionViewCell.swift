//
//  ColorsCollectionViewCell.swift
//  kari-pet-project
//
//  Created by Admin on 30.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

//MARK: Outlets

final class ColorsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    //MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Constants
    
    static let uiNib: UINib = UINib(nibName: String(describing: ColorsCollectionViewCell.self), bundle: nil)
    static let reuseID: String = .init(describing: ColorsCollectionViewCell.self)
    
    //MARK: Methods
    
    func setup(colors:Colors?){
        switch colors?.hex {
            
        case "#FFFFFF":
            imageView.backgroundColor = UIColor(hexString: "#e6e6e6")
            
        default:
            imageView.backgroundColor = UIColor(hexString: colors?.hex ?? "#FFFFFF")
        }
    }

}
