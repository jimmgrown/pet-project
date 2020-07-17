import UIKit

// MARK: - Declaration

#warning("Лишний пробел перед {")
final class AddInfoCollectionViewCell: UICollectionViewCell, CellsRegistration  {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

#warning("Вертикальные отступы и пробелы после : и перед {")
extension AddInfoCollectionViewCell {
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
