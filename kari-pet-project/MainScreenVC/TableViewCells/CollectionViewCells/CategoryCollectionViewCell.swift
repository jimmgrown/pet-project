import UIKit

// MARK: - Declaration

final class CategoryCollectionViewCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    
}

// MARK: - Public API

#warning("(Начало ворнинга в SliderCollectionViewCell) А тут-то почему ты решил их такими сделать?))))))")
extension CategoryCollectionViewCell {
    func setup(image: String,label: String) {
        
        if let url = URL(string: image) {
            imageView.sd_setImage(with: url)
        }
        
        labelName.text = label
        
    }
}
