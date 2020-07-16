import UIKit

// MARK: - Declaration

final class FindsCollectionViewCell: UICollectionViewCell, CellsRegistration  {

    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension FindsCollectionViewCell {
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
