import UIKit

// MARK: - Declaration

final class SliderCollectionViewCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

#warning("Вот тут ты сделал верные вертикальные отступы (см. CategoryCollectionViewCell для продолжения)")
extension SliderCollectionViewCell {
    
    func setup(image: String) {
        if let url = URL(string: image) {
            imageView.sd_setImage(with: url)
        }
    }
    
}
