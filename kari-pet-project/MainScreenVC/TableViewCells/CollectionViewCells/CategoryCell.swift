import UIKit

// MARK: - Declaration

final class CategoryCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    
}

// MARK: - Public API

extension CategoryCell {
    
    func setup(image: String,label: String) {
        if let url = URL(string: image) {
            imageView.sd_setImage(with: url)
        }
        labelName.text = label
    }
    
}
