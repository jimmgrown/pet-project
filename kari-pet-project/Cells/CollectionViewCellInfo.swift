import UIKit
import SDWebImage

class CollectionViewCellInfo: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "infoCell"
    
    func setup(response:ModelBlockIdTwo){
        if let url = URL(string: response.image){
            //print(url)
            imageView.sd_setImage(with: url)
        }
    }
}
