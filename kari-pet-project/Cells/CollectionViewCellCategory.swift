import UIKit
import SDWebImage

class CollectionViewCellCategory: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "categoryCell"
    
    func setup(response:ModelBlockIdTwo){
        nameLabel.numberOfLines = 0
        if let url = URL(string: response.image){
            //print(url)
            imageView.sd_setImage(with: url)
        }
        nameLabel.text = response.name
    }
}
