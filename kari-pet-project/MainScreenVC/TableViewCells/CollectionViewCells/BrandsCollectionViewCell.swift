import UIKit

// MARK: - Declaration

#warning("Лишний пробел перед {")
final class BrandsCollectionViewCell: UICollectionViewCell, CellsRegistration  {

    #warning("Пробел после //")
    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
}

// MARK: - Public API

#warning("Вертикальные отступы и пробелы после : и перед {")
extension BrandsCollectionViewCell {
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
