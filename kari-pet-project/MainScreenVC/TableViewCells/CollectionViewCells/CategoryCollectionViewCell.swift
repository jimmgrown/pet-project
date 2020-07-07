import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView  {

    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    
    //MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Methods
    
    func setup(image: String,label: String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
        labelName.text = label
    }
}
