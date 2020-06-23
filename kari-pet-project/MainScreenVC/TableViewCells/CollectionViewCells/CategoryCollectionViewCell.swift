import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    static let reuseID: String = .init(describing: CategoryCollectionViewCell.self)
    
    func setup(image: String,label: String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
        labelName.text = label
    }
}
