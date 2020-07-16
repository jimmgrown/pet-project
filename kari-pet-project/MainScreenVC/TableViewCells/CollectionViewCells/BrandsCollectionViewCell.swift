import UIKit

// MARK: - Declaration

final class BrandsCollectionViewCell: UICollectionViewCell, CellsRegistration  {

    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension BrandsCollectionViewCell {
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
