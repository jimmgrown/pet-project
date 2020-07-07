import UIKit

final class AddInfoCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView  {

    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    //MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Methods
    
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
