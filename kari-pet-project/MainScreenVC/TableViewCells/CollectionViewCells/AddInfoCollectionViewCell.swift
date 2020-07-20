import UIKit

// MARK: - Declaration

final class AddInfoCollectionViewCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension AddInfoCollectionViewCell {
    
    func setup(image: String) {
        if let url = URL(string: image) {
            imageView.sd_setImage(with: url)
        }
    }
    
}
