import UIKit

// MARK: - Declaration

final class SliderCollectionViewCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

extension SliderCollectionViewCell {
    
    func setup(image: String) {
        if let url = URL(string: image) {
            imageView.sd_setImage(with: url)
        }
    }
    
}
